From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 1/2] ACPI / APD: Add clock frequency for Hisilicon Hip08-Lite I2C controller
Date: Mon, 3 Feb 2020 09:36:06 +0800
Message-ID: <1580693767-5185-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, Sheng Feng <fengsheng5@huawei.com>, Hanjun Guo <guohanjun@huawei.com>
List-Id: linux-i2c@vger.kernel.org

I2C clock frequency of Designware ip for Hisilicon Hip08 Lite
is 125M, use a new ACPI HID to enable it.

Tested-by: Sheng Feng <fengsheng5@huawei.com>
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---

v2:
 - Reverse the order of the two patches suggested by Andy;

 drivers/acpi/acpi_apd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 71511ae..ba2612e 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -161,6 +161,11 @@ static int st_misc_setup(struct apd_private_data *pdata)
 	.fixed_clk_rate = 250000000,
 };
 
+static const struct apd_device_desc hip08_lite_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 125000000,
+};
+
 static const struct apd_device_desc thunderx2_i2c_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 125000000,
@@ -243,6 +248,7 @@ static int acpi_apd_create_device(struct acpi_device *adev,
 	{ "CAV9007",  APD_ADDR(thunderx2_i2c_desc) },
 	{ "HISI02A1", APD_ADDR(hip07_i2c_desc) },
 	{ "HISI02A2", APD_ADDR(hip08_i2c_desc) },
+	{ "HISI02A3", APD_ADDR(hip08_lite_i2c_desc) },
 	{ "HISI0173", APD_ADDR(hip08_spi_desc) },
 	{ "NXP0001", APD_ADDR(nxp_i2c_desc) },
 #endif
-- 
1.7.12.4
