From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: [PATCH v3 1/1] i2c: add ACPI support for I2C mux ports
Date: Mon, 19 Oct 2015 15:29:00 -0700
Message-ID: <1445293740-28537-2-git-send-email-dustin@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445293740-28537-1-git-send-email-dustin@cumulusnetworks.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1445293740-28537-1-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, andriy.shevchenko@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

Although I2C mux devices are easily enumerated using ACPI (_HID/_CID or
device property compatible string match) enumerating I2C client devices
connected through a I2C mux device requires a little extra work.

This change implements a method for describing an I2C device hierarchy that
includes mux devices by using an ACPI Device() for each mux channel along
with an _ADR to set the channel number for the device.  See
Documentation/acpi/i2c-muxes.txt for a simple example.

Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
---
 Documentation/acpi/i2c-muxes.txt | 58 ++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c           | 15 +++++++++--
 drivers/i2c/i2c-mux.c            |  8 ++++++
 include/linux/acpi.h             |  6 +++++
 4 files changed, 85 insertions(+), 2 deletions(-)
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
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 579b99d..af0811c 100644
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
@@ -1667,6 +1667,17 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 	struct device *dev = &adapter->dev;
 	int id;
 
+	/*
+	 * By default, associate I2C adapters with their parent device's ACPI
+	 * node.
+	 */
+	if (!has_acpi_companion(dev)) {
+		struct acpi_device *adev = ACPI_COMPANION(dev->parent);
+
+		if (adev)
+			ACPI_COMPANION_SET(dev, adev);
+	}
+
 	if (dev->of_node) {
 		id = of_alias_get_id(dev->of_node, "i2c");
 		if (id >= 0) {
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
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 51a96a8..66564f8 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -505,6 +505,12 @@ static inline bool has_acpi_companion(struct device *dev)
 	return false;
 }
 
+static inline void acpi_preset_companion(struct device *dev,
+					 struct acpi_device *parent, u64 addr)
+{
+	return;
+}
+
 static inline const char *acpi_dev_name(struct acpi_device *adev)
 {
 	return NULL;
-- 
2.1.4

