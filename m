From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 4/9] i2c: brcmstb: enable ACK condition
Date: Wed, 21 Oct 2015 11:36:56 +0900
Message-ID: <1445395021-4204-5-git-send-email-jaedon.shin@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33301 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbbJUCiD (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 20 Oct 2015 22:38:03 -0400
In-Reply-To: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Kamal Dasu <kdasu.kdev@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org, Jaedon Shin <jaedon.shin@gmail.com>

Removes the condition of a message with under 32 bytes in length. The
messages that do not require an ACK are I2C_M_IGNORE_NAK flag.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/i2c/busses/i2c-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 2d7d155029dc..53eb8b0c9bad 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -330,7 +330,7 @@ static int brcmstb_i2c_xfer_bsc_data(struct brcmstb_i2c_dev *dev,
 	int no_ack = pmsg->flags & I2C_M_IGNORE_NAK;
 
 	/* see if the transaction needs to check NACK conditions */
-	if (no_ack || len <= N_DATA_BYTES) {
+	if (no_ack) {
 		cmd = (pmsg->flags & I2C_M_RD) ? CMD_RD_NOACK
 			: CMD_WR_NOACK;
 		pi2creg->ctlhi_reg |= BSC_CTLHI_REG_IGNORE_ACK_MASK;
-- 
2.6.1
