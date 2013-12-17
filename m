From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: [RESEND PATCH v1 2/2] i2c: Add bus driver for for OSIF USB i2c device.
Date: Tue, 17 Dec 2013 21:31:48 +0100
Message-ID: <1387312308-2222-2-git-send-email-andrew@lunn.ch>
References: <1387312308-2222-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387312308-2222-1-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
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
 drivers/i2c/busses/Kconfig    |  10 ++
 drivers/i2c/busses/Makefile   |   1 +
 drivers/i2c/busses/i2c-osif.c | 267 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 278 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-osif.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index cdcbd8368ed3..e7ed9edd79e2 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -788,6 +788,16 @@ config I2C_DIOLAN_U2C
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-diolan-u2c.
 
+config I2C_OSIF
+	tristate "RobotFuzz Open Source InterFace USB adapter"
+	depends on USB
+	help
+	  If you say yes to this option, support will be included for the
+	  RobotFuzz Open Source InterFace USB to I2C interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-osif.
+
 config I2C_PARPORT
 	tristate "Parallel port adapter"
 	depends on PARPORT
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index d00997f3eb3b..4c147862b2a7 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_I2C_RCAR)		+= i2c-rcar.o
 
 # External I2C/SMBus adapter drivers
 obj-$(CONFIG_I2C_DIOLAN_U2C)	+= i2c-diolan-u2c.o
+obj-$(CONFIG_I2C_OSIF)		+= i2c-osif.o
 obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
 obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
 obj-$(CONFIG_I2C_TAOS_EVM)	+= i2c-taos-evm.o
