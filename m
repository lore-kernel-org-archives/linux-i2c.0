From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Constify i2c_get_clientdata's parameter (v2)
Date: Sun, 19 Oct 2008 13:16:42 +0200
Message-ID: <20081019131642.363efc74@hyperion.delvare>
References: <20081018142746.1b5321da@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081018142746.1b5321da-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

i2c_get_clientdata doesn't change the i2c_client it is passed as a
parameter, so it can be constified. Same for i2c_get_adapdata.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/i2c/writing-clients |    2 +-
 include/linux/device.h            |    2 +-
 include/linux/i2c.h               |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.28-rc0.orig/include/linux/i2c.h	2008-10-18 14:28:44.000000000 +0200
+++ linux-2.6.28-rc0/include/linux/i2c.h	2008-10-19 12:34:02.000000000 +0200
@@ -224,7 +224,7 @@ static inline struct i2c_client *kobj_to
 	return to_i2c_client(dev);
 }
 
-static inline void *i2c_get_clientdata (struct i2c_client *dev)
+static inline void *i2c_get_clientdata(const struct i2c_client *dev)
 {
 	return dev_get_drvdata (&dev->dev);
 }
@@ -369,7 +369,7 @@ struct i2c_adapter {
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
-static inline void *i2c_get_adapdata (struct i2c_adapter *dev)
+static inline void *i2c_get_adapdata(const struct i2c_adapter *dev)
 {
 	return dev_get_drvdata (&dev->dev);
 }
--- linux-2.6.28-rc0.orig/include/linux/device.h	2008-10-18 14:28:44.000000000 +0200
+++ linux-2.6.28-rc0/include/linux/device.h	2008-10-18 14:30:48.000000000 +0200
@@ -450,7 +450,7 @@ static inline void set_dev_node(struct d
 }
 #endif
 
-static inline void *dev_get_drvdata(struct device *dev)
+static inline void *dev_get_drvdata(const struct device *dev)
 {
 	return dev->driver_data;
 }
--- linux-2.6.28-rc0.orig/Documentation/i2c/writing-clients	2008-10-18 14:32:48.000000000 +0200
+++ linux-2.6.28-rc0/Documentation/i2c/writing-clients	2008-10-19 12:33:42.000000000 +0200
@@ -83,7 +83,7 @@ be very useful.
 	void i2c_set_clientdata(struct i2c_client *client, void *data);
 
 	/* retrieve the value */
-	void *i2c_get_clientdata(struct i2c_client *client);
+	void *i2c_get_clientdata(const struct i2c_client *client);
 
 An example structure is below.
 

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
