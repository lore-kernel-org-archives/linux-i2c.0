From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH] I2C: xiic: Add OF binding support
Date: Wed, 25 Apr 2012 15:48:53 +0200
Message-ID: <1335361733-24441-1-git-send-email-lars@metafoo.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/xiic.txt |   22 ++++++++++++++++++++++
 drivers/i2c/busses/i2c-xiic.c                  |   23 ++++++++++++++++++-----
 2 files changed, 40 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/xiic.txt

diff --git a/Documentation/devicetree/bindings/i2c/xiic.txt b/Documentation/devicetree/bindings/i2c/xiic.txt
new file mode 100644
index 0000000..ceabbe9
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/xiic.txt
@@ -0,0 +1,22 @@
+Xilinx IIC controller:
+
+Required properties:
+- compatible : Must be "xlnx,xps-iic-2.00.a"
+- reg : IIC register location and length
+- interrupts : IIC controller unterrupt
+- #address-cells = <1>
+- #size-cells = <0>
+
+Optional properties:
+- Child nodes conforming to i2c bus binding
+
+Example:
+
+	axi_iic_0: i2c@40800000 {
+		compatible = "xlnx,xps-iic-2.00.a";
+		interrupts = < 1 2 >;
+		reg = < 0x40800000 0x10000 >;
+
+		#size-cells = <0>;
+		#address-cells = <1>;
+	};
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 2bded76..641d0e5 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -40,6 +40,7 @@
 #include <linux/i2c-xiic.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/of_i2c.h>
 
 #define DRIVER_NAME "xiic-i2c"
 
@@ -705,8 +706,6 @@ static int __devinit xiic_i2c_probe(struct platform_device *pdev)
 		goto resource_missing;
 
 	pdata = (struct xiic_i2c_platform_data *) pdev->dev.platform_data;
-	if (!pdata)
-		return -EINVAL;
 
 	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
@@ -730,6 +729,7 @@ static int __devinit xiic_i2c_probe(struct platform_device *pdev)
 	i2c->adap = xiic_adapter;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
+	i2c->adap.dev.of_node = pdev->dev.of_node;
 
 	xiic_reinit(i2c);
 
@@ -748,9 +748,13 @@ static int __devinit xiic_i2c_probe(struct platform_device *pdev)
 		goto add_adapter_failed;
 	}
 
-	/* add in known devices to the bus */
-	for (i = 0; i < pdata->num_devices; i++)
-		i2c_new_device(&i2c->adap, pdata->devices + i);
+	if (pdata) {
+		/* add in known devices to the bus */
+		for (i = 0; i < pdata->num_devices; i++)
+			i2c_new_device(&i2c->adap, pdata->devices + i);
+	}
+
+	of_i2c_register_devices(&i2c->adap);
 
 	return 0;
 
@@ -795,12 +799,21 @@ static int __devexit xiic_i2c_remove(struct platform_device* pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id xiic_of_match[] __devinitconst = {
+	{ .compatible = "xlnx,xps-iic-2.00.a", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xiic_of_match);
+#endif
+
 static struct platform_driver xiic_i2c_driver = {
 	.probe   = xiic_i2c_probe,
 	.remove  = __devexit_p(xiic_i2c_remove),
 	.driver  = {
 		.owner = THIS_MODULE,
 		.name = DRIVER_NAME,
+		.of_match_table = of_match_ptr(xiic_of_match),
 	},
 };
 
-- 
1.7.9.5
