From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 01/15] i2c: Make i2c_unregister_device() NULL-aware
Date: Tue, 31 Oct 2017 16:21:35 +0200
Message-ID: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28036 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751717AbdJaOWX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 10:22:23 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It's a common pattern to be NULL-aware when freeing resources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/i2c-core-base.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 56e46581b84b..6735c9365430 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -808,6 +808,8 @@ EXPORT_SYMBOL_GPL(i2c_new_device);
  */
 void i2c_unregister_device(struct i2c_client *client)
 {
+	if (!client)
+		return;
 	if (client->dev.of_node)
 		of_node_clear_flag(client->dev.of_node, OF_POPULATED);
 	if (ACPI_COMPANION(&client->dev))
@@ -1417,8 +1419,7 @@ static int __unregister_client(struct device *dev, void *dummy)
 static int __unregister_dummy(struct device *dev, void *dummy)
 {
 	struct i2c_client *client = i2c_verify_client(dev);
-	if (client)
-		i2c_unregister_device(client);
+	i2c_unregister_device(client);
 	return 0;
 }
 
-- 
2.14.2
