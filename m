From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] i2c: bcm2835: Use devm_ioremap_resource()
Date: Tue, 11 Feb 2014 22:02:36 +0900
Message-ID: <001101cf2729$890d5b10$9b281130$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Stephen Warren' <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, 'Florian Meier' <florian.meier-oZ8rN/sblLk@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use devm_ioremap_resource() in order to make the code simpler,
and remove redundant return value check of platform_get_resource()
because the value is checked by devm_ioremap_resource().

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-bcm2835.c |   24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 77df97b..13b7ed5 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -219,7 +219,7 @@ static const struct i2c_algorithm bcm2835_i2c_algo = {
 static int bcm2835_i2c_probe(struct platform_device *pdev)
 {
 	struct bcm2835_i2c_dev *i2c_dev;
-	struct resource *mem, *requested, *irq;
+	struct resource *mem, *irq;
 	u32 bus_clk_rate, divider;
 	int ret;
 	struct i2c_adapter *adap;
@@ -234,25 +234,9 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	init_completion(&i2c_dev->completion);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "No mem resource\n");
-		return -ENODEV;
-	}
-
-	requested = devm_request_mem_region(&pdev->dev, mem->start,
-					    resource_size(mem),
-					    dev_name(&pdev->dev));
-	if (!requested) {
-		dev_err(&pdev->dev, "Could not claim register region\n");
-		return -EBUSY;
-	}
-
-	i2c_dev->regs = devm_ioremap(&pdev->dev, mem->start,
-				     resource_size(mem));
-	if (!i2c_dev->regs) {
-		dev_err(&pdev->dev, "Could not map registers\n");
-		return -ENOMEM;
-	}
+	i2c_dev->regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(i2c_dev->regs))
+		return PTR_ERR(i2c_dev->regs);
 
 	i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c_dev->clk)) {
-- 
1.7.10.4
