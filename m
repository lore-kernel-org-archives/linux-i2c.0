From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: [PATCH] i2c-eg20t: Rework pch_i2c_wait_for_bus_idle to reduce wait time
Date: Thu,  9 Feb 2012 09:32:46 +0100
Message-ID: <1328776366-6881-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Toshiharu Okada <toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If you insert several i2c transfers, the driver might start the next one
while the STOP bit of the previous transfer is still on the bus, marking
the bus as busy.
pch_i2c_wait_for_bus_idle does an msleep(20) delaying the next transfer
by >=20ms. Reduce wait time by actively waiting 5 us once, then using
usleep_range.

Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |   35 ++++++++++++++++++++++-------------
 1 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index ca88776..6987e73 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -271,30 +271,39 @@ static inline bool ktime_lt(const ktime_t cmp1, const ktime_t cmp2)
 /**
  * pch_i2c_wait_for_bus_idle() - check the status of bus.
  * @adap:	Pointer to struct i2c_algo_pch_data.
- * @timeout:	waiting time counter (us).
+ * @timeout:	waiting time counter (ms).
  */
 static s32 pch_i2c_wait_for_bus_idle(struct i2c_algo_pch_data *adap,
 				     s32 timeout)
 {
 	void __iomem *p = adap->pch_base_address;
-	ktime_t ns_val;
+	int schedule = 0;
+	unsigned long end = jiffies + msecs_to_jiffies(timeout);
 
 	if ((ioread32(p + PCH_I2CSR) & I2CMBB_BIT) == 0)
 		return 0;
 
-	/* MAX timeout value is timeout*1000*1000nsec */
-	ns_val = ktime_add_ns(ktime_get(), timeout*1000*1000);
-	do {
-		msleep(20);
-		if ((ioread32(p + PCH_I2CSR) & I2CMBB_BIT) == 0)
-			return 0;
-	} while (ktime_lt(ktime_get(), ns_val));
+	while (ioread32(p + PCH_I2CSR) & I2CMBB_BIT) {
+		if (time_after(jiffies, end)) {
+			pch_dbg(adap, "I2CSR = %x\n", ioread32(p + PCH_I2CSR));
+			pch_err(adap, "%s: Timeout Error.return%d\n",
+					__func__, -ETIME);
+			pch_i2c_init(adap);
+
+			return -ETIME;
+		}
 
-	pch_dbg(adap, "I2CSR = %x\n", ioread32(p + PCH_I2CSR));
-	pch_err(adap, "%s: Timeout Error.return%d\n", __func__, -ETIME);
-	pch_i2c_init(adap);
+		if (!schedule)
+			/* Retry after some usecs */
+			udelay(5);
+		else
+			/* Wait a bit more without consuming CPU */
+			usleep_range(20, 1000);
+
+		schedule = 1;
+	}
 
-	return -ETIME;
+	return 0;
 }
 
 /**
-- 
1.7.3.4
