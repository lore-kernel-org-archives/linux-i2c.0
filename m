From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: designware: Disable runtime PM in case i2c_dw_probe() fails
Date: Wed, 21 Oct 2015 17:21:46 +0300
Message-ID: <1445437306-9268-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49684 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbbJUOWZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 21 Oct 2015 10:22:25 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Call to pm_runtime_disable() got dropped while handling the merge conflict
between commit 36d48fb5766a ("i2c: designware-platdrv: enable RuntimePM
before registering to the core") and commit d80d134182ba ("i2c: designware:
Move common probe code into i2c_dw_probe()").

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index eb55760ccd9f..8fd9d4a18bd5 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -261,8 +261,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	}
 
 	r = i2c_dw_probe(dev);
-	if (r)
+	if (r) {
+		pm_runtime_disable(&pdev->dev);
 		return r;
+	}
 
 	return 0;
 }
-- 
2.6.1
