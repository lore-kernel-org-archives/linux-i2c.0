From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/2] i2c: designware: Print clock freq on invalid clock freq error
Date: Mon, 10 Jul 2017 20:45:39 +0200
Message-ID: <20170710184540.15119-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753245AbdGJSpo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 10 Jul 2017 14:45:44 -0400
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
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index d1263b82d646..4a3a7eda978b 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -275,7 +275,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (dev->clk_freq != 100000 && dev->clk_freq != 400000
 	    && dev->clk_freq != 1000000 && dev->clk_freq != 3400000) {
 		dev_err(&pdev->dev,
-			"Only 100kHz, 400kHz, 1MHz and 3.4MHz supported");
+			"%d Hz is unsupported, only 100kHz, 400kHz, 1MHz and 3.4MHz are supported\n",
+			dev->clk_freq);
 		r = -EINVAL;
 		goto exit_reset;
 	}
-- 
2.13.0
