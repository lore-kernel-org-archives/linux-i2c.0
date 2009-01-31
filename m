From: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c,algo: timeout reaches -1
Date: Sat, 31 Jan 2009 16:04:43 +0100
Message-ID: <4984688B.2090805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The postfix decrement decrements timeout till -1, but the
warning is already triggered on 0

Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 3e01992..0e2933f 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -115,7 +115,7 @@ static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
 
 	status = get_pcf(adap, 1);
 #ifndef STUB_I2C
-	while (timeout-- && !(status & I2C_PCF_BB)) {
+	while (--timeout && !(status & I2C_PCF_BB)) {
 		udelay(100); /* wait for 100 us */
 		status = get_pcf(adap, 1);
 	}
@@ -123,7 +123,7 @@ static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
 	if (timeout <= 0) {
 		printk(KERN_ERR "Timeout waiting for Bus Busy\n");
 	}
-	
+
 	return (timeout<=0);
 }
 
@@ -134,7 +134,7 @@ static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status) {
 
 	*status = get_pcf(adap, 1);
 #ifndef STUB_I2C
-	while (timeout-- && (*status & I2C_PCF_PIN)) {
+	while (--timeout && (*status & I2C_PCF_PIN)) {
 		adap->waitforpin(adap->data);
 		*status = get_pcf(adap, 1);
 	}
