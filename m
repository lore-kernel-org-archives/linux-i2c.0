From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH RESEND] i2c: pnx: Fix crash due to wrong init of timer->data
Date: Fri, 29 Apr 2011 15:30:02 +0200
Message-ID: <1304083802-18122-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

alg_data is already a pointer which must be passed directly.

Reported-by: Dieter Ripp <ripp-24OduB8/I+bby3iVrkZq2A@public.gmane.org>
Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---

Ben, will there be another i2c update for 2.6.39? This fixes a crash,
so I think it is even stable-material.

 drivers/i2c/busses/i2c-pnx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 4d2168f..30365f3 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -66,7 +66,7 @@ static inline void i2c_pnx_arm_timer(struct i2c_pnx_algo_data *alg_data)
 		jiffies, expires);
 
 	timer->expires = jiffies + expires;
-	timer->data = (unsigned long)&alg_data;
+	timer->data = (unsigned long)alg_data;
 
 	add_timer(timer);
 }
-- 
1.7.2.3
