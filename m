From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 1/2] mfd: sm-usb-dig: Add support for the TI SM-USB-DIG
Date: Tue, 31 May 2016 12:30:44 -0500
Message-ID: <20160531173045.5742-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-i2c@vger.kernel.org

The TI SM-USB-DIG is a USB to SPI/I2C/1Wire/GPIO adapter.
Add MFD core support.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
The SPI, GPIO, and 1Wire drivers are WIP.

 drivers/mfd/Kconfig            |   8 +++
 drivers/mfd/Makefile           |   2 +
 drivers/mfd/sm-usb-dig.c       | 138 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/sm-usb-dig.h |  73 ++++++++++++++++++++++
 4 files changed, 221 insertions(+)
 create mode 100644 drivers/mfd/sm-usb-dig.c
 create mode 100644 include/linux/mfd/sm-usb-dig.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 1bcf601..455219a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1373,6 +1373,14 @@ config MFD_LM3533
 	  additional drivers must be enabled in order to use the LED,
 	  backlight or ambient-light-sensor functionality of the device.
 
+config MFD_SM_USB_DIG
+	tristate "Texas Instruments SM-USB-DIG interface adapter"
+	select MFD_CORE
+	help
+	  Support for the TI SM-USB-DIG USB to SPI/I2C/1Wire/GPIO adapter.
+	  Additional drivers such as SPI_SM_USB_DIG, I2C_SM_USB_DIG, etc. must
+	  be enabled in order to use the functionality of the device.
+
 config MFD_TIMBERDALE
 	tristate "Timberdale FPGA"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 42a66e1..376013e 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -68,6 +68,8 @@ obj-$(CONFIG_MFD_WM8350_I2C)	+= wm8350-i2c.o
 wm8994-objs			:= wm8994-core.o wm8994-irq.o wm8994-regmap.o
 obj-$(CONFIG_MFD_WM8994)	+= wm8994.o
 
+obj-$(CONFIG_MFD_SM_USB_DIG)    += sm-usb-dig.o
+
 obj-$(CONFIG_TPS6105X)		+= tps6105x.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_TPS6507X)		+= tps6507x.o
