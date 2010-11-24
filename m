From: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Subject: [PATCH 2/3] i2c-ocores: Use devres for resource allocation
Date: Wed, 24 Nov 2010 17:26:21 +0100
Message-ID: <1290615982-1028-3-git-send-email-jonas@southpole.se>
References: <1290615982-1028-1-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1290615982-1028-1-git-send-email-jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch converts the i2c-cores driver to use devres routines for
resource allocation.

Signed-off-by: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
---
 drivers/i2c/busses/i2c-ocores.c |   46 +++++++++-----------------------------
 1 files changed, 11 insertions(+), 35 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index c05e8c4..dee0352 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -253,22 +253,21 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	if (!res2)
 		return -ENODEV;
 
-	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
+	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
-	if (!request_mem_region(res->start, resource_size(res),
-				pdev->name)) {
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+				     resource_size(res), pdev->name)) {
 		dev_err(&pdev->dev, "Memory region busy\n");
-		ret = -EBUSY;
-		goto request_mem_failed;
+		return -EBUSY;
 	}
 
-	i2c->base = ioremap(res->start, resource_size(res));
+	i2c->base = devm_ioremap_nocache(&pdev->dev, res->start,
+					 resource_size(res));
 	if (!i2c->base) {
 		dev_err(&pdev->dev, "Unable to map registers\n");
-		ret = -EIO;
-		goto map_failed;
+		return -EIO;
 	}
 
 	pdata = pdev->dev.platform_data;
@@ -284,10 +283,11 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	ocores_init(i2c);
 
 	init_waitqueue_head(&i2c->wait);
-	ret = request_irq(res2->start, ocores_isr, 0, pdev->name, i2c);
+	ret = devm_request_irq(&pdev->dev, res2->start, ocores_isr, 0,
+			       pdev->name, i2c);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot claim IRQ\n");
-		goto request_irq_failed;
+		return ret;
 	}
 
 	/* hook up driver to tree */
@@ -303,7 +303,7 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add adapter\n");
-		goto add_adapter_failed;
+		return ret;
 	}
 
 	/* add in known devices to the bus */
@@ -313,23 +313,11 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-add_adapter_failed:
-	free_irq(res2->start, i2c);
-request_irq_failed:
-	iounmap(i2c->base);
-map_failed:
-	release_mem_region(res->start, resource_size(res));
-request_mem_failed:
-	kfree(i2c);
-
-	return ret;
 }
 
 static int __devexit ocores_i2c_remove(struct platform_device* pdev)
 {
 	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
-	struct resource *res;
 
 	/* disable i2c logic */
 	oc_setreg(i2c, OCI2C_CONTROL, oc_getreg(i2c, OCI2C_CONTROL)
@@ -339,18 +327,6 @@ static int __devexit ocores_i2c_remove(struct platform_device* pdev)
 	i2c_del_adapter(&i2c->adap);
 	platform_set_drvdata(pdev, NULL);
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res)
-		free_irq(res->start, i2c);
-
-	iounmap(i2c->base);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res)
-		release_mem_region(res->start, resource_size(res));
-
-	kfree(i2c);
-
 	return 0;
 }
 
-- 
1.7.1
