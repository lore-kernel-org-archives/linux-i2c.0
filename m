From: Toshiharu Okada <toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: [PATCH] i2c-eg20t: modified the setting of transfer rate.
Date: Mon, 26 Sep 2011 16:16:23 +0900
Message-ID: <1317021383-11742-1-git-send-email-toshiharu-linux@dsn.okisemi.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org, Toshiharu Okada <toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch modified the setting value of
I2C Bus Transfer Rate Setting Counter regisrer.

Signed-off-by: Toshiharu Okada <toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index ce1a32b..6b46892 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -242,7 +242,7 @@ static void pch_i2c_init(struct i2c_algo_pch_data *adap)
 	if (pch_clk > PCH_MAX_CLK)
 		pch_clk = 62500;
 
-	pch_i2cbc = (pch_clk + (pch_i2c_speed * 4)) / pch_i2c_speed * 8;
+	pch_i2cbc = (pch_clk + (pch_i2c_speed * 4)) / (pch_i2c_speed * 8);
 	/* Set transfer speed in I2CBC */
 	iowrite32(pch_i2cbc, p + PCH_I2CBC);
 
-- 
1.7.4.4
