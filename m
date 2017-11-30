From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 5/7] eeprom: at24: zero-initialize variable chip in probe
Date: Thu, 30 Nov 2017 07:49:08 +0100
Message-ID: <0f7340b5-9766-debe-37b5-04b38e5344de@gmail.com>
References: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:41287 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbdK3GtX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Nov 2017 01:49:23 -0500
Received: by mail-wm0-f65.google.com with SMTP id g75so10958693wme.0
        for <linux-i2c@vger.kernel.org>; Wed, 29 Nov 2017 22:49:23 -0800 (PST)
In-Reply-To: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Zero-initialize variable chip to be on the safe side. This also
allows ro remove some explicit NULL initializations.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/at24.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 837f1d88c..8fef6d5a8 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -496,7 +496,7 @@ static const struct regmap_config regmap_config_16 = {
 
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
-	struct at24_platform_data chip;
+	struct at24_platform_data chip = {};
 	kernel_ulong_t magic = 0;
 	bool writable;
 	struct at24_data *at24;
@@ -533,9 +533,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		chip.flags = magic & AT24_BITMASK(AT24_SIZE_FLAGS);
 
 		at24_get_pdata(dev, &chip);
-
-		chip.setup = NULL;
-		chip.context = NULL;
 	}
 
 	/* both flags imply read-only */
-- 
2.15.0
