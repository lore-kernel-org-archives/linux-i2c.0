From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4/7] i2c: add error message when obtaining idr fails
Date: Sat,  9 Jul 2016 13:35:01 +0900
Message-ID: <1468038904-2571-5-git-send-email-wsa@the-dreams.de>
References: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37717 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653AbcGIEfj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 9 Jul 2016 00:35:39 -0400
In-Reply-To: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

Fix some whitespace issues while here.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 36183eacec105b..a94e7ccb9c3067 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1690,13 +1690,12 @@ out_list:
  */
 static int __i2c_add_numbered_adapter(struct i2c_adapter *adap)
 {
-	int	id;
+	int id;
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1,
-		       GFP_KERNEL);
+	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1, GFP_KERNEL);
 	mutex_unlock(&core_lock);
-	if (id < 0)
+	if (WARN(id < 0, "couldn't get idr"))
 		return id == -ENOSPC ? -EBUSY : id;
 
 	return i2c_register_adapter(adap);
@@ -1733,7 +1732,7 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 	id = idr_alloc(&i2c_adapter_idr, adapter,
 		       __i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
 	mutex_unlock(&core_lock);
-	if (id < 0)
+	if (WARN(id < 0, "couldn't get idr"))
 		return id;
 
 	adapter->nr = id;
-- 
2.8.1
