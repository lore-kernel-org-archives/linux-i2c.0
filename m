From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] i2c: xiic: Make suspend function names consistent
Date: Sat, 10 Mar 2018 09:40:56 -0800
Message-ID: <20180310174056.16572-1-mdf@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, wsa@the-dreams.de, Moritz Fischer <mdf@kernel.org>
List-Id: linux-i2c@vger.kernel.org

Suspend functions seem to have been copied from i2c-cadence driver.
Rename the functions to match the rest of the driver.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/i2c/busses/i2c-xiic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index ae6ed254e01d..c80527816ad0 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -851,7 +851,7 @@ static const struct of_device_id xiic_of_match[] = {
 MODULE_DEVICE_TABLE(of, xiic_of_match);
 #endif
 
-static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
+static int __maybe_unused xiic_i2c_runtime_suspend(struct device *dev)
 {
 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
 
@@ -860,7 +860,7 @@ static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
+static int __maybe_unused xiic_i2c_runtime_resume(struct device *dev)
 {
 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
 	int ret;
@@ -875,8 +875,8 @@ static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops xiic_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(cdns_i2c_runtime_suspend,
-			   cdns_i2c_runtime_resume, NULL)
+	SET_RUNTIME_PM_OPS(xiic_i2c_runtime_suspend,
+			   xiic_i2c_runtime_resume, NULL)
 };
 static struct platform_driver xiic_i2c_driver = {
 	.probe   = xiic_i2c_probe,
-- 
2.16.2
