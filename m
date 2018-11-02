From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] i2c: i2c-qcom-geni: Fix runtime PM mismatch with child devices
Date: Fri,  2 Nov 2018 11:35:37 -0700
Message-ID: <20181102183537.72334-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Alok Chauhan <alokc@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

We need to enable runtime PM on this i2c controller before populating
child devices with i2c_add_adapter(). Otherwise, if a child device uses
runtime PM and stays runtime PM enabled we'll get the following warning
at boot.

 Enabling runtime PM for inactive device (a98000.i2c) with active children
 WARNING: CPU: 4 PID: 1 at drivers/base/power/runtime.c:1300 pm_runtime_enable+0xd8/0xf8
 Modules linked in:
 CPU: 4 PID: 1 Comm: swapper/0 Not tainted 4.19.0 #6
 elants_i2c 14-0010: 14-0010 supply vccio not found, using dummy regulator
 pstate: 60c00089 (nZCv daIf +PAN +UAO)
 pc : pm_runtime_enable+0xd8/0xf8
 lr : pm_runtime_enable+0xd8/0xf8
 sp : ffffffc0de257a30
 x29: ffffffc0de257a30 x28: 0000000000061a80
 x27: ffffff9008ea7118
 x26: ffffffc0d718b058
 x25: ffffff9008ea7000 x24: ffffffc0d718a8dc
 x23: ffffffc0d718a8b0 x22: ffffffc0d823dd58
 x21: 0000000000000000 x20: ffffffc0d823dbc8
 x19: ffffffc0d823da90 x18: 000000007f743d9a
 x17: 0000000000000080 x16: 0000000000000003
 x15: 000000000000003f x14: 0720072007200720
 x13: 0720072007200720 x12: 0720072007200720
 x11: 0720072007200720 x10: 0720072007200720
 x9 : 0720072007200720 x8 : 0720072007200720
 x7 : ffffff900816da30 x6 : 0000000000000000
 x5 : 0000000000000080 x4 : 0000000000000003
 x3 : ffffff900816f304 x2 : ffffffc0de248050
 x1 : 25045a74f48a7400 x0 : 25045a74f48a7400
 Call trace:
  pm_runtime_enable+0xd8/0xf8
  geni_i2c_probe+0x440/0x460
  platform_drv_probe+0x74/0xc8
  really_probe+0x1ac/0x35c
  driver_probe_device+0xd4/0x118
  __driver_attach+0xc8/0x118
  bus_for_each_dev+0xac/0xe8
  driver_attach+0x38/0x44
  bus_add_driver+0x15c/0x294
  driver_register+0x13c/0x198
  __platform_driver_register+0x88/0x94
  geni_i2c_driver_init+0x20/0x28
  do_one_initcall+0x250/0x4ec
  kernel_init_freeable+0x6f0/0x7c4
  kernel_init+0x18/0x120
  ret_from_fork+0x10/0x18

Let's move the runtime PM enabling and setup to before we add the
adapter, so that this device can respond to runtime PM requests from
children.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Fixes: 37692de5d523 ("i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 527f55c8c4c7..145eb98ac8b4 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -571,18 +571,19 @@ static int geni_i2c_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
 
-	ret = i2c_add_adapter(&gi2c->adap);
-	if (ret) {
-		dev_err(&pdev->dev, "Error adding i2c adapter %d\n", ret);
-		return ret;
-	}
-
 	gi2c->suspended = 1;
 	pm_runtime_set_suspended(gi2c->se.dev);
 	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
 	pm_runtime_use_autosuspend(gi2c->se.dev);
 	pm_runtime_enable(gi2c->se.dev);
 
+	ret = i2c_add_adapter(&gi2c->adap);
+	if (ret) {
+		dev_err(&pdev->dev, "Error adding i2c adapter %d\n", ret);
+		pm_runtime_disable(gi2c->se.dev);
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
Sent by a computer through tubes
