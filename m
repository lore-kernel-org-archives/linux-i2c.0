From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/3] i2c-ocores: Add irq support for sparc
Date: Thu, 11 Oct 2012 16:11:17 +0200
Message-ID: <1349964679-23244-2-git-send-email-andreas@gaisler.com>
References: <1349964679-23244-1-git-send-email-andreas@gaisler.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349964679-23244-1-git-send-email-andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

There are no platform resources of type IORESOURCE_IRQ on sparc, so irq number
needs to be acquired in a different manner.

Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-ocores.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index bffd550..d62cb3f 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/of_i2c.h>
+#include <linux/of_irq.h>
 #include <linux/log2.h>
 
 struct ocores_i2c {
@@ -270,14 +271,22 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	struct resource *res, *res2;
 	int ret;
 	int i;
+	int irq = 0;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
 
 	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res2)
-		return -ENODEV;
+	if (res2) {
+		irq = res2->start;
+	} else {
+#ifdef CONFIG_SPARC
+		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+#endif
+		if (!irq)
+			return -ENODEV;
+	}
 
 	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
@@ -313,8 +322,7 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	ocores_init(i2c);
 
 	init_waitqueue_head(&i2c->wait);
-	ret = devm_request_irq(&pdev->dev, res2->start, ocores_isr, 0,
-			       pdev->name, i2c);
+	ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0, pdev->name, i2c);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot claim IRQ\n");
 		return ret;
-- 
1.7.0.4
