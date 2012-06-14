From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 14/17] i2c: omap: simplify errata check
Date: Thu, 14 Jun 2012 13:20:47 +0300
Message-ID: <1339669250-9183-15-git-send-email-balbi@ti.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1339669250-9183-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: ben-linux@fluff.org
Cc: Tony Lindgren <tony@atomide.com>, w.sang@pengutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-i2c@vger.kernel.org

omap_i2c_dev is allocated with kzalloc(),
so we need not initialize b_hw to zero.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index fad5f6f..fc5b8bc 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1139,9 +1139,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 		dev->fifo_size = (dev->fifo_size / 2);
 
-		if (dev->rev >= OMAP_I2C_REV_ON_3530_4430)
-			dev->b_hw = 0; /* Disable hardware fixes */
-		else
+		if (dev->rev < OMAP_I2C_REV_ON_3530_4430)
 			dev->b_hw = 1; /* Enable hardware fixes */
 
 		/* calculate wakeup latency constraint for MPU */
-- 
1.7.10.4

