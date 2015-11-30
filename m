From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 01/16] device property: always check for fwnode type
Date: Mon, 30 Nov 2015 17:11:29 +0200
Message-ID: <1448896304-87928-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Currently the property accessors unconditionally fall back to built-in property
set as a last resort. Make this strict and return an error in case the type of
fwnode is unknown.

This is actually a follow up to the commit 4fa7508e9f1c (device property:
Return -ENXIO if there is no suitable FW interface).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 1325ff2..09e488d 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -135,8 +135,9 @@ bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname)
 		return of_property_read_bool(to_of_node(fwnode), propname);
 	else if (is_acpi_node(fwnode))
 		return !acpi_node_prop_get(fwnode, propname, NULL);
-
-	return !!pset_prop_get(to_pset(fwnode), propname);
+	else if (is_pset(fwnode))
+		return !!pset_prop_get(to_pset(fwnode), propname);
+	return false;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_present);
 
@@ -494,9 +495,10 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 	else if (is_acpi_node(fwnode))
 		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
 					   val, 1);
-
-	return pset_prop_read_array(to_pset(fwnode), propname,
-				    DEV_PROP_STRING, val, 1);
+	else if (is_pset(fwnode))
+		return pset_prop_read_array(to_pset(fwnode), propname,
+					    DEV_PROP_STRING, val, 1);
+	return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string);
 
-- 
2.6.2
