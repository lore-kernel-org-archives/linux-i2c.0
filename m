From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH v2 2/2] i2c: designware: Add support for a bus clock
Date: Tue, 19 Feb 2019 15:10:42 +0000
Message-ID: <1550589042-11096-3-git-send-email-gareth.williams.jx@renesas.com>
References: <1550589042-11096-1-git-send-email-gareth.williams.jx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550589042-11096-1-git-send-email-gareth.williams.jx@renesas.com>
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
v2:
 - Use new devm_clk_get_optional() function as it simplifies handling when
   the optional clock is not present.
---
 drivers/i2c/busses/i2c-designware-common.c  | 12 +++++++++++-
 drivers/i2c/busses/i2c-designware-core.h    |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c |  5 +++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index a473011..febcea6 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -251,13 +251,23 @@ unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
 
 int i2c_dw_prepare_clk(struct dw_i2c_dev *dev, bool prepare)
 {
+	int ret;
+
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
 
-	if (prepare)
+	if (prepare) {
+		/* Optional bus clock */
+		ret = clk_prepare_enable(dev->busclk);
+		if (ret)
+			return ret;
+
 		return clk_prepare_enable(dev->clk);
+	}
 
 	clk_disable_unprepare(dev->clk);
+	clk_disable_unprepare(dev->busclk);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(i2c_dw_prepare_clk);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index b4a0b2b..9388ae3 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -226,6 +226,7 @@ struct dw_i2c_dev {
 	void __iomem		*ext;
 	struct completion	cmd_complete;
 	struct clk		*clk;
+	struct clk		*busclk;
 	struct reset_control	*rst;
 	struct i2c_client		*slave;
 	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 9eaac3b..fbaa6aa 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -346,6 +346,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	else
 		i2c_dw_configure_master(dev);
 
+	/* Optional bus clock */
+	dev->busclk = devm_clk_get_optional(&pdev->dev, "bus");
+	if (IS_ERR(dev->busclk))
+		return PTR_ERR(dev->busclk);
+
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!i2c_dw_prepare_clk(dev, true)) {
 		u64 clk_khz;
-- 
2.7.4
