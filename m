From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] i2c: imx: Use dev_dbg logging style
Date: Wed,  1 Aug 2012 17:38:15 -0300
Message-ID: <1343853495-23479-2-git-send-email-festevam@gmail.com>
References: <1343853495-23479-1-git-send-email-festevam@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343853495-23479-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Use dev_dbg logging style as it is done in other parts of this driver.

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index e143629..2e1d5f4 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -272,9 +272,9 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
 
 	/* dev_dbg() can't be used, because adapter is not yet registered */
 #ifdef CONFIG_I2C_DEBUG_BUS
-	printk(KERN_DEBUG "I2C: <%s> I2C_CLK=%d, REQ DIV=%d\n",
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> I2C_CLK=%d, REQ DIV=%d\n",
 		__func__, i2c_clk_rate, div);
-	printk(KERN_DEBUG "I2C: <%s> IFDR[IC]=0x%x, REAL DIV=%d\n",
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> IFDR[IC]=0x%x, REAL DIV=%d\n",
 		__func__, i2c_clk_div[i][1], i2c_clk_div[i][0]);
 #endif
 }
-- 
1.7.1
