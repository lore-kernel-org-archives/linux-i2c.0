From: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 1/8] i2c: imx: use struct representing i2c clk{div, val} pair
Date: Wed, 7 Aug 2013 17:05:36 +0800
Message-ID: <1375866343-2074-1-git-send-email-b35083@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

using struct representing the i2c clk{div, val} pair would
make the i2c_clk_div array more clear.

Signed-off-by: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index e242797..9167d43 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -30,6 +30,8 @@
  *	Copyright (C) 2007 RightHand Technologies, Inc.
  *	Copyright (C) 2008 Darius Augulis <darius.augulis at teltonika.lt>
  *
+ *	Copyright 2013 Freescale Semiconductor, Inc.
+ *
  */
 
 /** Includes *******************************************************************
@@ -95,8 +97,12 @@
  *
  * Duplicated divider values removed from list
  */
+struct imx_i2c_clk_pair {
+	u16	div;
+	u16	val;
+};
 
-static u16 __initdata i2c_clk_div[50][2] = {
+static struct imx_i2c_clk_pair __initdata i2c_clk_div[] = {
 	{ 22,	0x20 }, { 24,	0x21 }, { 26,	0x22 }, { 28,	0x23 },
 	{ 30,	0x00 },	{ 32,	0x24 }, { 36,	0x25 }, { 40,	0x26 },
 	{ 42,	0x03 }, { 44,	0x27 },	{ 48,	0x28 }, { 52,	0x05 },
@@ -274,15 +280,15 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
 	/* Divider value calculation */
 	i2c_clk_rate = clk_get_rate(i2c_imx->clk);
 	div = (i2c_clk_rate + rate - 1) / rate;
-	if (div < i2c_clk_div[0][0])
+	if (div < i2c_clk_div[0].div)
 		i = 0;
-	else if (div > i2c_clk_div[ARRAY_SIZE(i2c_clk_div) - 1][0])
+	else if (div > i2c_clk_div[ARRAY_SIZE(i2c_clk_div) - 1].div)
 		i = ARRAY_SIZE(i2c_clk_div) - 1;
 	else
-		for (i = 0; i2c_clk_div[i][0] < div; i++);
+		for (i = 0; i2c_clk_div[i].div < div; i++);
 
 	/* Store divider value */
-	i2c_imx->ifdr = i2c_clk_div[i][1];
+	i2c_imx->ifdr = i2c_clk_div[i].val;
 
 	/*
 	 * There dummy delay is calculated.
@@ -290,7 +296,7 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
 	 * This delay is used in I2C bus disable function
 	 * to fix chip hardware bug.
 	 */
-	i2c_imx->disable_delay = (500000U * i2c_clk_div[i][0]
+	i2c_imx->disable_delay = (500000U * i2c_clk_div[i].div
 		+ (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
 
 	/* dev_dbg() can't be used, because adapter is not yet registered */
@@ -298,7 +304,7 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> I2C_CLK=%d, REQ DIV=%d\n",
 		__func__, i2c_clk_rate, div);
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> IFDR[IC]=0x%x, REAL DIV=%d\n",
-		__func__, i2c_clk_div[i][1], i2c_clk_div[i][0]);
+		__func__, i2c_clk_div[i].val, i2c_clk_div[i].div);
 #endif
 }
 
-- 
1.8.0
