From: Ken Xue <Ken.Xue@amd.com>
Subject: [PATCH 2/2] i2c: designware: remove freq definition for "AMD0010"
 in acpi_device_id
Date: Tue, 20 Oct 2015 14:39:17 +0800
Message-ID: <1445323157.3380.26.camel@kxue-X58A-UD3R>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1on0078.outbound.protection.outlook.com ([157.56.110.78]:60224
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751428AbbJTHAh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 03:00:37 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: mika.westerberg@linux.intel.com, baruch@tkos.co.il
Cc: SPG_Linux_Kernel@amd.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Now, AMD ACPI devices can be reworked by APD which is similar to intel
lpss. And the clkdev for "AMD0010" can be registered in APD. So, try
to remove freq definition from id->driver_data for "AMD0010".

Make "AMD0010" look like other ones.

Signed-off-by: Ken Xue <Ken.Xue@amd.com>
Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 9ee1fc6..c8acbff 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -125,7 +125,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "INT3433", 0 },
 	{ "80860F41", 0 },
 	{ "808622C1", 0 },
-	{ "AMD0010", 133 * 1000 * 1000 },
+	{ "AMD0010", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
-- 
1.9.1
