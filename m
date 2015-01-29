From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: clarify comments about the dev_released completion
Date: Thu, 29 Jan 2015 22:45:09 +0100
Message-ID: <1422567909-13399-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There was quite some confusion why this completion is there and if it is
still necessary. Sadly, it is. However, let's improve the comments and
share what we rediscovered.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 39d25a8cb1ad..7a9368750b9a 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1796,11 +1796,15 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 	/* device name is gone after device_unregister */
 	dev_dbg(&adap->dev, "adapter [%s] unregistered\n", adap->name);
 
-	/* clean up the sysfs representation */
+	/* wait until all references to the device are gone
+	 *
+	 * FIXME: This is old code and should ideally be replaced by an
+	 * alternative which results in decoupling the lifetime of the struct
+	 * device from the i2c_adapter, like spi or netdev do. Any solution
+	 * should be throughly tested with DEBUG_KOBJECT_RELEASE enabled!
+	 */
 	init_completion(&adap->dev_released);
 	device_unregister(&adap->dev);
-
-	/* wait for sysfs to drop all references */
 	wait_for_completion(&adap->dev_released);
 
 	/* free bus id */
-- 
2.1.4
