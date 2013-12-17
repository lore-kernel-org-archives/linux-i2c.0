From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 11/13] i2c: versatile: Use devm_*() functions
Date: Tue, 17 Dec 2013 16:00:52 +0900
Message-ID: <002f01cefaf5$b943e890$2bcbb9b0$%han@samsung.com>
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
 drivers/i2c/busses/i2c-versatile.c |   33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-versatile.c
index 6bb3a89..6bcd477 100644
--- a/drivers/i2c/busses/i2c-versatile.c
+++ b/drivers/i2c/busses/i2c-versatile.c
@@ -71,27 +71,16 @@ static int i2c_versatile_probe(struct platform_device *dev)
 	int ret;
 
 	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (!r) {
-		ret = -EINVAL;
-		goto err_out;
-	}
+	if (!r)
+		return -EINVAL;
 
-	if (!request_mem_region(r->start, resource_size(r), "versatile-i2c")) {
-		ret = -EBUSY;
-		goto err_out;
-	}
+	i2c = devm_kzalloc(&dev->dev, sizeof(struct i2c_versatile), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
 
-	i2c = kzalloc(sizeof(struct i2c_versatile), GFP_KERNEL);
-	if (!i2c) {
-		ret = -ENOMEM;
-		goto err_release;
-	}
-
-	i2c->base = ioremap(r->start, resource_size(r));
-	if (!i2c->base) {
-		ret = -ENOMEM;
-		goto err_free;
-	}
+	i2c->base = devm_ioremap_resource(&dev->dev, r);
+	if (IS_ERR(i2c->base))
+		return PTR_ERR(i2c->base);
 
 	writel(SCL | SDA, i2c->base + I2C_CONTROLS);
 
@@ -110,12 +99,6 @@ static int i2c_versatile_probe(struct platform_device *dev)
 		return 0;
 	}
 
-	iounmap(i2c->base);
- err_free:
-	kfree(i2c);
- err_release:
-	release_mem_region(r->start, resource_size(r));
- err_out:
 	return ret;
 }
 
-- 
1.7.10.4
