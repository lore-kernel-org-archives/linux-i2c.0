From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Let new-style drivers implement attach_adapter
Date: Fri, 10 Apr 2009 15:51:03 +0200
Message-ID: <20090410155103.3cbdaf1e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

While it isn't the way the standard device binding model works, it is
OK for new-style drivers to implement attach_adapter. It may help
convert the renaming legacy drivers to new style drivers faster.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
Johannes, you'll need to apply this patch before you can test the
onyx/tas conversion patch I sent to you yesterday.

 drivers/i2c/i2c-core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.30-rc1.orig/drivers/i2c/i2c-core.c	2009-04-10 15:22:22.000000000 +0200
+++ linux-2.6.30-rc1/drivers/i2c/i2c-core.c	2009-04-10 15:31:19.000000000 +0200
@@ -716,8 +716,7 @@ int i2c_register_driver(struct module *o
 
 	/* new style driver methods can't mix with legacy ones */
 	if (is_newstyle_driver(driver)) {
-		if (driver->attach_adapter || driver->detach_adapter
-				|| driver->detach_client) {
+		if (driver->detach_adapter || driver->detach_client) {
 			printk(KERN_WARNING
 					"i2c-core: driver [%s] is confused\n",
 					driver->driver.name);


-- 
Jean Delvare
