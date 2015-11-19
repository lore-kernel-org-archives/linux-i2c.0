From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/1] i2c: core: replace boolean variable by integer
Date: Thu, 19 Nov 2015 18:11:56 +0200
Message-ID: <1447949516-107966-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:34447 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbbKSQMj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 19 Nov 2015 11:12:39 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is a warning when compiling i2c-core.c
drivers/i2c/i2c-core.c:2561:36: warning: dubious: x | !y

Replace boolean exdpression by a plain bitwise AND since I2C_M_RD is a bit 0
and thus we are on the safe side.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Alexander Sverdlin <aleaxander.sverdlin@nokia.com>
---
Changelog v3:
- add tag
- rephrase commit message
 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 040af5c..873ca1c 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2591,7 +2591,7 @@ static u8 i2c_smbus_pec(u8 crc, u8 *p, size_t count)
 static u8 i2c_smbus_msg_pec(u8 pec, struct i2c_msg *msg)
 {
 	/* The address will be sent first */
-	u8 addr = (msg->addr << 1) | !!(msg->flags & I2C_M_RD);
+	u8 addr = (msg->addr << 1) | (msg->flags & I2C_M_RD);
 	pec = i2c_smbus_pec(pec, &addr, 1);
 
 	/* The data buffer follows */
-- 
2.6.2
