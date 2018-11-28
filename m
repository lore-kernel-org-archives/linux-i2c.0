From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 08/15] i2c: acpi: Use ACPI_FAILURE instead of !ACPI_SUCCESS
Date: Wed, 28 Nov 2018 13:30:17 +0200
Message-ID: <20181128113024.42126-9-andriy.shevchenko@linux.intel.com>
References: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Convert to use ACPI_FAILURE instead of !ACPI_SUCCESS.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/i2c-core-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 689c0c467e97..8a88586e0902 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -65,7 +65,7 @@ static int i2c_acpi_fill_info(struct acpi_resource *ares, void *data)
 	status = acpi_get_handle(lookup->device_handle,
 				 sb->resource_source.string_ptr,
 				 &lookup->adapter_handle);
-	if (!ACPI_SUCCESS(status))
+	if (ACPI_FAILURE(status))
 		return 1;
 
 	info->addr = sb->slave_address;
-- 
2.19.2
