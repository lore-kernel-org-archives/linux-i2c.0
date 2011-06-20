From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] OMAP: I2C: Making dev_pm_ops constant
Date: Mon, 20 Jun 2011 16:04:25 +0530
Message-ID: <1308566065-31061-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The dev_pm_ops is not modified runtime so making it
const.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index abd9a8e..60dc148 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1168,7 +1168,7 @@ static int omap_i2c_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops omap_i2c_pm_ops = {
+static const struct dev_pm_ops omap_i2c_pm_ops = {
 	.suspend = omap_i2c_suspend,
 	.resume = omap_i2c_resume,
 };
-- 
1.7.1
