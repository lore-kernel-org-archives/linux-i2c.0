From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH v3] i2c: Only include slave support if selected
Date: Mon, 26 Jan 2015 20:59:31 +0100
Message-ID: <20150126205931.25e1f648@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Make the slave support depend on CONFIG_I2C_SLAVE. Otherwise it gets
included unconditionally, even when it is not needed.

I2C bus drivers which implement slave support must select
I2C_SLAVE.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
Changes since v2:
 * Added missing #if around i2c_algorithm callbacks
 * Improved patch description

 drivers/i2c/busses/Kconfig |    1 +
 drivers/i2c/i2c-core.c     |    2 ++
 include/linux/i2c.h        |    6 ++++++
 3 files changed, 9 insertions(+)

--- linux-3.19-rc6.orig/drivers/i2c/i2c-core.c	2015-01-26 12:47:26.467671896 +0100
+++ linux-3.19-rc6/drivers/i2c/i2c-core.c	2015-01-26 12:50:23.541420438 +0100
@@ -2962,6 +2962,7 @@ trace:
 }
 EXPORT_SYMBOL(i2c_smbus_xfer);
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
 int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
 {
 	int ret;
@@ -3009,6 +3010,7 @@ int i2c_slave_unregister(struct i2c_clie
 	return ret;
 }
 EXPORT_SYMBOL_GPL(i2c_slave_unregister);
+#endif
 
 MODULE_AUTHOR("Simon G. Vogl <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>");
 MODULE_DESCRIPTION("I2C-Bus main module");
--- linux-3.19-rc6.orig/include/linux/i2c.h	2015-01-26 12:47:26.470671959 +0100
+++ linux-3.19-rc6/include/linux/i2c.h	2015-01-26 20:10:38.727417893 +0100
@@ -222,7 +222,9 @@ struct i2c_client {
 	struct device dev;		/* the device structure		*/
 	int irq;			/* irq issued by device		*/
 	struct list_head detected;
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
 	i2c_slave_cb_t slave_cb;	/* callback for slave mode	*/
+#endif
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
@@ -247,6 +249,7 @@ static inline void i2c_set_clientdata(st
 
 /* I2C slave support */
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
 enum i2c_slave_event {
 	I2C_SLAVE_REQ_READ_START,
 	I2C_SLAVE_REQ_READ_END,
@@ -263,6 +266,7 @@ static inline int i2c_slave_event(struct
 {
 	return client->slave_cb(client, event, val);
 }
+#endif
 
 /**
  * struct i2c_board_info - template for device creation
@@ -398,8 +402,10 @@ struct i2c_algorithm {
 	/* To determine what the adapter supports */
 	u32 (*functionality) (struct i2c_adapter *);
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
 	int (*reg_slave)(struct i2c_client *client);
 	int (*unreg_slave)(struct i2c_client *client);
+#endif
 };
 
 /**
--- linux-3.19-rc6.orig/drivers/i2c/busses/Kconfig	2015-01-23 10:30:56.044531347 +0100
+++ linux-3.19-rc6/drivers/i2c/busses/Kconfig	2015-01-26 18:55:07.163736062 +0100
@@ -881,6 +881,7 @@ config I2C_XLR
 config I2C_RCAR
 	tristate "Renesas R-Car I2C Controller"
 	depends on ARCH_SHMOBILE || COMPILE_TEST
+	select I2C_SLAVE
 	help
 	  If you say yes to this option, support will be included for the
 	  R-Car I2C controller.


-- 
Jean Delvare
SUSE L3 Support
