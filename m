From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 2/2] i2c: brcmstb: Remove superfluous size check
Date: Fri, 15 Jul 2016 12:45:09 +0900
Message-ID: <20160715034509.58148-3-jaedon.shin@gmail.com>
References: <20160715034509.58148-1-jaedon.shin@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36619 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075AbcGODqB (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Jul 2016 23:46:01 -0400
Received: by mail-pf0-f194.google.com with SMTP id y134so1459836pfg.3
        for <linux-i2c@vger.kernel.org>; Thu, 14 Jul 2016 20:46:01 -0700 (PDT)
In-Reply-To: <20160715034509.58148-1-jaedon.shin@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Kamal Dasu <kdasu.kdev@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

The driver transfer to a message with NOACK always in any size.
If client (eg. EDID segment point message) needs NOACK condition, it can
use I2C_M_IGNORE_NAK flag.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/i2c/busses/i2c-brcmstb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 6a8cfc1344b2..3f5a4d71d3bf 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -343,10 +343,9 @@ static int brcmstb_i2c_xfer_bsc_data(struct brcmstb_i2c_dev *dev,
 	struct bsc_regs *pi2creg = dev->bsc_regmap;
 	int no_ack = pmsg->flags & I2C_M_IGNORE_NAK;
 	int data_regsz = brcmstb_i2c_get_data_regsz(dev);
-	int xfersz = brcmstb_i2c_get_xfersz(dev);
 
 	/* see if the transaction needs to check NACK conditions */
-	if (no_ack || len <= xfersz) {
+	if (no_ack) {
 		cmd = (pmsg->flags & I2C_M_RD) ? CMD_RD_NOACK
 			: CMD_WR_NOACK;
 		pi2creg->ctlhi_reg |= BSC_CTLHI_REG_IGNORE_ACK_MASK;
-- 
2.9.0
