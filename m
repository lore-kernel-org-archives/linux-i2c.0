From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-algo-bit: Don't resched on clock stretching
Date: Wed, 21 Mar 2012 11:12:02 +0100
Message-ID: <20120321111202.272d22ae@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Clock stretching is not supposed to last long, so asking to be
rescheduled while waiting for the clock line to be released by a slave
makes little sense. Odds are that the clock line will long have been
released when we run again, so we will have lost time and may even
get an SMBus timeout because of this.

So just busy-wait in that case. This also participates in the effort
to make i2c-algo-bit usable in contexts that can't sleep.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-3.3-rc7.orig/drivers/i2c/algos/i2c-algo-bit.c	2012-03-15 18:00:02.000000000 +0100
+++ linux-3.3-rc7/drivers/i2c/algos/i2c-algo-bit.c	2012-03-15 22:44:20.713259845 +0100
@@ -27,7 +27,6 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
@@ -112,7 +111,7 @@ static int sclhi(struct i2c_algo_bit_dat
 				break;
 			return -ETIMEDOUT;
 		}
-		cond_resched();
+		cpu_relax();
 	}
 #ifdef DEBUG
 	if (jiffies != start && i2c_debug >= 3)


-- 
Jean Delvare
