From: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Subject: [PATCH 1/2] i2c-ocores: Adapt for device tree
Date: Wed, 24 Nov 2010 15:09:48 +0100
Message-ID: <1290607789-8996-2-git-send-email-jonas@southpole.se>
References: <1290607789-8996-1-git-send-email-jonas@southpole.se>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1290607789-8996-1-git-send-email-jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch adapts the i2c-ocores driver for being defined and configured via
a device tree description.

The device tree bits need to be protected by CONFIG_OF guards as this is
still an optional feature.

Signed-off-by: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
---
 drivers/i2c/busses/i2c-ocores.c |   63 ++++++++++++++++++++++++++++++++++-----
 1 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 0070371..86a536c 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -210,6 +210,31 @@ static struct i2c_adapter ocores_adapter = {
 	.algo		= &ocores_algorithm,
 };
 
+#ifdef CONFIG_OF
+static int ocores_i2c_of_probe(struct platform_device* pdev,
+				struct ocores_i2c* i2c)
+{
+	int* val;
+
+	val = (int*) of_get_property(pdev->dev.of_node, "regstep", NULL);
+	if (!val) {
+		dev_err(&pdev->dev, "Missing required paramter 'regstep'");
+		return -ENODEV;
+	}
+
+	i2c->regstep = *val;
+	val = (int*) of_get_property(pdev->dev.of_node, "clock_khz", NULL);
+	if (!val) {
+		dev_err(&pdev->dev, "Missing required paramter 'clock_khz'");
+		return -ENODEV;
+	}
+	i2c->clock_khz = *val;
+
+	return 0;
+}
+#else
+#define ocores_i2c_of_probe(pdev,i2c) -ENODEV
+#endif
 
 static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 {
@@ -227,10 +252,6 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	if (!res2)
 		return -ENODEV;
 
-	pdata = (struct ocores_i2c_platform_data*) pdev->dev.platform_data;
-	if (!pdata)
-		return -ENODEV;
-
 	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
@@ -249,8 +270,16 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 		goto map_failed;
 	}
 
-	i2c->regstep = pdata->regstep;
-	i2c->clock_khz = pdata->clock_khz;
+	pdata = (struct ocores_i2c_platform_data*) pdev->dev.platform_data;
+	if (pdata) {
+		i2c->regstep = pdata->regstep;
+		i2c->clock_khz = pdata->clock_khz;
+	} else {
+		ret = ocores_i2c_of_probe(pdev, i2c);
+		if (ret)
+			return ret;
+	}
+
 	ocores_init(i2c);
 
 	init_waitqueue_head(&i2c->wait);
@@ -265,6 +294,9 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	i2c->adap = ocores_adapter;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
+#ifdef CONFIG_OF
+	i2c->adap.dev.of_node = pdev->dev.of_node;
+#endif
 
 	/* add i2c adapter to i2c tree */
 	ret = i2c_add_adapter(&i2c->adap);
@@ -274,8 +306,10 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* add in known devices to the bus */
-	for (i = 0; i < pdata->num_devices; i++)
-		i2c_new_device(&i2c->adap, pdata->devices + i);
+	if (pdata) {
+		for (i = 0; i < pdata->num_devices; i++)
+			i2c_new_device(&i2c->adap, pdata->devices + i);
+	}
 
 	return 0;
 
@@ -344,6 +378,16 @@ static int ocores_i2c_resume(struct platform_device *pdev)
 #define ocores_i2c_resume	NULL
 #endif
 
+#ifdef CONFIG_OF
+static struct of_device_id ocores_i2c_match[] = {
+        {
+                .compatible = "opencores,i2c-ocores",
+        },
+        {},
+};
+MODULE_DEVICE_TABLE(of, ocores_i2c_match);
+#endif
+
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:ocores-i2c");
 
@@ -355,6 +399,9 @@ static struct platform_driver ocores_i2c_driver = {
 	.driver  = {
 		.owner = THIS_MODULE,
 		.name = "ocores-i2c",
+#ifdef CONFIG_OF
+                .of_match_table = ocores_i2c_match,
+#endif
 	},
 };
 
-- 
1.7.1
