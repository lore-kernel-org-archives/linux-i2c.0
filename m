From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 03/13] device property: refactor built-in properties support
Date: Tue, 24 Nov 2015 12:22:49 +0200
Message-ID: <1448360579-79260-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Instead of using the type and nval fields we will use length (in bytes) of the
value. The sanity check is done in the accessors.

The built-in property accessors are split in the same way such as device tree.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 150 ++++++++++++++++++++++++++++++++++-------------
 include/linux/property.h |   8 +--
 2 files changed, 113 insertions(+), 45 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 2e01f3f..86834bd 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -63,45 +63,107 @@ static struct property_entry *pset_prop_get(struct property_set *pset,
 	return NULL;
 }
 
-static int pset_prop_read_array(struct property_set *pset, const char *name,
-				enum dev_prop_type type, void *val, size_t nval)
+static void *pset_prop_find(struct property_set *pset, const char *propname,
+			    size_t length)
 {
 	struct property_entry *prop;
-	unsigned int item_size;
+	void *pointer;
 
-	prop = pset_prop_get(pset, name);
+	prop = pset_prop_get(pset, propname);
+	if (!prop)
+		return ERR_PTR(-EINVAL);
+	pointer = prop->value.raw_data;
+	if (!pointer)
+		return ERR_PTR(-ENODATA);
+	if (length > prop->length)
+		return ERR_PTR(-EOVERFLOW);
+	return pointer;
+}
+
+static int pset_prop_read_u8_array(struct property_set *pset,
+				   const char *propname,
+				   u8 *values, size_t nval)
+{
+	void *pointer;
+	size_t length = nval * sizeof(*values);
+
+	pointer = pset_prop_find(pset, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(values, pointer, length);
+	return 0;
+}
+
+static int pset_prop_read_u16_array(struct property_set *pset,
+				    const char *propname,
+				    u16 *values, size_t nval)
+{
+	void *pointer;
+	size_t length = nval * sizeof(*values);
+
+	pointer = pset_prop_find(pset, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(values, pointer, length);
+	return 0;
+}
+
+static int pset_prop_read_u32_array(struct property_set *pset,
+				    const char *propname,
+				    u32 *values, size_t nval)
+{
+	void *pointer;
+	size_t length = nval * sizeof(*values);
+
+	pointer = pset_prop_find(pset, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(values, pointer, length);
+	return 0;
+}
+
+static int pset_prop_read_u64_array(struct property_set *pset,
+				    const char *propname,
+				    u64 *values, size_t nval)
+{
+	void *pointer;
+	size_t length = nval * sizeof(*values);
+
+	pointer = pset_prop_find(pset, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(values, pointer, length);
+	return 0;
+}
+
+static int pset_prop_count_elems_of_size(struct property_set *pset,
+					 const char *propname, size_t length)
+{
+	struct property_entry *prop;
+
+	prop = pset_prop_get(pset, propname);
 	if (!prop)
-		return -ENODATA;
-
-	if (prop->type != type)
-		return -EPROTO;
-
-	if (!val)
-		return prop->nval;
-
-	if (prop->nval < nval)
-		return -EOVERFLOW;
-
-	switch (type) {
-	case DEV_PROP_U8:
-		item_size = sizeof(u8);
-		break;
-	case DEV_PROP_U16:
-		item_size = sizeof(u16);
-		break;
-	case DEV_PROP_U32:
-		item_size = sizeof(u32);
-		break;
-	case DEV_PROP_U64:
-		item_size = sizeof(u64);
-		break;
-	case DEV_PROP_STRING:
-		item_size = sizeof(const char *);
-		break;
-	default:
 		return -EINVAL;
-	}
-	memcpy(val, prop->value.raw_data, nval * item_size);
+
+	return prop->length / length;
+}
+
+static int pset_prop_read_string_array(struct property_set *pset,
+				       const char *propname,
+				       const char **strings, size_t nval)
+{
+	void *pointer;
+	size_t length = nval * sizeof(*strings);
+
+	pointer = pset_prop_find(pset, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(strings, pointer, length);
 	return 0;
 }
 
@@ -314,6 +376,10 @@ EXPORT_SYMBOL_GPL(device_property_match_string);
 	(val) ? of_property_read_##type##_array((node), (propname), (val), (nval)) \
 	      : of_property_count_elems_of_size((node), (propname), sizeof(type))
 
+#define PSET_PROP_READ_ARRAY(node, propname, type, val, nval)				\
+	(val) ? pset_prop_read_##type##_array((node), (propname), (val), (nval))	\
+	      : pset_prop_count_elems_of_size((node), (propname), sizeof(type))
+
 #define FWNODE_PROP_READ_ARRAY(_fwnode_, _propname_, _type_, _proptype_, _val_, _nval_) \
 ({ \
 	int _ret_; \
@@ -324,8 +390,8 @@ EXPORT_SYMBOL_GPL(device_property_match_string);
 		_ret_ = acpi_node_prop_read(_fwnode_, _propname_, _proptype_, \
 					    _val_, _nval_); \
 	else if (is_pset_node(_fwnode_)) 						\
-		_ret_ = pset_prop_read_array(to_pset_node(_fwnode_), _propname_,	\
-					     _proptype_, _val_, _nval_); \
+		_ret_ = PSET_PROP_READ_ARRAY(to_pset_node(_fwnode_), _propname_,	\
+					     _type_, _val_, _nval_);			\
 	else \
 		_ret_ = -ENXIO; \
 	_ret_; \
@@ -466,8 +532,12 @@ int fwnode_property_read_string_array(struct fwnode_handle *fwnode,
 		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
 					   val, nval);
 	else if (is_pset_node(fwnode))
-		return pset_prop_read_array(to_pset_node(fwnode), propname,
-					    DEV_PROP_STRING, val, nval);
+		return val ?
+			pset_prop_read_string_array(to_pset_node(fwnode),
+						    propname, val, nval) :
+			pset_prop_count_elems_of_size(to_pset_node(fwnode),
+						      propname,
+						      sizeof(const char *));
 	return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
@@ -496,8 +566,8 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
 					   val, 1);
 	else if (is_pset_node(fwnode))
-		return pset_prop_read_array(to_pset_node(fwnode), propname,
-					    DEV_PROP_STRING, val, 1);
+		return pset_prop_read_string_array(to_pset_node(fwnode),
+						   propname, val, 1);
 	return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string);
diff --git a/include/linux/property.h b/include/linux/property.h
index 0a3705a..c29460a 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -144,14 +144,12 @@ static inline int fwnode_property_read_u64(struct fwnode_handle *fwnode,
 /**
  * struct property_entry - "Built-in" device property representation.
  * @name: Name of the property.
- * @type: Type of the property.
- * @nval: Number of items of type @type making up the value.
- * @value: Value of the property (an array of @nval items of type @type).
+ * @length: Length of data making up the value.
+ * @value: Value of the property (an array of items of the given type).
  */
 struct property_entry {
 	const char *name;
-	enum dev_prop_type type;
-	size_t nval;
+	size_t length;
 	union {
 		void *raw_data;
 		u8 *u8_data;
-- 
2.6.2

