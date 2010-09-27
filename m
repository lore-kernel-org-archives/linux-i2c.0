From: Bernhard Walle <walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>
Subject: [PATCH] MIPS: I2C: Return -ETIMEDOUT in octeon_i2c_wait() on timeout
Date: Mon, 27 Sep 2010 12:55:16 +0200
Message-ID: <1285584916-21317-1-git-send-email-walle@corscience.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, rade.bozic.ext-OYasijW0DpE@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

It doesn't make sense to set result to -ETIMEDOUT but return 0 (success)
afterwards. Since there's code in octeon_i2c_start() to handle the
error, it should be called.

Signed-off-by: Bernhard Walle <walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>
---
 drivers/i2c/busses/i2c-octeon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 0e9f85d..56dbe54 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -218,7 +218,7 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 		return result;
 	} else if (result == 0) {
 		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
-		result = -ETIMEDOUT;
+		return -ETIMEDOUT;
 	}
 
 	return 0;
-- 
1.7.0.4
