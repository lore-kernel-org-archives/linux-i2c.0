From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH 6/6] i2c: davinci: use devm_ functions
Date: Mon, 27 Aug 2012 21:53:21 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1208272152490.1938@localhost6.localdomain6>
References: <1345916499-6657-6-git-send-email-Julia.Lawall@lip6.fr> <503BA696.6080701@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <503BA696.6080701-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

The various devm_ functions allocate memory that is released when a driver
detaches.  This patch uses these functions for data that is allocated in
the probe function of a platform device and is only freed in the remove
function.

The call to platform_get_resource is moved down to the call to
devm_request_and_ioremap that uses it.

Signed-off-by: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

---
Not compiled.
I was not sure what to do with the comment on the first line, so I just
left it where it is.
I was also concerned about the calls to get_device and put_device, and
whether they would cause &pdev->dev to be freed before the devm-allocated
objects were freed.  Most other platform drivers don't seem to have these
calls.

v2: deleted the now unused ioarea variable and changed some label names to
be more meaningful.

  drivers/i2c/busses/i2c-davinci.c |   53 +++++++++------------------------------
  1 file changed, 13 insertions(+), 40 deletions(-)


diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index b6185dc..30afa7c 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -643,34 +643,20 @@ static int davinci_i2c_probe(struct platform_device *pdev)
  {
  	struct davinci_i2c_dev *dev;
  	struct i2c_adapter *adap;
-	struct resource *mem, *irq, *ioarea;
+	struct resource *mem, *irq;
  	int r;

  	/* NOTE: driver uses the static register mapping */
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "no mem resource?\n");
-		return -ENODEV;
-	}
-
  	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
  	if (!irq) {
  		dev_err(&pdev->dev, "no irq resource?\n");
  		return -ENODEV;
  	}

-	ioarea = request_mem_region(mem->start, resource_size(mem),
-				    pdev->name);
-	if (!ioarea) {
-		dev_err(&pdev->dev, "I2C region already claimed\n");
-		return -EBUSY;
-	}
-
-	dev = kzalloc(sizeof(struct davinci_i2c_dev), GFP_KERNEL);
-	if (!dev) {
-		r = -ENOMEM;
-		goto err_release_region;
-	}
+	dev = devm_kzalloc(&pdev->dev, sizeof(struct davinci_i2c_dev),
+			   GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;

  	init_completion(&dev->cmd_complete);
  #ifdef CONFIG_CPU_FREQ
@@ -699,22 +685,24 @@ static int davinci_i2c_probe(struct platform_device *pdev)
  		dev->pdata = &davinci_i2c_platform_data_default;
  	}

-	dev->clk = clk_get(&pdev->dev, NULL);
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
  	if (IS_ERR(dev->clk)) {
  		r = -ENODEV;
  		goto err_free_mem;
  	}
  	clk_enable(dev->clk);

-	dev->base = ioremap(mem->start, resource_size(mem));
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dev->base = devm_request_and_ioremap(&pdev->dev, mem);
  	if (!dev->base) {
  		r = -EBUSY;
-		goto err_mem_ioremap;
+		goto err_unuse_clocks;
  	}

  	i2c_davinci_init(dev);

-	r = request_irq(dev->irq, i2c_davinci_isr, 0, pdev->name, dev);
+	r = devm_request_irq(&pdev->dev, dev->irq, i2c_davinci_isr, 0,
+			     pdev->name, dev);
  	if (r) {
  		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
  		goto err_unuse_clocks;
@@ -723,7 +711,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
  	r = i2c_davinci_cpufreq_register(dev);
  	if (r) {
  		dev_err(&pdev->dev, "failed to register cpufreq\n");
-		goto err_free_irq;
+		goto err_unuse_clocks;
  	}

  	adap = &dev->adapter;
@@ -740,26 +728,18 @@ static int davinci_i2c_probe(struct platform_device *pdev)
  	r = i2c_add_numbered_adapter(adap);
  	if (r) {
  		dev_err(&pdev->dev, "failure adding adapter\n");
-		goto err_free_irq;
+		goto err_unuse_clocks;
  	}
  	of_i2c_register_devices(adap);

  	return 0;

-err_free_irq:
-	free_irq(dev->irq, dev);
  err_unuse_clocks:
-	iounmap(dev->base);
-err_mem_ioremap:
  	clk_disable(dev->clk);
-	clk_put(dev->clk);
  	dev->clk = NULL;
  err_free_mem:
  	platform_set_drvdata(pdev, NULL);
  	put_device(&pdev->dev);
-	kfree(dev);
-err_release_region:
-	release_mem_region(mem->start, resource_size(mem));

  	return r;
  }
@@ -767,7 +747,6 @@ err_release_region:
  static int davinci_i2c_remove(struct platform_device *pdev)
  {
  	struct davinci_i2c_dev *dev = platform_get_drvdata(pdev);
-	struct resource *mem;

  	i2c_davinci_cpufreq_deregister(dev);

@@ -776,16 +755,10 @@ static int davinci_i2c_remove(struct platform_device *pdev)
  	put_device(&pdev->dev);

  	clk_disable(dev->clk);
-	clk_put(dev->clk);
  	dev->clk = NULL;

  	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, 0);
-	free_irq(dev->irq, dev);
-	iounmap(dev->base);
-	kfree(dev);

-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, resource_size(mem));
  	return 0;
  }
