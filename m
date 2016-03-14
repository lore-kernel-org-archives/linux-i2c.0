From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: immediately mark ourselves as registered
Date: Mon, 14 Mar 2016 10:53:26 +0100
Message-ID: <1457949206-7226-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35714 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933966AbcCNJxj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 14 Mar 2016 05:53:39 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Thierry Reding <thierry.reding@gmail.com>

Mark the i2c bus as registered right after the the bus_register call,
not at the end of init. Otherwise, we can't register our own dummy
driver.

Reported-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Fixes: 95026658c46ea2 ("i2c: do not use internal data from driver core")
---
 drivers/i2c/i2c-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index f4726cdbb06a1e..f267b238c6730c 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2105,6 +2105,9 @@ static int __init i2c_init(void)
 	retval = bus_register(&i2c_bus_type);
 	if (retval)
 		return retval;
+
+	is_registered = true;
+
 #ifdef CONFIG_I2C_COMPAT
 	i2c_adapter_compat_class = class_compat_register("i2c-adapter");
 	if (!i2c_adapter_compat_class) {
@@ -2119,7 +2122,6 @@ static int __init i2c_init(void)
 	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
 		WARN_ON(of_reconfig_notifier_register(&i2c_of_notifier));
 
-	is_registered = true;
 	return 0;
 
 class_err:
-- 
2.7.0
