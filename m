From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Unregister dummy devices last on adapter removal
Date: Wed, 12 Jan 2011 17:24:27 +0100
Message-ID: <20110112172427.27a149d0@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c: Unregister dummy devices last on adapter removal

Remove real devices first and dummy devices last. This gives device
drivers which instantiated dummy devices themselves a chance to clean
them up before we do.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Tested-by: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
---
 drivers/i2c/i2c-core.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- linux-2.6.38-rc0.orig/drivers/i2c/i2c-core.c	2011-01-12 17:20:05.000000000 +0100
+++ linux-2.6.38-rc0/drivers/i2c/i2c-core.c	2011-01-12 17:23:24.000000000 +0100
@@ -1021,6 +1021,14 @@ static int i2c_do_del_adapter(struct i2c
 static int __unregister_client(struct device *dev, void *dummy)
 {
 	struct i2c_client *client = i2c_verify_client(dev);
+	if (client && strcmp(client->name, "dummy"))
+		i2c_unregister_device(client);
+	return 0;
+}
+
+static int __unregister_dummy(struct device *dev, void *dummy)
+{
+	struct i2c_client *client = i2c_verify_client(dev);
 	if (client)
 		i2c_unregister_device(client);
 	return 0;
@@ -1075,8 +1083,12 @@ int i2c_del_adapter(struct i2c_adapter *
 	mutex_unlock(&adap->userspace_clients_lock);
 
 	/* Detach any active clients. This can't fail, thus we do not
-	   checking the returned value. */
+	 * check the returned value. This is a two-pass process, because
+	 * we can't remove the dummy devices during the first pass: they
+	 * could have been instantiated by real devices wishing to clean
+	 * them up properly, so we give them a chance to do that first. */
 	res = device_for_each_child(&adap->dev, NULL, __unregister_client);
+	res = device_for_each_child(&adap->dev, NULL, __unregister_dummy);
 
 #ifdef CONFIG_I2C_COMPAT
 	class_compat_remove_link(i2c_adapter_compat_class, &adap->dev,

-- 
Jean Delvare
