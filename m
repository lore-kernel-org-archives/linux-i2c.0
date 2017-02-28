From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2] i2c: copy device properties when using
 i2c_register_board_info()
Date: Tue, 28 Feb 2017 11:10:51 -0800
Message-ID: <20170228191051.GA38277@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This will allow marking device property lists as __initdata, the same as
board info structures themselves.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: avoid copying NULL properties as it simply results in creating an
empty property set for no good reason.

 drivers/i2c/i2c-boardinfo.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/i2c-boardinfo.c b/drivers/i2c/i2c-boardinfo.c
index 6e5fac6a5262..5b8f6c3a6950 100644
--- a/drivers/i2c/i2c-boardinfo.c
+++ b/drivers/i2c/i2c-boardinfo.c
@@ -15,6 +15,7 @@
 #include <linux/export.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
+#include <linux/property.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 
@@ -55,6 +56,7 @@ EXPORT_SYMBOL_GPL(__i2c_first_dynamic_bus_num);
  *
  * The board info passed can safely be __initdata, but be careful of embedded
  * pointers (for platform_data, functions, etc) since that won't be copied.
+ * Device properties are deep-copied though.
  */
 int i2c_register_board_info(int busnum, struct i2c_board_info const *info, unsigned len)
 {
@@ -78,6 +80,14 @@ int i2c_register_board_info(int busnum, struct i2c_board_info const *info, unsig
 
 		devinfo->busnum = busnum;
 		devinfo->board_info = *info;
+
+		if (info->properties) {
+			devinfo->board_info.properties =
+					property_entries_dup(info->properties);
+			if (IS_ERR(devinfo->board_info.properties))
+				return PTR_ERR(devinfo->board_info.properties);
+		}
+
 		list_add_tail(&devinfo->list, &__i2c_board_list);
 	}
 
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
