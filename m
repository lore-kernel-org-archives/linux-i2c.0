From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] i2c: i2c-omap: make dev_pm_ops a const struct
Date: Tue, 22 Feb 2011 12:21:27 +0530
Message-ID: <1298357487-10966-2-git-send-email-gadiyar@ti.com>
References: <1298357487-10966-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298357487-10966-1-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

dev_pm_ops is normally a const struct. Update the structure
in this driver accordingly.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
Checkpatch complained about this when I generated the previous patch.
So I thought I might as well fix it up.

 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap-usb/drivers/i2c/busses/i2c-omap.c
===================================================================
--- linux-omap-usb.orig/drivers/i2c/busses/i2c-omap.c
+++ linux-omap-usb/drivers/i2c/busses/i2c-omap.c
@@ -1156,7 +1156,7 @@ static int omap_i2c_resume(struct device
 	return 0;
 }
 
-static struct dev_pm_ops omap_i2c_pm = {
+static const struct dev_pm_ops omap_i2c_pm = {
 	.suspend = omap_i2c_suspend,
 	.resume = omap_i2c_resume,
 };
