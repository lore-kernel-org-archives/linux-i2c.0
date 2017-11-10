From: Arseny Solokha <asolokha@kb.kras.ru>
Subject: [PATCH 2/4] i2c: mpc: unify obtaining the MPC8533/44 I2C clock prescaler w/ MPC8xxx
Date: Fri, 10 Nov 2017 14:50:13 +0700
Message-ID: <20171110075015.23906-3-asolokha@kb.kras.ru>
References: <20171110075015.23906-1-asolokha@kb.kras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171110075015.23906-1-asolokha@kb.kras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>, Arseny Solokha <asolokha@kb.kras.ru>
List-Id: linux-i2c@vger.kernel.org

Commit 8ce795cb0c6b ("i2c: mpc: assign the correct prescaler from SVR")
introduced the common helper function for obtaining the actual clock
prescaler value for MPC85xx. However, getting the prescaler for MPC8544
which depends on the SEC frequency ratio on this platform, has been always
performed separately based on the corresponding Device Tree configuration.

Move special handling of MPC8544 into that common helper. Make it dependent
on the SoC version and not on Device Tree compatible node, as is the case
with all other SoCs. Handle MPC8533 the same way which is similar
to MPC8544 in this regard, according to AN2919 "Determining the I2C
Frequency Divider Ratio for SCL".

Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
---
 drivers/i2c/busses/i2c-mpc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index bf0c86d41f1a..f47916466b82 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -350,7 +350,11 @@ static u32 mpc_i2c_get_sec_cfg_8xxx(void)
 
 static u32 mpc_i2c_get_prescaler_8xxx(void)
 {
-	/* mpc83xx and mpc82xx all have prescaler 1 */
+	/*
+	 * According to the AN2919 all MPC824x have prescaler 1, while MPC83xx
+	 * may have prescaler 1, 2, or 3, depending on the power-on
+	 * configuration.
+	 */
 	u32 prescaler = 1;
 
 	/* mpc85xx */
@@ -367,6 +371,10 @@ static u32 mpc_i2c_get_prescaler_8xxx(void)
 			|| (SVR_SOC_VER(svr) == SVR_8610))
 			/* the above 85xx SoCs have prescaler 1 */
 			prescaler = 1;
+		else if ((SVR_SOC_VER(svr) == SVR_8533)
+			|| (SVR_SOC_VER(svr) == SVR_8544))
+			/* the above 85xx SoCs have prescaler 3 or 2 */
+			prescaler = mpc_i2c_get_sec_cfg_8xxx() ? 3 : 2;
 		else
 			/* all the other 85xx have prescaler 2 */
 			prescaler = 2;
@@ -383,8 +391,6 @@ static int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
 	int i;
 
 	/* Determine proper divider value */
-	if (of_device_is_compatible(node, "fsl,mpc8544-i2c"))
-		prescaler = mpc_i2c_get_sec_cfg_8xxx() ? 3 : 2;
 	if (!prescaler)
 		prescaler = mpc_i2c_get_prescaler_8xxx();
 
-- 
2.15.0
