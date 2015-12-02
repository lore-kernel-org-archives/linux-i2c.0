From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 8/9] eeprom: at24: remove a reduntant if
Date: Wed,  2 Dec 2015 11:25:25 +0100
Message-ID: <1449051926-21918-9-git-send-email-bgolaszewski@baylibre.com>
References: <1449051926-21918-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34813 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497AbbLBKZn (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 2 Dec 2015 05:25:43 -0500
Received: by wmvv187 with SMTP id v187so247554950wmv.1
        for <linux-i2c@vger.kernel.org>; Wed, 02 Dec 2015 02:25:42 -0800 (PST)
In-Reply-To: <1449051926-21918-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

It seems as if the second check for I2C_FUNC_I2C functionality had been
introduced accidentally during a merge. Tt's reduntant, so remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 6e28b02..1288193 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -634,10 +634,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		} else {
 			return -EPFNOSUPPORT;
 		}
-	}
 
-	/* Use I2C operations unless we're stuck with SMBus extensions. */
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		if (i2c_check_functionality(client->adapter,
 				I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
 			use_smbus_write = I2C_SMBUS_I2C_BLOCK_DATA;
-- 
2.1.4
