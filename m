From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 1/2] i2c: designware: Print clock freq on invalid clock freq error
Date: Thu, 13 Jul 2017 15:45:01 +0200
Message-ID: <20170713134502.10816-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbdGMNpH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 13 Jul 2017 09:45:07 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org

When we refuse to probe due to an invalid clock frequency, log
the frequency which is causing this error.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Also fix the message missing a \n at the end
Changes in v3:
-Rebase on latest upstream master (adjust for s/r/ret/)
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 2ea6d0d25a01..d139b156f9c9 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -319,7 +319,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (dev->clk_freq != 100000 && dev->clk_freq != 400000
 	    && dev->clk_freq != 1000000 && dev->clk_freq != 3400000) {
 		dev_err(&pdev->dev,
-			"Only 100kHz, 400kHz, 1MHz and 3.4MHz supported");
+			"%d Hz is unsupported, only 100kHz, 400kHz, 1MHz and 3.4MHz are supported\n",
+			dev->clk_freq);
 		ret = -EINVAL;
 		goto exit_reset;
 	}
-- 
2.13.0
