From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] Use resource_size macro
Date: Wed,  6 May 2009 22:28:38 +0200
Message-ID: <1241641718-14585-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: root <root@fecusia.(none)>

This replace all instances in the i2c busses tree of
res->end - res->start + 1 with the handy macro resource_size(res)
from ioport.h (coming in from platform_device.h).

This was created with a simple
sed -i -e 's/\([a-z]*\)->end *- *[a-z]*->start *+ *1/resource_size(\1)/g'

Then manually replacing the PXA redefiniton of the same kind
of macro manually. Recompiled some ARM defconfigs I could find to
make a rough test so it shouldn't break anything, though I
couldn't see exactly which configs you need for all the drivers.

Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/i2c/busses/i2c-at91.c         |    8 ++++----
 drivers/i2c/busses/i2c-au1550.c       |    2 +-
 drivers/i2c/busses/i2c-bfin-twi.c     |    2 +-
 drivers/i2c/busses/i2c-highlander.c   |    2 +-
 drivers/i2c/busses/i2c-mv64xxx.c      |    2 +-
 drivers/i2c/busses/i2c-ocores.c       |    8 ++++----
 drivers/i2c/busses/i2c-omap.c         |    2 +-
 drivers/i2c/busses/i2c-pca-platform.c |   10 ++++------
 drivers/i2c/busses/i2c-pmcmsp.c       |    8 ++++----
 drivers/i2c/busses/i2c-pxa.c          |    9 ++++-----
 drivers/i2c/busses/i2c-versatile.c    |    6 +++---
 11 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 67d9dc5..06e1ecb 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -200,10 +200,10 @@ static int __devinit at91_i2c_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENXIO;
 
-	if (!request_mem_region(res->start, res->end - res->start + 1, "at91_i2c"))
+	if (!request_mem_region(res->start, resource_size(res), "at91_i2c"))
 		return -EBUSY;
 
-	twi_base = ioremap(res->start, res->end - res->start + 1);
+	twi_base = ioremap(res->start, resource_size(res));
 	if (!twi_base) {
 		rc = -ENOMEM;
 		goto fail0;
@@ -252,7 +252,7 @@ fail2:
 fail1:
 	iounmap(twi_base);
 fail0:
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 
 	return rc;
 }
