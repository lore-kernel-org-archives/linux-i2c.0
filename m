From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 02/14] i2c: mv64xxx: simplify optional reset handling
Date: Wed, 15 Mar 2017 12:31:34 +0100
Message-ID: <20170315113134.13655-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to return errors from devm_reset_control_get_optional and to
call reset_control_(de)assert unconditionally.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index a50bd6891e27b..cf737ec8563b8 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -823,13 +823,10 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 
 	drv_data->rstc = devm_reset_control_get_optional(dev, NULL);
 	if (IS_ERR(drv_data->rstc)) {
-		if (PTR_ERR(drv_data->rstc) == -EPROBE_DEFER) {
-			rc = -EPROBE_DEFER;
-			goto out;
-		}
-	} else {
-		reset_control_deassert(drv_data->rstc);
+		rc = PTR_ERR(drv_data->rstc);
+		goto out;
 	}
+	reset_control_deassert(drv_data->rstc);
 
 	/* Its not yet defined how timeouts will be specified in device tree.
 	 * So hard code the value to 1 second.
@@ -951,8 +948,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 exit_free_irq:
 	free_irq(drv_data->irq, drv_data);
 exit_reset:
-	if (!IS_ERR_OR_NULL(drv_data->rstc))
-		reset_control_assert(drv_data->rstc);
+	reset_control_assert(drv_data->rstc);
 exit_clk:
 	/* Not all platforms have a clk */
 	if (!IS_ERR(drv_data->clk))
@@ -968,8 +964,7 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 
 	i2c_del_adapter(&drv_data->adapter);
 	free_irq(drv_data->irq, drv_data);
-	if (!IS_ERR_OR_NULL(drv_data->rstc))
-		reset_control_assert(drv_data->rstc);
+	reset_control_assert(drv_data->rstc);
 	/* Not all platforms have a clk */
 	if (!IS_ERR(drv_data->clk))
 		clk_disable_unprepare(drv_data->clk);
-- 
2.11.0
