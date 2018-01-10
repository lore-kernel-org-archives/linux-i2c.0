From: Arseny Solokha <asolokha@kb.kras.ru>
Subject: [PATCH v2 4/4] i2c: mpc: always determine I2C clock prescaler at runtime
Date: Wed, 10 Jan 2018 18:36:07 +0700
Message-ID: <20180110113607.412-1-asolokha@kb.kras.ru>
References: <20171230181446.bxongiaogcqjrbos@ninjato>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171230181446.bxongiaogcqjrbos@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>, Arseny Solokha <asolokha@kb.kras.ru>
List-Id: linux-i2c@vger.kernel.org

Remove the facility for setting the prescaler value at compile time
entirely. It was only used for two SoCs, duplicating the actual value
for one of them and setting sometimes bogus value for another. Make all
MPC8xxx SoCs obtain their actual I2C clock prescaler from a single place
in the code.

Changes from v2:
- left Device Tree compatibles in place

Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
---
 drivers/i2c/busses/i2c-mpc.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index aac0ec6dc5fc..d94f05c8b8b7 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -78,9 +78,7 @@ struct mpc_i2c_divider {
 };
 
 struct mpc_i2c_data {
-	void (*setup)(struct device_node *node, struct mpc_i2c *i2c,
-		      u32 clock, u32 prescaler);
-	u32 prescaler;
+	void (*setup)(struct device_node *node, struct mpc_i2c *i2c, u32 clock);
 };
 
 static inline void writeccr(struct mpc_i2c *i2c, u32 x)
@@ -201,7 +199,7 @@ static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] = {
 };
 
 static int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock,
-					  int prescaler, u32 *real_clk)
+					  u32 *real_clk)
 {
 	const struct mpc_i2c_divider *div = NULL;
 	unsigned int pvr = mfspr(SPRN_PVR);
@@ -236,7 +234,7 @@ static int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock,
 
 static void mpc_i2c_setup_52xx(struct device_node *node,
 					 struct mpc_i2c *i2c,
-					 u32 clock, u32 prescaler)
+					 u32 clock)
 {
 	int ret, fdr;
 
@@ -246,7 +244,7 @@ static void mpc_i2c_setup_52xx(struct device_node *node,
 		return;
 	}
 
-	ret = mpc_i2c_get_fdr_52xx(node, clock, prescaler, &i2c->real_clk);
+	ret = mpc_i2c_get_fdr_52xx(node, clock, &i2c->real_clk);
 	fdr = (ret >= 0) ? ret : 0x3f; /* backward compatibility */
 
 	writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
@@ -258,7 +256,7 @@ static void mpc_i2c_setup_52xx(struct device_node *node,
 #else /* !(CONFIG_PPC_MPC52xx || CONFIG_PPC_MPC512x) */
 static void mpc_i2c_setup_52xx(struct device_node *node,
 					 struct mpc_i2c *i2c,
-					 u32 clock, u32 prescaler)
+					 u32 clock)
 {
 }
 #endif /* CONFIG_PPC_MPC52xx || CONFIG_PPC_MPC512x */
@@ -266,7 +264,7 @@ static void mpc_i2c_setup_52xx(struct device_node *node,
 #ifdef CONFIG_PPC_MPC512x
 static void mpc_i2c_setup_512x(struct device_node *node,
 					 struct mpc_i2c *i2c,
-					 u32 clock, u32 prescaler)
+					 u32 clock)
 {
 	struct device_node *node_ctrl;
 	void __iomem *ctrl;
@@ -289,12 +287,12 @@ static void mpc_i2c_setup_512x(struct device_node *node,
 	}
 
 	/* The clock setup for the 52xx works also fine for the 512x */
-	mpc_i2c_setup_52xx(node, i2c, clock, prescaler);
+	mpc_i2c_setup_52xx(node, i2c, clock);
 }
 #else /* CONFIG_PPC_MPC512x */
 static void mpc_i2c_setup_512x(struct device_node *node,
 					 struct mpc_i2c *i2c,
-					 u32 clock, u32 prescaler)
+					 u32 clock)
 {
 }
 #endif /* CONFIG_PPC_MPC512x */
@@ -388,16 +386,13 @@ static u32 mpc_i2c_get_prescaler_8xxx(void)
 }
 
 static int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
-					  u32 prescaler, u32 *real_clk)
+					  u32 *real_clk)
 {
 	const struct mpc_i2c_divider *div = NULL;
+	u32 prescaler = mpc_i2c_get_prescaler_8xxx();
 	u32 divider;
 	int i;
 
-	/* Determine proper divider value */
-	if (!prescaler)
-		prescaler = mpc_i2c_get_prescaler_8xxx();
-
 	if (clock == MPC_I2C_CLOCK_LEGACY) {
 		/* see below - default fdr = 0x1031 -> div = 16 * 3072 */
 		*real_clk = fsl_get_sys_freq() / prescaler / (16 * 3072);
@@ -425,7 +420,7 @@ static int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
 
 static void mpc_i2c_setup_8xxx(struct device_node *node,
 					 struct mpc_i2c *i2c,
-					 u32 clock, u32 prescaler)
+					 u32 clock)
 {
 	int ret, fdr;
 
@@ -436,7 +431,7 @@ static void mpc_i2c_setup_8xxx(struct device_node *node,
 		return;
 	}
 
-	ret = mpc_i2c_get_fdr_8xxx(node, clock, prescaler, &i2c->real_clk);
+	ret = mpc_i2c_get_fdr_8xxx(node, clock, &i2c->real_clk);
 	fdr = (ret >= 0) ? ret : 0x1031; /* backward compatibility */
 
 	writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
@@ -450,7 +445,7 @@ static void mpc_i2c_setup_8xxx(struct device_node *node,
 #else /* !CONFIG_FSL_SOC */
 static void mpc_i2c_setup_8xxx(struct device_node *node,
 					 struct mpc_i2c *i2c,
-					 u32 clock, u32 prescaler)
+					 u32 clock)
 {
 }
 #endif /* CONFIG_FSL_SOC */
@@ -721,11 +716,11 @@ static int fsl_i2c_probe(struct platform_device *op)
 
 	if (match->data) {
 		const struct mpc_i2c_data *data = match->data;
-		data->setup(op->dev.of_node, i2c, clock, data->prescaler);
+		data->setup(op->dev.of_node, i2c, clock);
 	} else {
 		/* Backwards compatibility */
 		if (of_get_property(op->dev.of_node, "dfsrr", NULL))
-			mpc_i2c_setup_8xxx(op->dev.of_node, i2c, clock, 0);
+			mpc_i2c_setup_8xxx(op->dev.of_node, i2c, clock);
 	}
 
 	prop = of_get_property(op->dev.of_node, "fsl,timeout", &plen);
@@ -823,12 +818,10 @@ static const struct mpc_i2c_data mpc_i2c_data_8313 = {
 
 static const struct mpc_i2c_data mpc_i2c_data_8543 = {
 	.setup = mpc_i2c_setup_8xxx,
-	.prescaler = 2,
 };
 
 static const struct mpc_i2c_data mpc_i2c_data_8544 = {
 	.setup = mpc_i2c_setup_8xxx,
-	.prescaler = 3,
 };
 
 static const struct of_device_id mpc_i2c_of_match[] = {
-- 
2.15.1
