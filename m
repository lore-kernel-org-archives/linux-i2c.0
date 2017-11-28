From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 2/2] i2c: designware: fix building driver as module
Date: Tue, 28 Nov 2017 11:09:11 +0800
Message-ID: <1511838551-4035-3-git-send-email-preid@electromag.com.au>
References: <1511838551-4035-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:52876 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751630AbdK1DJX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Nov 2017 22:09:23 -0500
In-Reply-To: <1511838551-4035-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, preid@electromag.com.au, linux-i2c@vger.kernel.org, sfr@canb.auug.org.au

The designware core and platform are built as separate modules.
Export i2c_dw_prepare_clk() so it can be used by the platform
driver.

Fixes commit a34a0b6da22540d19e57
("i2c: designware: move i2c_dw_plat_prepare_clk to common")

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/busses/i2c-designware-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 6b82809..27ebd90 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -197,6 +197,7 @@ int i2c_dw_prepare_clk(struct dw_i2c_dev *dev, bool prepare)
 	clk_disable_unprepare(dev->clk);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(i2c_dw_prepare_clk);
 
 int i2c_dw_acquire_lock(struct dw_i2c_dev *dev)
 {
-- 
1.8.3.1
