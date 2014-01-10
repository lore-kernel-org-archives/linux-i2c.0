From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: [PATCH v3 2/2] i2c: Add bus driver for for OSIF USB i2c device.
Date: Sat, 11 Jan 2014 00:23:59 +0100
Message-ID: <1389396239-21026-2-git-send-email-andrew@lunn.ch>
References: <20140109214930.GC3866@katana>
 <1389396239-21026-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389396239-21026-1-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Emmanuel Deloget <logout-GANU6spQydw@public.gmane.org>, Barry Carter <barry.carter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

OSIF, Open Source InterFace, is a USB based i2c bus master.  The
origional design was based on i2c-tiny-usb, but more modern versions
of the firmware running on the MegaAVR microcontroller use a different
protocol over the USB. This code is based on Barry Carter
<barry.carter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> driver.

Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
CC: Emmanuel Deloget <logout-GANU6spQydw@public.gmane.org>
CC: Barry Carter <barry.carter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:

Rearranged order of functions to remove forward declarations
Remove some obvious comments
Remove debug prints which the core also provides
Remove defines for module authors.
Allocate status byte once in priv, rather than for each xfer.
Fix MODULE_LICENSE()
Rename file and Kconfig entry for consistency and ordering.
Inline osif_free()

v3:

Fix name space issues
Remove more obvious comments
Remove unneeded casts
dev_err() on one line
SMBUS_QUICK has been tested with i2dectect -q
Empty line remove
s/retval/ret/g
---
 drivers/i2c/busses/Kconfig              |  10 ++
 drivers/i2c/busses/Makefile             |   1 +
 drivers/i2c/busses/i2c-robotfuzz-osif.c | 202 ++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-robotfuzz-osif.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index cdcbd8368ed3..ed1bd7a46c20 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -837,6 +837,16 @@ config I2C_PARPORT_LIGHT
 	  This support is also available as a module.  If so, the module
 	  will be called i2c-parport-light.
 
+config I2C_ROBOTFUZZ_OSIF
+	tristate "RobotFuzz Open Source InterFace USB adapter"
+	depends on USB
+	help
+	  If you say yes to this option, support will be included for the
+	  RobotFuzz Open Source InterFace USB to I2C interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-osif.
+
 config I2C_TAOS_EVM
 	tristate "TAOS evaluation module"
 	depends on TTY
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index d00997f3eb3b..f171fa8b1a72 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_I2C_RCAR)		+= i2c-rcar.o
 obj-$(CONFIG_I2C_DIOLAN_U2C)	+= i2c-diolan-u2c.o
 obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
 obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
+obj-$(CONFIG_I2C_ROBOTFUZZ_OSIF)	+= i2c-robotfuzz-osif.o
 obj-$(CONFIG_I2C_TAOS_EVM)	+= i2c-taos-evm.o
 obj-$(CONFIG_I2C_TINY_USB)	+= i2c-tiny-usb.o
 obj-$(CONFIG_I2C_VIPERBOARD)	+= i2c-viperboard.o
diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
new file mode 100644
index 000000000000..ced9c6a308d1
--- /dev/null
+++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
@@ -0,0 +1,202 @@
+/*
+ * Driver for RobotFuzz OSIF
+ *
+ * Copyright (c) 2013 Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
+ * Copyright (c) 2007 Barry Carter <Barry.Carter-hIwygO75nSHCXR85Y8Hu3Q@public.gmane.org>
+ *
+ * Based on the i2c-tiny-usb by
+ *
+ * Copyright (C) 2006 Til Harbaum (Till-zicpKgigMvpAfugRpC6u6w@public.gmane.org)
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+
+#define OSIFI2C_READ		20
+#define OSIFI2C_WRITE		21
+#define OSIFI2C_STOP		22
+#define OSIFI2C_STATUS		23
+#define OSIFI2C_SET_BIT_RATE	24
+
+#define STATUS_ADDRESS_ACK	0
+#define STATUS_ADDRESS_NAK	2
+
+struct osif_priv {
+	struct usb_device *usb_dev;
+	struct usb_interface *interface;
+	struct i2c_adapter adapter;
+	unsigned char status;
+};
+
+static int osif_usb_read(struct i2c_adapter *adapter, int cmd,
+			 int value, int index, void *data, int len)
+{
+	struct osif_priv *priv = adapter->algo_data;
+
+	return usb_control_msg(priv->usb_dev, usb_rcvctrlpipe(priv->usb_dev, 0),
+			       cmd, USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
+			       USB_DIR_IN, value, index, data, len, 2000);
+}
+
+static int osif_usb_write(struct i2c_adapter *adapter, int cmd,
+			  int value, int index, void *data, int len)
+{
+
+	struct osif_priv *priv = adapter->algo_data;
+
+	return usb_control_msg(priv->usb_dev, usb_sndctrlpipe(priv->usb_dev, 0),
+			       cmd, USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+			       value, index, data, len, 2000);
+}
+
+static int osif_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
+			 int num)
+{
+	struct osif_priv *priv = adapter->algo_data;
+	struct i2c_msg *pmsg;
+	int ret = 0;
+	int i, cmd;
+
+	for (i = 0; ret >= 0 && i < num; i++) {
+		pmsg = &msgs[i];
+
+		if (pmsg->flags & I2C_M_RD) {
+			cmd = OSIFI2C_READ;
+
+			ret = osif_usb_read(adapter, cmd, pmsg->flags,
+					    pmsg->addr, pmsg->buf,
+					    pmsg->len);
+			if (ret != pmsg->len) {
+				dev_err(&adapter->dev, "failure reading data\n");
+				return -EREMOTEIO;
+			}
+		} else {
+			cmd = OSIFI2C_WRITE;
+
+			ret = osif_usb_write(adapter, cmd, pmsg->flags,
+					     pmsg->addr, pmsg->buf, pmsg->len);
+			if (ret != pmsg->len) {
+				dev_err(&adapter->dev, "failure writing data\n");
+				return -EREMOTEIO;
+			}
+		}
+
+		ret = osif_usb_read(adapter, OSIFI2C_STOP, 0, 0, NULL, 0);
+		if (ret) {
+			dev_err(&adapter->dev, "failure sending STOP\n");
+			return -EREMOTEIO;
+		}
+
+		/* read status */
+		ret = osif_usb_read(adapter, OSIFI2C_STATUS, 0, 0,
+				    &priv->status, 1);
+		if (ret != 1) {
+			dev_err(&adapter->dev, "failure reading status\n");
+			return -EREMOTEIO;
+		}
+
+		if (priv->status != STATUS_ADDRESS_ACK) {
+			dev_dbg(&adapter->dev, "status = %d\n", priv->status);
+			return -EREMOTEIO;
+		}
+	}
+
+	return i;
+}
+
+static u32 osif_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static struct i2c_algorithm osif_algorithm = {
+	.master_xfer	= osif_xfer,
+	.functionality	= osif_func,
+};
+
+#define USB_OSIF_VENDOR_ID	0x1964
+#define USB_OSIF_PRODUCT_ID	0x0001
+
+static struct usb_device_id osif_table[] = {
+	{ USB_DEVICE(USB_OSIF_VENDOR_ID, USB_OSIF_PRODUCT_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, osif_table);
+
+static int osif_probe(struct usb_interface *interface,
+			     const struct usb_device_id *id)
+{
+	int ret;
+	struct osif_priv *priv;
+	u16 version;
+
+	priv = devm_kzalloc(&interface->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->usb_dev = usb_get_dev(interface_to_usbdev(interface));
+	priv->interface = interface;
+
+	usb_set_intfdata(interface, priv);
+
+	priv->adapter.owner = THIS_MODULE;
+	priv->adapter.class = I2C_CLASS_HWMON;
+	priv->adapter.algo = &osif_algorithm;
+	priv->adapter.algo_data = priv;
+	snprintf(priv->adapter.name, sizeof(priv->adapter.name),
+		 "OSIF at bus %03d device %03d",
+		 priv->usb_dev->bus->busnum, priv->usb_dev->devnum);
+
+	/*
+	 * Set bus frequency. The frequency is:
+	 * 120,000,000 / ( 16 + 2 * div * 4^prescale).
+	 * Using dev = 52, prescale = 0 give 100KHz */
+	ret = osif_usb_read(&priv->adapter, OSIFI2C_SET_BIT_RATE, 52, 0,
+			    NULL, 0);
+	if (ret) {
+		dev_err(&interface->dev, "failure sending bit rate");
+		usb_put_dev(priv->usb_dev);
+		return ret;
+	}
+
+	i2c_add_adapter(&(priv->adapter));
+
+	version = le16_to_cpu(priv->usb_dev->descriptor.bcdDevice);
+	dev_info(&interface->dev,
+		 "version %x.%02x found at bus %03d address %03d",
+		 version >> 8, version & 0xff,
+		 priv->usb_dev->bus->busnum, priv->usb_dev->devnum);
+
+	return 0;
+}
+
+static void osif_disconnect(struct usb_interface *interface)
+{
+	struct osif_priv *priv = usb_get_intfdata(interface);
+
+	i2c_del_adapter(&(priv->adapter));
+	usb_set_intfdata(interface, NULL);
+	usb_put_dev(priv->usb_dev);
+}
+
+static struct usb_driver osif_driver = {
+	.name		= "RobotFuzz Open Source InterFace, OSIF",
+	.probe		= osif_probe,
+	.disconnect	= osif_disconnect,
+	.id_table	= osif_table,
+};
+
+module_usb_driver(osif_driver);
+
+MODULE_AUTHOR("Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>");
+MODULE_AUTHOR("Barry Carter <barry.carter-hIwygO75nSHCXR85Y8Hu3Q@public.gmane.org>");
+MODULE_DESCRIPTION("RobotFuzz OSIF driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.5.1
