From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 2/2] i2c: i2c-ocores: add common clock support
Date: Mon,  2 Feb 2015 18:28:13 +0300
Message-ID: <1422890893-30989-3-git-send-email-jcmvbkbc@gmail.com>
References: <1422890893-30989-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422890893-30989-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Allow bus clock specification as a common clock handle. This makes this
controller easier to use in a setup based on common clock framework.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- fix binding documentation;
- make CCF support optional.

 .../devicetree/bindings/i2c/i2c-ocores.txt         | 32 +++++++++++++---
 drivers/i2c/busses/i2c-ocores.c                    | 44 +++++++++++++++++++++-
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
index 5bef3ad..17bef9a 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
@@ -4,8 +4,10 @@ Required properties:
 - compatible      : "opencores,i2c-ocores" or "aeroflexgaisler,i2cmst"
 - reg             : bus address start and address range size of device
 - interrupts      : interrupt number
+- clocks          : handle to the controller clock; see the note below.
+                    Mutually exclusive with opencores,ip-clock-frequency
 - opencores,ip-clock-frequency: frequency of the controller clock in Hz;
-                    see the note below
+                    see the note below. Mutually exclusive with clocks
 - #address-cells  : should be <1>
 - #size-cells     : should be <0>
 
@@ -20,14 +22,16 @@ Note
 clock-frequency property is meant to control the bus frequency for i2c bus
 drivers, but it was incorrectly used to specify i2c controller input clock
 frequency. So the following rules are set to fix this situation:
-- if clock-frequency is present and opencores,ip-clock-frequency is not,
-  then clock-frequency specifies i2c controller clock frequency. This is
-  to keep backwards compatibility with setups using old DTB. i2c bus
+- if clock-frequency is present and neither opencores,ip-clock-frequency nor
+  clocks are, then clock-frequency specifies i2c controller clock frequency.
+  This is to keep backwards compatibility with setups using old DTB. i2c bus
   frequency is fixed at 100 KHz.
+- if clocks is present it specifies i2c controller clock. clock-frequency
+  property specifies i2c bus frequency.
 - if opencores,ip-clock-frequency is present it specifies i2c controller
   clock frequency. clock-frequency property specifies i2c bus frequency.
 
-Example:
+Examples:
 
 	i2c0: ocores@a0000000 {
 		#address-cells = <1>;
@@ -45,3 +49,21 @@ Example:
 			reg = <0x60>;
 		};
 	};
+or
+	i2c0: ocores@a0000000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "opencores,i2c-ocores";
+		reg = <0xa0000000 0x8>;
+		interrupts = <10>;
+		clocks = <&osc>;
+		clock-frequency = <400000>; /* i2c bus frequency 400 KHz */
+
+		reg-shift = <0>;	/* 8 bit registers */
+		reg-io-width = <1>;	/* 8 bit read/write */
+
+		dummy@60 {
+			compatible = "dummy";
+			reg = <0x60>;
+		};
+	};
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index bff99e3..f9ec14c 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -12,6 +12,7 @@
  * kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -35,6 +36,9 @@ struct ocores_i2c {
 	int pos;
 	int nmsgs;
 	int state; /* see STATE_ */
+#ifdef CONFIG_HAVE_CLK
+	struct clk *clk;
+#endif
 	int ip_clock_khz;
 	int bus_clock_khz;
 	void (*setreg)(struct ocores_i2c *i2c, int reg, u8 value);
@@ -339,7 +343,24 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 							&clock_frequency);
 	i2c->bus_clock_khz = 100;
 
-	if (of_property_read_u32(np, "opencores,ip-clock-frequency", &val)) {
+#ifdef CONFIG_HAVE_CLK
+	i2c->clk = devm_clk_get(&pdev->dev, NULL);
+
+	if (!IS_ERR(i2c->clk)) {
+		int ret = clk_prepare_enable(i2c->clk);
+
+		if (ret) {
+			dev_err(&pdev->dev,
+				"clk_prepare_enable failed: %d\n", ret);
+			return ret;
+		}
+		i2c->ip_clock_khz = clk_get_rate(i2c->clk) / 1000;
+		if (clock_frequency_present)
+			i2c->bus_clock_khz = clock_frequency / 1000;
+	} else
+#endif
+		if (of_property_read_u32(np, "opencores,ip-clock-frequency",
+					 &val)) {
 		if (!clock_frequency_present) {
 			dev_err(&pdev->dev,
 				"Missing required parameter 'opencores,ip-clock-frequency'\n");
@@ -477,6 +498,11 @@ static int ocores_i2c_remove(struct platform_device *pdev)
 	/* remove adapter & data */
 	i2c_del_adapter(&i2c->adap);
 
+#ifdef CONFIG_HAVE_CLK
+	if (!IS_ERR(i2c->clk))
+		clk_disable_unprepare(i2c->clk);
+#endif
+
 	return 0;
 }
 
@@ -489,6 +515,10 @@ static int ocores_i2c_suspend(struct device *dev)
 	/* make sure the device is disabled */
 	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
 
+#ifdef CONFIG_HAVE_CLK
+	if (!IS_ERR(i2c->clk))
+		clk_disable_unprepare(i2c->clk);
+#endif
 	return 0;
 }
 
@@ -496,6 +526,18 @@ static int ocores_i2c_resume(struct device *dev)
 {
 	struct ocores_i2c *i2c = dev_get_drvdata(dev);
 
+#ifdef CONFIG_HAVE_CLK
+	if (!IS_ERR(i2c->clk)) {
+		int ret = clk_prepare_enable(i2c->clk);
+
+		if (ret) {
+			dev_err(&pdev->dev,
+				"clk_prepare_enable failed: %d\n", ret);
+			return ret;
+		}
+		i2c->ip_clock_khz = clk_get_rate(i2c->clk) / 1000;
+	}
+#endif
 	return ocores_init(dev, i2c);
 }
 
-- 
1.8.1.4
