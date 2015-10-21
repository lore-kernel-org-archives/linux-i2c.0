From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 3/9] i2c: brcmstb: add missing parenthesis
Date: Wed, 21 Oct 2015 11:36:55 +0900
Message-ID: <1445395021-4204-4-git-send-email-jaedon.shin@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33243 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbbJUCh7 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 20 Oct 2015 22:37:59 -0400
In-Reply-To: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Kamal Dasu <kdasu.kdev@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org, Jaedon Shin <jaedon.shin@gmail.com>

Add the necessary parenthesis for NOACK condition.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/i2c/busses/i2c-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 6b8bbf99880d..2d7d155029dc 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -305,7 +305,7 @@ static int brcmstb_send_i2c_cmd(struct brcmstb_i2c_dev *dev,
 	}
 
 	if ((CMD_RD || CMD_WR) &&
-	    bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK) {
+	    (bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK)) {
 		rc = -EREMOTEIO;
 		dev_dbg(dev->device, "controller received NOACK intr for %s\n",
 			cmd_string[cmd]);
-- 
2.6.1
