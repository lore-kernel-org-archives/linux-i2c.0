From: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: imx: only imx1 needs disable delay
Date: Wed, 30 Sep 2009 13:48:00 +0800
Message-ID: <1254289682-29056-2-git-send-email-linuxzsc@gmail.com>
References: <1254289682-29056-1-git-send-email-linuxzsc@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1254289682-29056-1-git-send-email-linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

check cpu_is_mx1() when set disable_delay.

Signed-off-by: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 156cc95..c1e541c 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -254,14 +254,16 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
 	/* Write divider value to register */
 	writeb(i2c_clk_div[i][1], i2c_imx->base + IMX_I2C_IFDR);
 
-	/*
-	 * There dummy delay is calculated.
-	 * It should be about one I2C clock period long.
-	 * This delay is used in I2C bus disable function
-	 * to fix chip hardware bug.
-	 */
-	i2c_imx->disable_delay = (500000U * i2c_clk_div[i][0]
-		+ (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
+	if (cpu_is_mx1()) {
+		/*
+		 * There dummy delay is calculated.
+		 * It should be about one I2C clock period long.
+		 * This delay is used in I2C bus disable function
+		 * to fix chip hardware bug.
+		 */
+		i2c_imx->disable_delay = (500000U * i2c_clk_div[i][0]
+			+ (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
+	}
 
 	/* dev_dbg() can't be used, because adapter is not yet registered */
 #ifdef CONFIG_I2C_DEBUG_BUS
-- 
1.6.0.4
