From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 06/13] device property: improve readability of macros
Date: Tue, 24 Nov 2015 12:22:52 +0200
Message-ID: <1448360579-79260-7-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

There is no functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 28 ++++++++++++++--------------
 include/linux/property.h |  4 ++--
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 3e603c0..c8e9722 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -398,29 +398,29 @@ int device_property_match_string(struct device *dev, const char *propname,
 }
 EXPORT_SYMBOL_GPL(device_property_match_string);
 
-#define OF_DEV_PROP_READ_ARRAY(node, propname, type, val, nval) \
-	(val) ? of_property_read_##type##_array((node), (propname), (val), (nval)) \
+#define OF_DEV_PROP_READ_ARRAY(node, propname, type, val, nval)				\
+	(val) ? of_property_read_##type##_array((node), (propname), (val), (nval))	\
 	      : of_property_count_elems_of_size((node), (propname), sizeof(type))
 
 #define PSET_PROP_READ_ARRAY(node, propname, type, val, nval)				\
 	(val) ? pset_prop_read_##type##_array((node), (propname), (val), (nval))	\
 	      : pset_prop_count_elems_of_size((node), (propname), sizeof(type))
 
-#define FWNODE_PROP_READ_ARRAY(_fwnode_, _propname_, _type_, _proptype_, _val_, _nval_) \
-({ \
-	int _ret_; \
-	if (is_of_node(_fwnode_)) \
-		_ret_ = OF_DEV_PROP_READ_ARRAY(to_of_node(_fwnode_), _propname_, \
-					       _type_, _val_, _nval_); \
-	else if (is_acpi_node(_fwnode_)) \
-		_ret_ = acpi_node_prop_read(_fwnode_, _propname_, _proptype_, \
-					    _val_, _nval_); \
+#define FWNODE_PROP_READ_ARRAY(_fwnode_, _propname_, _type_, _proptype_, _val_, _nval_)	\
+({											\
+	int _ret_;									\
+	if (is_of_node(_fwnode_))							\
+		_ret_ = OF_DEV_PROP_READ_ARRAY(to_of_node(_fwnode_), _propname_,	\
+					       _type_, _val_, _nval_);			\
+	else if (is_acpi_node(_fwnode_))						\
+		_ret_ = acpi_node_prop_read(_fwnode_, _propname_, _proptype_,		\
+					    _val_, _nval_);				\
 	else if (is_pset_node(_fwnode_)) 						\
 		_ret_ = PSET_PROP_READ_ARRAY(to_pset_node(_fwnode_), _propname_,	\
 					     _type_, _val_, _nval_);			\
-	else \
-		_ret_ = -ENXIO; \
-	_ret_; \
+	else										\
+		_ret_ = -ENXIO;								\
+	_ret_;										\
 })
 
 /**
diff --git a/include/linux/property.h b/include/linux/property.h
index 2528a000..e947403 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -73,8 +73,8 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child);
 
-#define device_for_each_child_node(dev, child) \
-	for (child = device_get_next_child_node(dev, NULL); child; \
+#define device_for_each_child_node(dev, child)				\
+	for (child = device_get_next_child_node(dev, NULL); child;	\
 	     child = device_get_next_child_node(dev, child))
 
 void fwnode_handle_put(struct fwnode_handle *fwnode);
-- 
2.6.2
