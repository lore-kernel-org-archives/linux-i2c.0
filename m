From: Ken Xue <Ken.Xue@amd.com>
Subject: [PATCH 1/2] i2c: designware: register clkdev during acpi device
 configuration
Date: Tue, 20 Oct 2015 14:38:01 +0800
Message-ID: <1445323081.3380.25.camel@kxue-X58A-UD3R>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1on0085.outbound.protection.outlook.com ([157.56.110.85]:51904
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750805AbbJTG7G (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 02:59:06 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: mika.westerberg@linux.intel.com, baruch@tkos.co.il
Cc: SPG_Linux_Kernel@amd.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

DW I2C driver tries to register a clk from id->driver_data as an
alternative way besides intel lpss. But code doesn't register the
clk to clkdev. So, devm_clk_get will fail during probe.

The patch can fix this issue.

Signed-off-by: Ken Xue <Ken.Xue@amd.com>
Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3dd2de3..9ee1fc6 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -27,6 +27,7 @@
 #include <linux/i2c.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/clkdev.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/err.h>
@@ -78,6 +79,7 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 	const struct acpi_device_id *id;
+	struct clk *clk;
 
 	dev->adapter.nr = -1;
 	dev->tx_fifo_depth = 32;
@@ -97,9 +99,11 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	 * id->driver_data.
 	 */
 	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
-	if (id && id->driver_data)
-		clk_register_fixed_rate(&pdev->dev, dev_name(&pdev->dev), NULL,
-					CLK_IS_ROOT, id->driver_data);
+	if (id && id->driver_data) {
+		clk = clk_register_fixed_rate(&pdev->dev, dev_name(&pdev->dev),
+					NULL, CLK_IS_ROOT, id->driver_data);
+		clk_register_clkdev(clk, NULL, dev_name(&pdev->dev));
+	}
 
 	return 0;
 }
-- 
1.9.1
