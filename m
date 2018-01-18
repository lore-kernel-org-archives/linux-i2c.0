From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/5] i2c: of: change log level of failed device creation
Date: Thu, 18 Jan 2018 13:11:29 +0100
Message-ID: <20180118121133.13554-2-wsa@the-dreams.de>
References: <20180118121133.13554-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56572 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbeARMLl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 Jan 2018 07:11:41 -0500
In-Reply-To: <20180118121133.13554-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Lixin Wang <alan.1.wang@nokia-sbell.com>, Wolfram Sang <wsa@the-dreams.de>

If we cannot create a device, this is an error, not a warning. Fix the
log level.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 8d474bb1dc1575..b652579ed04e66 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -103,7 +103,7 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
 
 		client = of_i2c_register_device(adap, node);
 		if (IS_ERR(client)) {
-			dev_warn(&adap->dev,
+			dev_err(&adap->dev,
 				 "Failed to create I2C device for %pOF\n",
 				 node);
 			of_node_clear_flag(node, OF_POPULATED);
-- 
2.11.0
