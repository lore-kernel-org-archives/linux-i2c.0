From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 1/2] mfd: ti-smusbdig: Add support for the TI SM-USB-DIG
Date: Fri, 10 Jun 2016 11:35:42 -0500
Message-ID: <20160610163543.9880-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-i2c@vger.kernel.org

The TI SM-USB-DIG is a USB to SPI/I2C/1Wire/GPIO adapter.
Add MFD core support.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/mfd/Kconfig             |   8 +++
 drivers/mfd/Makefile            |   2 +
 drivers/mfd/ti-smusbdig.c       | 138 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/ti-smusbdig.h |  75 ++++++++++++++++++++++
 4 files changed, 223 insertions(+)
 create mode 100644 drivers/mfd/ti-smusbdig.c
 create mode 100644 include/linux/mfd/ti-smusbdig.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 1bcf601..cabbf60 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1373,6 +1373,14 @@ config MFD_LM3533
 	  additional drivers must be enabled in order to use the LED,
 	  backlight or ambient-light-sensor functionality of the device.
 
+config MFD_TI_SMUSBDIG
+	tristate "Texas Instruments SM-USB-DIG interface adapter"
+	select MFD_CORE
+	help
+	  Support for the TI SM-USB-DIG USB to SPI/I2C/1Wire/GPIO adapter.
+	  Additional drivers such as SPI_TI_SMUSBDIG, I2C_TI_SMUSBDIG, etc. must
+	  be enabled in order to use the functionality of the device.
+
 config MFD_TIMBERDALE
 	tristate "Timberdale FPGA"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 42a66e1..4533b95 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -68,6 +68,8 @@ obj-$(CONFIG_MFD_WM8350_I2C)	+= wm8350-i2c.o
 wm8994-objs			:= wm8994-core.o wm8994-irq.o wm8994-regmap.o
 obj-$(CONFIG_MFD_WM8994)	+= wm8994.o
 
+obj-$(CONFIG_MFD_TI_SMUSBDIG)	+= ti-smusbdig.o
+
 obj-$(CONFIG_TPS6105X)		+= tps6105x.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_TPS6507X)		+= tps6507x.o
