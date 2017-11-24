From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] eeprom: at24: fix reading from 24MAC402/24MAC602
Date: Fri, 24 Nov 2017 07:42:31 +0100
Message-ID: <4f62e18a-fc2d-f24f-f549-46b97f882cfc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:44258 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbdKXGmr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 24 Nov 2017 01:42:47 -0500
Received: by mail-wm0-f66.google.com with SMTP id r68so20495102wmr.3
        for <linux-i2c@vger.kernel.org>; Thu, 23 Nov 2017 22:42:47 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Chip datasheet mentions that word addresses other than the actual
start position of the MAC delivers undefined results. So fix this.

Fixes: 0b813658c115 "eeprom: at24: add support for at24mac series"
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/at24.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index e0b4b36ef..00d602be7 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -425,7 +425,8 @@ static ssize_t at24_eeprom_read_mac(struct at24_data *at24, char *buf,
 	memset(msg, 0, sizeof(msg));
 	msg[0].addr = client->addr;
 	msg[0].buf = addrbuf;
-	addrbuf[0] = 0x90 + offset;
+	/* EUI-48 starts from 0x9a, EUI-64 from 0x98 */
+	addrbuf[0] = 0xa0 - at24->chip.byte_len + offset;
 	msg[0].len = 1;
 	msg[1].addr = client->addr;
 	msg[1].flags = I2C_M_RD;
-- 
2.15.0
