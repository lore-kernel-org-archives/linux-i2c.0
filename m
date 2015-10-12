From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 8/9] eeprom: at24: remove a reduntant if
Date: Mon, 12 Oct 2015 16:31:20 +0200
Message-ID: <1444660281-19150-9-git-send-email-bgolaszewski@baylibre.com>
References: <1444660281-19150-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35530 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbbJLOcb (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Oct 2015 10:32:31 -0400
Received: by wicge5 with SMTP id ge5so152910796wic.0
        for <linux-i2c@vger.kernel.org>; Mon, 12 Oct 2015 07:32:30 -0700 (PDT)
In-Reply-To: <1444660281-19150-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

It seems as if the second check for I2C_FUNC_I2C functionality had been
introduced accidentally during a merge. Tt's reduntant, so remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index b5181a3..52875f4 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -613,10 +613,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
