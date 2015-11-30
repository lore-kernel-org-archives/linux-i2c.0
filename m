From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 12/16] mfd: core: propagate device properties to sub devices drivers
Date: Mon, 30 Nov 2015 17:11:40 +0200
Message-ID: <1448896304-87928-13-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

In the similar way like we do for the platform data we propagate the device
properties. For example, in case of Intel LPSS drivers we may provide a
specific property to tell the actual device driver an additional information
such as platform name.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/mfd-core.c   | 7 +++++++
 include/linux/mfd/core.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 60b60dc..88bd1b1 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
+#include <linux/property.h>
 #include <linux/mfd/core.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -192,6 +193,12 @@ static int mfd_add_device(struct device *parent, int id,
 			goto fail_alias;
 	}
 
+	if (cell->pset) {
+		ret = platform_device_add_properties(pdev, cell->pset);
+		if (ret)
+			goto fail_alias;
+	}
+
 	ret = mfd_platform_add_cell(pdev, cell, usage_count);
 	if (ret)
 		goto fail_alias;
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 27dac3f..bc6f7e0 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 
 struct irq_domain;
+struct property_set;
 
 /* Matches ACPI PNP id, either _HID or _CID, or ACPI _ADR */
 struct mfd_cell_acpi_match {
@@ -44,6 +45,10 @@ struct mfd_cell {
 	/* platform data passed to the sub devices drivers */
 	void			*platform_data;
 	size_t			pdata_size;
+
+	/* device properties passed to the sub devices drivers */
+	const struct property_set *pset;
+
 	/*
 	 * Device Tree compatible string
 	 * See: Documentation/devicetree/usage-model.txt Chapter 2.2 for details
-- 
2.6.2
