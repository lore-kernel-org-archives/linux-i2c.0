From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 14/18] i2c: i2c-powermac: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:44:57 +0200
Message-ID: <1459709101-24462-15-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51936 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbcDCSpa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:30 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-powermac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 6abcf696e3594b..b0d9dee14a7e0b 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -150,13 +150,11 @@ static int i2c_powermac_master_xfer(	struct i2c_adapter *adap,
 {
 	struct pmac_i2c_bus	*bus = i2c_get_adapdata(adap);
 	int			rc = 0;
-	int			read;
 	int			addrdir;
 
 	if (msgs->flags & I2C_M_TEN)
 		return -EINVAL;
-	read = (msgs->flags & I2C_M_RD) != 0;
-	addrdir = (msgs->addr << 1) | read;
+	addrdir = i2c_8bit_addr_from_msg(msgs);
 
 	rc = pmac_i2c_open(bus, 0);
 	if (rc) {
-- 
2.7.0
