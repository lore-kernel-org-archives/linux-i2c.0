From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] i2c: davinci: Refactor i2c_davinci_wait_bus_not_busy()
Date: Wed, 13 May 2015 15:03:28 +0200
Message-ID: <55534BA0.3000506@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Lawnick Michael 61283229 <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Mastalski Bartosz <bartosz.mastalski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There are several problems in the function:
- "to_cnt" variable does nothing
- schedule_timeout() call without setting current state does nothing
- "allow_sleep" parameter is not really used

Refactor the function so that it really tries to wait. In case of timeout try
to recover the bus.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
Changes in v2:
- rebased on 110bc76729d4 of Linus's tree;

 drivers/i2c/busses/i2c-davinci.c |   42 +++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index df96ab6..03afdee 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -350,29 +350,25 @@ static struct i2c_bus_recovery_info davinci_i2c_scl_recovery_info = {
 /*
  * Waiting for bus not busy
  */
-static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
-					 char allow_sleep)
+static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev)
 {
-	unsigned long timeout;
-	static u16 to_cnt;
-
-	timeout = jiffies + dev->adapter.timeout;
-	while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
-	       & DAVINCI_I2C_STR_BB) {
-		if (to_cnt <= DAVINCI_I2C_MAX_TRIES) {
-			if (time_after(jiffies, timeout)) {
-				dev_warn(dev->dev,
-				"timeout waiting for bus ready\n");
-				to_cnt++;
-				return -ETIMEDOUT;
-			} else {
-				to_cnt = 0;
-				i2c_recover_bus(&dev->adapter);
-			}
-		}
-		if (allow_sleep)
-			schedule_timeout(1);
-	}
+	unsigned long timeout = jiffies + dev->adapter.timeout;
+
+	do {
+		if (!(davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG) & DAVINCI_I2C_STR_BB))
+			return 0;
+		schedule_timeout_uninterruptible(1);
+	} while (time_before_eq(jiffies, timeout));
+
+	dev_warn(dev->dev, "timeout waiting for bus ready\n");
+	i2c_recover_bus(dev);
+
+	/*
+	 * if bus is still "busy" here, it's most probably a HW problem like
+	 * short-circuit
+	 */
+	if (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG) & DAVINCI_I2C_STR_BB)
+		return -EIO;
 
 	return 0;
 }
@@ -508,7 +504,7 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
 
-	ret = i2c_davinci_wait_bus_not_busy(dev, 1);
+	ret = i2c_davinci_wait_bus_not_busy(dev);
 	if (ret < 0) {
 		dev_warn(dev->dev, "timeout waiting for bus ready\n");
 		return ret;
