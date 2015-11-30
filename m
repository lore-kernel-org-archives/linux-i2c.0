From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 07/16] device property: return -EINVAL when property isn't found in ACPI
Date: Mon, 30 Nov 2015 17:11:35 +0200
Message-ID: <1448896304-87928-8-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Change return code to be in align with OF and built-in device properties error
codes. In particular -EINVAL means property is not found.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 88f4306..2aee416 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -346,7 +346,7 @@ void acpi_free_properties(struct acpi_device *adev)
  *
  * Return: %0 if property with @name has been found (success),
  *         %-EINVAL if the arguments are invalid,
- *         %-ENODATA if the property doesn't exist,
+ *         %-EINVAL if the property doesn't exist,
  *         %-EPROTO if the property value type doesn't match @type.
  */
 static int acpi_data_get_property(struct acpi_device_data *data,
@@ -360,7 +360,7 @@ static int acpi_data_get_property(struct acpi_device_data *data,
 		return -EINVAL;
 
 	if (!data->pointer || !data->properties)
-		return -ENODATA;
+		return -EINVAL;
 
 	properties = data->properties;
 	for (i = 0; i < properties->package.count; i++) {
@@ -375,13 +375,13 @@ static int acpi_data_get_property(struct acpi_device_data *data,
 		if (!strcmp(name, propname->string.pointer)) {
 			if (type != ACPI_TYPE_ANY && propvalue->type != type)
 				return -EPROTO;
-			else if (obj)
+			if (obj)
 				*obj = propvalue;
 
 			return 0;
 		}
 	}
-	return -ENODATA;
+	return -EINVAL;
 }
 
 /**
@@ -439,7 +439,7 @@ int acpi_node_prop_get(struct fwnode_handle *fwnode, const char *propname,
  *
  * Return: %0 if array property (package) with @name has been found (success),
  *         %-EINVAL if the arguments are invalid,
- *         %-ENODATA if the property doesn't exist,
+ *         %-EINVAL if the property doesn't exist,
  *         %-EPROTO if the property is not a package or the type of its elements
  *           doesn't match @type.
  */
-- 
2.6.2
