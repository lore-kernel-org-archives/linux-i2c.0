From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 2/2] i2c: sm-usb-dig: add TI SM-USB-DIG I2C bus driver
Date: Tue, 31 May 2016 12:30:45 -0500
Message-ID: <20160531173045.5742-2-afd@ti.com>
References: <20160531173045.5742-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160531173045.5742-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-i2c@vger.kernel.org

Add support for the I2C bus functionality of the TI SM-USB-DIG.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/i2c/busses/Kconfig          |  10 ++
 drivers/i2c/busses/Makefile         |   1 +
 drivers/i2c/busses/i2c-sm-usb-dig.c | 190 ++++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-sm-usb-dig.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index f167021..5c74d09 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1076,6 +1076,16 @@ config I2C_ROBOTFUZZ_OSIF
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-osif.
 
+config I2C_SM_USB_DIG
+	tristate "Texas Instruments SM-USB-DIG I2C interface"
+	depends on MFD_SM_USB_DIG
+	help
+	  This adds support for the I2C bus functionality of the
+	  TI SM-USB-DIG USB interface adapter.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-sm-usb-dig.
+
 config I2C_TAOS_EVM
 	tristate "TAOS evaluation module"
 	depends on TTY
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 37f2819..2ee25ef 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_I2C_DLN2)		+= i2c-dln2.o
 obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
 obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
 obj-$(CONFIG_I2C_ROBOTFUZZ_OSIF)	+= i2c-robotfuzz-osif.o
+obj-$(CONFIG_I2C_SM_USB_DIG)	+= i2c-sm-usb-dig.o
 obj-$(CONFIG_I2C_TAOS_EVM)	+= i2c-taos-evm.o
 obj-$(CONFIG_I2C_TINY_USB)	+= i2c-tiny-usb.o
 obj-$(CONFIG_I2C_VIPERBOARD)	+= i2c-viperboard.o
