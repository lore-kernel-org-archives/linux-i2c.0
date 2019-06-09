From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH] i2c: imx: Initialize DMA before registering I2C adapter
Date: Sat,  8 Jun 2019 22:56:58 -0700
Message-ID: <20190609055658.3446-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, Chris Healy <cphealy@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Allocating DMA after registering I2C adapter can lead to infinite
probing loop, for example, consider the following scenario:

    1. i2c_imx_probe() is called and successfully registers an I2C
       adapter via i2c_add_numbered_adapter()

    2. As a part of i2c_add_numbered_adapter() new I2C slave devices
       are added from DT which results in a call to
       driver_deferred_probe_trigger()

    3. i2c_imx_probe() continues and calls i2c_imx_dma_request() which
       due to lack of proper DMA driver returns -EPROBE_DEFER

    4. i2c_imx_probe() fails, removes I2C adapter and returns
       -EPROBE_DEFER, which places it into deferred probe list

    5. Deferred probe work triggered in #2 above kicks in and calls
       i2c_imx_probe() again thus bringing us to step #1

To avoid having this problem, move i2c_imx_dma_request() to happen
before i2c_add_numbered_adapter().

This problem was encountered on VF610 CFU1 board with
CONFIG_FSL_EDMA=n.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-i2c@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/i2c/busses/i2c-imx.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index b1b8b938d7f4..78a909f56f75 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -278,7 +278,7 @@ static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 {
 	struct imx_i2c_dma *dma;
 	struct dma_slave_config dma_sconfig;
-	struct device *dev = &i2c_imx->adapter.dev;
+	struct device *dev = i2c_imx->adapter.dev.parent;
 	int ret;
 
 	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
@@ -1153,10 +1153,15 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	if (ret == -EPROBE_DEFER)
 		goto clk_notifier_unregister;
 
+	/* Init DMA config if supported */
+	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
+	if (ret < 0)
+		goto clk_notifier_unregister;
+
 	/* Add I2C adapter */
 	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
 	if (ret < 0)
-		goto clk_notifier_unregister;
+		goto dma_free;
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
@@ -1166,16 +1171,12 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
 		i2c_imx->adapter.name);
 
-	/* Init DMA config if supported */
-	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
-	if (ret < 0)
-		goto del_adapter;
-
 	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
 	return 0;   /* Return OK */
 
-del_adapter:
-	i2c_del_adapter(&i2c_imx->adapter);
+dma_free:
+	if (i2c_imx->dma)
+		i2c_imx_dma_free(i2c_imx);
 clk_notifier_unregister:
 	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
 rpm_disable:
-- 
2.21.0
