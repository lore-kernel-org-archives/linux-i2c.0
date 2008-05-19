From: matthias@kaehlcke.net
Subject: [patch 2/2] i2c_del_driver(): use list_for_each_entry_safe()
Date: Mon, 19 May 2008 22:48:40 +0200
Message-ID: <20080519204839.641691973@kaehlcke.net>
References: <20080519204838.612046856@kaehlcke.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763922AbYESUvg@vger.kernel.org>
Content-Disposition: inline; filename=i2c_del_driver-list_for_each_entry_safe.diff
Sender: linux-kernel-owner@vger.kernel.org
To: khali@linux-fr.org, i2c@lm-sensors.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Matthias Kaehlcke <matthias@kaehlcke.net>
List-Id: linux-i2c@vger.kernel.org

i2c-core.c: use list_for_each_entry_safe() in i2c_del_driver()

Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>

Index: linux-2.6/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.orig/drivers/i2c/i2c-core.c	2008-05-19 22:33:04.000000000 +0200
+++ linux-2.6/drivers/i2c/i2c-core.c	2008-05-19 22:33:51.000000000 +0200
@@ -707,8 +707,7 @@
  */
 void i2c_del_driver(struct i2c_driver *driver)
 {
-	struct list_head   *item2, *_n;
-	struct i2c_client  *client;
+	struct i2c_client  *client, *_n;
 	struct i2c_adapter *adap;
 
 	mutex_lock(&core_lock);
@@ -730,8 +729,7 @@
 					driver->driver.name);
 			}
 		} else {
-			list_for_each_safe(item2, _n, &adap->clients) {
-				client = list_entry(item2, struct i2c_client, list);
+			list_for_each_entry_safe(client, _n, &adap->clients, list) {
 				if (client->driver != driver)
 					continue;
 				dev_dbg(&adap->dev, "detaching client [%s] "

-- 
Matthias Kaehlcke
Embedded Linux Engineer
Barcelona

              We build too many walls and not enough bridges
                             (Isaac Newton)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
