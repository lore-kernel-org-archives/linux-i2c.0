From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 2/2] i2c: imx: defer probing on dma channel request
Date: Wed, 16 Jan 2019 13:28:55 +0200
Message-ID: <20190116112855.13824-2-laurentiu.tudor@nxp.com>
References: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, wsa@the-dreams.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabio.estevam@nxp.com, leoyang.li@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: linux-i2c@vger.kernel.org

If the dma controller is not yet probed, defer i2c probe.
The error path in probe was slightly modified (no functional change)
to avoid triggering this WARN_ON():
"cg-pll0-div1 already disabled
WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0xb0"

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
Changes in v2:
 - rebased on latest i2c tree
 - fix small error introduced by a previous commit (first patch)

 drivers/i2c/busses/i2c-imx.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 42fed40198a0..4e34b1572756 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1111,7 +1111,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 				pdev->name, i2c_imx);
 	if (ret) {
 		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
-		goto clk_disable;
+		clk_disable_unprepare(i2c_imx->clk);
+		return ret;
 	}
 
 	/* Init queue */
@@ -1161,19 +1162,25 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
+	/* Init DMA config if supported */
+	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_info(&pdev->dev, "can't use DMA, using PIO instead.\n");
+		else
+			goto del_adapter;
+	}
+
 	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
 	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);
 	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
 		i2c_imx->adapter.name);
 
-	/* Init DMA config if supported */
-	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
-	if (ret < 0)
-		goto clk_notifier_unregister;
-
 	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
 	return 0;   /* Return OK */
 
+del_adapter:
+	i2c_del_adapter(&i2c_imx->adapter);
 clk_notifier_unregister:
 	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
 rpm_disable:
@@ -1182,8 +1189,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
-clk_disable:
-	clk_disable_unprepare(i2c_imx->clk);
 	return ret;
 }
 
-- 
2.17.1
