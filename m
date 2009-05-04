From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Do not give adapters a default parent
Date: Mon, 4 May 2009 12:43:41 +0200
Message-ID: <20090504124341.42405e79@hyperion.delvare>
References: <20090426103025.4525edd3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090426103025.4525edd3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We don't need to give adapters a parent if they don't have one. The
driver core will put them in the virtual device directory and all will
be fine.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
Much better than my first attempt. Not sure what will happen if we ever
turn i2c-adapters into bus devices. I see that the driver core puts
class devices without a parent in virtual, but what about _bus_ devices
without a parent? Kay?

 drivers/i2c/i2c-core.c |   11 -----------
 1 file changed, 11 deletions(-)

--- linux-2.6.30-rc4.orig/drivers/i2c/i2c-core.c	2009-05-03 09:08:51.000000000 +0200
+++ linux-2.6.30-rc4/drivers/i2c/i2c-core.c	2009-05-04 11:19:59.000000000 +0200
@@ -29,7 +29,6 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/idr.h>
-#include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/completion.h>
 #include <linux/hardirq.h>
@@ -451,16 +450,6 @@ static int i2c_register_adapter(struct i
 
 	mutex_lock(&core_lock);
 
-	/* Add the adapter to the driver core.
-	 * If the parent pointer is not set up,
-	 * we add this adapter to the host bus.
-	 */
-	if (adap->dev.parent == NULL) {
-		adap->dev.parent = &platform_bus;
-		pr_debug("I2C adapter driver [%s] forgot to specify "
-			 "physical device\n", adap->name);
-	}
-
 	/* Set default timeout to 1 second if not already set */
 	if (adap->timeout == 0)
 		adap->timeout = HZ;

-- 
Jean Delvare
