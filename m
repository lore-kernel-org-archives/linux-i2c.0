From: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 1/7 v3] i2c-eg20t: Fix bus-idle waiting issue
Date: Thu,  6 Oct 2011 15:56:25 +0900
Message-ID: <1317884192-10694-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Currently, when checking whether bus is idle or not,
if timeout occurs,
this function always returns success(zero).
This patch fixes the issue.

Signed-off-by: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 6565009..35d819a 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -275,23 +275,23 @@ static s32 pch_i2c_wait_for_bus_idle(struct i2c_algo_pch_data *adap,
 				     s32 timeout)
 {
 	void __iomem *p = adap->pch_base_address;
+	ktime_t ns_val;
+
+	if ((ioread32(p + PCH_I2CSR) & I2CMBB_BIT) == 0)
+		return 0;
 
 	/* MAX timeout value is timeout*1000*1000nsec */
-	ktime_t ns_val = ktime_add_ns(ktime_get(), timeout*1000*1000);
+	ns_val = ktime_add_ns(ktime_get(), timeout*1000*1000);
 	do {
-		if ((ioread32(p + PCH_I2CSR) & I2CMBB_BIT) == 0)
-			break;
 		msleep(20);
+		if ((ioread32(p + PCH_I2CSR) & I2CMBB_BIT) == 0)
+			return 0;
 	} while (ktime_lt(ktime_get(), ns_val));
 
 	pch_dbg(adap, "I2CSR = %x\n", ioread32(p + PCH_I2CSR));
+	pch_err(adap, "%s: Timeout Error.return%d\n", __func__, -ETIME);
 
-	if (timeout == 0) {
-		pch_err(adap, "%s: Timeout Error.return%d\n", __func__, -ETIME);
-		return -ETIME;
-	}
-
-	return 0;
+	return -ETIME;
 }
 
 /**
-- 
1.7.4.4