diff --git a/drivers/mfd/ti-smusbdig.c b/drivers/mfd/ti-smusbdig.c
new file mode 100644
index 0000000..19f48c6
--- /dev/null
+++ b/drivers/mfd/ti-smusbdig.c
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
+#include <linux/mfd/core.h>
+#include <linux/mfd/ti-smusbdig.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#define TI_USB_VENDOR_ID                0x0451
+#define TI_USB_DEVICE_ID_SM_USB_DIG     0x2f90
+
+#define TI_SMUSBDIG_USB_TIMEOUT_MS      1000
+
+struct ti_smusbdig_device {
+	struct usb_device *usb_dev;
+	struct usb_interface *interface;
+};
+
+int ti_smusbdig_xfer(struct ti_smusbdig_device *ti_smusbdig,
+		     u8 *buffer, int size)
+{
+	struct device *dev = &ti_smusbdig->interface->dev;
+	int actual_length, ret;
+
+	if (!ti_smusbdig || !buffer || size <= 0)
+		return -EINVAL;
+
+	ret = usb_interrupt_msg(ti_smusbdig->usb_dev,
+				usb_sndctrlpipe(ti_smusbdig->usb_dev, 1),
+				buffer, size, &actual_length,
+				TI_SMUSBDIG_USB_TIMEOUT_MS);
+	if (ret) {
+		dev_err(dev, "USB transaction failed\n");
+		return ret;
+	}
+
+	ret = usb_interrupt_msg(ti_smusbdig->usb_dev,
+				usb_rcvctrlpipe(ti_smusbdig->usb_dev, 1),
+				buffer, TI_SMUSBDIG_PACKET_SIZE, &actual_length,
+				TI_SMUSBDIG_USB_TIMEOUT_MS);
+	if (ret) {
+		dev_err(dev, "USB transaction failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ti_smusbdig_xfer);
+
+static const struct mfd_cell ti_smusbdig_mfd_cells[] = {
+	{ .name = "ti-sm-usb-dig-gpio", },
+	{ .name = "ti-sm-usb-dig-i2c", },
+	{ .name = "ti-sm-usb-dig-spi", },
+	{ .name = "ti-sm-usb-dig-w1", },
+};
+
+static int ti_smusbdig_probe(struct usb_interface *interface,
+			     const struct usb_device_id *usb_id)
+{
+	struct usb_host_interface *hostif = interface->cur_altsetting;
+	struct device *dev = &interface->dev;
+	struct ti_smusbdig_device *ti_smusbdig;
+	u8 buffer[TI_SMUSBDIG_PACKET_SIZE];
+	int ret;
+
+	if (hostif->desc.bInterfaceNumber != 0 ||
+	    hostif->desc.bNumEndpoints < 2)
+		return -ENODEV;
+
+	ti_smusbdig = devm_kzalloc(dev, sizeof(*ti_smusbdig), GFP_KERNEL);
+	if (!ti_smusbdig)
+		return -ENOMEM;
+
+	ti_smusbdig->usb_dev = usb_get_dev(interface_to_usbdev(interface));
+	ti_smusbdig->interface = interface;
+	usb_set_intfdata(interface, ti_smusbdig);
+
+	buffer[0] = TI_SMUSBDIG_VERSION;
+	ret = ti_smusbdig_xfer(ti_smusbdig, buffer, 1);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "TI SM-USB-DIG Version: %d.%02d Found\n",
+		 buffer[0], buffer[1]);
+
+	/* Turn on power supply output */
+	buffer[0] = TI_SMUSBDIG_COMMAND;
+	buffer[1] = TI_SMUSBDIG_COMMAND_DUTPOWERON;
+	ret = ti_smusbdig_xfer(ti_smusbdig, buffer, 2);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, ti_smusbdig);
+	ret = mfd_add_hotplug_devices(dev, ti_smusbdig_mfd_cells,
+				      ARRAY_SIZE(ti_smusbdig_mfd_cells));
+	if (ret) {
+		dev_err(dev, "unable to add MFD devices\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ti_smusbdig_disconnect(struct usb_interface *interface)
+{
+	mfd_remove_devices(&interface->dev);
+}
+
+static const struct usb_device_id ti_smusbdig_id_table[] = {
+	{ USB_DEVICE(TI_USB_VENDOR_ID, TI_USB_DEVICE_ID_SM_USB_DIG) },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(usb, ti_smusbdig_id_table);
+
+static struct usb_driver ti_smusbdig_driver = {
+	.name = "ti-sm-usb-dig",
+	.probe = ti_smusbdig_probe,
+	.disconnect = ti_smusbdig_disconnect,
+	.id_table = ti_smusbdig_id_table,
+};
+module_usb_driver(ti_smusbdig_driver);
+
+MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_DESCRIPTION("Core driver for TI SM-USB-DIG interface adapter");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/ti-smusbdig.h b/include/linux/mfd/ti-smusbdig.h
new file mode 100644
index 0000000..46fd2da
--- /dev/null
+++ b/include/linux/mfd/ti-smusbdig.h
@@ -0,0 +1,75 @@
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
+#ifndef __LINUX_MFD_TI_SMUSBDIG_H
+#define __LINUX_MFD_TI_SMUSBDIG_H
+
+#define TI_SMUSBDIG_PACKET_SIZE    32
+/* (packet size - packet header */
+#define TI_SMUSBDIG_DATA_SIZE (TI_SMUSBDIG_PACKET_SIZE - 7)
+
+enum ti_smusbdig_function {
+	TI_SMUSBDIG_SPI            = 0x01,
+	TI_SMUSBDIG_I2C            = 0x02,
+	TI_SMUSBDIG_1W             = 0x03,
+	TI_SMUSBDIG_COMMAND        = 0x04,
+	TI_SMUSBDIG_VERSION        = 0x07,
+};
+
+enum ti_smusbdig_sub_command {
+	TI_SMUSBDIG_COMMAND_DUTPOWERON	= 0x01,
+	TI_SMUSBDIG_COMMAND_DUTPOWEROFF	= 0x02,
+};
+
+struct ti_smusbdig_packet {
+	u8 function;
+	u8 channel;
+	u8 edge_polarity;
+	u8 num_commands;
+	u8 is_command_mask[3];
+	u8 data[TI_SMUSBDIG_DATA_SIZE];
+} __packed;
+
+static inline void
+ti_smusbdig_packet_add_command(struct ti_smusbdig_packet *packet, int command)
+{
+	int num_commands = packet->num_commands;
+	int mask_number = num_commands / 8;
+	int mask_bit = num_commands % 8;
+
+	if (num_commands >= TI_SMUSBDIG_DATA_SIZE)
+		return;
+
+	packet->is_command_mask[mask_number] |= BIT(7 - mask_bit);
+	packet->data[num_commands] = command;
+	packet->num_commands++;
+}
+
+static inline void
+ti_smusbdig_packet_add_data(struct ti_smusbdig_packet *packet, u8 data)
+{
+	int num_commands = packet->num_commands;
+
+	if (num_commands >= TI_SMUSBDIG_DATA_SIZE)
+		return;
+
+	packet->data[num_commands] = data;
+	packet->num_commands++;
+}
+
+struct ti_smusbdig_device;
+int ti_smusbdig_xfer(struct ti_smusbdig_device *ti_smusbdig,
+		     u8 *buffer, int size);
+
+#endif /* __LINUX_MFD_TI_SMUSBDIG_H */
-- 
2.8.3