@@ -268,7 +268,7 @@ static int __devexit at91_i2c_remove(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	iounmap(twi_base);
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 
 	clk_disable(twi_clk);		/* disable peripheral clock */
 	clk_put(twi_clk);
diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index f78ce52..532828b 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -389,7 +389,7 @@ i2c_au1550_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	priv->ioarea = request_mem_region(r->start, r->end - r->start + 1,
+	priv->ioarea = request_mem_region(r->start, resource_size(r),
 					  pdev->name);
 	if (!priv->ioarea) {
 		ret = -EBUSY;
diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index fc548b3..1fceaf0 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -632,7 +632,7 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 		goto out_error_get_res;
 	}
 
-	iface->regs_base = ioremap(res->start, res->end - res->start + 1);
+	iface->regs_base = ioremap(res->start, resource_size(res));
 	if (iface->regs_base == NULL) {
 		dev_err(&pdev->dev, "Cannot map IO\n");
 		rc = -ENXIO;
diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c-highlander.c
index e5a8dae..87ecace 100644
--- a/drivers/i2c/busses/i2c-highlander.c
+++ b/drivers/i2c/busses/i2c-highlander.c
@@ -373,7 +373,7 @@ static int __devinit highlander_i2c_probe(struct platform_device *pdev)
 	if (unlikely(!dev))
 		return -ENOMEM;
 
-	dev->base = ioremap_nocache(res->start, res->end - res->start + 1);
+	dev->base = ioremap_nocache(res->start, resource_size(res));
 	if (unlikely(!dev->base)) {
 		ret = -ENXIO;
 		goto err;
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 5a4945d..c3869d9 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -469,7 +469,7 @@ mv64xxx_i2c_map_regs(struct platform_device *pd,
 	if (!r)
 		return -ENODEV;
 
-	size = r->end - r->start + 1;
+	size = resource_size(r);
 
 	if (!request_mem_region(r->start, size, drv_data->adapter.name))
 		return -EBUSY;
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index e5193bf..eec9ab2 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -233,14 +233,14 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
-	if (!request_mem_region(res->start, res->end - res->start + 1,
+	if (!request_mem_region(res->start, resource_size(res),
 				pdev->name)) {
 		dev_err(&pdev->dev, "Memory region busy\n");
 		ret = -EBUSY;
 		goto request_mem_failed;
 	}
 
-	i2c->base = ioremap(res->start, res->end - res->start + 1);
+	i2c->base = ioremap(res->start, resource_size(res));
 	if (!i2c->base) {
 		dev_err(&pdev->dev, "Unable to map registers\n");
 		ret = -EIO;
@@ -278,7 +278,7 @@ add_adapter_failed:
 request_irq_failed:
 	iounmap(i2c->base);
 map_failed:
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 request_mem_failed:
 	kfree(i2c);
 
@@ -306,7 +306,7 @@ static int __devexit ocores_i2c_remove(struct platform_device* pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res)
-		release_mem_region(res->start, res->end - res->start + 1);
+		release_mem_region(res->start, resource_size(res));
 
 	kfree(i2c);
 
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ece0125..af14635 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -807,7 +807,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev->idle = 1;
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
-	dev->base = ioremap(mem->start, mem->end - mem->start + 1);
+	dev->base = ioremap(mem->start, resource_size(mem));
 	if (!dev->base) {
 		r = -ENOMEM;
 		goto err_free_mem;
diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 7b23891..c4df9d4 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -27,8 +27,6 @@
 #include <asm/irq.h>
 #include <asm/io.h>
 
-#define res_len(r)		((r)->end - (r)->start + 1)
-
 struct i2c_pca_pf_data {
 	void __iomem			*reg_base;
 	int				irq;	/* if 0, use polling */
@@ -148,7 +146,7 @@ static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
 		goto e_print;
 	}
 
-	if (!request_mem_region(res->start, res_len(res), res->name)) {
+	if (!request_mem_region(res->start, resource_size(res), res->name)) {
 		ret = -ENOMEM;
 		goto e_print;
 	}
@@ -161,13 +159,13 @@ static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
 
 	init_waitqueue_head(&i2c->wait);
 
-	i2c->reg_base = ioremap(res->start, res_len(res));
+	i2c->reg_base = ioremap(res->start, resource_size(res));
 	if (!i2c->reg_base) {
 		ret = -ENOMEM;
 		goto e_remap;
 	}
 	i2c->io_base = res->start;
-	i2c->io_size = res_len(res);
+	i2c->io_size = resource_size(res);
 	i2c->irq = irq;
 
 	i2c->adap.nr = pdev->id >= 0 ? pdev->id : 0;
@@ -250,7 +248,7 @@ e_reqirq:
 e_remap:
 	kfree(i2c);
 e_alloc:
-	release_mem_region(res->start, res_len(res));
+	release_mem_region(res->start, resource_size(res));
 e_print:
 	printk(KERN_ERR "Registering PCA9564/PCA9665 FAILED! (%d)\n", ret);
 	return ret;
diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index 0bdb2d7..7b57d5f 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -283,7 +283,7 @@ static int __devinit pmcmsptwi_probe(struct platform_device *pldev)
 	}
 
 	/* reserve the memory region */
-	if (!request_mem_region(res->start, res->end - res->start + 1,
+	if (!request_mem_region(res->start, resource_size(res),
 				pldev->name)) {
 		dev_err(&pldev->dev,
 			"Unable to get memory/io address region 0x%08x\n",
@@ -294,7 +294,7 @@ static int __devinit pmcmsptwi_probe(struct platform_device *pldev)
 
 	/* remap the memory */
 	pmcmsptwi_data.iobase = ioremap_nocache(res->start,
-						res->end - res->start + 1);
+						resource_size(res));
 	if (!pmcmsptwi_data.iobase) {
 		dev_err(&pldev->dev,
 			"Unable to ioremap address 0x%08x\n", res->start);
@@ -360,7 +360,7 @@ ret_unmap:
 	iounmap(pmcmsptwi_data.iobase);
 
 ret_unreserve:
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 
 ret_err:
 	return rc;
@@ -385,7 +385,7 @@ static int __devexit pmcmsptwi_remove(struct platform_device *pldev)
 	iounmap(pmcmsptwi_data.iobase);
 
 	res = platform_get_resource(pldev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index c1405c8..b330883 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -979,7 +979,6 @@ static const struct i2c_algorithm i2c_pxa_pio_algorithm = {
 	.functionality	= i2c_pxa_functionality,
 };
 
-#define res_len(r)		((r)->end - (r)->start + 1)
 static int i2c_pxa_probe(struct platform_device *dev)
 {
 	struct pxa_i2c *i2c;
@@ -993,7 +992,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	if (res == NULL || irq < 0)
 		return -ENODEV;
 
-	if (!request_mem_region(res->start, res_len(res), res->name))
+	if (!request_mem_region(res->start, resource_size(res), res->name))
 		return -ENOMEM;
 
 	i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
@@ -1023,7 +1022,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		goto eclk;
 	}
 
-	i2c->reg_base = ioremap(res->start, res_len(res));
+	i2c->reg_base = ioremap(res->start, resource_size(res));
 	if (!i2c->reg_base) {
 		ret = -EIO;
 		goto eremap;
@@ -1031,7 +1030,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	i2c->reg_shift = (cpu_is_pxa3xx() && (dev->id == 1)) ? 0 : 1;
 
 	i2c->iobase = res->start;
-	i2c->iosize = res_len(res);
+	i2c->iosize = resource_size(res);
 
 	i2c->irq = irq;
 
@@ -1095,7 +1094,7 @@ eremap:
 eclk:
 	kfree(i2c);
 emalloc:
-	release_mem_region(res->start, res_len(res));
+	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-versatile.c
index fede619..70de821 100644
--- a/drivers/i2c/busses/i2c-versatile.c
+++ b/drivers/i2c/busses/i2c-versatile.c
@@ -76,7 +76,7 @@ static int i2c_versatile_probe(struct platform_device *dev)
 		goto err_out;
 	}
 
-	if (!request_mem_region(r->start, r->end - r->start + 1, "versatile-i2c")) {
+	if (!request_mem_region(r->start, resource_size(r), "versatile-i2c")) {
 		ret = -EBUSY;
 		goto err_out;
 	}
@@ -87,7 +87,7 @@ static int i2c_versatile_probe(struct platform_device *dev)
 		goto err_release;
 	}
 
-	i2c->base = ioremap(r->start, r->end - r->start + 1);
+	i2c->base = ioremap(r->start, resource_size(r));
 	if (!i2c->base) {
 		ret = -ENOMEM;
 		goto err_free;
@@ -118,7 +118,7 @@ static int i2c_versatile_probe(struct platform_device *dev)
  err_free:
 	kfree(i2c);
  err_release:
-	release_mem_region(r->start, r->end - r->start + 1);
+	release_mem_region(r->start, resource_size(r));
  err_out:
 	return ret;
 }
-- 
1.6.0.6
