From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 06/18] i2c: i2c-brcmstb: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:44:49 +0200
Message-ID: <1459709101-24462-7-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51903 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607AbcDCSpS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:18 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-brcmstb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 4a45408dd82060..6a8cfc1344b2ed 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -446,9 +446,7 @@ static int brcmstb_i2c_do_addr(struct brcmstb_i2c_dev *dev,
 
 		}
 	} else {
-		addr = msg->addr << 1;
-		if (msg->flags & I2C_M_RD)
-			addr |= 1;
+		addr = i2c_8bit_addr_from_msg(msg);
 
 		bsc_writel(dev, addr, chip_address);
 	}
-- 
2.7.0
