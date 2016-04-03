From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 04/18] i2c: i2c-bcm-iproc: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:44:47 +0200
Message-ID: <1459709101-24462-5-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51896 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbcDCSpQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:16 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index b9f0fff4e723a0..19c843828fe2ca 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -267,7 +267,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	iproc_i2c->msg = msg;
 
 	/* format and load slave address into the TX FIFO */
-	addr = msg->addr << 1 | (msg->flags & I2C_M_RD ? 1 : 0);
+	addr = i2c_8bit_addr_from_msg(msg);
 	writel(addr, iproc_i2c->base + M_TX_OFFSET);
 
 	/*
-- 
2.7.0
