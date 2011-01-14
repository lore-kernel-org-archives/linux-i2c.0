From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 4/9] i2c-designware: Add support for Designware core behind PCI devices.
Date: Fri, 14 Jan 2011 11:27:31 -0800
Message-ID: <1295033256-30077-5-git-send-email-dirk.brandewie@gmail.com>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295033256-30077-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Modify the driver to be a PCI driver from the platform template
created in the inital split of the driver.  Add controller config
options attached to PCI ID's. Add for the Moorsetown
and Medfield SOC's

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-pci.c |  244 +++++++++++++++++++++++--------
 1 files changed, 182 insertions(+), 62 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pci.c b/drivers/i2c/busses/i2c-designware-pci.c
index 11185b2..00717df 100644
--- a/drivers/i2c/busses/i2c-designware-pci.c
+++ b/drivers/i2c/busses/i2c-designware-pci.c
@@ -37,40 +37,156 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include "i2c-designware-core.h"
 
+#define DRIVER_NAME "i2c-designware-pci"
+#define STANDARD		0
+#define FAST			1
+#define HIGH			2
+
+enum dw_pci_ctl_id_t {
+	moorestown_0,
+	moorestown_1,
+	moorestown_2,
+
+	medfield_0,
+	medfield_1,
+	medfield_2,
+	medfield_3,
+	medfield_4,
+	medfield_5,
+};
+
+struct dw_pci_controller {
+	u32 bus_num;
+	u32 bus_speed;
+	u32 tx_fifo_depth;
+	u32 rx_fifo_depth;
+	u32 clk_khz;
+};
+
+static struct  dw_pci_controller  dw_pci_controllers[] = {
+	[moorestown_0] = {
+		.bus_num     = 0,
+		.bus_speed   = FAST,
+		.tx_fifo_depth = 64,
+		.rx_fifo_depth = 64,
+		.clk_khz      = 2500,
+	},
+	[moorestown_1] = {
+		.bus_num     = 1,
+		.bus_speed   = FAST,
+		.tx_fifo_depth = 64,
+		.rx_fifo_depth = 64,
+		.clk_khz      = 2500,
+	},
+	[moorestown_2] = {
+		.bus_num     = 2,
+		.bus_speed   = FAST,
+		.tx_fifo_depth = 64,
+		.rx_fifo_depth = 64,
+		.clk_khz      = 2500,
+	},
+	[medfield_0] = {
+		.bus_num     = 0,
+		.bus_speed   = FAST,
+		.tx_fifo_depth = 64,
+		.rx_fifo_depth = 64,
+		.clk_khz      = 2500,
+	},
+	[medfield_1] = {
+		.bus_num     = 1,
+		.bus_speed   = FAST,
+		.tx_fifo_depth = 64,
+		.rx_fifo_depth = 64,
+		.clk_khz      = 2500,
+	},
+	[medfield_2] = {
+		.bus_num     = 2,
+		.bus_speed   = FAST,
+		.tx_fifo_depth = 64,
+		.rx_fifo_depth = 64,
+		.clk_khz      = 2500,
+	},
+	[medfield_3] = {
+		.bus_num     = 3,
+		.bus_speed   = STANDARD,
+		.tx_fifo_depth = 64,
+		.rx_fifo_depth = 64,
+		.clk_khz      = 2500,
+	},
+	[medfield_4] = {
+		.bus_num     = 4,
+		.bus_speed   = FAST,
+		.tx_fifo_depth = 64,
+		.rx_fifo_depth = 64,
+		.clk_khz      = 2500,
+	},
+	[medfield_5] = {
+		.bus_num     = 5,
+		.bus_speed   = FAST,
+		.tx_fifo_depth = 64,
+		.rx_fifo_depth = 64,
+		.clk_khz      = 2500,
+	},
+};
 static struct i2c_algorithm i2c_dw_algo = {
 	.master_xfer	= i2c_dw_xfer,
 	.functionality	= i2c_dw_func,
 };
 
