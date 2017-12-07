From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] i2c: piix4: Fix port number check on release
Date: Thu, 7 Dec 2017 12:25:45 +0100
Message-ID: <20171207122545.1b8e17c6@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52365 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752491AbdLGLZs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 7 Dec 2017 06:25:48 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>

The port number shift is still hard-coded to 1 while it now depends
on the hardware.

Thankfully 0 is always 0 no matter how you shift it, so this was a
bug without consequences.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 0fe16195f891 ("i2c: piix4: Fix SMBus port selection for AMD Family 17h chips")
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
Sorry for missing this while reviewing the original patch.

 drivers/i2c/busses/i2c-piix4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-4.14.orig/drivers/i2c/busses/i2c-piix4.c	2017-12-07 11:06:05.198260340 +0100
+++ linux-4.14/drivers/i2c/busses/i2c-piix4.c	2017-12-07 12:18:56.405907856 +0100
@@ -989,7 +989,7 @@ static void piix4_adap_remove(struct i2c
 
 	if (adapdata->smba) {
 		i2c_del_adapter(adap);
-		if (adapdata->port == (0 << 1)) {
+		if (adapdata->port == (0 << piix4_port_shift_sb800)) {
 			release_region(adapdata->smba, SMBIOSIZE);
 			if (adapdata->sb800_main)
 				release_region(SB800_PIIX4_SMB_IDX, 2);


-- 
Jean Delvare
SUSE L3 Support
