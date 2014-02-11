From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] i2c: mxs: Use devm_ioremap_resource()
Date: Tue, 11 Feb 2014 22:04:55 +0900
Message-ID: <001a01cf2729$dc23cd70$946b6850$%han@samsung.com>
References: <001101cf2729$890d5b10$9b281130$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <001101cf2729$890d5b10$9b281130$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Marek Vasut' <marex-ynQEQJNshbs@public.gmane.org>, 'Shawn Guo' <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Sascha Hauer' <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use devm_ioremap_resource() in order to make the code simpler,
and remove redundant return value check of platform_get_resource()
because the value is checked by devm_ioremap_resource().

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 0cde4e6..9585b90 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -806,7 +806,6 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	struct mxs_i2c_dev *i2c;
 	struct i2c_adapter *adap;
 	struct resource *res;
-	resource_size_t res_size;
 	int err, irq;
 
 	i2c = devm_kzalloc(dev, sizeof(struct mxs_i2c_dev), GFP_KERNEL);
@@ -819,19 +818,14 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
+	i2c->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(i2c->regs))
+		return PTR_ERR(i2c->regs);
 
-	if (!res || irq < 0)
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
 		return -ENOENT;
 
-	res_size = resource_size(res);
-	if (!devm_request_mem_region(dev, res->start, res_size, res->name))
-		return -EBUSY;
-
-	i2c->regs = devm_ioremap_nocache(dev, res->start, res_size);
-	if (!i2c->regs)
-		return -EBUSY;
-
 	err = devm_request_irq(dev, irq, mxs_i2c_isr, 0, dev_name(dev), i2c);
 	if (err)
 		return err;
-- 
1.7.10.4
