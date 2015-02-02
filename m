From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 1/2] i2c: i2c-ocores: fix clock-frequency binding usage
Date: Mon,  2 Feb 2015 18:28:12 +0300
Message-ID: <1422890893-30989-2-git-send-email-jcmvbkbc@gmail.com>
References: <1422890893-30989-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422890893-30989-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
List-Id: linux-i2c@vger.kernel.org

clock-frequency property is meant to control the bus frequency for i2c bus
drivers, but it was incorrectly used to specify i2c controller input clock
frequency.
Introduce new attribute, opencores,ip-clock-frequency, that specifies i2c
controller clock frequency and make clock-frequency attribute compatible
with other i2c drivers. Maintain backwards compatibility in case
opencores,ip-clock-frequency attribute is missing.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- new patch

 .../devicetree/bindings/i2c/i2c-ocores.txt         | 18 ++++++-
 drivers/i2c/busses/i2c-ocores.c                    | 55 +++++++++++++++++-----
 2 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
index 1637c29..5bef3ad 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
@@ -4,15 +4,29 @@ Required properties:
 - compatible      : "opencores,i2c-ocores" or "aeroflexgaisler,i2cmst"
 - reg             : bus address start and address range size of device
 - interrupts      : interrupt number
-- clock-frequency : frequency of bus clock in Hz
+- opencores,ip-clock-frequency: frequency of the controller clock in Hz;
+                    see the note below
 - #address-cells  : should be <1>
 - #size-cells     : should be <0>
 
 Optional properties:
+- clock-frequency : frequency of bus clock in Hz; see the note below.
+                    Defaults to 100 KHz when the property is not specified
 - reg-shift       : device register offsets are shifted by this value
 - reg-io-width    : io register width in bytes (1, 2 or 4)
 - regstep         : deprecated, use reg-shift above
 
+Note
+clock-frequency property is meant to control the bus frequency for i2c bus
+drivers, but it was incorrectly used to specify i2c controller input clock
+frequency. So the following rules are set to fix this situation:
+- if clock-frequency is present and opencores,ip-clock-frequency is not,
+  then clock-frequency specifies i2c controller clock frequency. This is
+  to keep backwards compatibility with setups using old DTB. i2c bus
+  frequency is fixed at 100 KHz.
+- if opencores,ip-clock-frequency is present it specifies i2c controller
+  clock frequency. clock-frequency property specifies i2c bus frequency.
+
 Example:
 
 	i2c0: ocores@a0000000 {
@@ -21,7 +35,7 @@ Example:
 		compatible = "opencores,i2c-ocores";
 		reg = <0xa0000000 0x8>;
 		interrupts = <10>;
-		clock-frequency = <20000000>;
+		opencores,ip-clock-frequency = <20000000>;
 
 		reg-shift = <0>;	/* 8 bit registers */
 		reg-io-width = <1>;	/* 8 bit read/write */
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 2a4fe0b..bff99e3 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -35,7 +35,8 @@ struct ocores_i2c {
 	int pos;
 	int nmsgs;
 	int state; /* see STATE_ */
-	int clock_khz;
+	int ip_clock_khz;
+	int bus_clock_khz;
 	void (*setreg)(struct ocores_i2c *i2c, int reg, u8 value);
 	u8 (*getreg)(struct ocores_i2c *i2c, int reg);
 };
@@ -215,21 +216,34 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		return -ETIMEDOUT;
 }
 
-static void ocores_init(struct ocores_i2c *i2c)
+static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
 {
 	int prescale;
+	int diff;
 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 
 	/* make sure the device is disabled */
 	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
 
-	prescale = (i2c->clock_khz / (5*100)) - 1;
+	prescale = (i2c->ip_clock_khz / (5 * i2c->bus_clock_khz)) - 1;
+	prescale = clamp(prescale, 0, 0xffff);
+
+	diff = i2c->ip_clock_khz / (5 * (prescale + 1)) - i2c->bus_clock_khz;
+	if (abs(diff) > i2c->bus_clock_khz / 10) {
+		dev_err(dev,
+			"Unsupported clock settings: core: %d KHz, bus: %d KHz\n",
+			i2c->ip_clock_khz, i2c->bus_clock_khz);
+		return -EINVAL;
+	}
+
 	oc_setreg(i2c, OCI2C_PRELOW, prescale & 0xff);
 	oc_setreg(i2c, OCI2C_PREHIGH, prescale >> 8);
 
 	/* Init the device */
 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
 	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_IEN | OCI2C_CTRL_EN);
+
+	return 0;
 }
 
 
@@ -304,6 +318,8 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *match;
 	u32 val;
+	u32 clock_frequency;
+	bool clock_frequency_present;
 
 	if (of_property_read_u32(np, "reg-shift", &i2c->reg_shift)) {
 		/* no 'reg-shift', check for deprecated 'regstep' */
@@ -319,12 +335,24 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 		}
 	}
 
-	if (of_property_read_u32(np, "clock-frequency", &val)) {
-		dev_err(&pdev->dev,
-			"Missing required parameter 'clock-frequency'\n");
-		return -ENODEV;
+	clock_frequency_present = !of_property_read_u32(np, "clock-frequency",
+							&clock_frequency);
+	i2c->bus_clock_khz = 100;
+
+	if (of_property_read_u32(np, "opencores,ip-clock-frequency", &val)) {
+		if (!clock_frequency_present) {
+			dev_err(&pdev->dev,
+				"Missing required parameter 'opencores,ip-clock-frequency'\n");
+			return -ENODEV;
+		}
+		i2c->ip_clock_khz = clock_frequency / 1000;
+		dev_warn(&pdev->dev,
+			 "Deprecated usage of the 'clock-frequency' property, please update to 'opencores,ip-clock-frequency'\n");
+	} else {
+		i2c->ip_clock_khz = val / 1000;
+		if (clock_frequency_present)
+			i2c->bus_clock_khz = clock_frequency / 1000;
 	}
-	i2c->clock_khz = val / 1000;
 
 	of_property_read_u32(pdev->dev.of_node, "reg-io-width",
 				&i2c->reg_io_width);
@@ -368,7 +396,8 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 	if (pdata) {
 		i2c->reg_shift = pdata->reg_shift;
 		i2c->reg_io_width = pdata->reg_io_width;
-		i2c->clock_khz = pdata->clock_khz;
+		i2c->ip_clock_khz = pdata->clock_khz;
+		i2c->bus_clock_khz = 100;
 	} else {
 		ret = ocores_i2c_of_probe(pdev, i2c);
 		if (ret)
@@ -402,7 +431,9 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 		}
 	}
 
-	ocores_init(i2c);
+	ret = ocores_init(&pdev->dev, i2c);
+	if (ret)
+		return ret;
 
 	init_waitqueue_head(&i2c->wait);
 	ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
@@ -465,9 +496,7 @@ static int ocores_i2c_resume(struct device *dev)
 {
 	struct ocores_i2c *i2c = dev_get_drvdata(dev);
 
-	ocores_init(i2c);
-
-	return 0;
+	return ocores_init(dev, i2c);
 }
 
 static SIMPLE_DEV_PM_OPS(ocores_i2c_pm, ocores_i2c_suspend, ocores_i2c_resume);
-- 
1.8.1.4
