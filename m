From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 03/22] i2c-designware: Use platform_get_irq helper
Date: Fri, 06 Nov 2009 21:45:07 +0900
Message-ID: <4AF41A53.3080709@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Acked-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index eeb1915..139f555 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -548,8 +548,8 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
-	struct resource *mem, *irq, *ioarea;
-	int r;
+	struct resource *mem, *ioarea;
+	int irq, r;
 
 	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -558,10 +558,10 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
-		return -EINVAL;
+		return irq; /* -ENXIO */
 	}
 
 	ioarea = request_mem_region(mem->start, resource_size(mem),
@@ -581,7 +581,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	tasklet_init(&dev->pump_msg, dw_i2c_pump_msg, (unsigned long) dev);
 	mutex_init(&dev->lock);
 	dev->dev = get_device(&pdev->dev);
-	dev->irq = irq->start;
+	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
 
 	dev->clk = clk_get(&pdev->dev, NULL);
-- 
1.6.5.2
