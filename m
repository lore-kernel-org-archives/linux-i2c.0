From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 2/2] eeprom: at24: use a common prefix for all symbols in at24.c
Date: Wed,  6 Dec 2017 14:01:31 +0100
Message-ID: <20171206130131.13438-3-brgl@bgdev.pl>
References: <20171206130131.13438-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:46439 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbdLFNBw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Dec 2017 08:01:52 -0500
Received: by mail-wm0-f67.google.com with SMTP id r78so7099927wme.5
        for <linux-i2c@vger.kernel.org>; Wed, 06 Dec 2017 05:01:50 -0800 (PST)
In-Reply-To: <20171206130131.13438-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

There are a couple symbols defined in the driver source file which are
missing the at24_ prefix. This patch fixes that.

For module params: use module_param_named() in order not to break the
userspace.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2426f2c111c7..dd0903c7df39 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -93,17 +93,17 @@ struct at24_data {
  *
  * This value is forced to be a power of two so that writes align on pages.
  */
-static unsigned int io_limit = 128;
-module_param(io_limit, uint, 0000);
-MODULE_PARM_DESC(io_limit, "Maximum bytes per I/O (default 128)");
+static unsigned int at24_io_limit = 128;
+module_param_named(io_limit, at24_io_limit, uint, 0000);
+MODULE_PARM_DESC(at24_io_limit, "Maximum bytes per I/O (default 128)");
 
 /*
  * Specs often allow 5 msec for a page write, sometimes 20 msec;
  * it's important to recover from write timeouts.
  */
-static unsigned int write_timeout = 25;
-module_param(write_timeout, uint, 0000);
-MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
+static unsigned int at24_write_timeout = 25;
+module_param_named(write_timeout, at24_write_timeout, uint, 0000);
+MODULE_PARM_DESC(at24_write_timeout, "Time (in ms) to try writes (default 25)");
 
 #define AT24_SIZE_BYTELEN 5
 #define AT24_SIZE_FLAGS 8
@@ -126,8 +126,9 @@ MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
  * iteration of processing the request. Both should be unsigned integers
  * holding at least 32 bits.
  */
-#define loop_until_timeout(tout, op_time)				\
-	for (tout = jiffies + msecs_to_jiffies(write_timeout), op_time = 0; \
+#define at24_tool_until_timeout(tout, op_time)				\
+	for (tout = jiffies + msecs_to_jiffies(at24_write_timeout),	\
+	     op_time = 0;						\
 	     op_time ? time_before(op_time, tout) : true;		\
 	     usleep_range(1000, 1500), op_time = jiffies)
 
@@ -290,13 +291,13 @@ static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
 	regmap = at24_client->regmap;
 	client = at24_client->client;
 
-	if (count > io_limit)
-		count = io_limit;
+	if (count > at24_io_limit)
+		count = at24_io_limit;
 
 	/* adjust offset for mac and serial read ops */
 	offset += at24->offset_adj;
 
-	loop_until_timeout(timeout, read_time) {
+	at24_tool_until_timeout(timeout, read_time) {
 		ret = regmap_bulk_read(regmap, offset, buf, count);
 		dev_dbg(&client->dev, "read %zu@%d --> %d (%ld)\n",
 			count, offset, ret, jiffies);
@@ -347,7 +348,7 @@ static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
 	client = at24_client->client;
 	count = at24_adjust_write_count(at24, offset, count);
 
-	loop_until_timeout(timeout, write_time) {
+	at24_tool_until_timeout(timeout, write_time) {
 		ret = regmap_bulk_write(regmap, offset, buf, count);
 		dev_dbg(&client->dev, "write %zu@%d --> %d (%ld)\n",
 			count, offset, ret, jiffies);
@@ -613,7 +614,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	writable = !(chip.flags & AT24_FLAG_READONLY);
 	if (writable) {
-		at24->write_max = min_t(unsigned int, chip.page_size, io_limit);
+		at24->write_max = min_t(unsigned int,
+					chip.page_size, at24_io_limit);
 		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
 		    at24->write_max > I2C_SMBUS_BLOCK_MAX)
 			at24->write_max = I2C_SMBUS_BLOCK_MAX;
@@ -728,12 +730,12 @@ static struct i2c_driver at24_driver = {
 
 static int __init at24_init(void)
 {
-	if (!io_limit) {
-		pr_err("at24: io_limit must not be 0!\n");
+	if (!at24_io_limit) {
+		pr_err("at24: at24_io_limit must not be 0!\n");
 		return -EINVAL;
 	}
 
-	io_limit = rounddown_pow_of_two(io_limit);
+	at24_io_limit = rounddown_pow_of_two(at24_io_limit);
 	return i2c_add_driver(&at24_driver);
 }
 module_init(at24_init);
-- 
2.15.1
