From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 05/18] i2c: i2c-bcm-kona: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:44:48 +0200
Message-ID: <1459709101-24462-6-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51900 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752379AbcDCSpQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:16 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-bcm-kona.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
index 2c9d9b1c8e6441..ac9f47679c3a4b 100644
--- a/drivers/i2c/busses/i2c-bcm-kona.c
+++ b/drivers/i2c/busses/i2c-bcm-kona.c
@@ -501,10 +501,7 @@ static int bcm_kona_i2c_do_addr(struct bcm_kona_i2c_dev *dev,
 				return -EREMOTEIO;
 		}
 	} else {
-		addr = msg->addr << 1;
-
-		if (msg->flags & I2C_M_RD)
-			addr |= 1;
+		addr = i2c_8bit_addr_from_msg(msg);
 
 		if (bcm_kona_i2c_write_byte(dev, addr, 0) < 0)
 			return -EREMOTEIO;
-- 
2.7.0
