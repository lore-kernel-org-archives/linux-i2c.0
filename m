From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 14/14] eeprom: at24: add at24mac chips to the list of supported devices
Date: Sun, 29 May 2016 23:53:52 +0200
Message-ID: <1464558832-2262-15-git-send-email-bgolaszewski@baylibre.com>
References: <1464558832-2262-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464558832-2262-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

Now with the infrastructure for reading the factory-programmed mac
address in place, add the two available chips from the at24mac
family: at24mac402 and at24mac602 to the device ID list.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index b3afe15..0b8fafdb 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -139,6 +139,10 @@ static const struct i2c_device_id at24_ids[] = {
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
