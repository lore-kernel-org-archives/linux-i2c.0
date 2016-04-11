From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 13/13] eeprom: at24: add at24mac chips to the list of supported devices
Date: Mon, 11 Apr 2016 11:57:29 -0700
Message-ID: <1460401049-25459-14-git-send-email-bgolaszewski@baylibre.com>
References: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32906 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbcDKS6F (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Apr 2016 14:58:05 -0400
Received: by mail-pf0-f182.google.com with SMTP id 184so129327739pff.0
        for <linux-i2c@vger.kernel.org>; Mon, 11 Apr 2016 11:58:04 -0700 (PDT)
In-Reply-To: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com
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
