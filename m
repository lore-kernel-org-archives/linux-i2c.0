From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] i2c-designware: add OF binding support
Date: Thu, 20 Oct 2011 13:55:27 -0700
Message-ID: <4EA08ABF.9030400@gmail.com>
References: <1319135390-11131-1-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1319135390-11131-1-git-send-email-robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10/20/2011 11:29 AM, Rob Herring wrote:
> From: Rob Herring<rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>
> Add of_match_table and DT style i2c registration to designware i2c
> driver.
>
> Signed-off-by: Rob Herring<rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Cc: Ben Dooks<ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
> Ben,
>
> Please apply. I've dropped moving of i2c functions into i2c core and
> reverted back to my original patch and addressed your's and Grant's
> comments:
>
> - use of_match_ptr()
> - always call i2c_add_numbered_adapter and drop ifdef
>
> Rob
>

This patch moves Rob's changes to apply on top of my patch series to split the 
designware i2c driver into core, platform and PCI parts.

LKML thread: https://lkml.org/lkml/2011/10/6/287

The only changes to Rob's patch is the file names changed.
------ SNIP SNIP -----

i2c-designware: Add devicetree i2c registration

From: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>

Add of_match_table and DT style i2c registration to designware i2c
driver.

Signed-off-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
  .../devicetree/bindings/i2c/i2c-designware.txt     |   23 ++++++++++++++++++++
  drivers/i2c/busses/i2c-designware-platdrv.c        |   12 ++++++++++
  2 files changed, 35 insertions(+), 0 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-designware.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt 
b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
new file mode 100644
index 0000000..cbcb404
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
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
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c 
b/drivers/i2c/busses/i2c-designware-platdrv.c
index 2d3657a..5244c47 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -34,6 +34,7 @@
  #include <linux/sched.h>
  #include <linux/err.h>
  #include <linux/interrupt.h>
+#include <linux/of_i2c.h>
  #include <linux/platform_device.h>
  #include <linux/io.h>
  #include <linux/slab.h>
@@ -137,6 +138,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
  			sizeof(adap->name));
  	adap->algo = &i2c_dw_algo;
  	adap->dev.parent = &pdev->dev;
+	adap->dev.of_node = pdev->dev.of_node;

  	adap->nr = pdev->id;
  	r = i2c_add_numbered_adapter(adap);
@@ -144,6 +146,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
  		dev_err(&pdev->dev, "failure adding adapter\n");
  		goto err_free_irq;
  	}
+	of_i2c_register_devices(adap);

  	return 0;

@@ -187,6 +190,14 @@ static int __devexit dw_i2c_remove(struct platform_device 
*pdev)
  	return 0;
  }

+#ifdef CONFIG_OF
+static const struct of_device_id dw_i2c_of_match[] = {
+	{ .compatible = "snps,designware-i2c", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
+#endif
+
  /* work with hotplug and coldplug */
  MODULE_ALIAS("platform:i2c_designware");

@@ -195,6 +206,7 @@ static struct platform_driver dw_i2c_driver = {
  	.driver		= {
  		.name	= "i2c_designware",
  		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(dw_i2c_of_match),
  	},
  };
