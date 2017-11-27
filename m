From: Lixin Wang <alan.1.wang@nokia-sbell.com>
Subject: [PATCH] i2c: core: decrease reference count of device node in i2c_unregister_device
Date: Mon, 27 Nov 2017 15:06:55 +0800
Message-ID: <1511766415-3732-1-git-send-email-alan.1.wang@nokia-sbell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr50095.outbound.protection.outlook.com ([40.107.5.95]:55744
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751231AbdK0HIO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Nov 2017 02:08:14 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Lixin Wang <alan.1.wang@nokia-sbell.com>

Reference count of device node was increased in of_i2c_register_device,
but without decreasing it in i2c_unregister_device. Then the dynamically
added device node will never be released.
Fix this by adding the of_node_put.

Signed-off-by: Lixin Wang <alan.1.wang@nokia-sbell.com>
---
 drivers/i2c/i2c-core-base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 56e4658..b76adf9 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -808,8 +808,10 @@ EXPORT_SYMBOL_GPL(i2c_new_device);
  */
 void i2c_unregister_device(struct i2c_client *client)
 {
-	if (client->dev.of_node)
+	if (client->dev.of_node) {
 		of_node_clear_flag(client->dev.of_node, OF_POPULATED);
+		of_node_put(client->dev.of_node);
+	}
 	if (ACPI_COMPANION(&client->dev))
 		acpi_device_clear_enumerated(ACPI_COMPANION(&client->dev));
 	device_unregister(&client->dev);
-- 
2.6.2
