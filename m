From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: [PATCH v7 2/4] i2c-mpc: rename "setclock" initialization functions to
	"setup"
Date: Wed, 10 Feb 2010 15:55:09 +0100
Message-ID: <1265813711-16794-3-git-send-email-wg@grandegger.com>
References: <1265813711-16794-1-git-send-email-wg@grandegger.com>
	<1265813711-16794-2-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1265813711-16794-2-git-send-email-wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>

To prepare  support for the MPC512x processors from Freescale the
"setclock" initialization functions have been renamed to "setup"
because I2C interrupts must be enabled for the MPC512x by this
function as well.

Signed-off-by: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
---
 drivers/i2c/busses/i2c-mpc.c |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 9f0e203..370c342 100644
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
 
-- 
1.6.2.5
