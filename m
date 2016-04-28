From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PCI BAR
Date: Thu, 28 Apr 2016 13:23:30 +0300
Message-ID: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Many Intel systems the BIOS declares a SystemIO OpRegion below the SMBus
PCI device as can be seen in ACPI DSDT table from Lenovo Yoga 900:

  Device (SBUS)
  {
      OperationRegion (SMBI, SystemIO, (SBAR << 0x05), 0x10)
      Field (SMBI, ByteAcc, NoLock, Preserve)
      {
          HSTS,   8,
          Offset (0x02),
          HCON,   8,
          HCOM,   8,
          TXSA,   8,
          DAT0,   8,
          DAT1,   8,
          HBDR,   8,
          PECR,   8,
          RXSA,   8,
          SDAT,   16
      }

There are also bunch of ASL methods that that the BIOS can use to access
these fields. Most of the systems in question ASL methods accessing the
SMBI OpRegion are never used.

Now, because of this SMBI OpRegion many systems fail to load the SMBus
driver with an error looking like one below:

  ACPI Warning: SystemIO range 0x0000000000003040-0x000000000000305F
       conflicts with OpRegion 0x0000000000003040-0x000000000000304F
       (\_SB.PCI0.SBUS.SMBI) (20160108/utaddress-255)
  ACPI: If an ACPI driver is available for this device, you should use
       it instead of the native driver

The reason is that this SMBI OpRegion conflicts with the PCI BAR used by
the SMBus driver.

It turns out that we can install a custom SystemIO address space handler
for the SMBus device to intercept all accesses through that OpRegion. This
allows us to share the PCI BAR with the ASL code if it for some reason is
using it. We do not expect that this OpRegion handler will ever be called
but if it is we print a warning and execute the read/write operation under
a lock which prevents ASL and OS from messing each other.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/busses/i2c-i801.c | 83 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 5652bf6ce9be..7c0957870ee8 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -247,6 +247,9 @@ struct i801_priv {
 	struct platform_device *mux_pdev;
 #endif
 	struct platform_device *tco_pdev;
+
+	/* Serialize ACPI ASL and OS access to the registers */
+	struct mutex acpi_lock;
 };
 
 #define FEATURE_SMBUS_PEC	(1 << 0)
@@ -721,6 +724,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	struct i801_priv *priv = i2c_get_adapdata(adap);
 
 	pm_runtime_get_sync(&priv->pci_dev->dev);
+	mutex_lock(&priv->acpi_lock);
 
 	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC)
 		&& size != I2C_SMBUS_QUICK
@@ -820,6 +824,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	}
 
 out:
+	mutex_unlock(&priv->acpi_lock);
 	pm_runtime_mark_last_busy(&priv->pci_dev->dev);
 	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
 	return ret;
@@ -1260,6 +1265,75 @@ static void i801_add_tco(struct i801_priv *priv)
 	priv->tco_pdev = pdev;
 }
 
+#ifdef CONFIG_ACPI
+static acpi_status
+i801_acpi_io_handler(u32 function, acpi_physical_address address, u32 bits,
+		     u64 *value, void *handler_context, void *region_context)
+{
+	struct i801_priv *priv = handler_context;
+	struct pci_dev *pdev = priv->pci_dev;
+	acpi_status status;
+
+	dev_warn_once(&pdev->dev,
+		      "BIOS is accessing SMBus registers from ASL\n");
+
+	/*
+	 * ASL code is trying to access the I/O port. Make sure we do not
+	 * access the bus at the same time from OS side by taking the lock
+	 * here.
+	 */
+	pm_runtime_get_sync(&pdev->dev);
+	mutex_lock(&priv->acpi_lock);
+
+	if (function == ACPI_READ) {
+		u32 val = (u32)*value;
+		status = acpi_os_read_port(address, &val, bits);
+		if (ACPI_SUCCESS(status))
+			*value = val;
+	} else {
+		status = acpi_os_write_port(address, (u32)*value, bits);
+	}
+
+	mutex_unlock(&priv->acpi_lock);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
+	return status;
+}
+
+static int i801_acpi_probe(struct i801_priv *priv)
+{
+	struct acpi_device *adev;
+	acpi_status status;
+
+	adev = ACPI_COMPANION(&priv->pci_dev->dev);
+	if (adev) {
+		status = acpi_install_address_space_handler(adev->handle,
+				ACPI_ADR_SPACE_SYSTEM_IO, i801_acpi_io_handler,
+				NULL, priv);
+		if (ACPI_SUCCESS(status))
+			return 0;
+	}
+
+	return acpi_check_resource_conflict(&priv->pci_dev->resource[SMBBAR]);
+}
+
+static void i801_acpi_remove(struct i801_priv *priv)
+{
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(&priv->pci_dev->dev);
+	if (!adev)
+		return;
+
+	acpi_remove_address_space_handler(adev->handle,
+		ACPI_ADR_SPACE_SYSTEM_IO, i801_acpi_io_handler);
+}
+#else
+static inline int i801_acpi_probe(struct i801_priv *priv) { return 0; }
+static inline void i801_acpi_remove(struct i801_priv *priv) { }
+#endif
+
 static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned char temp;
@@ -1277,6 +1351,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	priv->adapter.dev.parent = &dev->dev;
 	ACPI_COMPANION_SET(&priv->adapter.dev, ACPI_COMPANION(&dev->dev));
 	priv->adapter.retries = 3;
+	mutex_init(&priv->acpi_lock);
 
 	priv->pci_dev = dev;
 	switch (dev->device) {
@@ -1339,10 +1414,9 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENODEV;
 	}
 
-	err = acpi_check_resource_conflict(&dev->resource[SMBBAR]);
-	if (err) {
-		return -ENODEV;
-	}
+	err = i801_acpi_probe(priv);
+	if (err)
+		return err;
 
 	err = pcim_iomap_regions(dev, 1 << SMBBAR,
 				 dev_driver_string(&dev->dev));
@@ -1439,6 +1513,7 @@ static void i801_remove(struct pci_dev *dev)
 	pm_runtime_forbid(&dev->dev);
 	pm_runtime_get_noresume(&dev->dev);
 
+	i801_acpi_remove(priv);
 	i801_del_mux(priv);
 	i2c_del_adapter(&priv->adapter);
 	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
-- 
2.8.0.rc3

