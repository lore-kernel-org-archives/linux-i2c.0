From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 07/18] i2c: i2c-cpm: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:44:50 +0200
Message-ID: <1459709101-24462-8-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51904 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607AbcDCSpU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:20 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-cpm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 714bdc837769fd..b6d2821aaabd5e 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -197,9 +197,7 @@ static void cpm_i2c_parse_message(struct i2c_adapter *adap,
 	tbdf = cpm->tbase + tx;
 	rbdf = cpm->rbase + rx;
 
-	addr = pmsg->addr << 1;
-	if (pmsg->flags & I2C_M_RD)
-		addr |= 1;
+	addr = i2c_8bit_addr_from_msg(pmsg);
 
 	tb = cpm->txbuf[tx];
 	rb = cpm->rxbuf[rx];
-- 
2.7.0
