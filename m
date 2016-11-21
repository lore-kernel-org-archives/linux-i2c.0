From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/1] i2c: designware: Consolidate default functionality bits
Date: Mon, 21 Nov 2016 11:43:20 +0100
Message-ID: <1479725000-22513-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:49464 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752075AbcKUKng (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 21 Nov 2016 05:43:36 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-i2c@vger.kernel.org

Use a common place for default functionality bits for both platform
and pci driver.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
This patch requires commit c3ae106050b9 ("i2c: designware: Implement support
for SMBus block read and write") which is included in current i2c/for-next
branch.
BTW: Do merrifield and medfield actually not support 10bit addressing?

 drivers/i2c/busses/i2c-designware-core.h    | 8 ++++++++
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 9 +--------
 drivers/i2c/busses/i2c-designware-platdrv.c | 9 +--------
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 0d44d2a..26250b4 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -22,6 +22,14 @@
  *
  */
 
+#include <linux/i2c.h>
+
+#define DW_IC_DEFAULT_FUNCTIONALITY (I2C_FUNC_I2C |			\
+					I2C_FUNC_SMBUS_BYTE |		\
+					I2C_FUNC_SMBUS_BYTE_DATA |	\
+					I2C_FUNC_SMBUS_WORD_DATA |	\
+					I2C_FUNC_SMBUS_BLOCK_DATA |	\
+					I2C_FUNC_SMBUS_I2C_BLOCK)
 
 #define DW_IC_CON_MASTER		0x1
 #define DW_IC_CON_SPEED_STD		0x2
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 8ffe2da..300802e7 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -71,13 +71,6 @@ struct dw_pci_controller {
 				DW_IC_CON_SLAVE_DISABLE |	\
 				DW_IC_CON_RESTART_EN)
 
-#define DW_DEFAULT_FUNCTIONALITY (I2C_FUNC_I2C |			\
-					I2C_FUNC_SMBUS_BYTE |		\
-					I2C_FUNC_SMBUS_BYTE_DATA |	\
-					I2C_FUNC_SMBUS_WORD_DATA |	\
-					I2C_FUNC_SMBUS_BLOCK_DATA |	\
-					I2C_FUNC_SMBUS_I2C_BLOCK)
-
 /* Merrifield HCNT/LCNT/SDA hold time */
 static struct dw_scl_sda_cfg mrfld_config = {
 	.ss_hcnt = 0x2f8,
@@ -250,7 +243,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	}
 
 	dev->functionality = controller->functionality |
-				DW_DEFAULT_FUNCTIONALITY;
+				DW_IC_DEFAULT_FUNCTIONALITY;
 
 	dev->master_cfg = controller->bus_cfg;
 	if (controller->scl_sda_cfg) {
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 7429dfa..08153ea 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -219,14 +219,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	dev->functionality =
-		I2C_FUNC_I2C |
-		I2C_FUNC_10BIT_ADDR |
-		I2C_FUNC_SMBUS_BYTE |
-		I2C_FUNC_SMBUS_BYTE_DATA |
-		I2C_FUNC_SMBUS_WORD_DATA |
-		I2C_FUNC_SMBUS_BLOCK_DATA |
-		I2C_FUNC_SMBUS_I2C_BLOCK;
+	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
 
 	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 			  DW_IC_CON_RESTART_EN;
-- 
2.7.3
