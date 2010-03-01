From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-i801: Let the user disable selected driver features
Date: Mon, 1 Mar 2010 20:05:10 +0100
Message-ID: <20100301200510.3db702f7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Let the user disable selected features normally supported by the
device. This makes it possible to work around possible driver or
hardware bugs if the feature in question doesn't work as intended
for whatever reason.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Felix, what do you think? This patch should let you work around the
driver bug, until we find it and fix it (load with disable_features=2).

 Documentation/i2c/busses/i2c-i801 |    8 +++++++-
 drivers/i2c/busses/i2c-i801.c     |   21 ++++++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

--- linux-2.6.34-rc0.orig/drivers/i2c/busses/i2c-i801.c	2010-03-01 15:39:05.000000000 +0100
+++ linux-2.6.34-rc0/drivers/i2c/busses/i2c-i801.c	2010-03-01 18:57:48.000000000 +0100
@@ -138,6 +138,17 @@ static struct pci_dev *I801_dev;
 #define FEATURE_I2C_BLOCK_READ	(1 << 3)
 static unsigned int i801_features;
 
+static const char *i801_feature_names[] = {
+	"SMBus PEC",
+	"Block buffer",
+	"Block process call",
+	"I2C block read",
+};
+
+static unsigned int disable_features;
+module_param(disable_features, uint, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(disable_features, "Disable selected driver features");
+
 /* Make sure the SMBus host is ready to start transmitting.
    Return 0 if it is, -EBUSY if it is not. */
 static int i801_check_pre(void)
@@ -690,7 +701,7 @@ static void __devinit dmi_check_onboard_
 static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned char temp;
-	int err;
+	int err, i;
 #if defined CONFIG_SENSORS_FSCHMD || defined CONFIG_SENSORS_FSCHMD_MODULE
 	const char *vendor;
 #endif
@@ -718,6 +729,14 @@ static int __devinit i801_probe(struct p
 		break;
 	}
 
+	/* Disable features on user request */
+	for (i = 0; i < ARRAY_SIZE(i801_feature_names); i++) {
+		if (i801_features & disable_features & (1 << i))
+			dev_notice(&dev->dev, "%s disabled by user\n",
+				   i801_feature_names[i]);
+	}
+	i801_features &= ~disable_features;
+
 	err = pci_enable_device(dev);
 	if (err) {
 		dev_err(&dev->dev, "Failed to enable SMBus PCI device (%d)\n",
--- linux-2.6.34-rc0.orig/Documentation/i2c/busses/i2c-i801	2010-03-01 18:21:20.000000000 +0100
+++ linux-2.6.34-rc0/Documentation/i2c/busses/i2c-i801	2010-03-01 18:22:45.000000000 +0100
@@ -27,7 +27,13 @@ Authors:
 Module Parameters
 -----------------
 
-None.
+* disable_features (bit vector)
+Disable selected features normally supported by the device. This makes it
+possible to work around possible driver or hardware bugs if the feature in
+question doesn't work as intended for whatever reason. Bit values:
+  1  disable SMBus PEC
+  2  disable the block buffer
+  8  disable the I2C block read functionality
 
 
 Description


-- 
Jean Delvare
