From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [RFC v2 1/2] acpi: Expose acpi_of_match_device
Date: Thu,  9 Jun 2016 16:06:02 +0300
Message-ID: <66f6a4e6d0eb771f66becf4017eda31df3629341.1465477193.git.leonard.crestez@intel.com>
References: <cover.1465477193.git.leonard.crestez@intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1277 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344AbcFINJD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 09:09:03 -0400
In-Reply-To: <cover.1465477193.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1465477193.git.leonard.crestez@intel.com>
References: <cover.1465477193.git.leonard.crestez@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Daniel Baluta <daniel.baluta@intel.com>

This can be used by device drivers as the equivalent of of_match_device
when they are instantiated through ACPI using devicetree IDs. This is
described in Documentation/acpi/enumeration.txt

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/acpi/bus.c   | 13 +++++++------
 include/linux/acpi.h |  8 ++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 27367d4..b366bb2 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -574,18 +574,18 @@ struct acpi_device *acpi_companion_match(const struct device *dev)
  * identifiers and a _DSD object with the "compatible" property, use that
  * property to match against the given list of identifiers.
  */
-static bool acpi_of_match_device(struct acpi_device *adev,
-				 const struct of_device_id *of_match_table)
+const struct of_device_id* acpi_of_match_device(const struct acpi_device *adev,
+						const struct of_device_id *of_match_table)
 {
 	const union acpi_object *of_compatible, *obj;
 	int i, nval;
 
 	if (!adev)
-		return false;
+		return NULL;
 
 	of_compatible = adev->data.of_compatible;
 	if (!of_match_table || !of_compatible)
-		return false;
+		return NULL;
 
 	if (of_compatible->type == ACPI_TYPE_PACKAGE) {
 		nval = of_compatible->package.count;
@@ -600,11 +600,12 @@ static bool acpi_of_match_device(struct acpi_device *adev,
 
 		for (id = of_match_table; id->compatible[0]; id++)
 			if (!strcasecmp(obj->string.pointer, id->compatible))
-				return true;
+				return id;
 	}
 
-	return false;
+	return NULL;
 }
+EXPORT_SYMBOL(acpi_of_match_device);
 
 static bool __acpi_match_device_cls(const struct acpi_device_id *id,
 				    struct acpi_hardware_id *hwid)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d4a3cb2..0810001 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -524,6 +524,8 @@ extern int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *),
 
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev);
+const struct of_device_id *acpi_of_match_device(const struct acpi_device *dev,
+						const struct of_device_id *ids);
 
 extern bool acpi_driver_match_device(struct device *dev,
 				     const struct device_driver *drv);
@@ -649,6 +651,12 @@ static inline const struct acpi_device_id *acpi_match_device(
 	return NULL;
 }
 
+const struct of_device_id *acpi_of_match_device(const struct acpi_device *dev,
+						const struct acpi_device_id *ids)
+{
+	return NULL;
+}
+
 static inline bool acpi_driver_match_device(struct device *dev,
 					    const struct device_driver *drv)
 {
-- 
2.5.5
