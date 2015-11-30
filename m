From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: piix4: remove unneeded assignments
Date: Mon, 30 Nov 2015 14:43:09 +0100
Message-ID: <1448890989-32733-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60949 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbbK3NnO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 08:43:14 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Christian Fetzer <fetzer.ch@gmail.com>, Wolfram Sang <wsa@the-dreams.de>

smatch rightfully says:
drivers/i2c/busses/i2c-piix4.c:504 piix4_access warn: unused return: i = inb_p()
drivers/i2c/busses/i2c-piix4.c:537 piix4_access warn: unused return: i = inb_p()

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Christian, can you please check on HW? I could only compile-test.

 drivers/i2c/busses/i2c-piix4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index af4e606f8886bd..e045985950737c 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -501,7 +501,7 @@ static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
 			if (len == 0 || len > I2C_SMBUS_BLOCK_MAX)
 				return -EINVAL;
 			outb_p(len, SMBHSTDAT0);
-			i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
+			inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
 			for (i = 1; i <= len; i++)
 				outb_p(data->block[i], SMBBLKDAT);
 		}
@@ -534,7 +534,7 @@ static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
 		data->block[0] = inb_p(SMBHSTDAT0);
 		if (data->block[0] == 0 || data->block[0] > I2C_SMBUS_BLOCK_MAX)
 			return -EPROTO;
-		i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
+		inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
 		for (i = 1; i <= data->block[0]; i++)
 			data->block[i] = inb_p(SMBBLKDAT);
 		break;
-- 
2.1.4
