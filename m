From: Colin King <colin.king@canonical.com>
Subject: [PATCH][i2c-next] i2c: designware: fix spelling mistakes
Date: Thu, 29 Jun 2017 09:22:15 +0100
Message-ID: <20170629082215.9044-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58543 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbdF2IWS (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 29 Jun 2017 04:22:18 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fixes to spelling mistakes in dev_dbg message

"STAUTS" -> "STATUS"
"SLAVE_ACTTVITY" -> "SLAVE_ACTIVITY"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/i2c/busses/i2c-designware-slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 4012c74e9785..100643f47244 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -277,7 +277,7 @@ static int i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
 		return 0;
 
 	dev_dbg(dev->dev,
-		"%#x STAUTS SLAVE_ACTTVITY=%#x : RAW_INTR_STAT=%#x : INTR_STAT=%#x\n",
+		"%#x STATUS SLAVE_ACTIVITY=%#x : RAW_INTR_STAT=%#x : INTR_STAT=%#x\n",
 		enabled, slave_activity, raw_stat, stat);
 
 	if ((stat & DW_IC_INTR_RX_FULL) && (stat & DW_IC_INTR_STOP_DET))
-- 
2.11.0
