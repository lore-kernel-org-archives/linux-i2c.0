From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] i2c: mxs: Use dma_request_chan() instead dma_request_slave_channel()
Date: Tue, 17 Dec 2019 09:45:05 +0200
Message-ID: <20191217074505.22527-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: shawnguo@kernel.org, s.hauer@pengutronix.de
Cc: vkoul@kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/i2c/busses/i2c-mxs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 89224913f578..03f5eee9883a 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -836,10 +836,10 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* Setup the DMA */
-	i2c->dmach = dma_request_slave_channel(dev, "rx-tx");
-	if (!i2c->dmach) {
+	i2c->dmach = dma_request_chan(dev, "rx-tx");
+	if (IS_ERR(i2c->dmach)) {
 		dev_err(dev, "Failed to request dma\n");
-		return -ENODEV;
+		return PTR_ERR(i2c->dmach);
 	}
 
 	platform_set_drvdata(pdev, i2c);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
