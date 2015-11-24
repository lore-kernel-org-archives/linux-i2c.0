From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 08/13] device property: Fallback to secondary fwnode if primary misses the property
Date: Tue, 24 Nov 2015 12:22:54 +0200
Message-ID: <1448360579-79260-9-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

The struct fwnode has notion of secondary fwnode. This is supposed to used
as fallback if the primary firmware interface (DT, ACPI) does not have the
property in question.

However, the current implementation never checks the secondary node which
prevents one to add default "built-in" properties to devices.

This patch adds fallback to the secondary fwnode if the primary fwnode
returns that the property does not exists.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 109 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 78 insertions(+), 31 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c8e9722..1768e61 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -212,12 +212,8 @@ bool device_property_present(struct device *dev, const char *propname)
 }
 EXPORT_SYMBOL_GPL(device_property_present);
 
-/**
- * fwnode_property_present - check if a property of a firmware node is present
- * @fwnode: Firmware node whose property to check
- * @propname: Name of the property
- */
-bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname)
+static bool __fwnode_property_present(struct fwnode_handle *fwnode,
+				      const char *propname)
 {
 	if (is_of_node(fwnode))
 		return of_property_read_bool(to_of_node(fwnode), propname);
@@ -227,6 +223,21 @@ bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname)
 		return !!pset_prop_get(to_pset_node(fwnode), propname);
 	return false;
 }
+
+/**
+ * fwnode_property_present - check if a property of a firmware node is present
+ * @fwnode: Firmware node whose property to check
+ * @propname: Name of the property
+ */
+bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname)
+{
+	bool ret;
+
+	ret = __fwnode_property_present(fwnode, propname);
+	if (ret == false && fwnode->secondary)
+		ret = __fwnode_property_present(fwnode->secondary, propname);
+	return ret;
+}
 EXPORT_SYMBOL_GPL(fwnode_property_present);
 
 /**
@@ -406,7 +417,7 @@ EXPORT_SYMBOL_GPL(device_property_match_string);
 	(val) ? pset_prop_read_##type##_array((node), (propname), (val), (nval))	\
 	      : pset_prop_count_elems_of_size((node), (propname), sizeof(type))
 
-#define FWNODE_PROP_READ_ARRAY(_fwnode_, _propname_, _type_, _proptype_, _val_, _nval_)	\
+#define FWNODE_PROP_READ(_fwnode_, _propname_, _type_, _proptype_, _val_, _nval_)	\
 ({											\
 	int _ret_;									\
 	if (is_of_node(_fwnode_))							\
@@ -423,6 +434,17 @@ EXPORT_SYMBOL_GPL(device_property_match_string);
 	_ret_;										\
 })
 
+#define FWNODE_PROP_READ_ARRAY(_fwnode_, _propname_, _type_, _proptype_, _val_, _nval_)	\
+({											\
+	int _ret_;									\
+	_ret_ = FWNODE_PROP_READ(_fwnode_, _propname_, _type_, _proptype_,		\
+				 _val_, _nval_);					\
+	if (_ret_ == -EINVAL && _fwnode_->secondary)					\
+		_ret_ = FWNODE_PROP_READ(_fwnode_->secondary, _propname_, _type_,	\
+				_proptype_, _val_, _nval_);				\
+	_ret_;										\
+})
+
 /**
  * fwnode_property_read_u8_array - return a u8 array property of firmware node
  * @fwnode: Firmware node to get the property of
@@ -527,6 +549,41 @@ int fwnode_property_read_u64_array(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_u64_array);
 
+static int __fwnode_property_read_string_array(struct fwnode_handle *fwnode,
+					       const char *propname,
+					       const char **val, size_t nval)
+{
+	if (is_of_node(fwnode))
+		return val ?
+			of_property_read_string_array(to_of_node(fwnode),
+						      propname, val, nval) :
+			of_property_count_strings(to_of_node(fwnode), propname);
+	else if (is_acpi_node(fwnode))
+		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
+					   val, nval);
+	else if (is_pset_node(fwnode))
+		return val ?
+			pset_prop_read_string_array(to_pset_node(fwnode),
+						    propname, val, nval) :
+			pset_prop_count_elems_of_size(to_pset_node(fwnode),
+						      propname,
+						      sizeof(const char *));
+	return -ENXIO;
+}
+
+static int __fwnode_property_read_string(struct fwnode_handle *fwnode,
+					 const char *propname, const char **val)
+{
+	if (is_of_node(fwnode))
+		return of_property_read_string(to_of_node(fwnode), propname, val);
+	else if (is_acpi_node(fwnode))
+		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
+					   val, 1);
+	else if (is_pset_node(fwnode))
+		return pset_prop_read_string(to_pset_node(fwnode), propname, val);
+	return -ENXIO;
+}
+
 /**
  * fwnode_property_read_string_array - return string array property of a node
  * @fwnode: Firmware node to get the property of
@@ -549,22 +606,13 @@ int fwnode_property_read_string_array(struct fwnode_handle *fwnode,
 				      const char *propname, const char **val,
 				      size_t nval)
 {
-	if (is_of_node(fwnode))
-		return val ?
-			of_property_read_string_array(to_of_node(fwnode),
-						      propname, val, nval) :
-			of_property_count_strings(to_of_node(fwnode), propname);
-	else if (is_acpi_node(fwnode))
-		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
-					   val, nval);
-	else if (is_pset_node(fwnode))
-		return val ?
-			pset_prop_read_string_array(to_pset_node(fwnode),
-						    propname, val, nval) :
-			pset_prop_count_elems_of_size(to_pset_node(fwnode),
-						      propname,
-						      sizeof(const char *));
-	return -ENXIO;
+	int ret;
+
+	ret = __fwnode_property_read_string_array(fwnode, propname, val, nval);
+	if (ret == -EINVAL && fwnode->secondary)
+		ret = __fwnode_property_read_string_array(fwnode->secondary,
+							  propname, val, nval);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
 
@@ -586,14 +634,13 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
 int fwnode_property_read_string(struct fwnode_handle *fwnode,
 				const char *propname, const char **val)
 {
-	if (is_of_node(fwnode))
-		return of_property_read_string(to_of_node(fwnode), propname, val);
-	else if (is_acpi_node(fwnode))
-		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
-					   val, 1);
-	else if (is_pset_node(fwnode))
-		return pset_prop_read_string(to_pset_node(fwnode), propname, val);
-	return -ENXIO;
+	int ret;
+
+	ret = __fwnode_property_read_string(fwnode, propname, val);
+	if (ret == -EINVAL && fwnode->secondary)
+		ret = __fwnode_property_read_string(fwnode->secondary,
+						    propname, val);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string);
 
-- 
2.6.2
