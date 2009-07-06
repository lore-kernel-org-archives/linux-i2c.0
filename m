From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 1/2] i2c-davinci: convert clock usage after clkdev conversion
Date: Mon,  6 Jul 2009 15:48:35 -0700
Message-ID: <1246920516-31462-2-git-send-email-khilman@deeprootsystems.com>
References: <1246920516-31462-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246920516-31462-1-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

DaVinci core code has converted to the new clkdev API so
clock name strings are not needed.  Instead, just the a
'struct device' pointer is needed.

Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 3fae3a9..ee3fbb8 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -523,7 +523,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	dev->irq = irq->start;
 	platform_set_drvdata(pdev, dev);
 
-	dev->clk = clk_get(&pdev->dev, "I2CCLK");
+	dev->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
 		r = -ENODEV;
 		goto err_free_mem;
-- 
1.6.3.3
