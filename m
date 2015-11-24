From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 04/13] device property: keep single value inplace
Date: Tue, 24 Nov 2015 12:22:50 +0200
Message-ID: <1448360579-79260-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

We may save a lot of lines of code and space by keeping single values inside
the struct property_entry. Refactor the implementation to do so.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 31 ++++++++++++++++++++++++++++---
 include/linux/property.h | 29 +++++++++++++++++++++--------
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 86834bd..3e603c0 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -72,7 +72,10 @@ static void *pset_prop_find(struct property_set *pset, const char *propname,
 	prop = pset_prop_get(pset, propname);
 	if (!prop)
 		return ERR_PTR(-EINVAL);
-	pointer = prop->value.raw_data;
+	if (prop->is_array)
+		pointer = prop->pointer.raw_data;
+	else
+		pointer = &prop->value.raw_data;
 	if (!pointer)
 		return ERR_PTR(-ENODATA);
 	if (length > prop->length)
@@ -167,6 +170,29 @@ static int pset_prop_read_string_array(struct property_set *pset,
 	return 0;
 }
 
+static int pset_prop_read_string(struct property_set *pset,
+				 const char *propname, const char **strings)
+{
+	struct property_entry *prop;
+	const char **pointer;
+
+	prop = pset_prop_get(pset, propname);
+	if (!prop)
+		return -EINVAL;
+	if (prop->is_array) {
+		pointer = prop->pointer.str;
+		if (!pointer)
+			return -ENODATA;
+	} else {
+		pointer = &prop->value.str;
+		if (strnlen(*pointer, prop->length) >= prop->length)
+			return -EILSEQ;
+	}
+
+	*strings = *pointer;
+	return 0;
+}
+
 static inline struct fwnode_handle *dev_fwnode(struct device *dev)
 {
 	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
@@ -566,8 +592,7 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
 					   val, 1);
 	else if (is_pset_node(fwnode))
-		return pset_prop_read_string_array(to_pset_node(fwnode),
-						   propname, val, 1);
+		return pset_prop_read_string(to_pset_node(fwnode), propname, val);
 	return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string);
diff --git a/include/linux/property.h b/include/linux/property.h
index c29460a..5d0b9b6 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -145,19 +145,32 @@ static inline int fwnode_property_read_u64(struct fwnode_handle *fwnode,
  * struct property_entry - "Built-in" device property representation.
  * @name: Name of the property.
  * @length: Length of data making up the value.
- * @value: Value of the property (an array of items of the given type).
+ * @is_array: True when the property is an array.
+ * @pointer: Pointer to the property (an array of items of the given type).
+ * @value: Value of the property (when it is a single item of the given type).
  */
 struct property_entry {
 	const char *name;
 	size_t length;
+	bool is_array;
 	union {
-		void *raw_data;
-		u8 *u8_data;
-		u16 *u16_data;
-		u32 *u32_data;
-		u64 *u64_data;
-		const char **str;
-	} value;
+		union {
+			void *raw_data;
+			u8 *u8_data;
+			u16 *u16_data;
+			u32 *u32_data;
+			u64 *u64_data;
+			const char **str;
+		} pointer;
+		union {
+			unsigned long long raw_data;
+			u8 u8_data;
+			u16 u16_data;
+			u32 u32_data;
+			u64 u64_data;
+			const char *str;
+		} value;
+	};
 };
 
 /**
-- 
2.6.2
