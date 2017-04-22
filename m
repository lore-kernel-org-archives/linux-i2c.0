From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/2] ACPI / APD: Add clock frequency for Hisilicon Hip07/08 I2C controller
Date: Sat, 22 Apr 2017 11:23:43 +0800
Message-ID: <1492831424-40581-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:5452 "EHLO
        dggrg03-dlp.huawei.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1042437AbdDVD3G (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 21 Apr 2017 23:29:06 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linuxarm@huawei.com, wangkefeng.wang@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>

From: Hanjun Guo <hanjun.guo@linaro.org>

I2C clock frequency of Designware ip for Hisilicon Hip07 is 200M,
but 250M for Hip08, use two ACPI IDs to differentiate them.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/acpi_apd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 26696b6..8f57648 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -106,6 +106,16 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 133000000,
 };
+
+static const struct apd_device_desc hip07_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 200000000,
+};
+
+static const struct apd_device_desc hip08_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 250000000,
+};
 #endif
 
 #else
@@ -169,6 +179,8 @@ static int acpi_apd_create_device(struct acpi_device *adev,
 #ifdef CONFIG_ARM64
 	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
 	{ "BRCM900D", APD_ADDR(vulcan_spi_desc) },
+	{ "HISI0A21", APD_ADDR(hip07_i2c_desc) },
+	{ "HISI0A22", APD_ADDR(hip08_i2c_desc) },
 #endif
 	{ }
 };
-- 
1.7.12.4
