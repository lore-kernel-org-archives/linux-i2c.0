From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 1/5] i2c: i2c-davinci: switch to use platform_get_irq
Date: Wed, 26 Nov 2014 15:59:49 +0200
Message-ID: <1417010393-30598-2-git-send-email-grygorii.strashko@ti.com>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Sekhar Nori <nsekhar@ti.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mike Looijmans <milo-software@users.sourceforge.net>, Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-i2c@vger.kernel.org

Switch Davinci I2C driver to use platform_get_irq(), because
it is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ, ..)
for requesting IRQ resources any more, as they can be not ready yet
in case of DT-boot.

CC: Sekhar Nori <nsekhar@ti.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
CC: Santosh Shilimkar <ssantosh@kernel.org>
CC: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/i2c/busses/i2c-davinci.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 4d96147..7f54903 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -640,13 +640,17 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 {
 	struct davinci_i2c_dev *dev;
 	struct i2c_adapter *adap;
-	struct resource *mem, *irq;
-	int r;
-
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "no irq resource?\n");
-		return -ENODEV;
+	struct resource *mem;
+	int r, irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		if (irq == -EPROBE_DEFER)
+			return irq;
+		if (!irq)
+			irq = -ENXIO;
+		dev_err(&pdev->dev, "can't get irq resource ret=%d\n", irq);
+		return irq;
 	}
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct davinci_i2c_dev),
@@ -661,7 +665,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	init_completion(&dev->xfr_complete);
 #endif
 	dev->dev = &pdev->dev;
-	dev->irq = irq->start;
+	dev->irq = irq;
 	dev->pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, dev);
 
-- 
1.9.1
