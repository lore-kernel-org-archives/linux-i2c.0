From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 1/5] i2c: i2c-davinci: switch to use platform_get_irq
Date: Thu, 20 Nov 2014 12:03:04 +0200
Message-ID: <1416477788-5544-2-git-send-email-grygorii.strashko@ti.com>
References: <1416477788-5544-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416477788-5544-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-i2c@vger.kernel.org

Switch Davinci I2C driver to use platform_get_irq(), because
- it is not recommened to use
  platform_get_resource(pdev, IORESOURCE_IRQ, ..) for requesting IRQ's
  resources any more, as they can be not ready yet in case of DT-booting.
- it makes code simpler

CC: Sekhar Nori <nsekhar@ti.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
CC: Santosh Shilimkar <ssantosh@kernel.org>
CC: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/i2c/busses/i2c-davinci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 4d96147..9bbfb8f 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -640,13 +640,13 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 {
 	struct davinci_i2c_dev *dev;
 	struct i2c_adapter *adap;
-	struct resource *mem, *irq;
-	int r;
+	struct resource *mem;
+	int r, irq;
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "no irq resource?\n");
-		return -ENODEV;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "can't get irq resource ret=%d\n", irq);
+		return irq;
 	}
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct davinci_i2c_dev),
@@ -661,7 +661,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	init_completion(&dev->xfr_complete);
 #endif
 	dev->dev = &pdev->dev;
-	dev->irq = irq->start;
+	dev->irq = irq;
 	dev->pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, dev);
 
-- 
1.9.1
