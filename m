From: David Thomson <david.thomson@alliedtelesis.co.nz>
Subject: [PATCH] i2c: core: Prevent race condition when removing i2c devices
Date: Thu,  8 Jun 2017 14:43:44 +1200
Message-ID: <20170608024344.9311-1-david.thomson@alliedtelesis.co.nz>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:54021 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbdFHCoT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 7 Jun 2017 22:44:19 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, David Thomson <david.thomson@alliedtelesis.co.nz>

There's a race condition that occurs when deleting & closing multiple
i2c devices, which results in a kernel warning on an incorrect reference
count:

Call Trace:
[c00000007e2cfaf0] [c0000000000b84e4] .module_put+0x24/0xb0 (unreliable)
[c00000007e2cfb70] [c0000000005db830] .i2c_put_adapter+0x30/0x50
[c00000007e2cfbf0] [c0000000005deb74] .i2cdev_release+0x24/0x60
[c00000007e2cfc70] [c00000000014015c] .__fput+0xbc/0x290
[c00000007e2cfd10] [c000000000059b64] .task_work_run+0xf4/0x130
[c00000007e2cfdb0] [c00000000000a0a4] .do_notify_resume+0x74/0x80
[c00000007e2cfe30] [c000000000000acc] .ret_from_except_lite+0x78/0x7c

The race is seen when an i2c adapter is being deleted while
file descriptor on another i2c adapter is being closed. The following
shows two threads executing concurrently (the first number is the thread
id):

4580 i2c_del_mux_adapter adapter i2c-6-mux (chan_id 2)
4580 i2c_del_adapter adapter i2c-6-mux (chan_id 2)
4580 i2cdev_detach_adapter adapter i2c-6-mux (chan_id 2)
2627 i2cdev_release START adapter i2c-6-mux (chan_id 2)
2627 i2c_put_adapter START adapter i2c-6-mux (chan_id 2) owner (null)
2627 i2c_adapter_dev_release adapter i2c-6-mux (chan_id 2)
4580 i2c_del_mux_adapter adapter i2c-6-mux (chan_id 3)
4580 i2c_del_adapter adapter i2c-6-mux (chan_id 3)
4580 i2cdev_detach_adapter adapter i2c-6-mux (chan_id 3)
2627 i2c_put_adapter END adapter i2c-6-mux (chan_id 2) owner c0000000edf66400
2627 i2cdev_release END adapter i2c-6-mux (chan_id 2)
2627 i2cdev_release START adapter i2c-6-mux (chan_id 3)
2627 i2c_put_adapter START adapter i2c-6-mux (chan_id 3) owner (null)
2627 i2c_adapter_dev_release adapter i2c-6-mux (chan_id 3)
2627 i2c_put_adapter END adapter i2c-6-mux (chan_id 3) owner (null)
2627 i2cdev_release END adapter i2c-6-mux (chan_id 3)

When thread 4580 for chan_id 3 interrupts 2627 doing
i2c_adapter_dev_release, the 'owner' field for chan_id 2 becomes
non-null. This causes the code to attempt to decrement the reference for
this owner, but the current reference count is invalid. I'm not sure how
the owner is getting set, but adding a lock around the
put_device/module_put calls resolves the issue.

Signed-off-by: David Thomson <david.thomson@alliedtelesis.co.nz>
---
 drivers/i2c/i2c-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 82576aaccc90..8831d9b363a7 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -3151,8 +3151,12 @@ void i2c_put_adapter(struct i2c_adapter *adap)
 	if (!adap)
 		return;
 
+	mutex_lock(&core_lock);
+
 	put_device(&adap->dev);
 	module_put(adap->owner);
+
+	mutex_unlock(&core_lock);
 }
 EXPORT_SYMBOL(i2c_put_adapter);
 
-- 
2.13.0
