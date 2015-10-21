From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: designware: Fix build error when !CONFIG_PM_SLEEP
Date: Wed, 21 Oct 2015 10:09:17 +0300
Message-ID: <1445411357-934-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49407 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbbJUHJ1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 21 Oct 2015 03:09:27 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Commit 6ad6fde3970c ("i2c: designware: Rename platform driver probe and PM
functions") introduced "'dw_i2c_plat_prepare' undeclared here" and
"'dw_i2c_plat_complete' undeclared here" build errors when CONFIG_PM_SLEEP
is not set.

Fix this by renaming NULL defined dw_i2c_prepare and dw_i2c_complete PM
hooks to dw_i2c_plat_prepare and dw_i2c_plat_complete since this was
obviously missing from the commit.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index f6b252a8ffd1..eb55760ccd9f 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -307,8 +307,8 @@ static void dw_i2c_plat_complete(struct device *dev)
 		pm_request_resume(dev);
 }
 #else
-#define dw_i2c_prepare	NULL
-#define dw_i2c_complete	NULL
+#define dw_i2c_plat_prepare	NULL
+#define dw_i2c_plat_complete	NULL
 #endif
 
 #ifdef CONFIG_PM
-- 
2.6.1
