From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] power/ds2782: fix clientdata on removal
Date: Thu,  1 Apr 2010 12:27:44 +0200
Message-ID: <1270117664-29099-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Probably due to a copy & paste bug, clientdata was set again to the data
structure (which is freed immediately afterwards) when it should be
NULLed. Just remove the calls as the i2c-core does this automatically
now.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
Cc: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Cc: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---

Anton: If it is okay with you, I think this should go via the I2C-tree to
ensure it comes after the needed modification of the i2c-core.

 drivers/power/ds2782_battery.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/power/ds2782_battery.c b/drivers/power/ds2782_battery.c
index da14f37..305d463 100644
--- a/drivers/power/ds2782_battery.c
+++ b/drivers/power/ds2782_battery.c
@@ -236,8 +236,6 @@ static int ds2782_battery_remove(struct i2c_client *client)
 	idr_remove(&battery_id, info->id);
 	mutex_unlock(&battery_lock);
 
-	i2c_set_clientdata(client, info);
-
 	kfree(info);
 	return 0;
 }
@@ -289,7 +287,6 @@ static int ds2782_battery_probe(struct i2c_client *client,
 fail_register:
 	kfree(info->battery.name);
 fail_name:
-	i2c_set_clientdata(client, info);
 	kfree(info);
 fail_info:
 	mutex_lock(&battery_lock);
-- 
1.7.0
