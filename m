From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] i2c: i2c-core: do not use bus internal data
Date: Mon,  7 Mar 2016 17:19:17 +0530
Message-ID: <1457351357-13457-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36122 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbcCGLt1 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Mar 2016 06:49:27 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, gregkh@linuxfoundation.org

The variable p is a data structure which is used by the driver core
internally and it is not expected that busses will be directly accessing
these driver core internal only data.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

Reference of Greg's comment about it at:
https://lkml.org/lkml/2016/3/5/171

 drivers/i2c/i2c-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 2949ab3..2f31fb5 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -73,6 +73,7 @@ static struct device_type i2c_client_type;
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
 
 static struct static_key i2c_trace_msg = STATIC_KEY_INIT_FALSE;
+static bool is_registered;
 
 void i2c_transfer_trace_reg(void)
 {
@@ -1529,7 +1530,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	int res = 0;
 
 	/* Can't register until after driver model init */
-	if (unlikely(WARN_ON(!i2c_bus_type.p))) {
+	if (unlikely(WARN_ON(!is_registered))) {
 		res = -EAGAIN;
 		goto out_list;
 	}
@@ -1926,7 +1927,7 @@ int i2c_register_driver(struct module *owner, struct i2c_driver *driver)
 	int res;
 
 	/* Can't register until after driver model init */
-	if (unlikely(WARN_ON(!i2c_bus_type.p)))
+	if (unlikely(WARN_ON(!is_registered)))
 		return -EAGAIN;
 
 	/* add the driver to the list of i2c drivers in the driver core */
@@ -2118,6 +2119,7 @@ static int __init i2c_init(void)
 	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
 		WARN_ON(of_reconfig_notifier_register(&i2c_of_notifier));
 
+	is_registered = true;
 	return 0;
 
 class_err:
-- 
1.9.1
