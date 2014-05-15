From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/4] i2c: designware: Disable device on system suspend
Date: Thu, 15 May 2014 17:37:22 +0300
Message-ID: <1400164644-3222-3-git-send-email-mika.westerberg@linux.intel.com>
References: <1400164644-3222-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400164644-3222-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Yao Jin <yao.jin@intel.com>, Aubrey Li <aubrey.li@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Userspace can initiate system suspend on arbitrary times which means that
device drivers must make sure that their device gets quiesced before system
suspend is entered. Therefore disable the I2C host controller in the driver
system suspend hook.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 9c7802614342..f72102f389c5 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -253,6 +253,7 @@ static int dw_i2c_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
+	i2c_dw_disable(i_dev);
 	clk_disable_unprepare(i_dev->clk);
 
 	return 0;
-- 
2.0.0.rc2
