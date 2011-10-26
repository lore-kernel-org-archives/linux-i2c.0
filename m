From: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] rtc-isl1208: Add support for the ISL1218
Date: Tue, 25 Oct 2011 21:30:06 -0500
Message-ID: <1319596206-23266-1-git-send-email-gardner.ben@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The ISL1218 chip is identical to the ISL1208, except that it has 6
additional user-storage registers. This patch does not enable access 
to those additional registers, but only adds the chip name to the list.

Signed-off-by: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/rtc/rtc-isl1208.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index da8beb8..ea10736 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -697,6 +697,7 @@ isl1208_remove(struct i2c_client *client)
 
 static const struct i2c_device_id isl1208_id[] = {
 	{ "isl1208", 0 },
+	{ "isl1218", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, isl1208_id);
-- 
1.7.7
