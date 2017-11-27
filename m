From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] eeprom: at24: fix reading from 24MAC402/24MAC602
Date: Mon, 27 Nov 2017 20:46:22 +0100
Message-ID: <32cfbfe3-fdff-5165-2753-186cbe2055a4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38822 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753246AbdK0Tq1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Nov 2017 14:46:27 -0500
Received: by mail-wr0-f195.google.com with SMTP id z75so26237348wrc.5
        for <linux-i2c@vger.kernel.org>; Mon, 27 Nov 2017 11:46:27 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Chip datasheet mentions that word addresses other than the actual
start position of the MAC delivers undefined results. So fix this.
Current implementation doesn't work due to this wrong offset.

Fixes: 0b813658c115 "eeprom: at24: add support for at24mac series"
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- extended commit message
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
