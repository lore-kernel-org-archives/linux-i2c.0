From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH v2 1/1] i2c: designware-pcidrv: Add 10bit address feature to medfield/merrifield
Date: Wed, 30 Nov 2016 17:34:15 +0100
Message-ID: <1480523655-10461-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:58621 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751606AbcK3Qe1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 30 Nov 2016 11:34:27 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-i2c@vger.kernel.org

Both Merrifield TRM and Medfield TRM state:
"Both 7-bit and 10-bit addressing modes are supported."

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes in v2:
* Fix typo in commit message

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
