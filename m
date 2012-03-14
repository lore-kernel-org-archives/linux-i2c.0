From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: [DEBUG PATCH] Print a message when a spurious i2c SCL timeout  occurs.
Date: Wed, 14 Mar 2012 10:32:53 +0200
Message-ID: <1331713973-7711-2-git-send-email-syrjala@sci.fi>
References: <1331713973-7711-1-git-send-email-syrjala@sci.fi>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1331713973-7711-1-git-send-email-syrjala-ORSVBvAovxo@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala-ORSVBvAovxo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

A quick hack to verify that the fix works as intended...

Do not apply.

---
 drivers/i2c/algos/i2c-algo-bit.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index d25112e..3f547b5 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -89,6 +89,7 @@ static inline void scllo(struct i2c_algo_bit_data *adap)
 static int sclhi(struct i2c_algo_bit_data *adap)
 {
 	unsigned long start;
+	bool timeout = false;
 
 	setscl(adap, 1);
 
@@ -104,11 +105,16 @@ static int sclhi(struct i2c_algo_bit_data *adap)
 		 * are processing data internally.
 		 */
 		if (time_after(jiffies, start + adap->timeout))
+		{
+			timeout = true;
 			break;
+		}
 		cond_resched();
 	}
 	if (!getscl(adap))
 		return -ETIMEDOUT;
+	if (timeout)
+		printk(KERN_CRIT "spurious i2c scl timeout\n");
 #ifdef DEBUG
 	if (jiffies != start && i2c_debug >= 3)
 		pr_debug("i2c-algo-bit: needed %ld jiffies for SCL to go "
-- 
1.7.3.4
