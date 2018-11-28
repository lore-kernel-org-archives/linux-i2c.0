From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 15/15] iio: inv_mpu6050: Use i2c_acpi_get_i2c_resource() helper
Date: Wed, 28 Nov 2018 13:30:24 +0200
Message-ID: <20181128113024.42126-16-andriy.shevchenko@linux.intel.com>
References: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

ACPI provides a generic helper to get I2C Serial Bus resources.
Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index d78a10403bac..a961b5a06fe6 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -91,18 +91,14 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 
 static int acpi_i2c_check_resource(struct acpi_resource *ares, void *data)
 {
+	struct acpi_resource_i2c_serialbus *sb;
 	u32 *addr = data;
 
-	if (ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
-		struct acpi_resource_i2c_serialbus *sb;
-
-		sb = &ares->data.i2c_serial_bus;
-		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_I2C) {
-			if (*addr)
-				*addr |= (sb->slave_address << 16);
-			else
-				*addr = sb->slave_address;
-		}
+	if (i2c_acpi_get_i2c_resource(ares, &sb)) {
+		if (*addr)
+			*addr |= (sb->slave_address << 16);
+		else
+			*addr = sb->slave_address;
 	}
 
 	/* Tell the ACPI core that we already copied this address */
-- 
2.19.2
