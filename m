From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v6] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PCI BAR
Date: Thu,  9 Jun 2016 16:56:28 +0300
Message-ID: <1465480588-137449-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, pali.rohar@gmail.com, Matt Fleming <matt@codeblueprint.co.uk>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Many Intel systems the BIOS declares a SystemIO OpRegion below the SMBu=
s
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

There are also bunch of AML methods that that the BIOS can use to acces=
s
these fields. Most of the systems in question AML methods accessing the
SMBI OpRegion are never used.

Now, because of this SMBI OpRegion many systems fail to load the SMBus
driver with an error looking like one below:

  ACPI Warning: SystemIO range 0x0000000000003040-0x000000000000305F
       conflicts with OpRegion 0x0000000000003040-0x000000000000304F
       (\_SB.PCI0.SBUS.SMBI) (20160108/utaddress-255)
  ACPI: If an ACPI driver is available for this device, you should use
       it instead of the native driver

The reason is that this SMBI OpRegion conflicts with the PCI BAR used b=
y
the SMBus driver.

It turns out that we can install a custom SystemIO address space handle=
r
for the SMBus device to intercept all accesses through that OpRegion. T=
his
allows us to share the PCI BAR with the AML code if it for some reason =
is
using it. We do not expect that this OpRegion handler will ever be call=
ed
but if it is we print a warning and prevent all access from the SMBus
driver itself.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D110041
Reported-by: Andy Lutomirski <luto@kernel.org>
Reported-and-tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: stable@vger.kernel.org
---
Changes to v5:
 - Call i801_acpi_remove() in i801_probe() in error paths to remove the
   OpRegion handler we registered in i801_acpi_probe().

Changes to v4:
 - Use ACPI_IO_MASK to mask function to get right value if in future we=
 get
   something else added to that field.
 - Add Reviewed/Tested-by from Jean Delvare

Changes to v3:
 - Added Tested-by from Pali Roh=C3=A1r (The patch did not change that =
much so I
   though it is still valid)
 - Return -EBUSY instead of -EIO
 - Move dev_warns() to be inside if (!priv->acpi_reserved) block
 - Remove unnecessary variable "val"
 - Do not clear priv->acpi_reserved in i801_acpi_remove()
 - Return -ENODEV if we detect conflict
 - Call i801_acpi_remove() after i2c_del_adapter().

Changes to v2:
 - Return -EIO instead of -EPERM
 - Added ACK from Rafael
 - Added Link and Reported-by tags
 - Tagged for stable inclusion

 drivers/i2c/busses/i2c-i801.c | 99 +++++++++++++++++++++++++++++++++++=
++++++--
 1 file changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i80=
1.c
index 5652bf6ce9be..8e3ad27c65dc 100644
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
=20
 #define FEATURE_SMBUS_PEC	(1 << 0)
@@ -720,6 +727,12 @@ static s32 i801_access(struct i2c_adapter *adap, u=
16 addr,
 	int ret =3D 0, xact =3D 0;
 	struct i801_priv *priv =3D i2c_get_adapdata(adap);
=20
+	mutex_lock(&priv->acpi_lock);
+	if (priv->acpi_reserved) {
+		mutex_unlock(&priv->acpi_lock);
+		return -EBUSY;
+	}
+
 	pm_runtime_get_sync(&priv->pci_dev->dev);
=20
 	hwpec =3D (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT=
_PEC)
@@ -822,6 +835,7 @@ static s32 i801_access(struct i2c_adapter *adap, u1=
6 addr,
 out:
 	pm_runtime_mark_last_busy(&priv->pci_dev->dev);
 	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
+	mutex_unlock(&priv->acpi_lock);
 	return ret;
 }
=20
@@ -1260,6 +1274,83 @@ static void i801_add_tco(struct i801_priv *priv)
 	priv->tco_pdev =3D pdev;
 }
