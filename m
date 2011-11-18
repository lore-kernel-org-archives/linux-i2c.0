From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] I2C: Make i2cdev_detach_adapter static
Date: Fri, 18 Nov 2011 14:12:11 +0530
Message-ID: <1321605731-3098-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The function i2cdev_detach_adapter is used only in i2c-dev file
making it static.
Also removes the following sparse warning

drivers/i2c/i2c-dev.c:582:5: warning: symbol 'i2cdev_notifier_call'
was not declared. Should it be static?

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/i2c-dev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index c90ce50..57a45ce 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -579,7 +579,7 @@ static int i2cdev_detach_adapter(struct device *dev, void *dummy)
 	return 0;
 }
 
-int i2cdev_notifier_call(struct notifier_block *nb, unsigned long action,
+static int i2cdev_notifier_call(struct notifier_block *nb, unsigned long action,
 			 void *data)
 {
 	struct device *dev = data;
-- 
1.7.1