diff --git a/drivers/i2c/busses/i2c-sm-usb-dig.c b/drivers/i2c/busses/i2c-sm-usb-dig.c
new file mode 100644
index 0000000..719a8c1
--- /dev/null
+++ b/drivers/i2c/busses/i2c-sm-usb-dig.c
@@ -0,0 +1,190 @@
+/*
+ * I2C bus driver for TI SM-USB-DIG
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
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <linux/mfd/sm-usb-dig.h>
+
+/* (data size - start condition - address - ACK) / ACK after data byte */
+#define SMUSBDIG_I2C_MAX_MSG ((SMUSBDIG_DATA_SIZE - 3) / 2)
+
+struct smusbdig_i2c {
+	struct device *dev;
+	struct smusbdig_device *smusbdig;
+	struct i2c_adapter adapter;
+};
+
+enum smusbdig_i2c_command {
+	SMUSBDIG_I2C_START = 0x3,
+	SMUSBDIG_I2C_STOP = 0x4,
+	SMUSBDIG_I2C_ACKM = 0x5,
+	SMUSBDIG_I2C_ACKS = 0x6,
+};
+
+static void smusbdig_i2c_packet_init(struct smusbdig_packet *packet)
+{
+	memset(packet, 0, sizeof(*packet));
+	packet->function = SMUSBDIG_I2C;
+	packet->channel = 0x1;
+}
+
+static int smusbdig_i2c_xfer(struct i2c_adapter *adapter,
+			     struct i2c_msg *msgs, int num)
+{
+	struct smusbdig_i2c *smusbdig_i2c = i2c_get_adapdata(adapter);
+	struct smusbdig_packet packet;
+	int i, j, k, ret;
+
+	for (i = 0; i < num; i++) {
+		smusbdig_i2c_packet_init(&packet);
+		smusbdig_packet_add_command(&packet, SMUSBDIG_I2C_START);
+		/* add read bit to address if needed */
+		msgs[i].addr <<= 1;
+		if (msgs[i].flags & I2C_M_RD)
+			msgs[i].addr |= BIT(0);
+		smusbdig_packet_add_data(&packet, msgs[i].addr);
+		smusbdig_packet_add_command(&packet, SMUSBDIG_I2C_ACKS);
+		if (msgs[i].flags & I2C_M_RD) {
+			for (j = 0; j < msgs[i].len; j++) {
+				smusbdig_packet_add_data(&packet, 0xff);
+				smusbdig_packet_add_command(&packet, SMUSBDIG_I2C_ACKM);
+			}
+		} else {
+			for (j = 0; j < msgs[i].len; j++) {
+				smusbdig_packet_add_data(&packet, msgs[i].buf[j]);
+				smusbdig_packet_add_command(&packet, SMUSBDIG_I2C_ACKS);
+			}
+		}
+
+		ret = smusbdig_xfer(smusbdig_i2c->smusbdig,
+				    (u8 *)&packet, sizeof(packet));
+		if (ret)
+			return ret;
+
+		/*
+		 * now we read in any data we got during read MSGs
+		 * and check ACKS
+		 */
+		if (((u8 *)&packet)[2]) {
+			num = -EPROTO;
+			goto stop;
+		}
+		for (j = 0, k = 3; j < msgs[i].len; j++, k += 2) {
+			if (msgs[i].flags & I2C_M_RD) {
+				msgs[i].buf[j] = ((u8 *)&packet)[k];
+			} else if (((u8 *)&packet)[k + 1]) {
+				num = -EPROTO;
+				goto stop;
+			}
+		}
+	}
+
+stop:
+	/* send stop condition */
+	smusbdig_i2c_packet_init(&packet);
+	smusbdig_packet_add_command(&packet, SMUSBDIG_I2C_STOP);
+	ret = smusbdig_xfer(smusbdig_i2c->smusbdig,
+			    (u8 *)&packet, sizeof(packet));
+	if (ret)
+		return ret;
+
+	return num;
+}
+
+static u32 smusbdig_i2c_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm smusbdig_i2c_algo = {
+	.master_xfer = smusbdig_i2c_xfer,
+	.functionality = smusbdig_i2c_func,
+};
+
+static struct i2c_adapter smusbdig_i2c_adapter = {
+	.owner = THIS_MODULE,
+	.class = I2C_CLASS_HWMON,
+	.algo = &smusbdig_i2c_algo,
+};
+
+static struct i2c_adapter_quirks dln2_i2c_quirks = {
+	.max_read_len = SMUSBDIG_I2C_MAX_MSG,
+	.max_write_len = SMUSBDIG_I2C_MAX_MSG,
+};
+
+static int smusbdig_i2c_probe(struct platform_device *pdev)
+{
+	struct smusbdig_i2c *smusbdig_i2c;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	smusbdig_i2c = devm_kzalloc(dev, sizeof(*smusbdig_i2c), GFP_KERNEL);
+	if (!smusbdig_i2c)
+		return -ENOMEM;
+
+	smusbdig_i2c->dev = dev;
+	smusbdig_i2c->smusbdig = dev_get_drvdata(dev->parent);
+	smusbdig_i2c->adapter = smusbdig_i2c_adapter;
+	strlcpy(smusbdig_i2c->adapter.name, dev_name(dev),
+		sizeof(smusbdig_i2c->adapter.name));
+	smusbdig_i2c->adapter.quirks = &dln2_i2c_quirks;
+	smusbdig_i2c->adapter.dev.parent = dev;
+	smusbdig_i2c->adapter.dev.of_node = dev->of_node;
+
+	i2c_set_adapdata(&smusbdig_i2c->adapter, smusbdig_i2c);
+	platform_set_drvdata(pdev, smusbdig_i2c);
+
+	ret = i2c_add_adapter(&smusbdig_i2c->adapter);
+	if (ret) {
+		dev_err(dev, "unable to add I2C adapter\n");
+		return ret;
+	}
+
+	dev_info(dev, "TI SM-USB-DIG Added: I2C Bus\n");
+
+	return 0;
+}
+
+static int smusbdig_i2c_remove(struct platform_device *pdev)
+{
+	struct smusbdig_i2c *smusbdig_i2c = platform_get_drvdata(pdev);
+
+	i2c_del_adapter(&smusbdig_i2c->adapter);
+
+	return 0;
+}
+
+static const struct platform_device_id smusbdig_i2c_id_table[] = {
+	{ "sm-usb-dig-i2c", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, smusbdig_i2c_id_table);
+
+static struct platform_driver smusbdig_i2c_driver = {
+	.driver = {
+		.name = "sm-usb-dig-i2c",
+	},
+	.probe = smusbdig_i2c_probe,
+	.remove = smusbdig_i2c_remove,
+	.id_table = smusbdig_i2c_id_table,
+};
+module_platform_driver(smusbdig_i2c_driver);
+
+MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_DESCRIPTION("I2C bus driver for TI SM-USB-DIG interface adapter");
+MODULE_LICENSE("GPL v2");
-- 
2.8.3
