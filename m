From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] i2c: core: Add missing of_node_put()
Date: Fri, 15 Apr 2016 13:43:11 +0100
Message-ID: <1460724191-12167-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12396 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbcDOMn3 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 15 Apr 2016 08:43:29 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

for_each_available_child_of_node performs an of_node_get on each
iteration, so of_node_put() must be called on each iteration once
we are finished with the node pointer.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/i2c/i2c-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 4979728f7fb2..38f4dae681a9 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1428,9 +1428,9 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
 	dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");
 
 	for_each_available_child_of_node(adap->dev.of_node, node) {
-		if (of_node_test_and_set_flag(node, OF_POPULATED))
-			continue;
-		of_i2c_register_device(adap, node);
+		if (!of_node_test_and_set_flag(node, OF_POPULATED))
+			of_i2c_register_device(adap, node);
+		of_node_put(node);
 	}
 }
 
-- 
2.1.4
