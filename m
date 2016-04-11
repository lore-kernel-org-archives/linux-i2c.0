From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 01/13] eeprom: at24: remove a reduntant if
Date: Mon, 11 Apr 2016 11:57:17 -0700
Message-ID: <1460401049-25459-2-git-send-email-bgolaszewski@baylibre.com>
References: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33103 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbcDKS5t (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Apr 2016 14:57:49 -0400
Received: by mail-pa0-f52.google.com with SMTP id zm5so126675570pac.0
        for <linux-i2c@vger.kernel.org>; Mon, 11 Apr 2016 11:57:49 -0700 (PDT)
In-Reply-To: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com
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