-static int __devinit dw_i2c_probe(struct platform_device *pdev)
+static int __devinit dw_i2c_pci_probe(struct pci_dev *pdev,
+const struct pci_device_id *id)
 {
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
-	struct resource *mem, *ioarea;
-	int irq, r;
+	unsigned long start, len;
+	void __iomem *base;
+	int r;
+	struct  dw_pci_controller *controller;
 
-	/* NOTE: driver uses the static register mapping */
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "no mem resource?\n");
+	if (id->driver_data >= ARRAY_SIZE(dw_pci_controllers)) {
+		printk(KERN_ERR "dw_i2c_pci_probe: invalid driver data %ld\n",
+			id->driver_data);
 		return -EINVAL;
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
-		return irq; /* -ENXIO */
+	controller = &dw_pci_controllers[id->driver_data];
+
+	r = pci_enable_device(pdev);
+	if (r) {
+		dev_err(&pdev->dev, "Failed to enable I2C PCI device (%d)\n",
+			r);
+		goto exit;
+	}
+
+	/* Determine the address of the I2C area */
+	start = pci_resource_start(pdev, 0);
+	len = pci_resource_len(pdev, 0);
+	if (!start || len == 0) {
+		dev_err(&pdev->dev, "base address not set\n");
+		r = -ENODEV;
+		goto exit;
+	}
+
+	r = pci_request_region(pdev, 0, DRIVER_NAME);
+	if (r) {
+		dev_err(&pdev->dev, "failed to request I2C region "
+			"0x%lx-0x%lx\n", start,
+			(unsigned long)pci_resource_end(pdev, 0));
+		goto exit;
 	}
 
-	ioarea = request_mem_region(mem->start, resource_size(mem),
-			pdev->name);
-	if (!ioarea) {
-		dev_err(&pdev->dev, "I2C region already claimed\n");
-		return -EBUSY;
+	base = ioremap_nocache(start, len);
+	if (!base) {
+		dev_err(&pdev->dev, "I/O memory remapping failed\n");
+		r = -ENOMEM;
+		goto err_release_region;
 	}
 
+
 	dev = kzalloc(sizeof(struct dw_i2c_dev), GFP_KERNEL);
 	if (!dev) {
 		r = -ENOMEM;
@@ -79,31 +195,17 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 
 	init_completion(&dev->cmd_complete);
 	mutex_init(&dev->lock);
+	dev->clk = NULL;
+	dev->clk_khz = controller->clk_khz;
+	dev->base = base;
 	dev->dev = get_device(&pdev->dev);
-	dev->irq = irq;
-	platform_set_drvdata(pdev, dev);
-
+	pci_set_drvdata(pdev, dev);
 
-	dev->base = ioremap(mem->start, resource_size(mem));
-	if (dev->base == NULL) {
-		dev_err(&pdev->dev, "failure mapping io resources\n");
-		r = -EBUSY;
-		goto err_unuse_clocks;
-	}
-	{
-		u32 param1 = readl(dev->base + DW_IC_COMP_PARAM_1);
+	dev->tx_fifo_depth = controller->tx_fifo_depth;
+	dev->rx_fifo_depth = controller->rx_fifo_depth;
 
-		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
-		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
-	}
 	i2c_dw_init(dev);
 
-	writel(0, dev->base + DW_IC_INTR_MASK); /* disable IRQ */
-	r = request_irq(dev->irq, i2c_dw_isr, IRQF_DISABLED, pdev->name, dev);
-	if (r) {
-		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
-		goto err_iounmap;
-	}
 
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
@@ -114,7 +216,15 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	adap->algo = &i2c_dw_algo;
 	adap->dev.parent = &pdev->dev;
 
-	adap->nr = pdev->id;
+	adap->nr = controller->bus_num;
+
+	writel(0, dev->base + DW_IC_INTR_MASK); /* disable IRQ */
+	r = request_irq(pdev->irq, i2c_dw_isr, IRQF_SHARED, adap->name, dev);
+	if (r) {
+		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
+		goto err_iounmap;
+	}
+
 	r = i2c_add_numbered_adapter(adap);
 	if (r) {
 		dev_err(&pdev->dev, "failure adding adapter\n");
@@ -124,60 +234,70 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_irq:
-	free_irq(dev->irq, dev);
+	free_irq(pdev->irq, dev);
 err_iounmap:
 	iounmap(dev->base);
-err_free_mem:
-	platform_set_drvdata(pdev, NULL);
+	pci_set_drvdata(pdev, NULL);
 	put_device(&pdev->dev);
 	kfree(dev);
 err_release_region:
-	release_mem_region(mem->start, resource_size(mem));
-
+	pci_release_region(pdev, 0);
+exit:
 	return r;
 }
 
-static int __devexit dw_i2c_remove(struct platform_device *pdev)
+static void __devexit dw_i2c_pci_remove(struct pci_dev *pdev)
 {
-	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
-	struct resource *mem;
+	struct dw_i2c_dev *dev = pci_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
+	writel(0, dev->base + DW_IC_ENABLE);
+	pci_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&dev->adapter);
 	put_device(&pdev->dev);
 
-	writel(0, dev->base + DW_IC_ENABLE);
 	free_irq(dev->irq, dev);
 	kfree(dev);
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, resource_size(mem));
-	return 0;
+	pci_release_region(pdev, 0);
 }
 
 /* work with hotplug and coldplug */
-MODULE_ALIAS("platform:i2c_designware");
+MODULE_ALIAS("i2c_designware-pci");
 
-static struct platform_driver dw_i2c_driver = {
-	.remove		= __devexit_p(dw_i2c_remove),
-	.driver		= {
-		.name	= "i2c_designware",
-		.owner	= THIS_MODULE,
-	},
+static struct pci_device_id i2_designware_pci_ids[] = {
+	/* Moorestown */
+	{ PCI_VDEVICE(INTEL, 0x0802), moorestown_0 },
+	{ PCI_VDEVICE(INTEL, 0x0803), moorestown_1 },
+	{ PCI_VDEVICE(INTEL, 0x0804), moorestown_2 },
+	/* Medfield */
+	{ PCI_VDEVICE(INTEL, 0x0817), medfield_3,},
+	{ PCI_VDEVICE(INTEL, 0x0818), medfield_4 },
+	{ PCI_VDEVICE(INTEL, 0x0819), medfield_5 },
+	{ PCI_VDEVICE(INTEL, 0x082C), medfield_0 },
+	{ PCI_VDEVICE(INTEL, 0x082D), medfield_1 },
+	{ PCI_VDEVICE(INTEL, 0x082E), medfield_2 },
+	{ 0,}
+};
+MODULE_DEVICE_TABLE(pci, i2_designware_pci_ids);
+
+static struct pci_driver dw_i2c_driver = {
+	.name		= DRIVER_NAME,
+	.id_table	= i2_designware_pci_ids,
+	.probe		= dw_i2c_pci_probe,
+	.remove		= __devexit_p(dw_i2c_pci_remove),
 };
 
 static int __init dw_i2c_init_driver(void)
 {
-	return platform_driver_probe(&dw_i2c_driver, dw_i2c_probe);
+	return  pci_register_driver(&dw_i2c_driver);
 }
 module_init(dw_i2c_init_driver);
 
 static void __exit dw_i2c_exit_driver(void)
 {
-	platform_driver_unregister(&dw_i2c_driver);
+	pci_unregister_driver(&dw_i2c_driver);
 }
 module_exit(dw_i2c_exit_driver);
 
-MODULE_AUTHOR("Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>");
-MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter");
+MODULE_AUTHOR("Dirk Brandewie <dirk.j.brandewie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org");
+MODULE_DESCRIPTION("Synopsys DesignWare PCI I2C bus adapter");
 MODULE_LICENSE("GPL");
-- 
1.7.3.4
