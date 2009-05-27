From: Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH] i2c: Simplified CONFIG_I2C=n interface.
Date: Wed, 27 May 2009 16:08:50 +0900
Message-ID: <20090527070850.GA11221@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-next@vger.kernel.org, linux-media@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Another day, another module-related failure due to the i2c interface
being used in code that optionally uses it:

ERROR: "i2c_new_device" [drivers/media/video/soc_camera.ko] undefined!
ERROR: "i2c_get_adapter" [drivers/media/video/soc_camera.ko] undefined!
ERROR: "i2c_put_adapter" [drivers/media/video/soc_camera.ko] undefined!
ERROR: "i2c_unregister_device" [drivers/media/video/soc_camera.ko] undefined!
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2
make: *** [sub-make] Error 2

In the interest of not continually inserting i2c ifdefs in to every
driver that supports an optional i2c interface, this provides a stubbed
set of interfaces for the CONFIG_I2C=n case.

I've covered the obvious ones that cause the majority of the build
failures, anything more involved really ought to have its dependencies
fixed instead.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 include/linux/i2c.h |  109 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index ad25805..ba73cd0 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -277,6 +277,8 @@ struct i2c_board_info {
 	.type = dev_type, .addr = (dev_addr)
 
 
+#ifdef CONFIG_I2C
+
 /* Add-on boards should register/unregister their devices; e.g. a board
  * with integrated I2C, a config eeprom, sensors, and a codec that's
  * used in conjunction with the primary hardware.
@@ -301,6 +303,33 @@ i2c_new_dummy(struct i2c_adapter *adap, u16 address);
 
 extern void i2c_unregister_device(struct i2c_client *);
 
+#else
+
+static inline struct i2c_client *
+i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
+{
+	return NULL;
+}
+
+static inline struct i2c_client *
+i2c_new_probed_device(struct i2c_adapter *adap,
+		      struct i2c_board_info *info,
+		      unsigned short const *addr_list)
+{
+	return NULL;
+}
+
+static inline struct i2c_client *
+i2c_new_dummy(struct i2c_adapter *adap, u16 address)
+{
+	return NULL;
+}
+
+static inline void i2c_unregister_device(struct i2c_client *client)
+{
+}
+#endif /* CONFIG_I2C */
+
 /* Mainboard arch_initcall() code should register all its I2C devices.
  * This is done at arch_initcall time, before declaring any i2c adapters.
  * Modules for add-on boards must use other calls.
@@ -415,6 +444,7 @@ struct i2c_client_address_data {
 
 /* ----- functions exported by i2c.o */
 
+#ifdef CONFIG_I2C
 /* administration...
  */
 extern int i2c_add_adapter(struct i2c_adapter *);
@@ -460,6 +490,85 @@ static inline u32 i2c_get_functionality(struct i2c_adapter *adap)
 	return adap->algo->functionality(adap);
 }
 
+#else
+
+static inline int i2c_add_adapter(struct i2c_adapter *adap)
+{
+	return -ENODEV;
+}
+
+static inline int i2c_del_adapter(struct i2c_adapter *adap)
+{
+	return -ENODEV;
+}
+
+static inline int i2c_add_numbered_adapter(struct i2c_adapter *adap)
+{
+	return -ENODEV;
+}
+
+static inline int i2c_register_driver(struct module *module,
+				      struct i2c_driver *driver)
+{
+	return -ENODEV;
+}
+
+static inline void i2c_del_driver(struct i2c_driver *driver)
+{
+}
+
+static inline int i2c_add_driver(struct i2c_driver *driver)
+{
+	return -ENODEV;
+}
+
+static inline int __deprecated i2c_attach_client(struct i2c_client *client)
+{
+	return -EINVAL;
+}
+
+static inline int __deprecated i2c_detach_client(struct i2c_client *client)
+{
+	return -EINVAL;
+}
+
+static inline struct i2c_client *i2c_use_client(struct i2c_client *client)
+{
+	return NULL;
+}
+
+static inline void i2c_release_client(struct i2c_client *client)
+{
+}
+
+static inline void i2c_clients_command(struct i2c_adapter *adap,
+				       unsigned int cmd, void *arg)
+{
+}
+
+static inline int i2c_probe(struct i2c_adapter *adapter,
+		const struct i2c_client_address_data *address_data,
+		int (*found_proc) (struct i2c_adapter *, int, int))
+{
+	return -ENODEV;
+}
+
+static inline struct i2c_adapter *i2c_get_adapter(int id)
+{
+	return NULL;
+}
+
+static inline void i2c_put_adapter(struct i2c_adapter *adap)
+{
+}
+
+/* Return the functionality mask */
+static inline u32 i2c_get_functionality(struct i2c_adapter *adap)
+{
+	return 0;
+}
+#endif /* CONFIG_I2C */
+
 /* Return 1 if adapter supports everything we need, 0 if not. */
 static inline int i2c_check_functionality(struct i2c_adapter *adap, u32 func)
 {
