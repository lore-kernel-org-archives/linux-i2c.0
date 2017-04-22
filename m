From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/2] i2c: designware: Add ACPI HID for Hisilicon Hip07/08 I2C controller
Date: Sat, 22 Apr 2017 11:23:44 +0800
Message-ID: <1492831424-40581-2-git-send-email-guohanjun@huawei.com>
References: <1492831424-40581-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1492831424-40581-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linuxarm@huawei.com, wangkefeng.wang@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-i2c@vger.kernel.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Add ACPI HID HISI02A1 and HISI02A2 for Hisilicon Hip07/08,
which have different clock frequency.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 79c4b4e..90c7c10 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -129,6 +129,8 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	{ "AMDI0010", ACCESS_INTR_MASK },
 	{ "AMDI0510", 0 },
 	{ "APMC0D0F", 0 },
+	{ "HISI02A1", 0 },
+	{ "HISI02A2", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
-- 
1.7.12.4

