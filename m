From: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH v3 5/7] ARM: davinci: i2c: add OF support
Date: Mon,  5 Mar 2012 12:10:02 +0100
Message-ID: <1330945804-3379-6-git-send-email-hs@denx.de>
References: <1330945804-3379-1-git-send-email-hs@denx.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1330945804-3379-1-git-send-email-hs-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
Cc: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

---
- changes for v2:
- add comments from Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
  - use "cell-index" instead "id"
  - OF_DEV_AUXDATA in the machine code, instead pre-define platform
    device name
- add comment from Grant Likely:
  - removed "id" resp. "cell-index" completely
  - fixed documentation
  - use of_match_ptr()
  - use devm_kzalloc() for allocating plattform data mem
  - fixed a whitespace issue
- no changes for v3

 .../devicetree/bindings/arm/davinci/i2c.txt        |   33 +++++++++++++++++
 drivers/i2c/busses/i2c-davinci.c                   |   37 ++++++++++++++++++++
 2 files changed, 70 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/davinci/i2c.txt

diff --git a/Documentation/devicetree/bindings/arm/davinci/i2c.txt b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
new file mode 100644
index 0000000..ba00d7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
@@ -0,0 +1,33 @@
+* Texas Instruments Davinci I2C
+
+This file provides information, what the device node for the
+davinci i2c interface contain.
+
+Required properties:
+- compatible: "ti,davinci-i2c";
+- reg : Offset and length of the register set for the device
+
+Recommended properties :
+- interrupts : <a> standard interrupt property.
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
+		interrupts = <15>;
+		interrupt-parent = <&intc>;
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
index a76d85f..0d07d02 100644
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
 
@@ -635,6 +638,12 @@ static struct i2c_algorithm i2c_davinci_algo = {
 	.functionality	= i2c_davinci_func,
 };
 
+static const struct of_device_id davinci_i2c_of_match[] = {
+	{.compatible = "ti,davinci-i2c", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, davinci_i2c_of_match);
+
 static int davinci_i2c_probe(struct platform_device *pdev)
 {
 	struct davinci_i2c_dev *dev;
@@ -676,6 +685,31 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	dev->irq = irq->start;
 	platform_set_drvdata(pdev, dev);
 
+	if ((dev->dev->platform_data == NULL) &&
+		(pdev->dev.of_node)) {
+		struct device_node *pinmux_np;
+		struct davinci_i2c_platform_data *pdata;
+		u32 prop;
+
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			r = -ENOMEM;
+			goto err_free_mem;
+		}
+		memcpy(pdata, &davinci_i2c_platform_data_default,
+			sizeof(*pdata));
+		dev->dev->platform_data = pdata;
+		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+			&prop))
+			pdata->bus_freq = prop / 1000;
+		if (!of_property_read_u32(pdev->dev.of_node, "bus-delay",
+			&prop))
+			pdata->bus_delay = prop;
+		pinmux_np = of_parse_phandle(pdev->dev.of_node,
+				"pinmux-handle", 0);
+		if (pinmux_np)
+			davinci_cfg_reg_of(pinmux_np);
+	}
 	dev->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
 		r = -ENODEV;
@@ -711,6 +745,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->algo = &i2c_davinci_algo;
 	adap->dev.parent = &pdev->dev;
 	adap->timeout = DAVINCI_I2C_TIMEOUT;
+	adap->dev.of_node = pdev->dev.of_node;
 
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
@@ -718,6 +753,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failure adding adapter\n");
 		goto err_free_irq;
 	}
+	of_i2c_register_devices(adap);
 
 	return 0;
 
@@ -809,6 +845,7 @@ static struct platform_driver davinci_i2c_driver = {
 		.name	= "i2c_davinci",
 		.owner	= THIS_MODULE,
 		.pm	= davinci_i2c_pm_ops,
+		.of_match_table = of_match_ptr(davinci_i2c_of_match),
 	},
 };
 
-- 
1.7.7.6
