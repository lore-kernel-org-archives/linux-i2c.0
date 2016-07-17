From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] eeprom: at24: tweak the loop_until_timeout() macro
Date: Sun, 17 Jul 2016 20:40:06 +0200
Message-ID: <1468780806-13034-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37728 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbcGQSkM (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 17 Jul 2016 14:40:12 -0400
Received: by mail-wm0-f42.google.com with SMTP id i5so89887141wmg.0
        for <linux-i2c@vger.kernel.org>; Sun, 17 Jul 2016 11:40:11 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>

loop_until_timeout() replaced a do {} while loop in the at24 driver
with a for loop which, under certain circumstances (such as heavy load
or low value of the write_timeout argument), can lead to the code in
the loop never being executed.

Make sure that at least one iteration of the code enclosed within
loop_until_timeout() is always executed.

Suggested-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0b8fafdb..1f62aaf 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -116,7 +116,8 @@ MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
 /*
  * Both reads and writes fail if the previous write didn't complete yet. This
  * macro loops a few times waiting at least long enough for one entire page
- * write to work.
+ * write to work while making sure that at least one iteration is run before
+ * checking the break condition.
  *
  * It takes two parameters: a variable in which the future timeout in jiffies
  * will be stored and a temporary variable holding the time of the last
@@ -124,9 +125,8 @@ MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
  * holding at least 32 bits.
  */
 #define loop_until_timeout(tout, op_time)				\
-	for (tout = jiffies + msecs_to_jiffies(write_timeout),		\
-		op_time = jiffies;					\
-	     time_before(op_time, tout);				\
+	for (tout = jiffies + msecs_to_jiffies(write_timeout), op_time = 0; \
+	     op_time ? time_before(op_time, tout) : true;		\
 	     usleep_range(1000, 1500), op_time = jiffies)
 
 static const struct i2c_device_id at24_ids[] = {
-- 
2.7.4
