From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/4] i2c: Check for address validity on client registration
Date: Mon, 31 May 2010 13:30:50 +0200
Message-ID: <20100531133050.5a97c1ad@hyperion.delvare>
References: <20100531132213.65f20b8f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100531132213.65f20b8f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Do basic address validity checks when a client is being registered. We
already had checks in place for devices which are being detected, but
not for devices which are simply instantiated.

This is a very basic check. We don't want to do strict checking here
because some devices are known to infringe the I2C address constraints
(e.g. IR receivers at 7-bit address 0x7a while this value is
supposedly reserved for 10-bit addresses.) So we assume the caller
knows what it is doing.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

--- linux-2.6.35-rc0.orig/drivers/i2c/i2c-core.c	2010-05-30 18:41:07.000000000 +0200
+++ linux-2.6.35-rc0/drivers/i2c/i2c-core.c	2010-05-30 18:50:31.000000000 +0200
@@ -371,6 +371,22 @@ struct i2c_client *i2c_verify_client(str
 EXPORT_SYMBOL(i2c_verify_client);
 
 
+/* This is a permissive address validity check, I2C address map constraints
+ * are purposedly not enforced, except for the general call address. */
+static int i2c_check_client_addr_validity(const struct i2c_client *client)
+{
+	if (client->flags & I2C_CLIENT_TEN) {
+		/* 10-bit address, all values are valid */
+		if (client->addr > 0x3ff)
+			return -EINVAL;
+	} else {
+		/* 7-bit address, reject the general call address */
+		if (client->addr == 0x00 || client->addr > 0x7f)
+			return -EINVAL;
+	}
+	return 0;
+}
+
 /**
  * i2c_new_device - instantiate an i2c device
  * @adap: the adapter managing the device
@@ -410,6 +426,14 @@ i2c_new_device(struct i2c_adapter *adap,
 
 	strlcpy(client->name, info->type, sizeof(client->name));
 
+	/* Check for address validity */
+	status = i2c_check_client_addr_validity(client);
+	if (status) {
+		dev_err(&adap->dev, "Invalid %d-bit I2C address 0x%02hx\n",
+			client->flags & I2C_CLIENT_TEN ? 10 : 7, client->addr);
+		goto out_err_silent;
+	}
+
 	/* Check for address business */
 	status = i2c_check_addr(adap, client->addr);
 	if (status)
@@ -436,6 +460,7 @@ i2c_new_device(struct i2c_adapter *adap,
 out_err:
 	dev_err(&adap->dev, "Failed to register i2c client %s at 0x%02x "
 		"(%d)\n", client->name, client->addr, status);
+out_err_silent:
 	kfree(client);
 	return NULL;
 }
@@ -561,15 +586,9 @@ i2c_sysfs_new_device(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (info.addr < 0x03 || info.addr > 0x77) {
-		dev_err(dev, "%s: Invalid I2C address 0x%hx\n", "new_device",
-			info.addr);
-		return -EINVAL;
-	}
-
 	client = i2c_new_device(adap, &info);
 	if (!client)
-		return -EEXIST;
+		return -EINVAL;
 
 	/* Keep track of the added device */
 	i2c_lock_adapter(adap);

-- 
Jean Delvare
