From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/5] i2c: of: make ref counting more visible
Date: Thu, 18 Jan 2018 13:11:30 +0100
Message-ID: <20180118121133.13554-3-wsa@the-dreams.de>
References: <20180118121133.13554-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56575 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbeARMLl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 Jan 2018 07:11:41 -0500
In-Reply-To: <20180118121133.13554-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Lixin Wang <alan.1.wang@nokia-sbell.com>, Wolfram Sang <wsa@the-dreams.de>

When debugging a ref counting problem, I overlooked this snipplet a few
times. Might be taste, but I think the new location is visually easier
recognizable.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index b652579ed04e66..5e2d55b3daacca 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -64,8 +64,8 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 	}
 
 	info.addr = addr;
-	info.of_node = of_node_get(node);
 	info.archdata = &dev_ad;
+	info.of_node = of_node_get(node);
 
 	if (of_property_read_bool(node, "host-notify"))
 		info.flags |= I2C_CLIENT_HOST_NOTIFY;
-- 
2.11.0
