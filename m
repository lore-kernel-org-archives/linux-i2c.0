From: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2] i2c: rk3x: fix divisor calculation for SCL frequency
Date: Mon,  8 Sep 2014 11:38:25 +0800
Message-ID: <1410147505-5930-1-git-send-email-addy.ke@rock-chips.com>
References: <1409884333-3544-1-git-send-email-addy.ke@rock-chips.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409884333-3544-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I2C_CLKDIV register descripted in the previous version of
RK3x chip manual is incorrect. Plus 1 is required.

The correct formula:
- T(SCL_HIGH) = T(PCLK) * (CLKDIVH + 1) * 8
- T(SCL_LOW) = T(PCLK) * (CLKDIVL + 1) * 8
- (SCL Divsor) = 8 * ((CLKDIVL + 1) + (CLKDIVH + 1))
- SCL = PCLK / (CLK Divsor)

It will be updated to the latest version of chip manual.

Signed-off-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
changes since v1:
- make it more cleaner, suggested by Doug Anderson

 drivers/i2c/busses/i2c-rk3x.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index e637c32..93cfc83 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -433,12 +433,11 @@ static void rk3x_i2c_set_scl_rate(struct rk3x_i2c *i2c, unsigned long scl_rate)
 	unsigned long i2c_rate = clk_get_rate(i2c->clk);
 	unsigned int div;
 
-	/* SCL rate = (clk rate) / (8 * DIV) */
-	div = DIV_ROUND_UP(i2c_rate, scl_rate * 8);
-
-	/* The lower and upper half of the CLKDIV reg describe the length of
-	 * SCL low & high periods. */
-	div = DIV_ROUND_UP(div, 2);
+	/* set DIV = DIVH = DIVL
+	 * SCL rate = (clk rate) / (8 * (DIVH + 1 + DIVL + 1))
+	 *          = (clk rate) / (16 * (DIV + 1))
+	 */
+	div = DIV_ROUND_UP(i2c_rate, scl_rate * 16) - 1;
 
 	i2c_writel(i2c, (div << 16) | (div & 0xffff), REG_CLKDIV);
 }
-- 
1.8.3.2
