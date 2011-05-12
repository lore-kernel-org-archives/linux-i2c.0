From: Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] Adding the i2c-bit-platform bus
Date: Thu, 12 May 2011 22:38:05 +0300
Message-ID: <1305229085-14408-1-git-send-email-pavius@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

- Platform now passes a new platform structure, i2c_bit_platform_data,
to the driver instead of passing i2c_algo_bit_data

Signed-off-by: Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/Kconfig            |   10 +++
 drivers/i2c/busses/Makefile           |    1 +
 drivers/i2c/busses/i2c-bit-platform.c |  120 +++++++++++++++++++++++++++++++++
 include/linux/i2c-bit-platform.h      |   35 ++++++++++
 4 files changed, 166 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-bit-platform.c
 create mode 100644 include/linux/i2c-bit-platform.h

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 3a6321c..f6c6b8c 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -365,6 +365,16 @@ config I2C_GPIO
 	  This is a very simple bitbanging I2C driver utilizing the
 	  arch-neutral GPIO API to control the SCL and SDA lines.
 
+config I2C_BIT_PLATFORM
+	tristate "I2c-bit-algo as platform device"
+	select I2C_ALGOBIT
+	help
+	  An I2C bus adapter which delegates the bit-algo callback registration
+	  to the platform. Useful in cases where existing adapters such as
+	  i2c-gpio are too slow. Keep in mind that no resource locking of any kind
+	  is performed by the adapter or algo, so any such contention must be
+	  handled by the platform.
+
 config I2C_HIGHLANDER
 	tristate "Highlander FPGA SMBus interface"
 	depends on SH_HIGHLANDER
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 84cb16a..65bced4 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
 obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
 obj-$(CONFIG_I2C_DESIGNWARE)	+= i2c-designware.o
 obj-$(CONFIG_I2C_GPIO)		+= i2c-gpio.o
+obj-$(CONFIG_I2C_BIT_PLATFORM)	+= i2c-bit-platform.o
 obj-$(CONFIG_I2C_HIGHLANDER)	+= i2c-highlander.o
 obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
 obj-$(CONFIG_I2C_IMX)		+= i2c-imx.o
diff --git a/drivers/i2c/busses/i2c-bit-platform.c b/drivers/i2c/busses/i2c-bit-platform.c
new file mode 100644
index 0000000..c1f4402
--- /dev/null
+++ b/drivers/i2c/busses/i2c-bit-platform.c
@@ -0,0 +1,120 @@
+/*
+    i2c-bit-algo as platform device
+    Delegates the bit-algo callback registration to the platform
+
+    Copyright (C) 2011 Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+*/
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/i2c-bit-platform.h>
+#include <linux/slab.h>
+
+static int __devinit i2c_bit_platform_probe(struct platform_device *pdev)
+{
+	struct i2c_bit_platform_data *pdata;
+	struct i2c_algo_bit_data *bit_data;
+	struct i2c_adapter *adap;
+	int ret;
+
+	if (pdev->dev.platform_data == NULL)
+		ret = -ENXIO;
+
+	pdata = pdev->dev.platform_data;
+
+	ret = -ENOMEM;
+	adap = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
+	if (adap == NULL)
+		goto err_alloc_adap;
+	bit_data = kzalloc(sizeof(struct i2c_algo_bit_data), GFP_KERNEL);
+	if (bit_data == NULL)
+		goto err_alloc_bit_data;
+
+	bit_data->data = pdata->data;
+	bit_data->setsda = pdata->setsda;
+	bit_data->setscl = pdata->setscl;
+	bit_data->getsda = pdata->getsda;
+	bit_data->getscl = pdata->getscl;
+	bit_data->udelay = pdata->udelay;
+	bit_data->timeout = pdata->timeout;
+
+	adap->owner = THIS_MODULE;
+	adap->algo_data = bit_data;
+	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	adap->dev.parent = &pdev->dev;
+
+	snprintf(adap->name, sizeof(adap->name), "i2c-bit-platform%d",
+			 pdev->id);
+	adap->name[sizeof(adap->name) - 1] = '\0';
+
+	/*
+	 * If "dev->id" is negative we consider it as zero.
+	 * The reason to do so is to avoid sysfs names that only make
+	 * sense when there are multiple adapters.
+	 */
+	adap->nr = (pdev->id != -1) ? pdev->id : 0;
+	ret = i2c_bit_add_numbered_bus(adap);
+	if (ret)
+		goto err_add_bus;
+
+	platform_set_drvdata(pdev, adap);
+
+	return 0;
+
+err_add_bus:
+	kfree(bit_data);
+err_alloc_bit_data:
+	kfree(adap);
+err_alloc_adap:
+	return ret;
+}
+
+static int __devexit i2c_bit_platform_remove(struct platform_device *pdev)
+{
+	struct i2c_adapter *adap;
+
+	adap = platform_get_drvdata(pdev);
+
+	i2c_del_adapter(adap);
+
+	kfree(adap->algo_data);
+	kfree(adap);
+
+	return 0;
+}
+
+static struct platform_driver i2c_bit_platform_driver = {
+	.driver		= {
+		.name	= "i2c-bit-platform",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= i2c_bit_platform_probe,
+	.remove		= __devexit_p(i2c_bit_platform_remove),
+};
+
+static int __init i2c_bit_platform_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&i2c_bit_platform_driver);
+	if (ret)
+		printk(KERN_ERR "i2c-bit-platform: probe failed: %d\n", ret);
+
+	return ret;
+}
+subsys_initcall(i2c_bit_platform_init);
+
+static void __exit i2c_bit_platform_exit(void)
+{
+	platform_driver_unregister(&i2c_bit_platform_driver);
+}
+module_exit(i2c_bit_platform_exit);
+
+MODULE_AUTHOR("Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("Thin platform adapter for i2c-bit-algo");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c-bit-platform.h b/include/linux/i2c-bit-platform.h
new file mode 100644
index 0000000..e3b601b
--- /dev/null
+++ b/include/linux/i2c-bit-platform.h
@@ -0,0 +1,35 @@
+/*
+ * i2c-bit-platform interface to platform code
+ *
+ * Copyright (C) 2011 Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _LINUX_I2C_BIT_PLATFORM_H
+#define _LINUX_I2C_BIT_PLATFORM_H
+
+/**
+ * struct i2c_bit_platform_data - Platform-dependent data for
+ * i2c-bit-platform
+ * @data: to be passed to callbacks, untouched
+ * @setsda: callback to set SDA line
+ * @setscl: callback to set SCL line
+ * @getsda: callback to get SDA line
+ * @getscl: callback to get SCL line
+ * @udelay: signal toggle delay. SCL frequency is (500 / udelay) kHz
+ * @timeout: clock stretching timeout in jiffies. If the slave keeps
+ *	SCL low for longer than this, the transfer will time out.
+ */
+struct i2c_bit_platform_data {
+	void *data;
+	void (*setsda) (void *data, int state);
+	void (*setscl) (void *data, int state);
+	int  (*getsda) (void *data);
+	int  (*getscl) (void *data);
+	int udelay;
+	int timeout;
+};
+
+#endif /* _LINUX_I2C_BIT_PLATFORM_H */
-- 
1.7.0.4
