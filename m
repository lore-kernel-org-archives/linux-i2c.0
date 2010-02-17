From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: [PATCH v8 2/4] i2c-mpc: rename "setclock" initialization functions to "setup"
Date: Wed, 17 Feb 2010 11:19:18 +0100
Message-ID: <1266401960-19127-3-git-send-email-wg@grandegger.com>
References: <1266401960-19127-1-git-send-email-wg@grandegger.com>
 <1266401960-19127-2-git-send-email-wg@grandegger.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1266401960-19127-2-git-send-email-wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>

To prepare  support for the MPC512x processors from Freescale the
"setclock" initialization functions have been renamed to "setup"
because I2C interrupts must be enabled for the MPC512x by this
function as well.

Signed-off-by: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mpc.c |   42 ++++++++++++++++++++----------------------
 1 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 2f74d9b..370c342 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -67,9 +67,8 @@ struct mpc_i2c_divider {
 };
 
 struct mpc_i2c_data {
-	void (*setclock)(struct device_node *node,
-			 struct mpc_i2c *i2c,
-			 u32 clock, u32 prescaler);
+	void (*setup)(struct device_node *node, struct mpc_i2c *i2c,
+		      u32 clock, u32 prescaler);
 	u32 prescaler;
 };
 
@@ -216,9 +215,9 @@ static int __devinit mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock,
 	return div ? (int)div->fdr : -EINVAL;
 }
 
-static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
-					    struct mpc_i2c *i2c,
-					    u32 clock, u32 prescaler)
+static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
+					 struct mpc_i2c *i2c,
+					 u32 clock, u32 prescaler)
 {
 	int ret, fdr;
 
@@ -231,9 +230,9 @@ static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
 		dev_info(i2c->dev, "clock %d Hz (fdr=%d)\n", clock, fdr);
 }
 #else /* !CONFIG_PPC_MPC52xx */
-static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
-					    struct mpc_i2c *i2c,
-					    u32 clock, u32 prescaler)
+static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
+					 struct mpc_i2c *i2c,
+					 u32 clock, u32 prescaler)
 {
 }
 #endif /* CONFIG_PPC_MPC52xx*/
@@ -322,9 +321,9 @@ static int __devinit mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
 	return div ? (int)div->fdr : -EINVAL;
 }
 
-static void __devinit mpc_i2c_setclock_8xxx(struct device_node *node,
-					    struct mpc_i2c *i2c,
-					    u32 clock, u32 prescaler)
+static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
+					 struct mpc_i2c *i2c,
+					 u32 clock, u32 prescaler)
 {
 	int ret, fdr;
 
@@ -340,9 +339,9 @@ static void __devinit mpc_i2c_setclock_8xxx(struct device_node *node,
 }
 
 #else /* !CONFIG_FSL_SOC */
-static void __devinit mpc_i2c_setclock_8xxx(struct device_node *node,
-					    struct mpc_i2c *i2c,
-					    u32 clock, u32 prescaler)
+static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
+					 struct mpc_i2c *i2c,
+					 u32 clock, u32 prescaler)
 {
 }
 #endif /* CONFIG_FSL_SOC */
@@ -533,12 +532,11 @@ static int __devinit fsl_i2c_probe(struct of_device *op,
 		if (match->data) {
 			struct mpc_i2c_data *data =
 				(struct mpc_i2c_data *)match->data;
-			data->setclock(op->node, i2c, clock, data->prescaler);
+			data->setup(op->node, i2c, clock, data->prescaler);
 		} else {
 			/* Backwards compatibility */
 			if (of_get_property(op->node, "dfsrr", NULL))
-				mpc_i2c_setclock_8xxx(op->node, i2c,
-						      clock, 0);
+				mpc_i2c_setup_8xxx(op->node, i2c, clock, 0);
 		}
 	}
 
@@ -585,20 +583,20 @@ static int __devexit fsl_i2c_remove(struct of_device *op)
 };
 
 static struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata = {
-	.setclock = mpc_i2c_setclock_52xx,
+	.setup = mpc_i2c_setup_52xx,
 };
 
 static struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata = {
-	.setclock = mpc_i2c_setclock_8xxx,
+	.setup = mpc_i2c_setup_8xxx,
 };
 
 static struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata = {
-	.setclock = mpc_i2c_setclock_8xxx,
+	.setup = mpc_i2c_setup_8xxx,
 	.prescaler = 2,
 };
 
 static struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata = {
-	.setclock = mpc_i2c_setclock_8xxx,
+	.setup = mpc_i2c_setup_8xxx,
 	.prescaler = 3,
 };
 
-- 
1.6.2.5
