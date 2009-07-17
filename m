From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: [PATCH] i2c-s3c2410: s3c24xx_i2c_init: don't clobber IICLC value
Date: Fri, 17 Jul 2009 22:33:37 +0200
Message-ID: <1247862817-17106-1-git-send-email-jacmet@sunsite.dk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

s3c24xx_i2c_init() was overwriting the IICLC value set just above in
s3c24xx_i2c_clockrate() with zero, effectively disabling the platform
line control setting.

Signed-off-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
---
 drivers/i2c/busses/i2c-s3c2410.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 8f42a45..20bb0ce 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -763,11 +763,6 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 	dev_info(i2c->dev, "bus frequency set to %d KHz\n", freq);
 	dev_dbg(i2c->dev, "S3C2410_IICCON=0x%02lx\n", iicon);
 
-	/* check for s3c2440 i2c controller  */
-
-	if (s3c24xx_i2c_is2440(i2c))
-		writel(0x0, i2c->regs + S3C2440_IICLC);
-
 	return 0;
 }
 
-- 
1.6.3.3
