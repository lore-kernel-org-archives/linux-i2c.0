From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 11/15] platform/x86: i2c-multi-instantiate: Distinguish IRQ resource type
Date: Wed, 28 Nov 2018 13:30:20 +0200
Message-ID: <20181128113024.42126-12-andriy.shevchenko@linux.intel.com>
References: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

As a preparatory patch switch the driver to distinguish IRQ resource type.
For now, only GpioInt() is supported.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/i2c-multi-instantiate.c | 27 +++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
index d99bbaed0ca2..99db3e336718 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -14,9 +15,14 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
+#define IRQ_RESOURCE_TYPE	GENMASK(1, 0)
+#define IRQ_RESOURCE_NONE	0
+#define IRQ_RESOURCE_GPIO	1
+
 struct i2c_inst_data {
 	const char *type;
-	int gpio_irq_idx;
+	unsigned int flags;
+	int irq_idx;
 };
 
 struct i2c_multi_inst_data {
@@ -88,16 +94,19 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 		snprintf(name, sizeof(name), "%s-%s", match->id,
 			 inst_data[i].type);
 		board_info.dev_name = name;
-		board_info.irq = 0;
-		if (inst_data[i].gpio_irq_idx != -1) {
-			ret = acpi_dev_gpio_irq_get(adev,
-						    inst_data[i].gpio_irq_idx);
+		switch (inst_data[i].flags & IRQ_RESOURCE_TYPE) {
+		case IRQ_RESOURCE_GPIO:
+			ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
 			if (ret < 0) {
 				dev_err(dev, "Error requesting irq at index %d: %d\n",
-					inst_data[i].gpio_irq_idx, ret);
+					inst_data[i].irq_idx, ret);
 				goto error;
 			}
 			board_info.irq = ret;
+			break;
+		default:
+			board_info.irq = 0;
+			break;
 		}
 		multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
 		if (IS_ERR(multi->clients[i])) {
@@ -135,9 +144,9 @@ static int i2c_multi_inst_remove(struct platform_device *pdev)
 }
 
 static const struct i2c_inst_data bsg1160_data[]  = {
-	{ "bmc150_accel", 0 },
-	{ "bmc150_magn", -1 },
-	{ "bmg160", -1 },
+	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
+	{ "bmc150_magn" },
+	{ "bmg160" },
 	{}
 };
 
-- 
2.19.2
