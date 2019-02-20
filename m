From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH v3 2/2] i2c: designware: Add support for a bus clock
Date: Wed, 20 Feb 2019 15:50:03 +0000
Message-ID: <1550677803-29716-3-git-send-email-gareth.williams.jx@renesas.com>
References: <1550677803-29716-1-git-send-email-gareth.williams.jx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550677803-29716-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org
Cc: Phil Edworthy <phil.edworthy@renesas.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Gareth Williams <gareth.williams.jx@renesas.com>
List-Id: linux-i2c@vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

The Synopsys I2C Controller has a bus clock, but most SoCs hide this away.
However, on some SoCs you need to explicity enable the bus clock in order
to access the registers. Therefore, add support for an optional bus clock.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
v3:
 - busclk renamed to pclk.
 - Added comment with dw_i2c_dev struct definition describing pclk.
 - Added enable rollback of first clock if second fails to enable.
v2:
 - Use new devm_clk_get_optional() function as it simplifies handling when
   the optional clock is not present.
---
 drivers/i2c/busses/i2c-designware-common.c  | 18 ++++++++++++++++--
 drivers/i2c/busses/i2c-designware-core.h    |  2 ++
 drivers/i2c/busses/i2c-designware-platdrv.c |  5 +++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index a473011..5f70078 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -251,13 +251,27 @@ unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
 
 int i2c_dw_prepare_clk(struct dw_i2c_dev *dev, bool prepare)
 {
+	int ret;
+
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
 
-	if (prepare)
-		return clk_prepare_enable(dev->clk);
+	if (prepare) {
+		/* Optional bus clock */
+		ret = clk_prepare_enable(dev->pclk);
+		if (ret)
+			return ret;
+
+		ret = clk_prepare_enable(dev->clk);
+		if (ret)
+			clk_disable_unprepare(dev->pclk);
+
+		return ret;
+	}
 
 	clk_disable_unprepare(dev->clk);
+	clk_disable_unprepare(dev->pclk);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(i2c_dw_prepare_clk);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index b4a0b2b..e88c711 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -177,6 +177,7 @@
  * @base: IO registers pointer
  * @cmd_complete: tx completion indicator
  * @clk: input reference clock
+ * @pclk: clock required to access the registers
  * @slave: represent an I2C slave device
  * @cmd_err: run time hadware error code
  * @msgs: points to an array of messages currently being transferred
@@ -226,6 +227,7 @@ struct dw_i2c_dev {
 	void __iomem		*ext;
 	struct completion	cmd_complete;
 	struct clk		*clk;
+	struct clk		*pclk;
 	struct reset_control	*rst;
 	struct i2c_client		*slave;
 	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 9eaac3b..c550fb2 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -346,6 +346,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	else
 		i2c_dw_configure_master(dev);
 
+	/* Optional bus clock */
+	dev->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
+	if (IS_ERR(dev->pclk))
+		return PTR_ERR(dev->pclk);
+
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!i2c_dw_prepare_clk(dev, true)) {
 		u64 clk_khz;
-- 
2.7.4
