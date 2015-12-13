From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] i2c: create builtin_i2c_driver to avoid registration boilerplate
Date: Sun, 13 Dec 2015 15:33:19 -0500
Message-ID: <1450038799-27995-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

In commit f309d4443130bf814e991f836e919dca22df37ae ("platform_device:
better support builtin boilerplate avoidance") we introduced the
builtin_driver macro.

Here we use that support and extend it to I2C driver registration,
so where a driver is clearly non-modular and builtin-only, we can
register it in a similar fashion.  And existing code that is clearly
non-modular can be updated with the simple mapping of

     module_i2c_driver(...)  ---> builtin_i2c_driver(...)

We've essentially cloned the former to make the latter, and taken
out the remove/module_exit parts since those never get used in a
non-modular build of the code.

A similar thing was done in commit b4eb6cdbbd13698704863f680c643c569909e1c2
("PCI: Add builtin_pci_driver() to avoid registration boilerplate").

Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[I've about 10 drivers/mfd and one drivers/gpio users of this in
 my personal testing queue, but obviously I can't submit those
 until builtin_i2c_driver makes it to mainline.  Since there are
 no drivers/i2c users yet this change is sent to i2c on its own.]

 include/linux/i2c.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 768063baafbf..d3ca750bfcdf 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -622,7 +622,7 @@ static inline int i2c_adapter_id(struct i2c_adapter *adap)
 }
 
 /**
- * module_i2c_driver() - Helper macro for registering a I2C driver
+ * module_i2c_driver() - Helper macro for registering a modular I2C driver
  * @__i2c_driver: i2c_driver struct
  *
  * Helper macro for I2C drivers which do not do anything special in module
@@ -633,6 +633,17 @@ static inline int i2c_adapter_id(struct i2c_adapter *adap)
 	module_driver(__i2c_driver, i2c_add_driver, \
 			i2c_del_driver)
 
+/**
+ * builtin_i2c_driver() - Helper macro for registering a builtin I2C driver
+ * @__i2c_driver: i2c_driver struct
+ *
+ * Helper macro for I2C drivers which do not do anything special in their
+ * init. This eliminates a lot of boilerplate. Each driver may only
+ * use this macro once, and calling it replaces device_initcall().
+ */
+#define builtin_i2c_driver(__i2c_driver) \
+	builtin_driver(__i2c_driver, i2c_add_driver)
+
 #endif /* I2C */
 
 #if IS_ENABLED(CONFIG_OF)
-- 
2.5.0

