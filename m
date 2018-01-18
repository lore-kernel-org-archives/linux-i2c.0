From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 3/5] i2c: of: rename variable to meet expectations
Date: Thu, 18 Jan 2018 13:11:31 +0100
Message-ID: <20180118121133.13554-4-wsa@the-dreams.de>
References: <20180118121133.13554-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56578 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbeARMLm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 Jan 2018 07:11:42 -0500
In-Reply-To: <20180118121133.13554-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Lixin Wang <alan.1.wang@nokia-sbell.com>, Wolfram Sang <wsa@the-dreams.de>

'result' is mostly used in the kernel as int for functions returning
errno on failure. Here it is a pointer to the client struct, so let's
call it this way (as the parent function does, too).

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core-of.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 5e2d55b3daacca..4b573ee4a8203a 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -25,7 +25,7 @@
 static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 						 struct device_node *node)
 {
-	struct i2c_client *result;
+	struct i2c_client *client;
 	struct i2c_board_info info = {};
 	struct dev_archdata dev_ad = {};
 	const __be32 *addr_be;
@@ -73,13 +73,13 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 	if (of_get_property(node, "wakeup-source", NULL))
 		info.flags |= I2C_CLIENT_WAKE;
 
-	result = i2c_new_device(adap, &info);
-	if (result == NULL) {
+	client = i2c_new_device(adap, &info);
+	if (!client) {
 		dev_err(&adap->dev, "of_i2c: Failure registering %pOF\n", node);
 		of_node_put(node);
 		return ERR_PTR(-EINVAL);
 	}
-	return result;
+	return client;
 }
 
 void of_i2c_register_devices(struct i2c_adapter *adap)
-- 
2.11.0
