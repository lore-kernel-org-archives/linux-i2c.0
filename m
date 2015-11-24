From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 09/13] mfd: core: propagate device properties to sub devices drivers
Date: Tue, 24 Nov 2015 12:22:55 +0200
Message-ID: <1448360579-79260-10-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

In the similar way like we do for the platform data we propagate the device
properties. For example, in case of Intel LPSS drivers we may provide a
specific property to tell the actual device driver an additional information
such as platform name.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/mfd-core.c   | 3 +++
 include/linux/mfd/core.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 60b60dc..ec00f6f 100644
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
@@ -192,6 +193,8 @@ static int mfd_add_device(struct device *parent, int id,
 			goto fail_alias;
 	}
 
+	device_add_property_set(&pdev->dev, cell->pset);
+
 	ret = mfd_platform_add_cell(pdev, cell, usage_count);
 	if (ret)
 		goto fail_alias;
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 27dac3f..0c62f17 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -15,6 +15,7 @@
 #define MFD_CORE_H
 
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 struct irq_domain;
 
@@ -44,6 +45,10 @@ struct mfd_cell {
 	/* platform data passed to the sub devices drivers */
 	void			*platform_data;
 	size_t			pdata_size;
+
+	/* device properties passed to the sub devices drivers */
+	struct property_set	*pset;
+
 	/*
 	 * Device Tree compatible string
 	 * See: Documentation/devicetree/usage-model.txt Chapter 2.2 for details
-- 
2.6.2
