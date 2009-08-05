From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 4/4] i2c: Provide compatibility links for i2c adapters
Date: Wed, 5 Aug 2009 11:14:03 +0200
Message-ID: <20090805111403.5bddea31@hyperion.delvare>
References: <20090805110537.73735169@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090805110537.73735169-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Some user-space applications may be relying on i2c adapters showing up
as class devices in sysfs. Provide compatibility links for them for
the time being. We will remove them after a long transition period.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
---
 drivers/i2c/Kconfig    |    8 ++++++++
 drivers/i2c/i2c-core.c |   33 ++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

--- linux-2.6.31-rc4.orig/drivers/i2c/Kconfig	2009-07-31 16:17:21.000000000 +0200
+++ linux-2.6.31-rc4/drivers/i2c/Kconfig	2009-07-31 18:37:06.000000000 +0200
@@ -27,6 +27,14 @@ config I2C_BOARDINFO
 	boolean
 	default y
 
+config I2C_COMPAT
+	boolean "Enable compatibility bits for old user-space"
+	default y
+	help
+	  Say Y here if you intend to run lm-sensors 3.1.1 or older, or any
+	  other user-space package which expects i2c adapters to be class
+	  devices. If you don't know, say Y.
+
 config I2C_CHARDEV
 	tristate "I2C device interface"
 	help
--- linux-2.6.31-rc4.orig/drivers/i2c/i2c-core.c	2009-07-31 18:35:53.000000000 +0200
+++ linux-2.6.31-rc4/drivers/i2c/i2c-core.c	2009-07-31 18:35:57.000000000 +0200
@@ -538,6 +538,10 @@ static struct device_type i2c_adapter_ty
 	.release	= i2c_adapter_dev_release,
 };
 
+#ifdef CONFIG_I2C_COMPAT
+static struct class_compat *i2c_adapter_compat_class;
+#endif
+
 static void i2c_scan_static_board_info(struct i2c_adapter *adapter)
 {
 	struct i2c_devinfo	*devinfo;
@@ -595,6 +599,14 @@ static int i2c_register_adapter(struct i
 
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
+#ifdef CONFIG_I2C_COMPAT
+	res = class_compat_create_link(i2c_adapter_compat_class, &adap->dev,
+				       adap->dev.parent);
+	if (res)
+		dev_warn(&adap->dev,
+			 "Failed to create compatibility class link\n");
+#endif
+
 	/* create pre-declared device nodes */
 	if (adap->nr < __i2c_first_dynamic_bus_num)
 		i2c_scan_static_board_info(adap);
@@ -773,6 +785,11 @@ int i2c_del_adapter(struct i2c_adapter *
 	   checking the returned value. */
 	res = device_for_each_child(&adap->dev, NULL, __unregister_client);
 
+#ifdef CONFIG_I2C_COMPAT
+	class_compat_remove_link(i2c_adapter_compat_class, &adap->dev,
+				 adap->dev.parent);
+#endif
+
 	/* clean up the sysfs representation */
 	init_completion(&adap->dev_released);
 	device_unregister(&adap->dev);
@@ -978,12 +995,23 @@ static int __init i2c_init(void)
 	retval = bus_register(&i2c_bus_type);
 	if (retval)
 		return retval;
+#ifdef CONFIG_I2C_COMPAT
+	i2c_adapter_compat_class = class_compat_register("i2c-adapter");
+	if (!i2c_adapter_compat_class) {
+		retval = -ENOMEM;
+		goto bus_err;
+	}
+#endif
 	retval = i2c_add_driver(&dummy_driver);
 	if (retval)
-		goto bus_err;
+		goto class_err;
 	return 0;
 
+class_err:
+#ifdef CONFIG_I2C_COMPAT
+	class_compat_unregister(i2c_adapter_compat_class);
 bus_err:
+#endif
 	bus_unregister(&i2c_bus_type);
 	return retval;
 }
@@ -991,6 +1019,9 @@ bus_err:
 static void __exit i2c_exit(void)
 {
 	i2c_del_driver(&dummy_driver);
+#ifdef CONFIG_I2C_COMPAT
+	class_compat_unregister(i2c_adapter_compat_class);
+#endif
 	bus_unregister(&i2c_bus_type);
 }
 

-- 
Jean Delvare
