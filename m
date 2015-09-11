From: Kieran Bingham <kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RESEND PATCH v4 6/8] i2c: Provide a temporary .probe2() call-back type
Date: Fri, 11 Sep 2015 12:56:02 +0100
Message-ID: <1441972564-9621-7-git-send-email-kieranbingham@gmail.com>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441972564-9621-1-git-send-email-kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, Kieran Bingham <kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This will aid the seamless removal of the current probe()'s, more
commonly unused than used second parameter.  Most I2C drivers can
simply switch over to the new interface, others which have DT
support can use its own matching instead and others can call
i2c_match_id() themselves.  This brings I2C's device probe method
into line with other similar interfaces in the kernel and prevents
the requirement to pass an i2c_device_id table.

Suggested-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
[Kieran: fix rebase conflicts and adapt for dev_pm_domain_{attach,detach}]
Signed-off-by: Kieran Bingham <kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 22 ++++++++++++++--------
 include/linux/i2c.h    |  8 +++++++-
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 0e40136..a28b423 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -658,8 +658,6 @@ static int i2c_device_probe(struct device *dev)
 	}
 
 	driver = to_i2c_driver(dev->driver);
-	if (!driver->probe)
-		return -EINVAL;
 
 	/*
 	 * An I2C ID table is not mandatory, if and only if, a suitable Device
@@ -679,12 +677,20 @@ static int i2c_device_probe(struct device *dev)
 		return status;
 
 	status = dev_pm_domain_attach(&client->dev, true);
-	if (status != -EPROBE_DEFER) {
-		status = driver->probe(client, i2c_match_id(driver->id_table,
-					client));
-		if (status)
-			dev_pm_domain_detach(&client->dev, true);
-	}
+	if (status == -EPROBE_DEFER)
+		return status;
+
+	/* When there are no more users of probe(), rename probe2 to probe. */
+	if (driver->probe2)
+		status = driver->probe2(client);
+	else if (driver->probe)
+		status = driver->probe(client,
+					i2c_match_id(driver->id_table, client));
+	else
+		status = -EINVAL;
+
+	if (status)
+		dev_pm_domain_detach(&client->dev, true);
 
 	return status;
 }
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 787066b..bf675d5 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -127,7 +127,8 @@ extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
  * struct i2c_driver - represent an I2C device driver
  * @class: What kind of i2c device we instantiate (for detect)
  * @attach_adapter: Callback for bus addition (deprecated)
- * @probe: Callback for device binding
+ * @probe: Callback for device binding - soon to be deprecated
+ * @probe2: New callback for device binding
  * @remove: Callback for device unbinding
  * @shutdown: Callback for device shutdown
  * @alert: Alert callback, for example for the SMBus alert protocol
@@ -170,6 +171,11 @@ struct i2c_driver {
 	int (*probe)(struct i2c_client *, const struct i2c_device_id *);
 	int (*remove)(struct i2c_client *);
 
+	/* New driver model interface to aid the seamless removal of the
+	 * current probe()'s, more commonly unused than used second parameter.
+	 */
+	int (*probe2)(struct i2c_client *);
+
 	/* driver model interfaces that don't relate to enumeration  */
 	void (*shutdown)(struct i2c_client *);
 
-- 
2.1.4
