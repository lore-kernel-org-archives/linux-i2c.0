From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 3/4] i2c: eg20t: remove unused function
Date: Fri, 20 Apr 2012 22:45:16 +0200
Message-ID: <1334954717-13146-4-git-send-email-w.sang@pengutronix.de>
References: <1334954717-13146-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334954717-13146-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

cppcheck rightfully says:
drivers/i2c/busses/i2c-eg20t.c:266: style: The function 'ktime_lt' is never used

Signed-off-by: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 93926a7..5441e69 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -263,11 +263,6 @@ static void pch_i2c_init(struct i2c_algo_pch_data *adap)
 	init_waitqueue_head(&pch_event);
 }
 
-static inline bool ktime_lt(const ktime_t cmp1, const ktime_t cmp2)
-{
-	return cmp1.tv64 < cmp2.tv64;
-}
-
 /**
  * pch_i2c_wait_for_bus_idle() - check the status of bus.
  * @adap:	Pointer to struct i2c_algo_pch_data.
-- 
1.7.10
