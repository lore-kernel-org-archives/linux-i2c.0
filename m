From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] i2c: mpc: cleanup clock API use
Date: Fri, 23 Aug 2013 18:01:44 +0200
Message-ID: <1377273704-7474-1-git-send-email-agust@denx.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>

make the MPC I2C driver get, prepare and enable the gated clock item for
register access during probe; disable and unprepare the clock upon
remove(), put is done by the devm approach; hold a reference to the
clock over the period of use

clock lookup is non-fatal in this implementation as not all platforms
may provide clock specs in their device tree, but failure to enable a
clock when specified is considered fatal

Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Signed-off-by: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
---
 drivers/i2c/busses/i2c-mpc.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index ffac214..50da3b2 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -21,6 +21,7 @@
 #include <linux/of_i2c.h>
 #include <linux/slab.h>
 
+#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/fsl_devices.h>
 #include <linux/i2c.h>
@@ -67,6 +68,7 @@ struct mpc_i2c {
 #ifdef CONFIG_PM_SLEEP
 	u8 fdr, dfsrr;
 #endif
+	struct clk *clk_per;
 };
 
 struct mpc_i2c_divider {
@@ -623,6 +625,8 @@ static int fsl_i2c_probe(struct platform_device *op)
 	int result = 0;
 	int plen;
 	struct resource res;
+	struct clk *clk;
+	int err;
 
 	match = of_match_device(mpc_i2c_of_match, &op->dev);
 	if (!match)
@@ -653,6 +657,21 @@ static int fsl_i2c_probe(struct platform_device *op)
 		}
 	}
 
+	/*
+	 * enable clock for the I2C peripheral (non fatal),
+	 * keep a reference upon successful allocation
+	 */
+	clk = devm_clk_get(&op->dev, NULL);
+	if (!IS_ERR(clk)) {
+		err = clk_prepare_enable(clk);
+		if (err) {
+			dev_err(&op->dev, "failed to enable clock\n");
+			goto fail_request;
+		} else {
+			i2c->clk_per = clk;
+		}
+	}
+
 	if (of_get_property(op->dev.of_node, "fsl,preserve-clocking", NULL)) {
 		clock = MPC_I2C_CLOCK_PRESERVE;
 	} else {
@@ -699,6 +718,8 @@ static int fsl_i2c_probe(struct platform_device *op)
 	return result;
 
  fail_add:
+	if (i2c->clk_per)
+		clk_disable_unprepare(i2c->clk_per);
 	free_irq(i2c->irq, i2c);
  fail_request:
 	irq_dispose_mapping(i2c->irq);
@@ -714,6 +735,9 @@ static int fsl_i2c_remove(struct platform_device *op)
 
 	i2c_del_adapter(&i2c->adap);
 
+	if (i2c->clk_per)
+		clk_disable_unprepare(i2c->clk_per);
+
 	if (i2c->irq)
 		free_irq(i2c->irq, i2c);
 
-- 
1.7.9.5