diff --git a/drivers/i2c/busses/i2c-osif.c b/drivers/i2c/busses/i2c-osif.c
new file mode 100644
index 000000000000..8c12407d88c2
--- /dev/null
+++ b/drivers/i2c/busses/i2c-osif.c
@@ -0,0 +1,267 @@
+/*
+ * Driver for RobotFuzz OSIF
+ *
+ * Copyright (c) 2007 Barry Carter <Barry.Carter-hIwygO75nSHCXR85Y8Hu3Q@public.gmane.org>
+ * Copyright (c) 2013 Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
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
+#define DRIVER_AUTHOR  "Barry Carter <barry.carter-hIwygO75nSHCXR85Y8Hu3Q@public.gmane.org>,"	\
+	"Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>"
+#define DRIVER_DESC    "OSIF driver"
+
+#define OSIFI2C_READ		20 /* Read from i2c bus */
+#define OSIFI2C_WRITE		21 /* Write to i2c bus */
+#define OSIFI2C_STOP		22 /* Send stop condition */
+#define OSIFI2C_STATUS		23 /* Get status from i2c action */
+#define OSIFI2C_SET_BIT_RATE	24 /* Set the bit rate & prescaler */
+
+#define STATUS_ADDRESS_ACK	0
+#define STATUS_ADDRESS_NAK	2
+
+static int usb_read(struct i2c_adapter *adapter, int cmd,
+		    int value, int index, void *data, int len);
+
+static int usb_write(struct i2c_adapter *adapter, int cmd,
+		     int value, int index, void *data, int len);
+
+/* ----- begin of i2c layer ---------------------------------------------- */
+
+static int usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
+{
+	unsigned char *pstatus;
+	struct i2c_msg *pmsg;
+	int ret = 0;
+	int i, cmd;
+
+	dev_dbg(&adapter->dev, "master xfer %d messages:\n", num);
+
+	pstatus = kmalloc(sizeof(*pstatus), GFP_KERNEL);
+	if (!pstatus)
+		return -ENOMEM;
+
+	for (i = 0; ret >= 0 && i < num; i++) {
+
+		pmsg = &msgs[i];
+
+		dev_dbg(&adapter->dev,
+			"  %d: %s (flags %d) %d bytes to 0x%02x\n",
+			i, pmsg->flags & I2C_M_RD ? "read" : "write",
+			pmsg->flags, pmsg->len, pmsg->addr);
+
+		if (pmsg->flags & I2C_M_RD) {
+			cmd = OSIFI2C_READ;
+
+			ret = usb_read(adapter, cmd, pmsg->flags, pmsg->addr,
+				       pmsg->buf, pmsg->len);
+			if (ret != pmsg->len) {
+				dev_err(&adapter->dev,
+					"failure reading data\n");
+				ret = -EREMOTEIO;
+				goto out;
+			}
+		} else {
+			cmd = OSIFI2C_WRITE;
+
+			ret = usb_write(adapter, cmd, pmsg->flags, pmsg->addr,
+					pmsg->buf, pmsg->len);
+			if (ret != pmsg->len) {
+				dev_err(&adapter->dev,
+					"failure writing data\n");
+				ret = -EREMOTEIO;
+				goto out;
+			}
+		}
+
+		ret = usb_read(adapter, OSIFI2C_STOP, 0, 0, NULL, 0);
+		if (ret != 0) {
+			dev_err(&adapter->dev, "failure sending STOP\n");
+			ret = -EREMOTEIO;
+			goto out;
+		}
+
+		/* read status */
+		ret = usb_read(adapter, OSIFI2C_STATUS, 0, 0, pstatus, 1);
+		if (ret != 1) {
+			dev_err(&adapter->dev, "failure reading status\n");
+			ret = -EREMOTEIO;
+			goto out;
+		}
+
+		dev_dbg(&adapter->dev, "status = %d\n", *pstatus);
+		if (*pstatus != STATUS_ADDRESS_ACK) {
+			ret = -EREMOTEIO;
+			goto out;
+		}
+	}
+
+	ret = i;
+out:
+	kfree(pstatus);
+	return ret;
+}
+
+static u32 usb_func(struct i2c_adapter *adapter)
+{
+	/* configure for I2c mode and SMBUS emulation */
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+/* This is the actual algorithm we define */
+static struct i2c_algorithm usb_algorithm = {
+	.master_xfer	= usb_xfer,
+	.functionality	= usb_func,
+};
+
+/* ----- end of i2c layer ---------------------------------------------- */
+
+/* ----- begin of usb layer ---------------------------------------------- */
+
+/* the usb i2c interface uses a vid/pid pair donated by ftdi */
+#define USB_OSIF_VENDOR_ID	0x1964
+#define USB_OSIF_PRODUCT_ID	0x0001
+
+/* table of devices that work with this driver */
+static struct usb_device_id osif_table[] = {
+	{ USB_DEVICE(USB_OSIF_VENDOR_ID, USB_OSIF_PRODUCT_ID) },
+	{ } /* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(usb, osif_table);
+
+/* Structure to hold all of our device specific stuff */
+struct priv {
+	struct usb_device *usb_dev; /* the usb device for this device */
+	struct usb_interface *interface; /* the interface for this device */
+	struct i2c_adapter adapter; /* i2c related things */
+};
+
+static int usb_read(struct i2c_adapter *adapter, int cmd,
+		    int value, int index, void *data, int len)
+{
+	struct priv *priv = (struct priv *)adapter->algo_data;
+
+	/* do control transfer */
+	return usb_control_msg(priv->usb_dev, usb_rcvctrlpipe(priv->usb_dev, 0),
+			       cmd, USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
+			       USB_DIR_IN, value, index, data, len, 2000);
+}
+
+static int usb_write(struct i2c_adapter *adapter, int cmd,
+		    int value, int index, void *data, int len)
+{
+
+	struct priv *priv = (struct priv *)adapter->algo_data;
+
+	/* do control transfer */
+	return usb_control_msg(priv->usb_dev, usb_sndctrlpipe(priv->usb_dev, 0),
+			       cmd, USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+			       value, index, data, len, 2000);
+}
+
+static void osif_free(struct priv *priv)
+{
+	usb_put_dev(priv->usb_dev);
+}
+
+static int osif_probe(struct usb_interface *interface,
+			     const struct usb_device_id *id)
+{
+	struct priv *priv = NULL;
+	int retval = -ENOMEM;
+	u16 version;
+
+	dev_dbg(&interface->dev, "probing usb device");
+
+	/* allocate memory for our device state and initialize it */
+	priv = devm_kzalloc(&interface->dev, sizeof(*priv), GFP_KERNEL);
+	if (priv == NULL) {
+		dev_err(&interface->dev, "Out of memory\n");
+		goto error;
+	}
+
+	priv->usb_dev = usb_get_dev(interface_to_usbdev(interface));
+	priv->interface = interface;
+
+	/* save our data pointer in this interface device */
+	usb_set_intfdata(interface, priv);
+
+	version = le16_to_cpu(priv->usb_dev->descriptor.bcdDevice);
+	dev_info(&interface->dev,
+		 "version %x.%02x found at bus %03d address %03d",
+		 version >> 8, version & 0xff,
+		 priv->usb_dev->bus->busnum, priv->usb_dev->devnum);
+
+	/* setup i2c adapter description */
+	priv->adapter.owner = THIS_MODULE;
+	priv->adapter.class = I2C_CLASS_HWMON;
+	priv->adapter.algo = &usb_algorithm;
+	priv->adapter.algo_data = priv;
+	snprintf(priv->adapter.name, sizeof(priv->adapter.name),
+		 "OSIF at bus %03d device %03d",
+		 priv->usb_dev->bus->busnum, priv->usb_dev->devnum);
+
+	/*
+	 * Set bus frequency. The frequency is:
+	 * 120,000,000 / ( 16 + 2(div)*4^prescale).
+	 * Using dev=52, prescale =0 give 100KHz */
+	retval = usb_read(&priv->adapter, OSIFI2C_SET_BIT_RATE, 52, 0, NULL, 0);
+	if (retval != 0) {
+		dev_err(&interface->dev, "failure sending bit rate");
+		retval = -EREMOTEIO;
+		goto error;
+	}
+
+	/* and finally attach to i2c layer */
+	i2c_add_adapter(&(priv->adapter));
+
+	/* inform user about successful attachment to i2c layer */
+	dev_info(&priv->adapter.dev, "connected OSIF device\n");
+
+	return 0;
+
+error:
+
+	if (priv)
+		osif_free(priv);
+
+	return retval;
+}
+
+static void osif_disconnect(struct usb_interface *interface)
+{
+	struct priv *priv = usb_get_intfdata(interface);
+
+	i2c_del_adapter(&(priv->adapter));
+	usb_set_intfdata(interface, NULL);
+	osif_free(priv);
+}
+
+static struct usb_driver osif_driver = {
+	.name		= "Open Source InterFace OSIF",
+	.probe		= osif_probe,
+	.disconnect	= osif_disconnect,
+	.id_table	= osif_table,
+};
+
+module_usb_driver(osif_driver);
+
+/* ----- end of usb layer ---------------------------------------------- */
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
-- 
1.8.5.1
