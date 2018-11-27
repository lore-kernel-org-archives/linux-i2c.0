From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 08/13] platform/x86: i2c-multi-instantiate: Count I2cSerialBus() resources
Date: Tue, 27 Nov 2018 17:37:23 +0200
Message-ID: <20181127153728.47866-9-andriy.shevchenko@linux.intel.com>
References: <20181127153728.47866-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127153728.47866-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Instead of relying on hard coded and thus expected number of I2C clients,
count the real amount provided by firmware.

This allows to support non-fixed amount of the slaves.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/i2c-multi-instantiate.c | 41 ++++++++++++++++++--
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
index 18928e4ede7f..f82f0b36f38d 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/types.h>
 
 struct i2c_inst_data {
 	const char *type;
@@ -23,6 +24,31 @@ struct i2c_multi_inst_data {
 	struct i2c_client *clients[0];
 };
 
+static int i2c_multi_inst_count(struct acpi_resource *ares, void *data)
+{
+	struct acpi_resource_i2c_serialbus *sb;
+	int *count = data;
+
+	if (i2c_acpi_get_i2c_resource(ares, &sb))
+		*count = *count + 1;
+
+	return 1;
+}
+
+static int i2c_multi_inst_count_resources(struct acpi_device *adev)
+{
+	LIST_HEAD(r);
+	int count = 0;
+	int ret;
+
+	ret = acpi_dev_get_resources(adev, &r, i2c_multi_inst_count, &count);
+	if (ret < 0)
+		return ret;
+
+	acpi_dev_free_resource_list(&r);
+	return count;
+}
+
 static int i2c_multi_inst_probe(struct platform_device *pdev)
 {
 	struct i2c_multi_inst_data *multi;
@@ -44,17 +70,19 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 	adev = ACPI_COMPANION(dev);
 
 	/* Count number of clients to instantiate */
-	for (i = 0; inst_data[i].type; i++) {}
+	ret = i2c_multi_inst_count_resources(adev);
+	if (ret < 0)
+		return ret;
 
 	multi = devm_kmalloc(dev,
-			offsetof(struct i2c_multi_inst_data, clients[i]),
+			offsetof(struct i2c_multi_inst_data, clients[ret]),
 			GFP_KERNEL);
 	if (!multi)
 		return -ENOMEM;
 
-	multi->num_clients = i;
+	multi->num_clients = ret;
 
-	for (i = 0; i < multi->num_clients; i++) {
+	for (i = 0; i < multi->num_clients && inst_data[i].type; i++) {
 		memset(&board_info, 0, sizeof(board_info));
 		strlcpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
 		snprintf(name, sizeof(name), "%s-%s", match->id,
@@ -83,6 +111,11 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 			goto error;
 		}
 	}
+	if (i < multi->num_clients) {
+		dev_err(dev, "Error finding driver, idx %d\n", i);
+		ret = -ENODEV;
+		goto error;
+	}
 
 	platform_set_drvdata(pdev, multi);
 	return 0;
-- 
2.19.2
