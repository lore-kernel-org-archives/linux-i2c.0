From: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: [PATCH v2 5/5] i2c: pca-platform: use dev_warn/dev_info instead of printk
Date: Tue, 20 Jun 2017 13:18:37 +1200
Message-ID: <20170620011837.14010-6-chris.packham@alliedtelesis.co.nz>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170620011837.14010-1-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
---
 drivers/i2c/busses/i2c-pca-platform.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 12ab0cafa7c9..27175d681548 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -107,8 +107,8 @@ static int i2c_pca_pf_waitforcompletion(void *pd)
 static void i2c_pca_pf_dummyreset(void *pd)
 {
 	struct i2c_pca_pf_data *i2c = pd;
-	printk(KERN_WARNING "%s: No reset-pin found. Chip may get stuck!\n",
-		i2c->adap.name);
+
+	dev_warn(&i2c->adap.dev, "No reset-pin found. Chip may get stuck!\n");
 }
 
 static void i2c_pca_pf_resetchip(void *pd)
@@ -214,8 +214,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 			gpio_direction_output(i2c->gpio, 1);
 			i2c->algo_data.reset_chip = i2c_pca_pf_resetchip;
 		} else {
-			printk(KERN_WARNING "%s: Registering gpio failed!\n",
-				i2c->adap.name);
+			dev_warn(&pdev->dev, "Registering gpio failed!\n");
 			i2c->gpio = ret;
 		}
 	}
@@ -233,7 +232,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2c);
 
-	printk(KERN_INFO "%s registered.\n", i2c->adap.name);
+	dev_info(&pdev->dev, "registered.\n");
 
 	return 0;
 }
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
