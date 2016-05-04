From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PCI BAR
Date: Wed,  4 May 2016 12:27:25 +0300
Message-ID: <1462354045-94455-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, pali.rohar@gmail.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
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

There are also bunch of AML methods that that the BIOS can use to access
these fields. Most of the systems in question AML methods accessing the
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
allows us to share the PCI BAR with the AML code if it for some reason is
using it. We do not expect that this OpRegion handler will ever be called
but if it is we print a warning and prevent all access from the SMBus
driver itself.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Hi,

This is a second try. The first version of the patch is here:

  https://patchwork.ozlabs.org/patch/616120/

This version inhibits all further driver access to the SMBus device when
BIOS first time uses the conflicting OpRegion.

I've tested this using MinnowBoard MAX with modified DSDT where _STA
(device status) method tries to read from the OpRegion and it seems to
work. Below is the modified ASL if someone wants to give it a try:

  Device (SBUS)
  {
      Name (_ADR, 0x001F0003)  // _ADR: Address
      OperationRegion (SMBP, PCI_Config, 0x40, 0xC0)
      Field (SMBP, DWordAcc, NoLock, Preserve)
      {
              ,   2, 
          I2CE,   1
      }

      OperationRegion (SMPB, PCI_Config, 0x20, 0x04)
      Field (SMPB, DWordAcc, NoLock, Preserve)
      {
              ,   5, 
          SBAR,   11
      }

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

      Method (_STA, 0, NotSerialized)
      {
          Local0 = HSTS
          Local0 += 1
          Local1 = SDAT
          Local1 += 1
          Return (0xF)
      }
  }

Basically it just does two reads from the OpRegion whenever device status
is queried. After that accesses to the bus fails:

  # i2cget -y 9 0xc 0 b
  Error: Read failed

 drivers/i2c/busses/i2c-i801.c | 106 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 5652bf6ce9be..e200cdbd2882 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -247,6 +247,13 @@ struct i801_priv {
 	struct platform_device *mux_pdev;
 #endif
 	struct platform_device *tco_pdev;
+
+	/*
+	 * If set to true the host controller registers are reserved for
+	 * ACPI AML use. Protected by acpi_lock.
+	 */
+	bool acpi_reserved;
+	struct mutex acpi_lock;
 };
 
 #define FEATURE_SMBUS_PEC	(1 << 0)
@@ -720,6 +727,12 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	int ret = 0, xact = 0;
 	struct i801_priv *priv = i2c_get_adapdata(adap);
 
+	mutex_lock(&priv->acpi_lock);
+	if (priv->acpi_reserved) {
+		mutex_unlock(&priv->acpi_lock);
+		return -EPERM;
+	}
+
 	pm_runtime_get_sync(&priv->pci_dev->dev);
 
 	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC)
@@ -822,6 +835,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 out:
 	pm_runtime_mark_last_busy(&priv->pci_dev->dev);
 	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
+	mutex_unlock(&priv->acpi_lock);
 	return ret;
 }
 
@@ -1260,6 +1274,89 @@ static void i801_add_tco(struct i801_priv *priv)
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
+	/*
+	 * Once BIOS AML code touches the OpRegion we warn and inhibit any
+	 * further access from the driver itself. This device is now owned
+	 * by the system firmware.
+	 */
+	dev_warn_once(&pdev->dev, "BIOS is accessing SMBus registers\n");
+	dev_warn_once(&pdev->dev, "Driver SMBus register access inhibited\n");
+
+	mutex_lock(&priv->acpi_lock);
+
+	if (!priv->acpi_reserved) {
+		priv->acpi_reserved = true;
+
+		/*
+		 * BIOS is accessing the host controller so prevent it from
+		 * suspending automatically from now on.
+		 */
+		pm_runtime_get_sync(&pdev->dev);
+	}
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
+
+	mutex_lock(&priv->acpi_lock);
+	if (priv->acpi_reserved) {
+		priv->acpi_reserved = false;
+		pm_runtime_put(&priv->pci_dev->dev);
+	}
+	mutex_unlock(&priv->acpi_lock);
+}
+#else
+static inline int i801_acpi_probe(struct i801_priv *priv) { return 0; }
+static inline void i801_acpi_remove(struct i801_priv *priv) { }
+#endif
+
 static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned char temp;
@@ -1277,6 +1374,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	priv->adapter.dev.parent = &dev->dev;
 	ACPI_COMPANION_SET(&priv->adapter.dev, ACPI_COMPANION(&dev->dev));
 	priv->adapter.retries = 3;
+	mutex_init(&priv->acpi_lock);
 
 	priv->pci_dev = dev;
 	switch (dev->device) {
@@ -1339,10 +1437,9 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
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
@@ -1439,6 +1536,7 @@ static void i801_remove(struct pci_dev *dev)
 	pm_runtime_forbid(&dev->dev);
 	pm_runtime_get_noresume(&dev->dev);
 
+	i801_acpi_remove(priv);
 	i801_del_mux(priv);
 	i2c_del_adapter(&priv->adapter);
 	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
-- 
2.8.1

