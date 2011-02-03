From: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Subject: [PATCH] i2c-gpio: add devicetree support
Date: Thu,  3 Feb 2011 10:26:20 +0800
Message-ID: <1296699980-30234-1-git-send-email-thomas@wytron.com.tw>
References: <AANLkTimoaJKy-WTTHmRXFMmM6=e7uvzhjwRcDtNqGAPj@mail.gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimoaJKy-WTTHmRXFMmM6=e7uvzhjwRcDtNqGAPj-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>, Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch adds devicetree support to i2c-gpio driver. It converts
dts bindings and allocates a struct i2c_gpio_platform_data, which
will be freed on driver removal.

Signed-off-by: Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
Signed-off-by: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
---
for v2.6.39
v2 move of nodes probing to a hook, which will be optimized out
     when devicetree is not used.
   use linux/gpio.h.
   move binding doc to i2c/i2c-gpio.txt.
v3 use speed-hz instead of udelay in dts binding.
   condition the devicetree probe.

 Documentation/devicetree/bindings/i2c/i2c-gpio.txt |   40 ++++++++++
 drivers/i2c/busses/i2c-gpio.c                      |   83 +++++++++++++++++++-
 2 files changed, 119 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gpio.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
new file mode 100644
index 0000000..38ef4f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
@@ -0,0 +1,40 @@
+GPIO-based I2C
+
+Required properties:
+- compatible : should be "i2c-gpio".
+- gpios : should specify GPIOs used for SDA and SCL lines, in that order.
+Optional properties:
+- sda-is-open-drain : present if SDA gpio is open-drain.
+- scl-is-open-drain : present if SCL gpio is open-drain.
+- scl-is-output-only : present if the output driver for SCL cannot be
+	turned off. this will prevent clock stretching from working.
+- speed-hz : SCL frequency.
+- timeout : clock stretching timeout in milliseconds.
+
+Example:
+
+gpio0: starlet-gpio@0d8000c0 {
+	compatible = "nintendo,starlet-gpio";
+	reg = <0d8000c0 4>;
+	gpio-controller;
+	#gpio-cells = <2>;
+};
+
+i2c-video {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "i2c-gpio";
+
+	gpios = <&gpio0 10 0	/* SDA line */
+		 &gpio0 11 0	/* SCL line */
+		>;
+	sda-is-open-drain;
+	scl-is-open-drain;
+	scl-is-output-only;
+	speed-hz = <250000>;
+
+	audio-video-encoder {
+		compatible = "nintendo,wii-ave-rvl";
+		reg = <70>;
+	};
+};
diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index d9aa9a6..4b31bbe 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -14,8 +14,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
-
-#include <asm/gpio.h>
+#include <linux/gpio.h>
+#include <linux/of_i2c.h>
 
 /* Toggle SDA by changing the direction of the pin */
 static void i2c_gpio_setsda_dir(void *data, int state)
@@ -78,15 +78,74 @@ static int i2c_gpio_getscl(void *data)
 	return gpio_get_value(pdata->scl_pin);
 }
 
+#ifdef CONFIG_OF
+#include <linux/of_gpio.h>
+
+/* Check if devicetree nodes exist and build platform data */
+static struct i2c_gpio_platform_data *i2c_gpio_of_probe(
+	struct platform_device *pdev)
+{
+	struct i2c_gpio_platform_data *pdata = NULL;
+	struct device_node *np = pdev->dev.of_node;
+	const __be32 *prop;
+	int sda_pin, scl_pin;
+
+	if (!np || of_gpio_count(np) < 2)
+		goto err;
+
+	sda_pin = of_get_gpio_flags(np, 0, NULL);
+	scl_pin = of_get_gpio_flags(np, 1, NULL);
+	if (sda_pin < 0 || scl_pin < 0) {
+		pr_err("%s: invalid GPIO pins, sda=%d/scl=%d\n",
+		       np->full_name, sda_pin, scl_pin);
+		goto err;
+	}
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		goto err;
+
+	pdata->sda_pin = sda_pin;
+	pdata->scl_pin = scl_pin;
+	prop = of_get_property(np, "sda-is-open-drain", NULL);
+	if (prop)
+		pdata->sda_is_open_drain = 1;
+	prop = of_get_property(np, "scl-is-open-drain", NULL);
+	if (prop)
+		pdata->scl_is_open_drain = 1;
+	prop = of_get_property(np, "scl-is-output-only", NULL);
+	if (prop)
+		pdata->scl_is_output_only = 1;
+	prop = of_get_property(np, "speed-hz", NULL);
+	if (prop)
+		pdata->udelay = DIV_ROUND_UP(1000000, be32_to_cpup(prop) * 2);
+	prop = of_get_property(np, "timeout", NULL);
+	if (prop) {
+		pdata->timeout =
+			msecs_to_jiffies(be32_to_cpup(prop));
+	}
+err:
+	return pdata;
+}
+#else
+static struct i2c_gpio_platform_data *i2c_gpio_of_probe(
+	struct platform_device *pdev)
+{
+	return NULL;
+}
+#endif
+
 static int __devinit i2c_gpio_probe(struct platform_device *pdev)
 {
-	struct i2c_gpio_platform_data *pdata;
+	struct i2c_gpio_platform_data *pdata, *pdata_of = NULL;
 	struct i2c_algo_bit_data *bit_data;
 	struct i2c_adapter *adap;
 	int ret;
 
 	pdata = pdev->dev.platform_data;
 	if (!pdata)
+		pdata = pdata_of = i2c_gpio_of_probe(pdev);
+	if (!pdata)
 		return -ENXIO;
 
 	ret = -ENOMEM;
@@ -143,6 +202,8 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
 	adap->algo_data = bit_data;
 	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->dev.parent = &pdev->dev;
+	if (pdata_of)
+		adap->dev.of_node = pdev->dev.of_node;
 
 	/*
 	 * If "dev->id" is negative we consider it as zero.
@@ -161,6 +222,9 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
 		 pdata->scl_is_output_only
 		 ? ", no clock stretching" : "");
 
+	/* Now register all the child nodes */
+	of_i2c_register_devices(adap);
+
 	return 0;
 
 err_add_bus:
@@ -172,6 +236,7 @@ err_request_sda:
 err_alloc_bit_data:
 	kfree(adap);
 err_alloc_adap:
+	kfree(pdata_of);
 	return ret;
 }
 
@@ -179,23 +244,33 @@ static int __devexit i2c_gpio_remove(struct platform_device *pdev)
 {
 	struct i2c_gpio_platform_data *pdata;
 	struct i2c_adapter *adap;
+	struct i2c_algo_bit_data *bit_data;
 
 	adap = platform_get_drvdata(pdev);
-	pdata = pdev->dev.platform_data;
+	bit_data = adap->algo_data;
+	pdata = bit_data->data;
 
 	i2c_del_adapter(adap);
 	gpio_free(pdata->scl_pin);
 	gpio_free(pdata->sda_pin);
 	kfree(adap->algo_data);
+	if (adap->dev.of_node)
+		kfree(pdata);
 	kfree(adap);
 
 	return 0;
 }
 
+static const struct of_device_id i2c_gpio_match[] = {
+	{ .compatible = "i2c-gpio", },
+	{},
+};
+
 static struct platform_driver i2c_gpio_driver = {
 	.driver		= {
 		.name	= "i2c-gpio",
 		.owner	= THIS_MODULE,
+		.of_match_table = i2c_gpio_match,
 	},
 	.probe		= i2c_gpio_probe,
 	.remove		= __devexit_p(i2c_gpio_remove),
-- 
1.7.3.5
