From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 2/3] i2c / ACPI: Use 0 to indicate that device does not have interrupt assigned
Date: Wed,  6 May 2015 13:29:07 +0300
Message-ID: <1430908148-201129-3-git-send-email-mika.westerberg@linux.intel.com>
References: <1430908148-201129-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1430908148-201129-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This is the convention used in most parts of the kernel including DT
counterpart of I2C slave enumeration. To make things consistent do the same
for ACPI I2C slave enumeration path as well.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/i2c-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 987c124432c5..c21b3de70234 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -107,7 +107,7 @@ static int acpi_i2c_add_resource(struct acpi_resource *ares, void *data)
 			if (sb->access_mode == ACPI_I2C_10BIT_MODE)
 				info->flags |= I2C_CLIENT_TEN;
 		}
-	} else if (info->irq < 0) {
+	} else if (!info->irq) {
 		struct resource r;
 
 		if (acpi_dev_resource_interrupt(ares, 0, &r))
@@ -134,7 +134,6 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
 
 	memset(&info, 0, sizeof(info));
 	info.fwnode = acpi_fwnode_handle(adev);
-	info.irq = -1;
 
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_resources(adev, &resource_list,
-- 
2.1.4

