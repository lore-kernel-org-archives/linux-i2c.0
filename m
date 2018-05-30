From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] i2c: qup: fix building without CONFIG_ACPI
Date: Wed, 30 May 2018 23:31:49 +0200
Message-ID: <20180530213201.550467-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Abhishek Sahu <absahu@codeaurora.org>, Austin Christ <austinwc@codeaurora.org>, Sricharan R <sricharan@codeaurora.org>, Bhumika Goyal <bhumirks@gmail.com>, Peter Rosin <peda@axentia.se>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The added Centriq support broke compilation with CONFIG_ACPI disabled:

drivers/i2c/busses/i2c-qup.c: In function 'qup_i2c_probe':
drivers/i2c/busses/i2c-qup.c:1707:25: error: 'qup_i2c_acpi_match' undeclared (first use in this function); did you mean 'qup_i2c_recv_data'?

This fixes it by removing the extraneous #ifdef. All ACPI specific
code will be dropped implicitly when that option is disabled, but
the compiler first needs to see it.

Fixes: 902a91a02bdf ("i2c: qup: add probe path for Centriq ACPI devices")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/i2c/busses/i2c-qup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 4f793b5d0c3b..9cfcc0473227 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1657,13 +1657,11 @@ static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
 	clk_disable_unprepare(qup->pclk);
 }
 
-#if IS_ENABLED(CONFIG_ACPI)
 static const struct acpi_device_id qup_i2c_acpi_match[] = {
 	{ "QCOM8010"},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, qup_i2c_acpi_match);
-#endif
 
 static int qup_i2c_probe(struct platform_device *pdev)
 {
-- 
2.9.0
