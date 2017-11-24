From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] eeprom: at24: check at24_read/write arguments
Date: Fri, 24 Nov 2017 07:47:50 +0100
Message-ID: <a519bea7-9c68-caf1-7b1a-100c2562a2d7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34459 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbdKXGr5 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 24 Nov 2017 01:47:57 -0500
Received: by mail-wm0-f65.google.com with SMTP id y82so19258486wmg.1
        for <linux-i2c@vger.kernel.org>; Thu, 23 Nov 2017 22:47:56 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

So far we completely rely on the caller to provide valid arguments.
To be on the safe side perform an own sanity check.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/at24.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 00d602be7..52cbaeb6f 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -569,6 +569,9 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	if (unlikely(!count))
 		return count;
 
+	if (off + count > at24->chip.byte_len)
+		return -EINVAL;
+
 	client = at24_translate_offset(at24, &off);
 
 	ret = pm_runtime_get_sync(&client->dev);
@@ -614,6 +617,9 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	if (unlikely(!count))
 		return -EINVAL;
 
+	if (off + count > at24->chip.byte_len)
+		return -EINVAL;
+
 	client = at24_translate_offset(at24, &off);
 
 	ret = pm_runtime_get_sync(&client->dev);
-- 
2.15.0
