From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 8/9] eeprom: at24: remove a reduntant if
Date: Tue, 27 Oct 2015 12:43:52 +0100
Message-ID: <1445946233-6071-9-git-send-email-bgolaszewski@baylibre.com>
References: <1445946233-6071-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445946233-6071-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

It seems as if the second check for I2C_FUNC_I2C functionality had been
introduced accidentally during a merge. Tt's reduntant, so remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 387d134..65f1479 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -619,10 +619,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
