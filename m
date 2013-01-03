From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Subject: [PATCH 1/2] drivers/i2c/busses/i2c-sh7760.c: use clk API instead of direct dereferences
Date: Thu,  3 Jan 2013 11:34:19 +0100
Message-ID: <1357209260-15412-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

A struct clk value is intended to be an abstract pointer, so it should be
manipulated using the various API functions.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,e1;
identifier i;
@@

*e = clk_get(...)
 ... when != e = e1
     when any
*e->i
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

---
I am not able to compile this code.  Furthermore, the documentation on
clk_get_rate says that the result is only valid if the clock has been
enabled, and I don't know if that is the case here.

 drivers/i2c/busses/i2c-sh7760.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index 3a2253e..972eafe 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -401,7 +401,7 @@ static int calc_CCR(unsigned long scl_hz)
 	if (IS_ERR(mclk)) {
 		return PTR_ERR(mclk);
 	} else {
-		mck = mclk->rate;
+		mck = clk_get_rate(mclk);
 		clk_put(mclk);
 	}
 
