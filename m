From: Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH v6 1/2] i2c: i2c-ocores: Add irq support for sparc
Date: Thu, 15 Nov 2012 16:50:58 +0100
Message-ID: <1352994659-22392-2-git-send-email-andreas@gaisler.com>
References: <1352994659-22392-1-git-send-email-andreas@gaisler.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352994659-22392-1-git-send-email-andreas@gaisler.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>, Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-i2c@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, software@gaisler.com
List-Id: linux-i2c@vger.kernel.org

Add sparc support by using platform_get_irq instead of platform_get_resource.
There are no platform resources of type IORESOURCE_IRQ for sparc, but
platform_get_irq works for sparc. In the non-sparc case platform_get_irq
internally uses platform_get_resource.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 Changes since v5:
 - None

 drivers/i2c/busses/i2c-ocores.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index bffd550..1d204cb 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -267,7 +267,8 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 {
 	struct ocores_i2c *i2c;
 	struct ocores_i2c_platform_data *pdata;
-	struct resource *res, *res2;
+	struct resource *res;
+	int irq;
 	int ret;
 	int i;
 
@@ -275,9 +276,9 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENODEV;
 
-	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res2)
-		return -ENODEV;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
@@ -313,7 +314,7 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	ocores_init(i2c);
 
 	init_waitqueue_head(&i2c->wait);
-	ret = devm_request_irq(&pdev->dev, res2->start, ocores_isr, 0,
+	ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
 			       pdev->name, i2c);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot claim IRQ\n");
-- 
1.7.0.4
