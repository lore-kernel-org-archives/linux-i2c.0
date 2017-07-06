From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] i2c: Provide a stub for i2c_detect_slave_mode()
Date: Thu,  6 Jul 2017 20:26:17 +0300
Message-ID: <20170706172617.39817-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:22687 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbdGFR0Z (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 6 Jul 2017 13:26:25 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Luis.Oliveira@synopsys.com, linux-next <linux-next@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Drivers would like to call i2c_detect_slave_mode() even if !I2C_SLAVE.
Give them what they want to,

Otherwise kernel will not compile:
drivers/i2c/busses/i2c-designware-platdrv.c: In function ‘dw_i2c_plat_probe’:
drivers/i2c/busses/i2c-designware-platdrv.c:331:6: error: implicit declaration of function ‘i2c_detect_slave_mode’ [-Werror=implicit-function-declaration]
  if (i2c_detect_slave_mode(&pdev->dev))
      ^~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Fixes: 6e38cf3b4421 ("i2c: designware: Let slave adapter support be optional")
Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/i2c.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 72d0ece70ed3..00ca5b86a753 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -295,6 +295,8 @@ static inline int i2c_slave_event(struct i2c_client *client,
 {
 	return client->slave_cb(client, event, val);
 }
+#else
+static inline bool i2c_detect_slave_mode(struct device *dev) { return false; }
 #endif
 
 /**
-- 
2.11.0
