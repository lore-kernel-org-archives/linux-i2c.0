From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Drop i2c_adapter.id
Date: Fri, 18 Mar 2011 10:22:08 +0100
Message-ID: <20110318102208.3c9c45aa@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is no user left of i2c_adapter.id, so we can get rid of it.
Finally! :)

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
3 months earlier than planned, isn't it nice :)

 Documentation/feature-removal-schedule.txt |   10 ----------
 include/linux/i2c.h                        |    1 -
 2 files changed, 11 deletions(-)

--- linux-2.6.39-rc0.orig/include/linux/i2c.h	2011-03-17 16:57:49.000000000 +0100
+++ linux-2.6.39-rc0/include/linux/i2c.h	2011-03-17 16:57:53.000000000 +0100
@@ -353,7 +353,6 @@ struct i2c_algorithm {
  */
 struct i2c_adapter {
 	struct module *owner;
-	unsigned int id __deprecated;
 	unsigned int class;		  /* classes to allow probing for */
 	const struct i2c_algorithm *algo; /* the algorithm to access the bus */
 	void *algo_data;
--- linux-2.6.39-rc0.orig/Documentation/feature-removal-schedule.txt	2011-03-17 16:57:49.000000000 +0100
+++ linux-2.6.39-rc0/Documentation/feature-removal-schedule.txt	2011-03-17 16:57:53.000000000 +0100
@@ -585,16 +585,6 @@ Who:    NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
 
 ----------------------------
 
-What:	i2c_adapter.id
-When:	June 2011
-Why:	This field is deprecated. I2C device drivers shouldn't change their
-	behavior based on the underlying I2C adapter. Instead, the I2C
-	adapter driver should instantiate the I2C devices and provide the
-	needed platform-specific information.
-Who:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
-
-----------------------------
-
 What:	cancel_rearming_delayed_work[queue]()
 When:	2.6.39
 


-- 
Jean Delvare
