From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4/5] i2c: of: remove duplicated check for valid address
Date: Thu, 18 Jan 2018 13:11:32 +0100
Message-ID: <20180118121133.13554-5-wsa@the-dreams.de>
References: <20180118121133.13554-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56581 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754629AbeARMLm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 Jan 2018 07:11:42 -0500
In-Reply-To: <20180118121133.13554-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Lixin Wang <alan.1.wang@nokia-sbell.com>, Wolfram Sang <wsa@the-dreams.de>

The very same check is done when calling i2c_new_device(). Remove it
here to avoid code duplication.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core-of.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 4b573ee4a8203a..bbfff3f61b1fdb 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -57,12 +57,6 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 		info.flags |= I2C_CLIENT_SLAVE;
 	}
 
-	if (i2c_check_addr_validity(addr, info.flags)) {
-		dev_err(&adap->dev, "of_i2c: invalid addr=%x on %pOF\n",
-			addr, node);
-		return ERR_PTR(-EINVAL);
-	}
-
 	info.addr = addr;
 	info.archdata = &dev_ad;
 	info.of_node = of_node_get(node);
-- 
2.11.0
