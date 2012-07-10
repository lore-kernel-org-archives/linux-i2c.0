From: "Jayachandran C" <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: [PATCH 2/4] i2c: i2c-ocores: Use reg-shift property
Date: Tue, 10 Jul 2012 11:40:56 +0530
Message-ID: <1341900658-7698-3-git-send-email-jayachandranc@netlogicmicro.com>
References: <1341900658-7698-1-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341900658-7698-1-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org
Cc: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Deprecate 'regstep' property and use the standard 'reg-shift' property
for register offset shifts. 'regstep' will still be supported as an
optional property, but will give a warning when used.

Signed-off-by: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-ocores.txt         |    8 +++--
 drivers/i2c/busses/i2c-ocores.c                    |   36 ++++++++++++--------
 include/linux/i2c-ocores.h                         |    6 ++--
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
index bfec894..1c9334b 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
@@ -4,11 +4,14 @@ Required properties:
 - compatible      : "opencores,i2c-ocores"
 - reg             : bus address start and address range size of device
 - interrupts      : interrupt number
-- regstep         : size of device registers in bytes
 - clock-frequency : frequency of bus clock in Hz
 - #address-cells  : should be <1>
 - #size-cells     : should be <0>
 
+Optional properties:
+- reg-shift       : device register offsets are shifted by this value
+- regstep         : deprecated, use reg-shift above
+
 Example:
 
 	i2c0: ocores@a0000000 {
@@ -17,9 +20,10 @@ Example:
 		compatible = "opencores,i2c-ocores";
 		reg = <0xa0000000 0x8>;
 		interrupts = <10>;
-		regstep = <1>;
 		clock-frequency = <20000000>;
 
+		reg-shift = <0>;	/* 8 bit registers */
+
 		dummy@60 {
 			compatible = "dummy";
 			reg = <0x60>;
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index e8159db..9617ec1 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -25,10 +25,11 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/of_i2c.h>
+#include <linux/log2.h>
 
 struct ocores_i2c {
 	void __iomem *base;
-	int regstep;
+	int reg_shift;
 	wait_queue_head_t wait;
 	struct i2c_adapter adap;
 	struct i2c_msg *msg;
@@ -71,12 +72,12 @@ struct ocores_i2c {
 
 static inline void oc_setreg(struct ocores_i2c *i2c, int reg, u8 value)
 {
-	iowrite8(value, i2c->base + reg * i2c->regstep);
+	iowrite8(value, i2c->base + (reg << i2c->reg_shift));
 }
 
 static inline u8 oc_getreg(struct ocores_i2c *i2c, int reg)
 {
-	return ioread8(i2c->base + reg * i2c->regstep);
+	return ioread8(i2c->base + (reg << i2c->reg_shift));
 }
 
 static void ocores_process(struct ocores_i2c *i2c)
@@ -219,22 +220,29 @@ static struct i2c_adapter ocores_adapter = {
 static int ocores_i2c_of_probe(struct platform_device *pdev,
 				struct ocores_i2c *i2c)
 {
-	const __be32* val;
-
-	val = of_get_property(pdev->dev.of_node, "regstep", NULL);
-	if (!val) {
-		dev_err(&pdev->dev, "Missing required parameter 'regstep'\n");
-		return -ENODEV;
+	struct device_node *np = pdev->dev.of_node;
+	u32 val;
+
+	if (of_property_read_u32(np, "reg-shift", &i2c->reg_shift)) {
+		/* no 'reg-shift', check for deprecated 'regstep' */
+		if (!of_property_read_u32(np, "regstep", &val)) {
+			if (!is_power_of_2(val)) {
+				dev_err(&pdev->dev, "invalid regstep %d\n",
+					val);
+				return -EINVAL;
+			}
+			i2c->reg_shift = ilog2(val);
+			dev_warn(&pdev->dev,
+				"regstep property deprecated, use reg-shift\n");
+		}
 	}
-	i2c->regstep = be32_to_cpup(val);
 
-	val = of_get_property(pdev->dev.of_node, "clock-frequency", NULL);
-	if (!val) {
+	if (of_property_read_u32(np, "clock-frequency", &val)) {
 		dev_err(&pdev->dev,
 			"Missing required parameter 'clock-frequency'\n");
 		return -ENODEV;
 	}
-	i2c->clock_khz = be32_to_cpup(val) / 1000;
+	i2c->clock_khz = val / 1000;
 
 	return 0;
 }
@@ -277,7 +285,7 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 
 	pdata = pdev->dev.platform_data;
 	if (pdata) {
-		i2c->regstep = pdata->regstep;
+		i2c->reg_shift = pdata->reg_shift;
 		i2c->clock_khz = pdata->clock_khz;
 	} else {
 		ret = ocores_i2c_of_probe(pdev, i2c);
diff --git a/include/linux/i2c-ocores.h b/include/linux/i2c-ocores.h
index 4d5e57f..bb58c7d 100644
--- a/include/linux/i2c-ocores.h
+++ b/include/linux/i2c-ocores.h
@@ -12,9 +12,9 @@
 #define _LINUX_I2C_OCORES_H
 
 struct ocores_i2c_platform_data {
-	u32 regstep;   /* distance between registers */
-	u32 clock_khz; /* input clock in kHz */
-	u8 num_devices; /* number of devices in the devices list */
+	u32 reg_shift;		/* register offset shift value */
+	u32 clock_khz;		/* input clock in kHz */
+	u8 num_devices;		/* number of devices in the devices list */
 	struct i2c_board_info const *devices; /* devices connected to the bus */
 };
 
-- 
1.7.9.5
