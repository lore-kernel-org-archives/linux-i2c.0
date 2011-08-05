From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] i2c-designware: add OF binding support
Date: Fri,  5 Aug 2011 16:24:28 -0500
Message-ID: <1312579468-19365-4-git-send-email-robherring2@gmail.com>
References: <1312579468-19365-1-git-send-email-robherring2@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312579468-19365-1-git-send-email-robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>

Add of_match_table and DT style i2c registration to designware i2c
driver.

Signed-off-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 Documentation/devicetree/bindings/i2c/dw-i2c.txt |   23 ++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware.c              |    8 +++++++
 2 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/dw-i2c.txt

diff --git a/Documentation/devicetree/bindings/i2c/dw-i2c.txt b/Documentation/devicetree/bindings/i2c/dw-i2c.txt
new file mode 100644
index 0000000..cbcb404
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/dw-i2c.txt
@@ -0,0 +1,23 @@
+* Synopsys DesignWare I2C
+
+Required properties :
+
+ - compatible : should be "snps,designware-i2c"
+ - reg : Offset and length of the register set for the device
+ - interrupts : <IRQ> where IRQ is the interrupt number.
+
+Recommended properties :
+
+ - clock-frequency : desired I2C bus clock frequency in Hz.
+
+Example :
+
+	i2c@f0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,designware-i2c";
+		reg = <0xf0000 0x1000>;
+		interrupts = <11>;
+		clock-frequency = <400000>;
+	};
+
diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index b7a51c4..0223b98 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -769,6 +769,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 			sizeof(adap->name));
 	adap->algo = &i2c_dw_algo;
 	adap->dev.parent = &pdev->dev;
+	adap->dev.of_node = pdev->dev.of_node;
 
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
@@ -819,6 +820,12 @@ static int __devexit dw_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id dw_i2c_of_match[] = {
+	{ .compatible = "snps,designware-i2c", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
+
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:i2c_designware");
 
@@ -827,6 +834,7 @@ static struct platform_driver dw_i2c_driver = {
 	.driver		= {
 		.name	= "i2c_designware",
 		.owner	= THIS_MODULE,
+		.of_match_table = dw_i2c_of_match,
 	},
 };
 
-- 
1.7.4.1