diff --git a/drivers/mfd/sm-usb-dig.c b/drivers/mfd/sm-usb-dig.c
new file mode 100644
index 0000000..cf7ccab
--- /dev/null
+++ b/drivers/mfd/sm-usb-dig.c
@@ -0,0 +1,138 @@
+/*
+ * MFD Core driver for TI SM-USB-DIG
+ *
+ * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ *	Andrew F. Davis <afd@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether expressed or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License version 2 for more details.
+ */
+
+#include <linux/usb.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+
+#include <linux/mfd/sm-usb-dig.h>
+
+#define USB_VENDOR_ID_TI                0x0451
+#define USB_DEVICE_ID_TI_SM_USB_DIG	0x2f90
+
+#define SMUSBDIG_USB_TIMEOUT		1000	/* in ms */
+
+struct smusbdig_device {
+	struct usb_device *usb_dev;
+	struct usb_interface *interface;
+};
+
+int smusbdig_xfer(struct smusbdig_device *smusbdig, u8 *buffer, int size)
+{
+	struct device *dev = &smusbdig->interface->dev;
+	int actual_length, ret;
+
+	if (!smusbdig || !buffer || size <= 0)
+		return -EINVAL;
+
+	ret = usb_interrupt_msg(smusbdig->usb_dev,
+				usb_sndctrlpipe(smusbdig->usb_dev, 1),
+				buffer, size, &actual_length,
+				SMUSBDIG_USB_TIMEOUT);
+	if (ret) {
+		dev_err(dev, "USB transaction failed\n");
+		return ret;
+	}
+
+	ret = usb_interrupt_msg(smusbdig->usb_dev,
+				usb_rcvctrlpipe(smusbdig->usb_dev, 1),
+				buffer, SMUSBDIG_PACKET_SIZE, &actual_length,
+				SMUSBDIG_USB_TIMEOUT);
+	if (ret) {
+		dev_err(dev, "USB transaction failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(smusbdig_xfer);
+
+static const struct mfd_cell smusbdig_mfd_cells[] = {
+	{ .name = "sm-usb-dig-gpio", },
+	{ .name = "sm-usb-dig-i2c", },
+	{ .name = "sm-usb-dig-spi", },
+	{ .name = "sm-usb-dig-w1", },
+};
+
+static int smusbdig_probe(struct usb_interface *interface,
+			  const struct usb_device_id *usb_id)
+{
+	struct usb_host_interface *hostif = interface->cur_altsetting;
+	struct device *dev = &interface->dev;
+	struct smusbdig_device *smusbdig;
+	u8 buffer[SMUSBDIG_PACKET_SIZE];
+	int ret;
+
+	if (hostif->desc.bInterfaceNumber != 0 ||
+	    hostif->desc.bNumEndpoints < 2)
+		return -ENODEV;
+
+	smusbdig = devm_kzalloc(dev, sizeof(*smusbdig), GFP_KERNEL);
+	if (!smusbdig)
+		return -ENOMEM;
+
+	smusbdig->usb_dev = usb_get_dev(interface_to_usbdev(interface));
+	smusbdig->interface = interface;
+	usb_set_intfdata(interface, smusbdig);
+
+	buffer[0] = SMUSBDIG_VERSION;
+	ret = smusbdig_xfer(smusbdig, buffer, 1);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "TI SM-USB-DIG Version: %d.%02d Found\n",
+		 buffer[0], buffer[1]);
+
+	/* Turn on power supply output */
+	buffer[0] = SMUSBDIG_COMMAND;
+	buffer[1] = SMUSBDIG_COMMAND_DUTPOWERON;
+	ret = smusbdig_xfer(smusbdig, buffer, 2);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, smusbdig);
+	ret = mfd_add_hotplug_devices(dev, smusbdig_mfd_cells,
+				      ARRAY_SIZE(smusbdig_mfd_cells));
+	if (ret) {
+		dev_err(dev, "unable to add MFD devices\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+void smusbdig_disconnect(struct usb_interface *interface)
+{
+	mfd_remove_devices(&interface->dev);
+}
+
+static const struct usb_device_id smusbdig_id_table[] = {
+	{ USB_DEVICE(USB_VENDOR_ID_TI, USB_DEVICE_ID_TI_SM_USB_DIG) },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(usb, smusbdig_id_table);
+
+static struct usb_driver smusbdig_driver = {
+	.name = "sm-usb-dig",
+	.probe = smusbdig_probe,
+	.disconnect = smusbdig_disconnect,
+	.id_table = smusbdig_id_table,
+};
+module_usb_driver(smusbdig_driver);
+
+MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_DESCRIPTION("Core driver for TI SM-USB-DIG interface adapter");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/sm-usb-dig.h b/include/linux/mfd/sm-usb-dig.h
new file mode 100644
index 0000000..1558ff2
--- /dev/null
+++ b/include/linux/mfd/sm-usb-dig.h
@@ -0,0 +1,73 @@
+/*
+ * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ *	Andrew F. Davis <afd@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether expressed or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License version 2 for more details.
+ */
+
+#ifndef __LINUX_MFD_SM_USB_DIG_H
+#define __LINUX_MFD_SM_USB_DIG_H
+
+#define SMUSBDIG_PACKET_SIZE    32
+/* (packet size - packet header */
+#define SMUSBDIG_DATA_SIZE (SMUSBDIG_PACKET_SIZE - 7)
+
+enum smusbdig_function {
+	SMUSBDIG_SPI            = 0x01,
+	SMUSBDIG_I2C            = 0x02,
+	SMUSBDIG_1W             = 0x03,
+	SMUSBDIG_COMMAND        = 0x04,
+	SMUSBDIG_VERSION        = 0x07,
+};
+
+enum smusbdig_sub_command {
+	SMUSBDIG_COMMAND_DUTPOWERON	= 0x01,
+	SMUSBDIG_COMMAND_DUTPOWEROFF	= 0x02,
+};
+
+struct smusbdig_packet {
+	u8 function;
+	u8 channel;
+	u8 edge_polarity;
+	u8 num_commands;
+	u8 is_command_mask[3];
+	u8 data[SMUSBDIG_DATA_SIZE];
+} __packed;
+
+static void smusbdig_packet_add_command(struct smusbdig_packet *packet,
+					int command)
+{
+	int num_commands = packet->num_commands;
+	int mask_number = num_commands / 8;
+	int mask_bit = num_commands % 8;
+
+	if (num_commands >= SMUSBDIG_DATA_SIZE)
+		return;
+
+	packet->is_command_mask[mask_number] |= BIT(7 - mask_bit);
+	packet->data[num_commands] = command;
+	packet->num_commands++;
+}
+
+static void smusbdig_packet_add_data(struct smusbdig_packet *packet, u8 data)
+{
+	int num_commands = packet->num_commands;
+
+	if (num_commands >= SMUSBDIG_DATA_SIZE)
+		return;
+
+	packet->data[num_commands] = data;
+	packet->num_commands++;
+}
+
+struct smusbdig_device;
+int smusbdig_xfer(struct smusbdig_device *smusbdig, u8 *buffer, int size);
+
+#endif /* __LINUX_MFD_SM_USB_DIG_H */
-- 
2.8.3
