From: Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH] eeprom: at24: Fix unexpected timeout under high load
Date: Sat, 4 Aug 2018 19:43:40 +0200
Message-ID: <1533404620-18536-1-git-send-email-mark.jonas@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Wang Xin <xin.wang7@cn.bosch.com>, Mark Jonas <mark.jonas@de.bosch.com>
List-Id: linux-i2c@vger.kernel.org

From: Wang Xin <xin.wang7@cn.bosch.com>

Within at24_loop_until_timeout the timestamp used for timeout checking
is recorded after the I2C transfer and sleep_range(). Under high CPU
load either the execution time for I2C transfer or sleep_range() could
actually be larger than the timeout value. Worst case the I2C transfer
is only tried once because the loop will exit due to the timeout
although the EEPROM is now ready.

To fix this issue the timestamp is recorded at the beginning of each
iteration. That is, before I2C transfer and sleep. Then the timeout
is actually checked against the timestamp of the previous iteration.
This makes sure that even if the timeout is reached, there is still one
more chance to try the I2C transfer in case the EEPROM is ready.

Signed-off-by: Wang Xin <xin.wang7@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 drivers/misc/eeprom/at24.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index f5cc517..6d8c294 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -112,16 +112,26 @@ MODULE_PARM_DESC(at24_write_timeout, "Time (in ms) to try writes (default 25)");
  * write to work while making sure that at least one iteration is run before
  * checking the break condition.
  *
+ * By recording current time at the beginning of one iteration, the timeout
+ * is actually checked against the time in previous iteration. It makes sure,
+ * even the timeout is reached, there is still one more chance to try I2C
+ * transfer in case EEPROM is ready.
+ *
  * It takes two parameters: a variable in which the future timeout in jiffies
  * will be stored and a temporary variable holding the time of the last
  * iteration of processing the request. Both should be unsigned integers
  * holding at least 32 bits.
  */
-#define at24_loop_until_timeout(tout, op_time)				\
-	for (tout = jiffies + msecs_to_jiffies(at24_write_timeout),	\
-	     op_time = 0;						\
-	     op_time ? time_before(op_time, tout) : true;		\
-	     usleep_range(1000, 1500), op_time = jiffies)
+#define at24_loop_until_timeout_begin(tout, op_time)		\
+	tout = jiffies + msecs_to_jiffies(at24_write_timeout);	\
+	while (true) {						\
+		op_time = jiffies;
+
+#define at24_loop_until_timeout_end(tout, op_time)		\
+		if (time_before(tout, op_time))			\
+			break;					\
+		usleep_range(1000, 1500);			\
+	}
 
 struct at24_chip_data {
 	/*
@@ -308,13 +318,14 @@ static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
 	/* adjust offset for mac and serial read ops */
 	offset += at24->offset_adj;
 
-	at24_loop_until_timeout(timeout, read_time) {
+	at24_loop_until_timeout_begin(timeout, read_time) {
 		ret = regmap_bulk_read(regmap, offset, buf, count);
 		dev_dbg(&client->dev, "read %zu@%d --> %d (%ld)\n",
 			count, offset, ret, jiffies);
 		if (!ret)
 			return count;
 	}
+	at24_loop_until_timeout_end(timeout, read_time)
 
 	return -ETIMEDOUT;
 }
@@ -359,13 +370,14 @@ static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
 	client = at24_client->client;
 	count = at24_adjust_write_count(at24, offset, count);
 
-	at24_loop_until_timeout(timeout, write_time) {
+	at24_loop_until_timeout_begin(timeout, write_time) {
 		ret = regmap_bulk_write(regmap, offset, buf, count);
 		dev_dbg(&client->dev, "write %zu@%d --> %d (%ld)\n",
 			count, offset, ret, jiffies);
 		if (!ret)
 			return count;
 	}
+	at24_loop_until_timeout_end(timeout, write_time)
 
 	return -ETIMEDOUT;
 }
-- 
2.7.4
