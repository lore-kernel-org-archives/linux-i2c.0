From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] i2c: remove CONFIG_HOTPLUG ifdefs
Date: Thu, 28 Mar 2013 10:25:50 +0800
Message-ID: <1364437550-12200-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, jiang.liu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option, cleanup CONFIG_HOTPLUG
ifdefs in i2c files.

Signed-off-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 991d38d..d1db97e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -91,7 +91,6 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-#ifdef	CONFIG_HOTPLUG
 
 /* uevent helps with hotplug: modprobe -q $(MODALIAS) */
 static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
@@ -105,10 +104,6 @@ static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-#else
-#define i2c_device_uevent	NULL
-#endif	/* CONFIG_HOTPLUG */
-
 static int i2c_device_probe(struct device *dev)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
-- 
1.7.1
