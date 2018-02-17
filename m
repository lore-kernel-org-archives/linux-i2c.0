From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] i2c: designware: Consider SCL GPIO optional
Date: Sat, 17 Feb 2018 22:58:43 +0200
Message-ID: <20180217205843.17680-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5746 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbeBQU6s (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 17 Feb 2018 15:58:48 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tim Sander <tim@krieglstein.org>

GPIO library can return -ENOSYS for the failed request.
Instead of failing ->probe() in this case override error code to 0.

Fixes: ca382f5b38f3 ("i2c: designware: add i2c gpio recovery option")
Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Tim Sander <tim@krieglstein.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index ae691884d071..5778908351a2 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -644,7 +644,7 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
 	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio)) {
 		r = PTR_ERR(gpio);
-		if (r == -ENOENT)
+		if (r == -ENOENT || r == -ENOSYS)
 			return 0;
 		return r;
 	}
-- 
2.15.1
