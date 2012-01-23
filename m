From: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Subject: [RFC PATCH 5/7] ARM: davinci: i2c: add OF support
Date: Mon, 23 Jan 2012 09:56:05 +0100
Message-ID: <1327308967-8092-6-git-send-email-hs@denx.de>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1327308967-8092-1-git-send-email-hs-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

add of support for the davinci i2c driver.

Signed-off-by: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
---
 .../devicetree/bindings/arm/davinci/i2c.txt        |   39 ++++++++++++++++++
 drivers/i2c/busses/i2c-davinci.c                   |   43 ++++++++++++++++++++
 2 files changed, 82 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/davinci/i2c.txt

diff --git a/Documentation/devicetree/bindings/arm/davinci/i2c.txt b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
new file mode 100644
index 0000000..94ec670
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
@@ -0,0 +1,39 @@
+* Texas Instruments Davinci I2C
+
+This file provides information, what the device node for the
+davinci i2c interface contain.
+
+Required properties:
+- compatible: "ti,davinci-i2c";
+- reg : Offset and length of the register set for the device
+- id: id of the controller
+
+Recommended properties :
+- interrupts : <a b> where a is the interrupt number and b is a
+  field that represents an encoding of the sense and level
+  information for the interrupt.
+- interrupt-parent : the phandle for the interrupt controller that
+  services interrupts for this device.
+- clock-frequency : desired I2C bus clock frequency in Hz.
+
+Optional properties:
+- bus-delay: bus delay in usec
+- pinmux-handle: Contains a handle to configure the pinmux settings.
+
+Example (enbw_cmc board):
+	i2c@1c22000 {
+		compatible = "ti,davinci-i2c";
+		reg = <0x22000 0x1000>;
+		clock-frequency = <100000>;
+		interrupts = <15 2>;
+		interrupt-parent = <&intc>;
+		id = <1>;
+		pinmux-handle = <&i2c1_pins>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dtt@48 {
+				compatible = "national,lm75";
+				reg = <0x48>;
+			};
+	};
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index a76d85f..6f59fae 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -38,9 +38,12 @@
 #include <linux/slab.h>
 #include <linux/cpufreq.h>
 #include <linux/gpio.h>
+#include <linux/of_i2c.h>
+#include <linux/of_device.h>
 
 #include <mach/hardware.h>
 #include <mach/i2c.h>
+#include <mach/mux.h>
 
 /* ----- global defines ----------------------------------------------- */
 
@@ -635,6 +638,16 @@ static struct i2c_algorithm i2c_davinci_algo = {
 	.functionality	= i2c_davinci_func,
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id davinci_i2c_of_match[] = {
+	{.compatible = "ti,davinci-i2c", },
+	{},
+}
+MODULE_DEVICE_TABLE(of, davinci_i2c_of_match);
+#else
+#define davinci_i2c_of_match NULL
+#endif
+
 static int davinci_i2c_probe(struct platform_device *pdev)
 {
 	struct davinci_i2c_dev *dev;
@@ -676,7 +689,34 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	dev->irq = irq->start;
 	platform_set_drvdata(pdev, dev);
 
+	if ((dev->dev->platform_data == NULL) &&
+		(pdev->dev.of_node)) {
+		struct device_node *pinmux_np;
+		struct davinci_i2c_platform_data *pdata;
+		u32 prop;
+
+		dev->dev->platform_data = &davinci_i2c_platform_data_default;
+		pdata = &davinci_i2c_platform_data_default;
+		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+			&prop))
+			pdata->bus_freq = prop / 1000;
+		if (!of_property_read_u32(pdev->dev.of_node, "bus-delay",
+			&prop))
+			pdata->bus_delay = prop;
+		if (!of_property_read_u32(pdev->dev.of_node, "id",
+			&prop)) {
+			pdev->id = prop;
+			pdev->dev.init_name = kzalloc(20, GFP_KERNEL);
+			sprintf((char *)pdev->dev.init_name,
+				"i2c_davinci.%d", pdev->id);
+		}
+		pinmux_np = of_parse_phandle(pdev->dev.of_node,
+				"pinmux-handle", 0);
+		if (pinmux_np)
+			davinci_cfg_reg_of(pinmux_np);
+	}
 	dev->clk = clk_get(&pdev->dev, NULL);
+
 	if (IS_ERR(dev->clk)) {
 		r = -ENODEV;
 		goto err_free_mem;
@@ -711,6 +751,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->algo = &i2c_davinci_algo;
 	adap->dev.parent = &pdev->dev;
 	adap->timeout = DAVINCI_I2C_TIMEOUT;
+	adap->dev.of_node = pdev->dev.of_node;
 
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
@@ -718,6 +759,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failure adding adapter\n");
 		goto err_free_irq;
 	}
+	of_i2c_register_devices(adap);
 
 	return 0;
 
@@ -809,6 +851,7 @@ static struct platform_driver davinci_i2c_driver = {
 		.name	= "i2c_davinci",
 		.owner	= THIS_MODULE,
 		.pm	= davinci_i2c_pm_ops,
+		.of_match_table = davinci_i2c_of_match,
 	},
 };
 
-- 
1.7.7.5
