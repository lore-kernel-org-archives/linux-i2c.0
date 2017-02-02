From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH] i2c: piix4: Request the SMBUS semaphore inside the mutex
Date: Thu,  2 Feb 2017 20:15:16 +0100
Message-ID: <20170202191516.4476-1-ricardo.ribalda@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35222 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdBBTPX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 2 Feb 2017 14:15:23 -0500
Received: by mail-yw0-f194.google.com with SMTP id l16so2832106ywb.2
        for <linux-i2c@vger.kernel.org>; Thu, 02 Feb 2017 11:15:23 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

SMBSLVCNT must be protected with the piix4_mutex_sb800 in order to avoid
multiple buses accessing to the semaphore at the same time.

Reported-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 73cc6799cc59..c21ca7bf2efe 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -592,6 +592,8 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	u8 port;
 	int retval;
 
+	mutex_lock(&piix4_mutex_sb800);
+
 	/* Request the SMBUS semaphore, avoid conflicts with the IMC */
 	smbslvcnt  = inb_p(SMBSLVCNT);
 	do {
@@ -605,10 +607,10 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 		usleep_range(1000, 2000);
 	} while (--retries);
 	/* SMBus is still owned by the IMC, we give up */
-	if (!retries)
+	if (!retries) {
+		mutex_unlock(&piix4_mutex_sb800);
 		return -EBUSY;
-
-	mutex_lock(&piix4_mutex_sb800);
+	}
 
 	outb_p(piix4_port_sel_sb800, SB800_PIIX4_SMB_IDX);
 	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
@@ -623,11 +625,11 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 
 	outb_p(smba_en_lo, SB800_PIIX4_SMB_IDX + 1);
 
-	mutex_unlock(&piix4_mutex_sb800);
-
 	/* Release the semaphore */
 	outb_p(smbslvcnt | 0x20, SMBSLVCNT);
 
+	mutex_unlock(&piix4_mutex_sb800);
+
 	return retval;
 }
 
-- 
2.11.0
