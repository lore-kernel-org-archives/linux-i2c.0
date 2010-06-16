From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Drop dummy variable
Date: Wed, 16 Jun 2010 16:41:47 +0200
Message-ID: <20100616164147.43bf4fbe@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Now that bus_for_each_drv() is no longer __must_check, we can drop the
dummy variable that was used to store the returned value.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Justin P. Mattock <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Anticipating that my other patch will be accepted...

 drivers/i2c/i2c-core.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.35-rc3.orig/drivers/i2c/i2c-core.c	2010-06-16 12:44:52.000000000 +0200
+++ linux-2.6.35-rc3/drivers/i2c/i2c-core.c	2010-06-16 12:44:54.000000000 +0200
@@ -783,7 +783,7 @@ static int __process_new_adapter(struct
 
 static int i2c_register_adapter(struct i2c_adapter *adap)
 {
-	int res = 0, dummy;
+	int res = 0;
 
 	/* Can't register until after driver model init */
 	if (unlikely(WARN_ON(!i2c_bus_type.p))) {
@@ -821,8 +821,7 @@ static int i2c_register_adapter(struct i
 
 	/* Notify drivers */
 	mutex_lock(&core_lock);
-	dummy = bus_for_each_drv(&i2c_bus_type, NULL, adap,
-				 __process_new_adapter);
+	bus_for_each_drv(&i2c_bus_type, NULL, adap, __process_new_adapter);
 	mutex_unlock(&core_lock);
 
 	return 0;


-- 
Jean Delvare
