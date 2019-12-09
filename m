From: shubhrajyoti.datta@gmail.com
Subject: [PATCH 2/4] i2c: cadence: Fix power management order of operations
Date: Mon,  9 Dec 2019 16:10:50 +0530
Message-ID: <1575888052-20447-2-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1575888052-20447-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1575888052-20447-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: michal.simek@xilinx.com, Topi Kuutela <topi.kuutela@gmail.com>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

From: Topi Kuutela <topi.kuutela@gmail.com>

E.g. pm_runtime_set_active must be called while the power
management system is disabled. Fixes extra hanging clk_enable.

Signed-off-by: Topi Kuutela <topi.kuutela@gmail.com>
Acked-by: Sören Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/i2c/busses/i2c-cadence.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 7b989a2..08427e9 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -932,10 +932,10 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		dev_err(&pdev->dev, "Unable to enable clock.\n");
 
-	pm_runtime_enable(id->dev);
 	pm_runtime_set_autosuspend_delay(id->dev, CNDS_I2C_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(id->dev);
 	pm_runtime_set_active(id->dev);
+	pm_runtime_enable(id->dev);
 
 	id->clk_rate_change_nb.notifier_call = cdns_i2c_clk_notifier_cb;
 	if (clk_notifier_register(id->clk, &id->clk_rate_change_nb))
@@ -984,8 +984,8 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 
 err_clk_dis:
 	clk_disable_unprepare(id->clk);
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	return ret;
 }
 
@@ -1001,10 +1001,13 @@ static int cdns_i2c_remove(struct platform_device *pdev)
 {
 	struct cdns_i2c *id = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+
 	i2c_del_adapter(&id->adap);
 	clk_notifier_unregister(id->clk, &id->clk_rate_change_nb);
 	clk_disable_unprepare(id->clk);
-	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
2.1.1
