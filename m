From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Subject: [PATCH 1/3] i2c: put driver_unregister() out of core_lock protection.
Date: Wed, 28 Jan 2009 22:14:33 +0100
Message-ID: <1233177275-21700-2-git-send-email-giometti@linux.it>
References: <1233177275-21700-1-git-send-email-giometti@linux.it>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1233177275-21700-1-git-send-email-giometti-k2GhghHVRtY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index b1c9abe..3454878 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -799,10 +799,10 @@ void i2c_del_driver(struct i2c_driver *driver)
 	class_for_each_device(&i2c_adapter_class, NULL, driver,
 			      __detach_adapter);
 
+	mutex_unlock(&core_lock);
+
 	driver_unregister(&driver->driver);
 	pr_debug("i2c-core: driver [%s] unregistered\n", driver->driver.name);
-
-	mutex_unlock(&core_lock);
 }
 EXPORT_SYMBOL(i2c_del_driver);
 
-- 
1.5.6.3
