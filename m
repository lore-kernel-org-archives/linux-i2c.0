From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] i2c: brcmstb: Fix START and STOP conditions
Date: Fri, 12 Aug 2016 14:56:27 +0900
Message-ID: <20160812055627.34668-1-jaedon.shin@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35269 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbcHLF5V (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 12 Aug 2016 01:57:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id h186so955132pfg.2
        for <linux-i2c@vger.kernel.org>; Thu, 11 Aug 2016 22:56:42 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Kamal Dasu <kdasu.kdev@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

Fixes always repeated START when process multiple bytes with a message
in combined transactions.

The BSC has multiple data stroage that send or receive data at once, and
it has the RESTART, NOSTART, NOSTOP to the condition flags. The problem
is that begin repeated START for all the messages in combined
transaction. If length of a data is over 32bytes, The BSC transmit
repeated START in every 32bytes.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/i2c/busses/i2c-brcmstb.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 3f5a4d71d3bf..51c5f0bd361d 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -465,6 +465,7 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
 	u8 *tmp_buf;
 	int len = 0;
 	int xfersz = brcmstb_i2c_get_xfersz(dev);
+	u32 cond, cond_per_msg;
 
 	if (dev->is_suspended)
 		return -EBUSY;
@@ -481,10 +482,11 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
 			pmsg->buf ? pmsg->buf[0] : '0', pmsg->len);
 
 		if (i < (num - 1) && (msgs[i + 1].flags & I2C_M_NOSTART))
-			brcmstb_set_i2c_start_stop(dev, ~(COND_START_STOP));
+			cond = ~COND_START_STOP;
 		else
-			brcmstb_set_i2c_start_stop(dev,
-						   COND_RESTART | COND_NOSTOP);
+			cond = COND_RESTART | COND_NOSTOP;
+
+		brcmstb_set_i2c_start_stop(dev, cond);
 
 		/* Send slave address */
 		if (!(pmsg->flags & I2C_M_NOSTART)) {
@@ -497,13 +499,24 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
 			}
 		}
 
+		cond_per_msg = cond;
+
 		/* Perform data transfer */
 		while (len) {
 			bytes_to_xfer = min(len, xfersz);
 
-			if (len <= xfersz && i == (num - 1))
-				brcmstb_set_i2c_start_stop(dev,
-							   ~(COND_START_STOP));
+			if (len <= xfersz) {
+				if (i == (num - 1))
+					cond_per_msg = cond_per_msg &
+						~(COND_RESTART | COND_NOSTOP);
+				else
+					cond_per_msg = cond;
+			} else {
+				cond_per_msg = (cond_per_msg & ~COND_RESTART) |
+					COND_NOSTOP;
+			}
+
+			brcmstb_set_i2c_start_stop(dev, cond_per_msg);
 
 			rc = brcmstb_i2c_xfer_bsc_data(dev, tmp_buf,
 						       bytes_to_xfer, pmsg);
@@ -512,6 +525,8 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
 
 			len -=  bytes_to_xfer;
 			tmp_buf += bytes_to_xfer;
+
+			cond_per_msg = COND_NOSTART | COND_NOSTOP;
 		}
 	}
 
-- 
2.9.2