=20
+#ifdef CONFIG_ACPI
+static acpi_status
+i801_acpi_io_handler(u32 function, acpi_physical_address address, u32 =
bits,
+		     u64 *value, void *handler_context, void *region_context)
+{
+	struct i801_priv *priv =3D handler_context;
+	struct pci_dev *pdev =3D priv->pci_dev;
+	acpi_status status;
+
+	/*
+	 * Once BIOS AML code touches the OpRegion we warn and inhibit any
+	 * further access from the driver itself. This device is now owned
+	 * by the system firmware.
+	 */
+	mutex_lock(&priv->acpi_lock);
+
+	if (!priv->acpi_reserved) {
+		priv->acpi_reserved =3D true;
+
+		dev_warn(&pdev->dev, "BIOS is accessing SMBus registers\n");
+		dev_warn(&pdev->dev, "Driver SMBus register access inhibited\n");
+
+		/*
+		 * BIOS is accessing the host controller so prevent it from
+		 * suspending automatically from now on.
+		 */
+		pm_runtime_get_sync(&pdev->dev);
+	}
+
+	if ((function & ACPI_IO_MASK) =3D=3D ACPI_READ)
+		status =3D acpi_os_read_port(address, (u32 *)value, bits);
+	else
+		status =3D acpi_os_write_port(address, (u32)*value, bits);
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
+	adev =3D ACPI_COMPANION(&priv->pci_dev->dev);
+	if (adev) {
+		status =3D acpi_install_address_space_handler(adev->handle,
+				ACPI_ADR_SPACE_SYSTEM_IO, i801_acpi_io_handler,
+				NULL, priv);
+		if (ACPI_SUCCESS(status))
+			return 0;
+	}
+
+	return acpi_check_resource_conflict(&priv->pci_dev->resource[SMBBAR])=
;
+}
+
+static void i801_acpi_remove(struct i801_priv *priv)
+{
+	struct acpi_device *adev;
+
+	adev =3D ACPI_COMPANION(&priv->pci_dev->dev);
+	if (!adev)
+		return;
+
+	acpi_remove_address_space_handler(adev->handle,
+		ACPI_ADR_SPACE_SYSTEM_IO, i801_acpi_io_handler);
+
+	mutex_lock(&priv->acpi_lock);
+	if (priv->acpi_reserved)
+		pm_runtime_put(&priv->pci_dev->dev);
+	mutex_unlock(&priv->acpi_lock);
+}
+#else
+static inline int i801_acpi_probe(struct i801_priv *priv) { return 0; =
}
+static inline void i801_acpi_remove(struct i801_priv *priv) { }
+#endif
+
 static int i801_probe(struct pci_dev *dev, const struct pci_device_id =
*id)
 {
 	unsigned char temp;
@@ -1277,6 +1368,7 @@ static int i801_probe(struct pci_dev *dev, const =
struct pci_device_id *id)
 	priv->adapter.dev.parent =3D &dev->dev;
 	ACPI_COMPANION_SET(&priv->adapter.dev, ACPI_COMPANION(&dev->dev));
 	priv->adapter.retries =3D 3;
+	mutex_init(&priv->acpi_lock);
=20
 	priv->pci_dev =3D dev;
 	switch (dev->device) {
@@ -1339,10 +1431,8 @@ static int i801_probe(struct pci_dev *dev, const=
 struct pci_device_id *id)
 		return -ENODEV;
 	}
=20
-	err =3D acpi_check_resource_conflict(&dev->resource[SMBBAR]);
-	if (err) {
+	if (i801_acpi_probe(priv))
 		return -ENODEV;
-	}
=20
 	err =3D pcim_iomap_regions(dev, 1 << SMBBAR,
 				 dev_driver_string(&dev->dev));
@@ -1351,6 +1441,7 @@ static int i801_probe(struct pci_dev *dev, const =
struct pci_device_id *id)
 			"Failed to request SMBus region 0x%lx-0x%Lx\n",
 			priv->smba,
 			(unsigned long long)pci_resource_end(dev, SMBBAR));
+		i801_acpi_remove(priv);
 		return err;
 	}
=20
@@ -1415,6 +1506,7 @@ static int i801_probe(struct pci_dev *dev, const =
struct pci_device_id *id)
 	err =3D i2c_add_adapter(&priv->adapter);
 	if (err) {
 		dev_err(&dev->dev, "Failed to add SMBus adapter\n");
+		i801_acpi_remove(priv);
 		return err;
 	}
=20
@@ -1441,6 +1533,7 @@ static void i801_remove(struct pci_dev *dev)
=20
 	i801_del_mux(priv);
 	i2c_del_adapter(&priv->adapter);
+	i801_acpi_remove(priv);
 	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
=20
 	platform_device_unregister(priv->tco_pdev);
--=20
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
