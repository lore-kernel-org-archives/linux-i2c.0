From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 6/7] eeprom: at24: don't check chip.byte_len for power of two
Date: Thu, 30 Nov 2017 07:49:10 +0100
Message-ID: <bf82e4d8-66df-0d2e-d6e0-9874dbd763b1@gmail.com>
References: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45771 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbdK3GtY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Nov 2017 01:49:24 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so10814136wme.4
        for <linux-i2c@vger.kernel.org>; Wed, 29 Nov 2017 22:49:24 -0800 (PST)
In-Reply-To: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

When using AT24_FLAG_SERIAL and AT24_FLAG_MAC we expose just parts of
the chip. These parts can have arbitrary size (e.g. a 6 byte MAC),
so remove the check for power of two.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/at24.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 8fef6d5a8..74d2347a1 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -539,8 +539,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (chip.flags & AT24_FLAG_SERIAL || chip.flags & AT24_FLAG_MAC)
 		chip.flags |= AT24_FLAG_READONLY;
 
-	if (!is_power_of_2(chip.byte_len))
-		dev_warn(dev, "byte_len looks suspicious (no power of 2)!\n");
 	if (!chip.page_size) {
 		dev_err(dev, "page_size must not be 0!\n");
 		return -EINVAL;
-- 
2.15.0
