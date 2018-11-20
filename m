From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 06/15] i2c: acpi: Assign fwnode for devices created via i2c_acpi_new_device()
Date: Tue, 20 Nov 2018 17:59:15 +0200
Message-ID: <20181120155924.10773-7-andriy.shevchenko@linux.intel.com>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

i2c_acpi_new_device() doesn't assign fwnode like it's done, for example,
in i2c_acpi_register_devices() path.

Assign fwnode in i2c_acpi_new_device() as it's done elsewhere.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index af4b5bd5d973..478862abb82a 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -420,6 +420,7 @@ struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 	if (!adapter)
 		return NULL;
 
+	info->fwnode = acpi_fwnode_handle(adev);
 	return i2c_new_device(adapter, info);
 }
 EXPORT_SYMBOL_GPL(i2c_acpi_new_device);
-- 
2.19.1
