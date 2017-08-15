From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] i2c: designware: Remove needless pm_runtime_put_noidle() call
Date: Tue, 15 Aug 2017 17:34:44 +0300
Message-ID: <20170815143445.26167-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7639 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751989AbdHOOkw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 15 Aug 2017 10:40:52 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Luis Oliveira <Luis.Oliveira@synopsys.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

I guess pm_runtime_put_noidle() call in i2c_dw_probe_slave() was copied
by accident from similar master mode adapter registration code. It is
unbalanced due missing pm_runtime_get_noresume() but harmless since it
doesn't decrease dev->power.usage_count below zero.

In theory we can hit similar needless runtime suspend/resume cycle
during slave mode adapter registration that was happening when
registering the master mode adapter. See commit cd998ded5c12 ("i2c:
designware: Prevent runtime suspend during adapter registration").

However, since we are slave, we can consider it as a wrong configuration
if we have other slaves attached under this adapter and can omit the
pm_runtime_get_noresume()/pm_runtime_put_noidle() calls for simplicity.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-slave.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 64c7c5e337b9..bb8f738cab14 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -382,7 +382,6 @@ int i2c_dw_probe_slave(struct dw_i2c_dev *dev)
 	ret = i2c_add_numbered_adapter(adap);
 	if (ret)
 		dev_err(dev->dev, "failure adding adapter: %d\n", ret);
-	pm_runtime_put_noidle(dev->dev);
 
 	return ret;
 }
-- 
2.14.1
