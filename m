From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 13/13] eeprom: at24: add at24mac chips to the list of supported devices
Date: Thu, 24 Mar 2016 17:19:43 +0100
Message-ID: <1458836383-6668-14-git-send-email-bgolaszewski@baylibre.com>
References: <1458836383-6668-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38104 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757017AbcCXQUA (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Mar 2016 12:20:00 -0400
Received: by mail-wm0-f43.google.com with SMTP id l68so73708054wml.1
        for <linux-i2c@vger.kernel.org>; Thu, 24 Mar 2016 09:19:59 -0700 (PDT)
In-Reply-To: <1458836383-6668-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Now with the infrastructue for reading the factory-programmed mac
address in place, add the two available chips from the at24mac
family: at24mac402 and at24mac602 to the device ID list.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index edec236..558b498 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -120,6 +120,10 @@ static const struct i2c_device_id at24_ids[] = {
 	{ "24c02",	AT24_DEVICE_MAGIC(2048 / 8,	0) },
 	{ "24cs02",	AT24_DEVICE_MAGIC(128 / 8,
 				AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
+	{ "24mac402",	AT24_DEVICE_MAGIC(48 / 8,
+				AT24_FLAG_MAC | AT24_FLAG_READONLY) },
+	{ "24mac602",	AT24_DEVICE_MAGIC(64 / 8,
+				AT24_FLAG_MAC | AT24_FLAG_READONLY) },
 	/* spd is a 24c02 in memory DIMMs */
 	{ "spd",	AT24_DEVICE_MAGIC(2048 / 8,
 				AT24_FLAG_READONLY | AT24_FLAG_IRUGO) },
-- 
2.7.4
