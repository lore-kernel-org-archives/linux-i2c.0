From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 06/13] i2c: pmcmsp: Use devm_*() functions
Date: Tue, 17 Dec 2013 15:54:23 +0900
Message-ID: <002a01cefaf4$d17ae720$7470b560$%han@samsung.com>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <001601cefaf3$940d0040$bc2700c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use devm_*() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pmcmsp.c |   44 +++++++--------------------------------
 1 file changed, 7 insertions(+), 37 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index f6389e2..cfbee76 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -279,34 +279,19 @@ static int pmcmsptwi_probe(struct platform_device *pldev)
 	res = platform_get_resource(pldev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pldev->dev, "IOMEM resource not found\n");
-		goto ret_err;
+		return rc;
 	}
 
-	/* reserve the memory region */
-	if (!request_mem_region(res->start, resource_size(res),
-				pldev->name)) {
-		dev_err(&pldev->dev,
-			"Unable to get memory/io address region 0x%08x\n",
-			res->start);
-		rc = -EBUSY;
-		goto ret_err;
-	}
-
-	/* remap the memory */
-	pmcmsptwi_data.iobase = ioremap_nocache(res->start,
-						resource_size(res));
-	if (!pmcmsptwi_data.iobase) {
-		dev_err(&pldev->dev,
-			"Unable to ioremap address 0x%08x\n", res->start);
-		rc = -EIO;
-		goto ret_unreserve;
-	}
+	pmcmsptwi_data.iobase = devm_ioremap_resource(&pldev->dev, res);
+	if (IS_ERR(pmcmsptwi_data.iobase))
+		return PTR_ERR(pmcmsptwi_data.iobase);
 
 	/* request the irq */
 	pmcmsptwi_data.irq = platform_get_irq(pldev, 0);
 	if (pmcmsptwi_data.irq) {
-		rc = request_irq(pmcmsptwi_data.irq, &pmcmsptwi_interrupt,
-				 IRQF_SHARED, pldev->name, &pmcmsptwi_data);
+		rc = devm_request_irq(&pldev->dev, pmcmsptwi_data.irq,
+				      &pmcmsptwi_interrupt, IRQF_SHARED,
+				      pldev->name, &pmcmsptwi_data);
 		if (rc == 0) {
 			/*
 			 * Enable 'DONE' interrupt only.
@@ -352,15 +337,8 @@ ret_unmap:
 	if (pmcmsptwi_data.irq) {
 		pmcmsptwi_writel(0,
 			pmcmsptwi_data.iobase + MSP_TWI_INT_MSK_REG_OFFSET);
-		free_irq(pmcmsptwi_data.irq, &pmcmsptwi_data);
 	}
 
-	iounmap(pmcmsptwi_data.iobase);
-
-ret_unreserve:
-	release_mem_region(res->start, resource_size(res));
-
-ret_err:
 	return rc;
 }
 
@@ -369,21 +347,13 @@ ret_err:
  */
 static int pmcmsptwi_remove(struct platform_device *pldev)
 {
-	struct resource *res;
-
 	i2c_del_adapter(&pmcmsptwi_adapter);
 
 	if (pmcmsptwi_data.irq) {
 		pmcmsptwi_writel(0,
 			pmcmsptwi_data.iobase + MSP_TWI_INT_MSK_REG_OFFSET);
-		free_irq(pmcmsptwi_data.irq, &pmcmsptwi_data);
 	}
 
-	iounmap(pmcmsptwi_data.iobase);
-
-	res = platform_get_resource(pldev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
 	return 0;
 }
 
-- 
1.7.10.4
