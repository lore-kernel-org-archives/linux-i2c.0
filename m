From: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: [PATCH 1/7] i2c-eg20t: Fix bus-idle waiting issue
Date: Wed, 21 Sep 2011 16:51:43 +0900
Message-ID: <1316591509-4433-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org, Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Currently, when checking whether bus is idle or not,
if timeout occurs,
this function always returns success(zero).
This patch fixes the issue.

Signed-off-by: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 6565009..6add59f 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -286,7 +286,7 @@ static s32 pch_i2c_wait_for_bus_idle(struct i2c_algo_pch_data *adap,
 
 	pch_dbg(adap, "I2CSR = %x\n", ioread32(p + PCH_I2CSR));
 
-	if (timeout == 0) {
+	if (!ktime_lt(ktime_get(), ns_val)) {
 		pch_err(adap, "%s: Timeout Error.return%d\n", __func__, -ETIME);
 		return -ETIME;
 	}
-- 
1.7.4.4
