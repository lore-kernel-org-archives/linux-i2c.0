From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 2/4] i2c: eg20t: pass on return value in i2c_xfer
Date: Fri, 20 Apr 2012 22:45:15 +0200
Message-ID: <1334954717-13146-3-git-send-email-w.sang@pengutronix.de>
References: <1334954717-13146-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334954717-13146-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

smatch says:
drivers/i2c/busses/i2c-eg20t.c:702 pch_i2c_xfer() info: why not propagate 'ret' from mutex_lock_interruptible() instead of -512?

which is especially true since for -ENORESTARTSYS it is said in
linux/errno.h "signal_pending() MUST be set" which is not done here. So
just pass on the return value we got.

Signed-off-by: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 6e9e075..93926a7 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -699,7 +699,7 @@ static s32 pch_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	ret = mutex_lock_interruptible(&pch_mutex);
 	if (ret)
-		return -ERESTARTSYS;
+		return ret;
 
 	if (adap->p_adapter_info->pch_i2c_suspended) {
 		mutex_unlock(&pch_mutex);
-- 
1.7.10
