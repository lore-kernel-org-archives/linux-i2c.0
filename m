From: matthias@kaehlcke.net
Subject: [patch 1/2] i2c_del_adapter(): use list_for_each_entry_safe()
Date: Mon, 19 May 2008 22:48:39 +0200
Message-ID: <20080519204839.185643940@kaehlcke.net>
References: <20080519204838.612046856@kaehlcke.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759989AbYESUvU@vger.kernel.org>
Content-Disposition: inline; filename=i2c_del_adapter-list_for_each_entry_safe.diff
Sender: linux-kernel-owner@vger.kernel.org
To: khali@linux-fr.org, i2c@lm-sensors.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Matthias Kaehlcke <matthias@kaehlcke.net>
List-Id: linux-i2c@vger.kernel.org

i2c-core.c: use list_for_each_entry_safe() in i2c_del_adapter()

Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>

--- linux-2.6.orig/drivers/i2c/i2c-core.c	2008-05-19 22:30:41.000000000 +0200
+++ linux-2.6/drivers/i2c/i2c-core.c	2008-05-19 22:30:59.000000000 +0200
@@ -582,8 +582,7 @@
  */
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
-	struct list_head  *item, *_n;
-	struct i2c_client *client;
+	struct i2c_client *client, *_n;
 	int res = 0;
 
 	mutex_lock(&core_lock);
@@ -604,10 +603,9 @@
 
 	/* detach any active clients. This must be done first, because
 	 * it can fail; in which case we give up. */
-	list_for_each_safe(item, _n, &adap->clients) {
+	list_for_each_entry_safe(client, _n, &adap->clients, list) {
 		struct i2c_driver	*driver;
 
-		client = list_entry(item, struct i2c_client, list);
 		driver = client->driver;
 
 		/* new style, follow standard driver model */

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
