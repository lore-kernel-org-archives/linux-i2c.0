From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] i2c: core: remove unused function
Date: Wed, 31 Jul 2019 12:56:42 +0200
Message-ID: <20190731105642.29664-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
List-Id: linux-i2c@vger.kernel.org

GCC warns taht function 'i2c_acpi_find_match_adapter()' is not used.

../drivers/i2c/i2c-core-acpi.c:347:12: warning:
  ‘i2c_acpi_find_match_adapter’ defined but not used [-Wunused-function]
 static int i2c_acpi_find_match_adapter(struct device *dev, const void *data)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Rework to remove the function 'i2c_acpi_find_match_adapter()'.

Fixes: 00500147cbd3 ("drivers: Introduce device lookup variants by ACPI_COMPANION device")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/i2c/i2c-core-acpi.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index bc80aafb521f..bb6b39fe343a 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -344,17 +344,6 @@ u32 i2c_acpi_find_bus_speed(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(i2c_acpi_find_bus_speed);
 
-static int i2c_acpi_find_match_adapter(struct device *dev, const void *data)
-{
-	struct i2c_adapter *adapter = i2c_verify_adapter(dev);
-
-	if (!adapter)
-		return 0;
-
-	return ACPI_HANDLE(dev) == (acpi_handle)data;
-}
-
-
 struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
 {
 	struct device *dev = bus_find_device_by_acpi_dev(&i2c_bus_type, handle);
-- 
2.20.1
