From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 4/7] i2c: sh_mobile: let RuntimePM do the clock handling
Date: Mon, 18 Dec 2017 22:57:59 +0100
Message-ID: <20171218215802.28591-5-wsa+renesas@sang-engineering.com>
References: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40905 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965322AbdLRV6K (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 18 Dec 2017 16:58:10 -0500
In-Reply-To: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Start RuntimePM a bit earlier, so we can use it to enable the clock
during probe for frequency calculations. Make sure it is enabled before
calling setup().

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 88af45225003a5..f1a9b971e2c14a 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -252,11 +252,7 @@ static int sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 	u32 tHIGH, tLOW, tf;
 	uint16_t max_val;
 
-	/* Get clock rate after clock is enabled */
-	clk_prepare_enable(pd->clk);
-	i2c_clk_khz = clk_get_rate(pd->clk) / 1000;
-	clk_disable_unprepare(pd->clk);
-	i2c_clk_khz /= pd->clks_per_count;
+	i2c_clk_khz = clk_get_rate(pd->clk) / 1000 / pd->clks_per_count;
 
 	if (pd->bus_speed == STANDARD_MODE) {
 		tLOW	= 47;	/* tLOW = 4.7 us */
@@ -881,6 +877,20 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	if (resource_size(res) > 0x17)
 		pd->flags |= IIC_FLAG_HAS_ICIC67;
 
+	/* Enable Runtime PM for this device.
+	 *
+	 * Also tell the Runtime PM core to ignore children
+	 * for this device since it is valid for us to suspend
+	 * this I2C master driver even though the slave devices
+	 * on the I2C bus may not be suspended.
+	 *
+	 * The state of the I2C hardware bus is unaffected by
+	 * the Runtime PM state.
+	 */
+	pm_suspend_ignore_children(&dev->dev, true);
+	pm_runtime_enable(&dev->dev);
+	pm_runtime_get_sync(&dev->dev);
+
 	config = of_device_get_match_data(&dev->dev);
 	if (config) {
 		pd->clks_per_count = config->clks_per_count;
@@ -888,6 +898,8 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	} else {
 		ret = sh_mobile_i2c_init(pd);
 	}
+
+	pm_runtime_put_sync(&dev->dev);
 	if (ret)
 		return ret;
 
@@ -896,19 +908,6 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	pd->dma_direction = DMA_NONE;
 	pd->dma_rx = pd->dma_tx = ERR_PTR(-EPROBE_DEFER);
 
-	/* Enable Runtime PM for this device.
-	 *
-	 * Also tell the Runtime PM core to ignore children
-	 * for this device since it is valid for us to suspend
-	 * this I2C master driver even though the slave devices
-	 * on the I2C bus may not be suspended.
-	 *
-	 * The state of the I2C hardware bus is unaffected by
-	 * the Runtime PM state.
-	 */
-	pm_suspend_ignore_children(&dev->dev, true);
-	pm_runtime_enable(&dev->dev);
-
 	/* setup the private data */
 	adap = &pd->adap;
 	i2c_set_adapdata(adap, pd);
-- 
2.11.0
