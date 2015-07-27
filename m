From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/4] i2c: core: manage i2c bus device refcount in i2c_[get|put]_adapter
Date: Mon, 27 Jul 2015 17:30:49 +0300
Message-ID: <1438007451-8553-3-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1438007451-8553-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438007451-8553-1-git-send-email-vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

In addition to module_get()/module_put() add get_device()/put_device()
calls into i2c_get_adapter()/i2c_put_adapter() exported
interfaces. This is done to lock I2C bus device, if it is in use by a
client.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
Changes from v1 to v2:
* none, new change suggested by Thierry

 drivers/i2c/i2c-core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d5fe5a4..a7054ac 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2411,9 +2411,15 @@ struct i2c_adapter *i2c_get_adapter(int nr)
 
 	mutex_lock(&core_lock);
 	adapter = idr_find(&i2c_adapter_idr, nr);
-	if (adapter && !try_module_get(adapter->owner))
+	if (!adapter)
+		goto exit;
+
+	if (try_module_get(adapter->owner))
+		get_device(&adapter->dev);
+	else
 		adapter = NULL;
 
+ exit:
 	mutex_unlock(&core_lock);
 	return adapter;
 }
@@ -2421,8 +2427,11 @@ EXPORT_SYMBOL(i2c_get_adapter);
 
 void i2c_put_adapter(struct i2c_adapter *adap)
 {
-	if (adap)
-		module_put(adap->owner);
+	if (!adap)
+		return;
+
+	put_device(&adap->dev);
+	module_put(adap->owner);
 }
 EXPORT_SYMBOL(i2c_put_adapter);
 
-- 
2.1.4
