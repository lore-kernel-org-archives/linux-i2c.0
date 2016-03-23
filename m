From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH] i2c: Prevent endless uevent loop with dev_dbg
Date: Wed, 23 Mar 2016 16:50:47 +0100
Message-ID: <1458748247-9219-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38385 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423AbcCWPvY (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Mar 2016 11:51:24 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

After enabling CONFIG_I2C_DEBUG_CORE my system was broken
(no network, console login not possible). System log was
flooded with the this message:

 ...
[  608.052077] rtc-ds1307 0-0068: uevent
[  608.052500] rtc-ds1307 0-0068: uevent
[  608.052925] rtc-ds1307 0-0068: uevent
 ...

The culprit is the dev_dbg printk in the i2c uevent handler.
If this is activated (for instance by CONFIG_I2C_DEBUG_CORE)
it results in an endless loop with systemd-journald.

This happens if user-space scans the system log and reads the uevent
file to get information about a newly created device, which seems fair
use to me. Unfortunately reading the "uevent" file uses the same
function that runs for creating the uevent for a new device,
generating the next syslog entry.

Ideally user-space would implement a recursion detection and
after reading the same device file for the 1000th time call it a
day, but nevertheless I think we should avoid this problem by
removing the debug print completly or using another print variant.

The same problem seems to be reported here:
https://bugs.freedesktop.org/show_bug.cgi?id=76886

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 0f2f848..84165d9 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -539,7 +539,7 @@ static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (add_uevent_var(env, "MODALIAS=%s%s",
 			   I2C_MODULE_PREFIX, client->name))
 		return -ENOMEM;
-	dev_dbg(dev, "uevent\n");
+	pr_debug("uevent: device: %s\n", dev_name(dev));
 	return 0;
 }
 
-- 
1.9.1
