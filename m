From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC Patch v0 3/3] iio: Capella cm3218x: smbus alert processing
Date: Wed, 26 Mar 2014 17:42:12 -0700
Message-ID: <1395880932-19124-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1395880932-19124-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395880932-19124-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Added driver alert callback and modified existing polls to the
core calls.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iio/light/cm3218x.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/light/cm3218x.c b/drivers/iio/light/cm3218x.c
index e422f68..774b199 100644
--- a/drivers/iio/light/cm3218x.c
+++ b/drivers/iio/light/cm3218x.c
@@ -23,6 +23,7 @@
 #include <linux/iio/events.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/i2c-smbus.h>
 
 /* Registers Address */
 #define CM3218x_REG_ADDR_CMD		0x00
@@ -130,6 +131,12 @@ static int cm3218x_get_lux(struct cm3218x_chip *chip);
 static int cm3218x_threshold_update(struct cm3218x_chip *chip, int percent);
 static int cm3218x_read_als_it(struct cm3218x_chip *chip, int *val2);
 
+/* alert callback for i2c driver */
+static void cm3218x_alert(struct i2c_client *client, unsigned int flag)
+{
+	dev_err(&client->dev, "SMBUS alert flag %d\n", flag);
+}
+
 /**
  * cm3218x_read_ara() - Read ARA register
  * @cm3218x:	pointer of struct cm3218x.
@@ -142,19 +149,7 @@ static int cm3218x_read_als_it(struct cm3218x_chip *chip, int *val2);
  */
 static int cm3218x_read_ara(struct cm3218x_chip *chip)
 {
-	struct i2c_client *client = chip->client;
-	int status;
-	unsigned short addr;
-
-	addr = client->addr;
-	client->addr = 0x0C;
-	status = i2c_smbus_read_byte(client);
-	client->addr = addr;
-
-	if (status < 0)
-		return -ENODEV;
-
-	return status;
+	return i2c_smbus_ara_poll(chip->client);
 }
 
 /**
@@ -760,6 +755,7 @@ static struct i2c_driver cm3218x_driver = {
 	.id_table	= cm3218x_id,
 	.probe		= cm3218x_probe,
 	.remove		= cm3218x_remove,
+	.alert		= cm3218x_alert,
 };
 
 module_i2c_driver(cm3218x_driver);
-- 
1.8.3.2
