From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/1] i2c: designware-pcidrv: Add 10bit address feature to medfield/merrifield
Date: Wed, 30 Nov 2016 15:48:30 +0100
Message-ID: <1480517310-28401-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:60155 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932454AbcK3Ost (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 30 Nov 2016 09:48:49 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-i2c@vger.kernel.org

Both Merrifield TRM and Medfiel TRM state:
"Both 7-bit and 10-bit addressing modes are supported."

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 300802e7..d6423cf 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -141,6 +141,7 @@ static struct dw_pci_controller dw_pci_controllers[] = {
 		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 32,
 		.rx_fifo_depth = 32,
+		.functionality = I2C_FUNC_10BIT_ADDR,
 		.clk_khz      = 25000,
 		.setup = mfld_setup,
 	},
@@ -149,6 +150,7 @@ static struct dw_pci_controller dw_pci_controllers[] = {
 		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 64,
 		.rx_fifo_depth = 64,
+		.functionality = I2C_FUNC_10BIT_ADDR,
 		.scl_sda_cfg = &mrfld_config,
 		.setup = mrfld_setup,
 	},
-- 
2.7.3
