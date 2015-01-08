From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: pmcmsp: remove dead code
Date: Thu,  8 Jan 2015 20:19:00 +0100
Message-ID: <1420744740-26468-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CPPCHECK rightfully says:

drivers/i2c/busses/i2c-pmcmsp.c:151: style: The function 'pmcmsptwi_reg_to_clock' is never used.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-pmcmsp.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index 44f03eed00dd..d37d9db6681e 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -148,13 +148,6 @@ static inline u32 pmcmsptwi_clock_to_reg(
 	return ((clock->filter & 0xf) << 12) | (clock->clock & 0x03ff);
 }
 
-static inline void pmcmsptwi_reg_to_clock(
-			u32 reg, struct pmcmsptwi_clock *clock)
-{
-	clock->filter = (reg >> 12) & 0xf;
-	clock->clock = reg & 0x03ff;
-}
-
 static inline u32 pmcmsptwi_cfg_to_reg(const struct pmcmsptwi_cfg *cfg)
 {
 	return ((cfg->arbf & 0xf) << 12) |
-- 
2.1.3
