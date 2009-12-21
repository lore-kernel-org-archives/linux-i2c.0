From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 2/10] ARM: PNX4008: simplify clk enable/disable paths
Date: Tue, 22 Dec 2009 00:21:38 +0100
Message-ID: <083DF309106F364B939360100EC290F804F592E902@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


Signed-off-by: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
---
 arch/arm/mach-pnx4008/clock.c |   56 +++++++++++++++++-----------------------
 1 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-pnx4008/clock.c b/arch/arm/mach-pnx4008/clock.c
index e0d1e9f..b1380f1 100644
--- a/arch/arm/mach-pnx4008/clock.c
+++ b/arch/arm/mach-pnx4008/clock.c
@@ -808,49 +808,41 @@ static struct clk_lookup onchip_clkreg[] = {
 	{ .clk = &wdt_ck,	.con_id = "wdt_ck"	},
 };
 
-static int local_clk_enable(struct clk *clk)
-{
-	int ret = 0;
-
-	if (!(clk->flags & FIXED_RATE) && !clk->rate && clk->set_rate
-	    && clk->user_rate)
-		ret = clk->set_rate(clk, clk->user_rate);
-	return ret;
-}
-
 static void local_clk_disable(struct clk *clk)
 {
-	if (!(clk->flags & FIXED_RATE) && clk->rate && clk->set_rate)
-		clk->set_rate(clk, 0);
-}
+	if (WARN_ON(clk->usecount == 0))
+		return;
+
+	if (!(--clk->usecount)) {
+		if (!(clk->flags & FIXED_RATE) && clk->rate && clk->set_rate)
+			clk->set_rate(clk, 0);
 
-static void local_clk_unuse(struct clk *clk)
-{
-	if (clk->usecount > 0 && !(--clk->usecount)) {
-		local_clk_disable(clk);
 		if (clk->parent)
-			local_clk_unuse(clk->parent);
+			local_clk_disable(clk->parent);
 	}
 }
 
-static int local_clk_use(struct clk *clk)
+static int local_clk_enable(struct clk *clk)
 {
 	int ret = 0;
-	if (clk->usecount++ == 0) {
-		if (clk->parent)
-			ret = local_clk_use(clk->parent);
 
-		if (ret != 0) {
-			clk->usecount--;
-			goto out;
+	if (clk->usecount == 0) {
+		if (clk->parent) {
+			ret = local_clk_enable(clk->parent);
+			if (ret != 0)
+				goto out;
 		}
 
-		ret = local_clk_enable(clk);
+		if (!(clk->flags & FIXED_RATE) && !clk->rate && clk->set_rate
+		    && clk->user_rate)
+			ret = clk->set_rate(clk, clk->user_rate);
 
 		if (ret != 0 && clk->parent) {
-			local_clk_unuse(clk->parent);
-			clk->usecount--;
+			local_clk_disable(clk->parent);
+			goto out;
 		}
+
+		clk->usecount++;
 	}
 out:
 	return ret;
@@ -909,10 +901,10 @@ EXPORT_SYMBOL(clk_get_rate);
 
 int clk_enable(struct clk *clk)
 {
-	int ret = 0;
+	int ret;
 
 	clock_lock();
-	ret = local_clk_use(clk);
+	ret = local_clk_enable(clk);
 	clock_unlock();
 	return ret;
 }
@@ -922,7 +914,7 @@ EXPORT_SYMBOL(clk_enable);
 void clk_disable(struct clk *clk)
 {
 	clock_lock();
-	local_clk_unuse(clk);
+	local_clk_disable(clk);
 	clock_unlock();
 }
 
@@ -981,7 +973,7 @@ static int __init clk_init(void)
 			__func__, (*clkp)->name, (*clkp)->rate);
 	}
 
-	local_clk_use(&ck_pll4);
+	local_clk_enable(&ck_pll4);
 
 	/* if ck_13MHz is not used, disable it. */
 	if (ck_13MHz.usecount == 0)
-- 
1.6.0.6
