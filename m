From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Match dummy devices by type
Date: Mon, 5 May 2008 11:28:58 +0200
Message-ID: <20080505112858.5101c99a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

As the old driver_name/type matching scheme is going away soon, change
the dummy device mechanism to use the new matching scheme.

This has the downside that dummy i2c clients can no longer choose
their name, they'll all appear as "dummy" in sysfs and in log
messages. I don't think it is a problem in practice though, as there
is little reason to use these i2c clients to log messages.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
Byron, could you possibly test this patch? It goes on top of 2.6.26-rc1.

 drivers/i2c/i2c-core.c    |   15 +++++++++------
 drivers/rtc/rtc-s35390a.c |    2 +-
 include/linux/i2c.h       |    2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

--- linux-2.6.26-rc0.orig/drivers/i2c/i2c-core.c	2008-05-03 15:49:09.000000000 +0200
+++ linux-2.6.26-rc0/drivers/i2c/i2c-core.c	2008-05-03 15:49:18.000000000 +0200
@@ -327,6 +327,12 @@ void i2c_unregister_device(struct i2c_cl
 EXPORT_SYMBOL_GPL(i2c_unregister_device);
 
 
+static const struct i2c_device_id dummy_id[] = {
+	{ "dummy", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, dummy_id);
+
 static int dummy_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
@@ -342,13 +348,13 @@ static struct i2c_driver dummy_driver = 
 	.driver.name	= "dummy",
 	.probe		= dummy_probe,
 	.remove		= dummy_remove,
+	.id_table	= dummy_id,
 };
 
 /**
  * i2c_new_dummy - return a new i2c device bound to a dummy driver
  * @adapter: the adapter managing the device
  * @address: seven bit address to be used
- * @type: optional label used for i2c_client.name
  * Context: can sleep
  *
  * This returns an I2C client bound to the "dummy" driver, intended for use
@@ -364,15 +370,12 @@ static struct i2c_driver dummy_driver = 
  * i2c_unregister_device(); or NULL to indicate an error.
  */
 struct i2c_client *
-i2c_new_dummy(struct i2c_adapter *adapter, u16 address, const char *type)
+i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
 {
 	struct i2c_board_info info = {
-		.driver_name	= "dummy",
-		.addr		= address,
+		I2C_BOARD_INFO("dummy", address),
 	};
 
-	if (type)
-		strlcpy(info.type, type, sizeof info.type);
 	return i2c_new_device(adapter, &info);
 }
 EXPORT_SYMBOL_GPL(i2c_new_dummy);
--- linux-2.6.26-rc0.orig/include/linux/i2c.h	2008-05-03 15:49:09.000000000 +0200
+++ linux-2.6.26-rc0/include/linux/i2c.h	2008-05-03 15:49:18.000000000 +0200
@@ -262,7 +262,7 @@ i2c_new_probed_device(struct i2c_adapter
  * client handles for the extra addresses.
  */
 extern struct i2c_client *
-i2c_new_dummy(struct i2c_adapter *adap, u16 address, const char *type);
+i2c_new_dummy(struct i2c_adapter *adap, u16 address);
 
 extern void i2c_unregister_device(struct i2c_client *);
 
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-s35390a.c	2008-05-03 15:49:09.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-s35390a.c	2008-05-03 15:49:18.000000000 +0200
@@ -227,7 +227,7 @@ static int s35390a_probe(struct i2c_clie
 	/* This chip uses multiple addresses, use dummy devices for them */
 	for (i = 1; i < 8; ++i) {
 		s35390a->client[i] = i2c_new_dummy(client->adapter,
-					client->addr + i, "rtc-s35390a");
+					client->addr + i);
 		if (!s35390a->client[i]) {
 			dev_err(&client->dev, "Address %02x unavailable\n",
 						client->addr + i);


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
