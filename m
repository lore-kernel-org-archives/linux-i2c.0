From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH v2 1/2] i2c: bcm2835: Move IRQ request after clock code in
 probe
Date: Fri, 21 Jun 2019 03:52:49 -0700
Message-ID: <20190621105250.19858-2-nh6z@nh6z.net>
References: <20190621105250.19858-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190621105250.19858-1-nh6z@nh6z.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: eric@anholt.net, wahrenst@gmx.net, f.fainelli@gmail.com, wsa@the-dreams.de, swarren@wwwdotorg.org, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: team@nwdigitalradio.com, Annaliese McDermond <nh6z@nh6z.net>
List-Id: linux-i2c@vger.kernel.org

If any of the clock code in the probe fails and returns, the IRQ
will not be freed.  Moving the IRQ request to last allows it to
be freed on any errors further up in the probe function.  devm_
calls can apparently not be used because there are some potential
race conditions that will arise.

Fixes: bebff81fb8b9 ("i2c: bcm2835: Model Divider in CCF")

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 drivers/i2c/busses/i2c-bcm2835.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 108d2ae4632c..27b2f204c693 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -521,20 +521,6 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(i2c_dev->regs))
 		return PTR_ERR(i2c_dev->regs);
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
-		return -ENODEV;
-	}
-	i2c_dev->irq = irq->start;
-
-	ret = request_irq(i2c_dev->irq, bcm2835_i2c_isr, IRQF_SHARED,
-			  dev_name(&pdev->dev), i2c_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Could not request IRQ\n");
-		return -ENODEV;
-	}
-
 	mclk_name = of_clk_get_parent_name(pdev->dev.of_node, 0);
 
 	bus_clk = bcm2835_i2c_register_div(&pdev->dev, mclk_name, i2c_dev);
@@ -564,6 +550,20 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!irq) {
+		dev_err(&pdev->dev, "No IRQ resource\n");
+		return -ENODEV;
+	}
+	i2c_dev->irq = irq->start;
+
+	ret = request_irq(i2c_dev->irq, bcm2835_i2c_isr, IRQF_SHARED,
+			  dev_name(&pdev->dev), i2c_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not request IRQ\n");
+		return -ENODEV;
+	}
+
 	adap = &i2c_dev->adapter;
 	i2c_set_adapdata(adap, i2c_dev);
 	adap->owner = THIS_MODULE;
-- 
2.19.1
