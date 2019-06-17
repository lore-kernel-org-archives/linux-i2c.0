From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 1/3] include: linux: i2c: more helpers for declaring i2c drivers
Date: Mon, 17 Jun 2019 20:39:37 +0200
Message-ID: <1560796779-17117-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, wsa@the-dreams.de, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Add more helper macros for trivial driver init cases, similar to the
already existing module_i2c_driver()+friends - now for those which
are initialized at other stages (eg. by subsys_initcall()).

This helps to further reduce driver init boilerplate.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 include/linux/i2c.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 1308126..fee59bd 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -920,6 +920,23 @@ static inline u8 i2c_8bit_addr_from_msg(const struct i2c_msg *msg)
 #define builtin_i2c_driver(__i2c_driver) \
 	builtin_driver(__i2c_driver, i2c_add_driver)
 
+/* subsys_i2c_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces subsys_initcall() and module_exit()
+ */
+#define subsys_i2c_driver(__i2c_driver) \
+static int __init __i2c_driver##_init(void) \
+{ \
+       return i2c_add_driver(&(__i2c_driver)); \
+} \
+subsys_initcall(__i2c_driver##_init); \
+static void __exit __i2c_driver##_exit(void) \
+{ \
+       i2c_del_driver(&(__i2c_driver)); \
+} \
+module_exit(__i2c_driver##_exit);
+
 #endif /* I2C */
 
 #if IS_ENABLED(CONFIG_OF)
-- 
1.9.1
