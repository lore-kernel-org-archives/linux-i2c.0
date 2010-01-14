From: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Renesas SDK7786 FPGA I2C/SMBus support.
Date: Thu, 14 Jan 2010 21:19:35 +0900
Message-ID: <20100114121935.GB20473@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This adds a simple driver for the SMBus interfaces in the SDK7786 FPGA.

At present this includes 2 identically implemented blocks, one for
wrangling control from the CPU I2C for the RTC, and a secondary one for
PCI Express. As this will vary across FPGA versions, we use a platform
device abstraction and leave it to the board code (which already has FPGA
versioning information available to it) to figure out what it wants.

These are fairly simple controllers, only supporting control and data
registers, with no IRQ to speak of.

Signed-off-by: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>

---

Note that the board support for this is in my tree for 2.6.34, so I can
carry this patch there as well once folks are happy with it.

 drivers/i2c/busses/Kconfig       |    7 +
 drivers/i2c/busses/Makefile      |    1 
 drivers/i2c/busses/i2c-sdk7786.c |  163 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 5f318ce..5cdad4e 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -509,6 +509,13 @@ config I2C_S6000
 	  To compile this driver as a module, choose M here. The module
 	  will be called i2c-s6000.
 
+config I2C_SDK7786
+	tristate "Renesas SDK7786 FPGA SMBus interface"
+	depends on SH_SDK7786
+	help
+	  This driver supports the various SMBus controllers in the
+	  SDK7786 FPGA.
+
 config I2C_SH7760
 	tristate "Renesas SH7760 I2C Controller"
 	depends on CPU_SUBTYPE_SH7760
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 302c551..6162f22 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
 obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
 obj-$(CONFIG_I2C_S3C2410)	+= i2c-s3c2410.o
 obj-$(CONFIG_I2C_S6000)		+= i2c-s6000.o
+obj-$(CONFIG_I2C_SDK7786)	+= i2c-sdk7786.o
 obj-$(CONFIG_I2C_SH7760)	+= i2c-sh7760.o
 obj-$(CONFIG_I2C_SH_MOBILE)	+= i2c-sh_mobile.o
 obj-$(CONFIG_I2C_SIMTEC)	+= i2c-simtec.o
diff --git a/drivers/i2c/busses/i2c-sdk7786.c b/drivers/i2c/busses/i2c-sdk7786.c
new file mode 100644
index 0000000..c37a29d
--- /dev/null
+++ b/drivers/i2c/busses/i2c-sdk7786.c
@@ -0,0 +1,163 @@
+/*
+ * Renesas SDK7786 FPGA I2C/SMBus support.
+ *
+ * Copyright (C) 2010  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License version 2. See the file "COPYING" in the main directory
+ * of this archive for more details.
+ */
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+
+#define I2CCR	0x0000
+#define I2CDR	0x0010
+
+struct sdk7786_i2c_dev {
+	void __iomem		*base;
+	struct i2c_adapter	adapter;
+};
+
+static int sdk7786_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr,
+				  unsigned short flags, char read_write,
+				  u8 command, int size,
+				  union i2c_smbus_data *data)
+{
+	struct sdk7786_i2c_dev *dev = i2c_get_adapdata(adap);
+	int read = read_write & I2C_SMBUS_READ;
+	u16 ctrl;
+
+	dev_dbg(&adap->dev, "addr %04x, command %02x, read_write %d, size %d\n",
+		addr, command, read_write, size);
+
+	ctrl = (addr & 0x7f) << 9 | (read << 8);
+
+	switch (size) {
+	case I2C_SMBUS_BYTE:
+		if (read_write == I2C_SMBUS_WRITE)
+			ctrl |= command;
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		ctrl |= command;
+		break;
+	default:
+		dev_err(&adap->dev, "unsupported command %d\n", size);
+		return -EINVAL;
+	}
+
+	if (read) {
+		iowrite16(ctrl, dev->base + I2CCR);
+		data->byte = ioread16(dev->base + I2CDR) & 0xff;
+	} else {
+		iowrite16(data->byte, dev->base + I2CDR);
+		iowrite16(ctrl, dev->base + I2CCR);
+	}
+
+	/* delay, as we have no way to check xfer status.. */
+	udelay(100);
+
+	return 0;
+}
+
+static u32 sdk7786_i2c_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA;
+}
+
+static const struct i2c_algorithm sdk7786_i2c_algo = {
+	.smbus_xfer	= sdk7786_i2c_smbus_xfer,
+	.functionality	= sdk7786_i2c_func,
+};
+
+static int __devinit sdk7786_i2c_probe(struct platform_device *pdev)
+{
+	struct sdk7786_i2c_dev *dev;
+	struct i2c_adapter *adap;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(!res)) {
+		dev_err(&pdev->dev, "no mem resource\n");
+		return -ENODEV;
+	}
+
+	dev = kzalloc(sizeof(struct sdk7786_i2c_dev), GFP_KERNEL);
+	if (unlikely(!dev))
+		return -ENOMEM;
+
+	dev->base = ioremap_nocache(res->start, resource_size(res));
+	if (unlikely(!dev->base)) {
+		ret = -ENXIO;
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, dev);
+
+	adap = &dev->adapter;
+	i2c_set_adapdata(adap, dev);
+
+	adap->owner = THIS_MODULE;
+	adap->class = I2C_CLASS_HWMON;
+	strlcpy(adap->name, "SDK7786 FPGA", sizeof(adap->name));
+	adap->algo = &sdk7786_i2c_algo;
+	adap->dev.parent = &pdev->dev;
+	adap->nr = pdev->id;
+
+	ret = i2c_add_numbered_adapter(adap);
+	if (unlikely(ret)) {
+		dev_err(&pdev->dev, "failure adding adapter\n");
+		goto err_unmap;
+	}
+
+	return 0;
+
+err_unmap:
+	iounmap(dev->base);
+err:
+	kfree(dev);
+	platform_set_drvdata(pdev, NULL);
+	return ret;
+}
+
+static int __devexit sdk7786_i2c_remove(struct platform_device *pdev)
+{
+	struct sdk7786_i2c_dev *dev = platform_get_drvdata(pdev);
+
+	i2c_del_adapter(&dev->adapter);
+	iounmap(dev->base);
+	kfree(dev);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver sdk7786_i2c_driver = {
+	.driver		= {
+		.name	= "i2c-sdk7786",
+		.owner	= THIS_MODULE,
+	},
+
+	.probe		= sdk7786_i2c_probe,
+	.remove		= __devexit_p(sdk7786_i2c_remove),
+};
+
+static int __init sdk7786_i2c_init(void)
+{
+	return platform_driver_register(&sdk7786_i2c_driver);
+}
+
+static void __exit sdk7786_i2c_exit(void)
+{
+	platform_driver_unregister(&sdk7786_i2c_driver);
+}
+
+module_init(sdk7786_i2c_init);
+module_exit(sdk7786_i2c_exit);
+
+MODULE_AUTHOR("Paul Mundt");
+MODULE_DESCRIPTION("Renesas SDK7786 FPGA SMBus adapters");
+MODULE_LICENSE("GPL v2");
