From: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: [PATCH v2 3/5] i2c: pca-platform: use gpio_is_valid
Date: Tue, 20 Jun 2017 13:18:35 +1200
Message-ID: <20170620011837.14010-4-chris.packham@alliedtelesis.co.nz>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170620011837.14010-1-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use gpio_is_valid() instead of gpio > -1.

Signed-off-by: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
---
 drivers/i2c/busses/i2c-pca-platform.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 87ca2f02f607..3a9845bae9a4 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -197,7 +197,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	} else {
 		i2c->adap.timeout = HZ;
 		i2c->algo_data.i2c_clock = 59000;
-		i2c->gpio = -1;
+		i2c->gpio = -ENODEV;
 	}
 
 	i2c->algo_data.data = i2c;
@@ -220,8 +220,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 		break;
 	}
 
-	/* Use gpio_is_valid() when in mainline */
-	if (i2c->gpio > -1) {
+	if (gpio_is_valid(i2c->gpio)) {
 		ret = gpio_request(i2c->gpio, i2c->adap.name);
 		if (ret == 0) {
 			gpio_direction_output(i2c->gpio, 1);
@@ -255,7 +254,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	if (irq)
 		free_irq(irq, i2c);
 e_reqirq:
-	if (i2c->gpio > -1)
+	if (gpio_is_valid(i2c->gpio))
 		gpio_free(i2c->gpio);
 
 	iounmap(i2c->reg_base);
@@ -277,7 +276,7 @@ static int i2c_pca_pf_remove(struct platform_device *pdev)
 	if (i2c->irq)
 		free_irq(i2c->irq, i2c);
 
-	if (i2c->gpio > -1)
+	if (gpio_is_valid(i2c->gpio))
 		gpio_free(i2c->gpio);
 
 	iounmap(i2c->reg_base);
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
