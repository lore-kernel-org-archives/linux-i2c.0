From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5/5] i2c: of: simplify reading the "reg" property
Date: Thu, 18 Jan 2018 13:11:33 +0100
Message-ID: <20180118121133.13554-6-wsa@the-dreams.de>
References: <20180118121133.13554-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56584 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbeARMLn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 Jan 2018 07:11:43 -0500
In-Reply-To: <20180118121133.13554-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Lixin Wang <alan.1.wang@nokia-sbell.com>, Wolfram Sang <wsa@the-dreams.de>

of_get_property() is a bit cumbersome to use. Replace it with the newer
of_property_read_u32() for more readable code.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core-of.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index bbfff3f61b1fdb..c405270a98b4f0 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2008 Jochen Friedrich <jochen@scram.de>
  * based on a previous patch from Jon Smirl <jonsmirl@gmail.com>
  *
- * Copyright (C) 2013 Wolfram Sang <wsa@the-dreams.de>
+ * Copyright (C) 2013, 2018 Wolfram Sang <wsa@the-dreams.de>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
@@ -28,9 +28,8 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 	struct i2c_client *client;
 	struct i2c_board_info info = {};
 	struct dev_archdata dev_ad = {};
-	const __be32 *addr_be;
 	u32 addr;
-	int len;
+	int ret;
 
 	dev_dbg(&adap->dev, "of_i2c: register %pOF\n", node);
 
@@ -40,13 +39,12 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 		return ERR_PTR(-EINVAL);
 	}
 
-	addr_be = of_get_property(node, "reg", &len);
-	if (!addr_be || (len < sizeof(*addr_be))) {
+	ret = of_property_read_u32(node, "reg", &addr);
+	if (ret) {
 		dev_err(&adap->dev, "of_i2c: invalid reg on %pOF\n", node);
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(ret);
 	}
 
-	addr = be32_to_cpup(addr_be);
 	if (addr & I2C_TEN_BIT_ADDRESS) {
 		addr &= ~I2C_TEN_BIT_ADDRESS;
 		info.flags |= I2C_CLIENT_TEN;
-- 
2.11.0
