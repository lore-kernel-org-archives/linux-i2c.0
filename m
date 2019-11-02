From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] i2c: imx-lpi2c: add clk_disable_unprepare calls
Date: Sat,  2 Nov 2019 14:21:49 +0800
Message-ID: <20191102062149.3957-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: linux-i2c@vger.kernel.org

The driver forgets to call clk_disable_unprepare when probe fails
and remove.
Add the two calls to fix the problem.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Adjust the call order to make it consistent in probe failure and
    removal.

 drivers/i2c/busses/i2c-imx-lpi2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index c92b56485fa6..f964693c0901 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -618,6 +618,7 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	return 0;
 
 rpm_disable:
+	clk_disable_unprepare(lpi2c_imx->clk);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
@@ -630,6 +631,7 @@ static int lpi2c_imx_remove(struct platform_device *pdev)
 	struct lpi2c_imx_struct *lpi2c_imx = platform_get_drvdata(pdev);
 
 	i2c_del_adapter(&lpi2c_imx->adapter);
+	clk_disable_unprepare(lpi2c_imx->clk);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.23.0
