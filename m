From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 01/13] eeprom: at24: remove a reduntant if
Date: Thu, 24 Mar 2016 17:19:31 +0100
Message-ID: <1458836383-6668-2-git-send-email-bgolaszewski@baylibre.com>
References: <1458836383-6668-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36880 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbcCXQTs (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Mar 2016 12:19:48 -0400
Received: by mail-wm0-f54.google.com with SMTP id p65so73379640wmp.0
        for <linux-i2c@vger.kernel.org>; Thu, 24 Mar 2016 09:19:47 -0700 (PDT)
In-Reply-To: <1458836383-6668-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

It seems as if the second check for I2C_FUNC_I2C functionality had
been introduced accidentally during a merge. Tt's reduntant, so
remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 089d694..001a9af 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -544,10 +544,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
2.7.4
