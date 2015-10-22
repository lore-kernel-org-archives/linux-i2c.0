From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: [PATCH v4 2/2] i2c: add ACPI support for I2C mux ports
Date: Thu, 22 Oct 2015 02:17:42 -0700
Message-ID: <1445505462-27915-3-git-send-email-dustin@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445505462-27915-1-git-send-email-dustin@cumulusnetworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445505462-27915-1-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, "Puustinen, Ismo" <ismo.puustinen@intel.com>
List-Id: linux-i2c@vger.kernel.org

Although I2C mux devices are easily enumerated using ACPI (_HID/_CID or
device property compatible string match), enumerating I2C client devices
connected through an I2C mux needs a little extra work.

This change implements a method for describing an I2C device hierarchy that
includes mux devices by using an ACPI Device() for each mux channel along
with an _ADR to set the channel number for the device.  See
Documentation/acpi/i2c-muxes.txt for a simple example.

To make this work the ismt, i801, and designware pci/platform devs now
share an ACPI companion with their I2C adapter dev similar to how it's done
in OF.  This is done on the assumption that power management functions will
not be called directly on the I2C dev that is sharing the ACPI node.

Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
---
 Documentation/acpi/i2c-muxes.txt            | 58 +++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-pcidrv.c  |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c |  6 ++-
 drivers/i2c/busses/i2c-i801.c               |  9 ++---
 drivers/i2c/busses/i2c-ismt.c               |  8 +---
 drivers/i2c/i2c-core.c                      |  4 +-
 drivers/i2c/i2c-mux.c                       |  8 ++++
 7 files changed, 78 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/acpi/i2c-muxes.txt

diff --git a/Documentation/acpi/i2c-muxes.txt b/Documentation/acpi/i2c-muxes.txt
new file mode 100644
index 0000000..9fcc4f0
--- /dev/null
+++ b/Documentation/acpi/i2c-muxes.txt
@@ -0,0 +1,58 @@
+ACPI I2C Muxes
+--------------
+
+Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
+Device () scope per mux channel.
+
+Consider this topology:
+
++------+   +------+
+| SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
+|      |   | 0x70 |--CH01--> i2c client B (0x50)
++------+   +------+
+
+which corresponds to the following ASL:
+
+Device (SMB1)
+{
+    Name (_HID, ...)
+    Device (MUX0)
+    {
+        Name (_HID, ...)
+        Name (_CRS, ResourceTemplate () {
+            I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
+                          AddressingMode7Bit, "^SMB1", 0x00,
+                          ResourceConsumer,,)
+        }
+
+        Device (CH00)
+        {
+            Name (_ADR, 0)
+
+            Device (CLIA)
+            {
+                Name (_HID, ...)
+                Name (_CRS, ResourceTemplate () {
+                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
+                                  AddressingMode7Bit, "^CH00", 0x00,
+                                  ResourceConsumer,,)
+                }
+            }
+        }
+
+        Device (CH01)
+        {
+            Name (_ADR, 1)
+
+            Device (CLIB)
+            {
+                Name (_HID, ...)
+                Name (_CRS, ResourceTemplate () {
+                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
+                                  AddressingMode7Bit, "^CH01", 0x00,
+                                  ResourceConsumer,,)
+                }
+            }
+        }
+    }
+}
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index df23e8c..5b9dcdb 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -256,6 +256,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	adap->class = 0;
 	adap->algo = &i2c_dw_algo;
 	adap->dev.parent = &pdev->dev;
+	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
 	adap->nr = controller->bus_num;
 
 	snprintf(adap->name, sizeof(adap->name), "i2c-designware-pci");
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 472b882..9efeac6 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -267,12 +267,14 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_DEPRECATED;
-	strlcpy(adap->name, "Synopsys DesignWare I2C adapter",
-			sizeof(adap->name));
 	adap->algo = &i2c_dw_algo;
 	adap->dev.parent = &pdev->dev;
+	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
 	adap->dev.of_node = pdev->dev.of_node;
 
+	strlcpy(adap->name, "Synopsys DesignWare I2C adapter",
+			sizeof(adap->name));
+
 	if (dev->pm_runtime_disabled) {
 		pm_runtime_forbid(&pdev->dev);
 	} else {
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index eaef9bc..d4a6e77 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1251,6 +1251,9 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	priv->adapter.owner = THIS_MODULE;
 	priv->adapter.class = i801_get_adapter_class(priv);
 	priv->adapter.algo = &smbus_algorithm;
+	priv->adapter.dev.parent = &dev->dev;
+	ACPI_COMPANION_SET(&priv->adapter.dev, ACPI_COMPANION(&dev->dev));
+	priv->adapter.retries = 3;
 
 	priv->pci_dev = dev;
 	switch (dev->device) {
@@ -1381,12 +1384,6 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	i801_add_tco(priv);
 
-	/* set up the sysfs linkage to our parent device */
-	priv->adapter.dev.parent = &dev->dev;
-
-	/* Retry up to 3 times on lost arbitration */
-	priv->adapter.retries = 3;
-
 	snprintf(priv->adapter.name, sizeof(priv->adapter.name),
 		"SMBus I801 adapter at %04lx", priv->smba);
 	err = i2c_add_adapter(&priv->adapter);
diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index f994712..2ec2bb6 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -847,17 +847,13 @@ ismt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	pci_set_drvdata(pdev, priv);
+
 	i2c_set_adapdata(&priv->adapter, priv);
 	priv->adapter.owner = THIS_MODULE;
-
 	priv->adapter.class = I2C_CLASS_HWMON;
-
 	priv->adapter.algo = &smbus_algorithm;
-
-	/* set up the sysfs linkage to our parent device */
 	priv->adapter.dev.parent = &pdev->dev;
-
-	/* number of retries on lost arbitration */
+	ACPI_COMPANION_SET(&priv->adapter.dev, ACPI_COMPANION(&pdev->dev));
 	priv->adapter.retries = ISMT_MAX_RETRIES;
 
 	priv->pci_dev = pdev;
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 579b99d..040af5c 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -156,7 +156,7 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
 	info.fwnode = acpi_fwnode_handle(adev);
 
 	memset(&lookup, 0, sizeof(lookup));
-	lookup.adapter_handle = ACPI_HANDLE(adapter->dev.parent);
+	lookup.adapter_handle = ACPI_HANDLE(&adapter->dev);
 	lookup.device_handle = handle;
 	lookup.info = &info;
 
@@ -212,7 +212,7 @@ static void acpi_i2c_register_devices(struct i2c_adapter *adap)
 {
 	acpi_status status;
 
-	if (!adap->dev.parent || !has_acpi_companion(adap->dev.parent))
+	if (!has_acpi_companion(&adap->dev))
 		return;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 2ba7c0f..00fc5b1 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -25,6 +25,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
 #include <linux/of.h>
+#include <linux/acpi.h>
 
 /* multiplexer per channel data */
 struct i2c_mux_priv {
@@ -173,6 +174,13 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 		}
 	}
 
+	/*
+	 * Associate the mux channel with an ACPI node.
+	 */
+	if (has_acpi_companion(mux_dev))
+		acpi_preset_companion(&priv->adap.dev, ACPI_COMPANION(mux_dev),
+				      chan_id);
+
 	if (force_nr) {
 		priv->adap.nr = force_nr;
 		ret = i2c_add_numbered_adapter(&priv->adap);
-- 
2.1.4
