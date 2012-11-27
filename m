From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 01/16] i2c/busses: remove __dev* attributes
Date: Tue, 27 Nov 2012 15:59:38 -0500
Message-ID: <1354049993-12718-2-git-send-email-wfp5p@virginia.edu>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
---
 drivers/i2c/busses/i2c-at91.c               | 14 +++++------
 drivers/i2c/busses/i2c-au1550.c             |  6 ++---
 drivers/i2c/busses/i2c-designware-pcidrv.c  |  6 ++---
 drivers/i2c/busses/i2c-designware-platdrv.c |  6 ++---
 drivers/i2c/busses/i2c-eg20t.c              |  6 ++---
 drivers/i2c/busses/i2c-elektor.c            |  8 +++---
 drivers/i2c/busses/i2c-highlander.c         |  6 ++---
 drivers/i2c/busses/i2c-hydra.c              |  6 ++---
 drivers/i2c/busses/i2c-ibm_iic.c            |  8 +++---
 drivers/i2c/busses/i2c-intel-mid.c          |  6 ++---
 drivers/i2c/busses/i2c-mpc.c                | 38 ++++++++++++++---------------
 drivers/i2c/busses/i2c-mv64xxx.c            | 18 +++++++-------
 drivers/i2c/busses/i2c-mxs.c                |  6 ++---
 drivers/i2c/busses/i2c-nuc900.c             |  6 ++---
 drivers/i2c/busses/i2c-octeon.c             | 10 ++++----
 drivers/i2c/busses/i2c-pmcmsp.c             |  6 ++---
 drivers/i2c/busses/i2c-powermac.c           | 16 ++++++------
 drivers/i2c/busses/i2c-pxa-pci.c            |  6 ++---
 drivers/i2c/busses/i2c-rcar.c               |  6 ++---
 drivers/i2c/busses/i2c-s6000.c              |  8 +++---
 drivers/i2c/busses/i2c-sh7760.c             |  8 +++---
 drivers/i2c/busses/i2c-sh_mobile.c          |  2 +-
 drivers/i2c/busses/i2c-tegra.c              |  8 +++---
 drivers/i2c/busses/i2c-viperboard.c         |  6 ++---
 drivers/i2c/busses/i2c-xiic.c               |  8 +++---
 drivers/i2c/busses/i2c-xlr.c                |  6 ++---
 drivers/i2c/muxes/i2c-mux-pinctrl.c         |  8 +++---
 27 files changed, 119 insertions(+), 119 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index b4575ee..6d65d9c 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -145,7 +145,7 @@ static void at91_init_twi_bus(struct at91_twi_dev *dev)
  * Calculate symmetric clock as stated in datasheet:
  * twi_clk = F_MAIN / (2 * (cdiv * (1 << ckdiv) + offset))
  */
-static void __devinit at91_calc_twi_clock(struct at91_twi_dev *dev, int twi_clk)
+static void at91_calc_twi_clock(struct at91_twi_dev *dev, int twi_clk)
 {
 	int ckdiv, cdiv, div;
 	struct at91_twi_pdata *pdata = dev->pdata;
@@ -604,7 +604,7 @@ MODULE_DEVICE_TABLE(of, atmel_twi_dt_ids);
 #define atmel_twi_dt_ids NULL
 #endif
 
-static bool __devinit filter(struct dma_chan *chan, void *slave)
+static bool filter(struct dma_chan *chan, void *slave)
 {
 	struct at_dma_slave *sl = slave;
 
@@ -616,7 +616,7 @@ static bool __devinit filter(struct dma_chan *chan, void *slave)
 	}
 }
 
-static int __devinit at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
+static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 {
 	int ret = 0;
 	struct at_dma_slave *sdata;
@@ -688,7 +688,7 @@ error:
 	return ret;
 }
 
-static struct at91_twi_pdata * __devinit at91_twi_get_driver_data(
+static struct at91_twi_pdata * at91_twi_get_driver_data(
 					struct platform_device *pdev)
 {
 	if (pdev->dev.of_node) {
@@ -701,7 +701,7 @@ static struct at91_twi_pdata * __devinit at91_twi_get_driver_data(
 	return (struct at91_twi_pdata *) platform_get_device_id(pdev)->driver_data;
 }
 
-static int __devinit at91_twi_probe(struct platform_device *pdev)
+static int at91_twi_probe(struct platform_device *pdev)
 {
 	struct at91_twi_dev *dev;
 	struct resource *mem;
@@ -779,7 +779,7 @@ static int __devinit at91_twi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit at91_twi_remove(struct platform_device *pdev)
+static int at91_twi_remove(struct platform_device *pdev)
 {
 	struct at91_twi_dev *dev = platform_get_drvdata(pdev);
 	int rc;
@@ -820,7 +820,7 @@ static const struct dev_pm_ops at91_twi_pm = {
 
 static struct platform_driver at91_twi_driver = {
 	.probe		= at91_twi_probe,
-	.remove		= __devexit_p(at91_twi_remove),
+	.remove		= at91_twi_remove,
 	.id_table	= at91_twi_devtypes,
 	.driver		= {
 		.name	= "at91_i2c",
diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 582d616..b278298 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -313,7 +313,7 @@ static void i2c_au1550_disable(struct i2c_au1550_data *priv)
  * Prior to calling us, the 50MHz clock frequency and routing
  * must have been set up for the PSC indicated by the adapter.
  */
-static int __devinit
+static int
 i2c_au1550_probe(struct platform_device *pdev)
 {
 	struct i2c_au1550_data *priv;
@@ -372,7 +372,7 @@ out:
 	return ret;
 }
 
-static int __devexit i2c_au1550_remove(struct platform_device *pdev)
+static int i2c_au1550_remove(struct platform_device *pdev)
 {
 	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
 
@@ -423,7 +423,7 @@ static struct platform_driver au1xpsc_smbus_driver = {
 		.pm	= AU1XPSC_SMBUS_PMOPS,
 	},
 	.probe		= i2c_au1550_probe,
-	.remove		= __devexit_p(i2c_au1550_remove),
+	.remove		= i2c_au1550_remove,
 };
 
 module_platform_driver(au1xpsc_smbus_driver);
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 92a1e2c..6add851 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -207,7 +207,7 @@ static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
 	return dev->controller->clk_khz;
 }
 
-static int __devinit i2c_dw_pci_probe(struct pci_dev *pdev,
+static int i2c_dw_pci_probe(struct pci_dev *pdev,
 const struct pci_device_id *id)
 {
 	struct dw_i2c_dev *dev;
@@ -328,7 +328,7 @@ exit:
 	return r;
 }
 
-static void __devexit i2c_dw_pci_remove(struct pci_dev *pdev)
+static void i2c_dw_pci_remove(struct pci_dev *pdev)
 {
 	struct dw_i2c_dev *dev = pci_get_drvdata(pdev);
 
@@ -368,7 +368,7 @@ static struct pci_driver dw_i2c_driver = {
 	.name		= DRIVER_NAME,
 	.id_table	= i2_designware_pci_ids,
 	.probe		= i2c_dw_pci_probe,
-	.remove		= __devexit_p(i2c_dw_pci_remove),
+	.remove		= i2c_dw_pci_remove,
 	.driver         = {
 		.pm     = &i2c_dw_pm_ops,
 	},
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0506fef..343357a 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -50,7 +50,7 @@ static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
 	return clk_get_rate(dev->clk)/1000;
 }
 
-static int __devinit dw_i2c_probe(struct platform_device *pdev)
+static int dw_i2c_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
@@ -169,7 +169,7 @@ err_release_region:
 	return r;
 }
 
-static int __devexit dw_i2c_remove(struct platform_device *pdev)
+static int dw_i2c_remove(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 	struct resource *mem;
@@ -228,7 +228,7 @@ static SIMPLE_DEV_PM_OPS(dw_i2c_dev_pm_ops, dw_i2c_suspend, dw_i2c_resume);
 MODULE_ALIAS("platform:i2c_designware");
 
 static struct platform_driver dw_i2c_driver = {
-	.remove		= __devexit_p(dw_i2c_remove),
+	.remove		= dw_i2c_remove,
 	.driver		= {
 		.name	= "i2c_designware",
 		.owner	= THIS_MODULE,
diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 259f769..5e7886e7 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -758,7 +758,7 @@ static void pch_i2c_disbl_int(struct i2c_algo_pch_data *adap)
 	iowrite32(BUFFER_MODE_INTR_DISBL, p + PCH_I2CBUFMSK);
 }
 
-static int __devinit pch_i2c_probe(struct pci_dev *pdev,
+static int pch_i2c_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
 	void __iomem *base_addr;
@@ -851,7 +851,7 @@ err_pci_enable:
 	return ret;
 }
 
-static void __devexit pch_i2c_remove(struct pci_dev *pdev)
+static void pch_i2c_remove(struct pci_dev *pdev)
 {
 	int i;
 	struct adapter_info *adap_info = pci_get_drvdata(pdev);
@@ -948,7 +948,7 @@ static struct pci_driver pch_pcidriver = {
 	.name = KBUILD_MODNAME,
 	.id_table = pch_pcidev_id,
 	.probe = pch_i2c_probe,
-	.remove = __devexit_p(pch_i2c_remove),
+	.remove = pch_i2c_remove,
 	.suspend = pch_i2c_suspend,
 	.resume = pch_i2c_resume
 };
diff --git a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
index 37e2e82..4854970 100644
--- a/drivers/i2c/busses/i2c-elektor.c
+++ b/drivers/i2c/busses/i2c-elektor.c
@@ -205,7 +205,7 @@ static struct i2c_adapter pcf_isa_ops = {
 	.name		= "i2c-elektor",
 };
 
-static int __devinit elektor_match(struct device *dev, unsigned int id)
+static int elektor_match(struct device *dev, unsigned int id)
 {
 #ifdef __alpha__
 	/* check to see we have memory mapped PCF8584 connected to the
@@ -264,7 +264,7 @@ static int __devinit elektor_match(struct device *dev, unsigned int id)
 	return 1;
 }
 
-static int __devinit elektor_probe(struct device *dev, unsigned int id)
+static int elektor_probe(struct device *dev, unsigned int id)
 {
 	init_waitqueue_head(&pcf_wait);
 	if (pcf_isa_init())
@@ -293,7 +293,7 @@ static int __devinit elektor_probe(struct device *dev, unsigned int id)
 	return -ENODEV;
 }
 
-static int __devexit elektor_remove(struct device *dev, unsigned int id)
+static int elektor_remove(struct device *dev, unsigned int id)
 {
 	i2c_del_adapter(&pcf_isa_ops);
 
@@ -316,7 +316,7 @@ static int __devexit elektor_remove(struct device *dev, unsigned int id)
 static struct isa_driver i2c_elektor_driver = {
 	.match		= elektor_match,
 	.probe		= elektor_probe,
-	.remove		= __devexit_p(elektor_remove),
+	.remove		= elektor_remove,
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= "i2c-elektor",
diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c-highlander.c
index 19515df..3351cc7 100644
--- a/drivers/i2c/busses/i2c-highlander.c
+++ b/drivers/i2c/busses/i2c-highlander.c
@@ -356,7 +356,7 @@ static const struct i2c_algorithm highlander_i2c_algo = {
 	.functionality	= highlander_i2c_func,
 };
 
-static int __devinit highlander_i2c_probe(struct platform_device *pdev)
+static int highlander_i2c_probe(struct platform_device *pdev)
 {
 	struct highlander_i2c_dev *dev;
 	struct i2c_adapter *adap;
@@ -441,7 +441,7 @@ err:
 	return ret;
 }
 
-static int __devexit highlander_i2c_remove(struct platform_device *pdev)
+static int highlander_i2c_remove(struct platform_device *pdev)
 {
 	struct highlander_i2c_dev *dev = platform_get_drvdata(pdev);
 
@@ -465,7 +465,7 @@ static struct platform_driver highlander_i2c_driver = {
 	},
 
 	.probe		= highlander_i2c_probe,
-	.remove		= __devexit_p(highlander_i2c_remove),
+	.remove		= highlander_i2c_remove,
 };
 
 module_platform_driver(highlander_i2c_driver);
diff --git a/drivers/i2c/busses/i2c-hydra.c b/drivers/i2c/busses/i2c-hydra.c
index c9f95e1..79c3d90 100644
--- a/drivers/i2c/busses/i2c-hydra.c
+++ b/drivers/i2c/busses/i2c-hydra.c
@@ -112,7 +112,7 @@ static DEFINE_PCI_DEVICE_TABLE(hydra_ids) = {
 
 MODULE_DEVICE_TABLE (pci, hydra_ids);
 
-static int __devinit hydra_probe(struct pci_dev *dev,
+static int hydra_probe(struct pci_dev *dev,
 				 const struct pci_device_id *id)
 {
 	unsigned long base = pci_resource_start(dev, 0);
@@ -139,7 +139,7 @@ static int __devinit hydra_probe(struct pci_dev *dev,
 	return 0;
 }
 
-static void __devexit hydra_remove(struct pci_dev *dev)
+static void hydra_remove(struct pci_dev *dev)
 {
 	pdregw(hydra_bit_data.data, 0);		/* clear SCLK_OE and SDAT_OE */
 	i2c_del_adapter(&hydra_adap);
@@ -153,7 +153,7 @@ static struct pci_driver hydra_driver = {
 	.name		= "hydra_smbus",
 	.id_table	= hydra_ids,
 	.probe		= hydra_probe,
-	.remove		= __devexit_p(hydra_remove),
+	.remove		= hydra_remove,
 };
 
 module_pci_driver(hydra_driver);
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 806e225..33a2abb 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -660,7 +660,7 @@ static inline u8 iic_clckdiv(unsigned int opb)
 	return (u8)((opb + 9) / 10 - 1);
 }
 
-static int __devinit iic_request_irq(struct platform_device *ofdev,
+static int iic_request_irq(struct platform_device *ofdev,
 				     struct ibm_iic_private *dev)
 {
 	struct device_node *np = ofdev->dev.of_node;
@@ -691,7 +691,7 @@ static int __devinit iic_request_irq(struct platform_device *ofdev,
 /*
  * Register single IIC interface
  */
-static int __devinit iic_probe(struct platform_device *ofdev)
+static int iic_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
 	struct ibm_iic_private *dev;
@@ -781,7 +781,7 @@ error_cleanup:
 /*
  * Cleanup initialized IIC interface
  */
-static int __devexit iic_remove(struct platform_device *ofdev)
+static int iic_remove(struct platform_device *ofdev)
 {
 	struct ibm_iic_private *dev = dev_get_drvdata(&ofdev->dev);
 
@@ -812,7 +812,7 @@ static struct platform_driver ibm_iic_driver = {
 		.of_match_table = ibm_iic_match,
 	},
 	.probe	= iic_probe,
-	.remove	= __devexit_p(iic_remove),
+	.remove	= iic_remove,
 };
 
 module_platform_driver(ibm_iic_driver);
diff --git a/drivers/i2c/busses/i2c-intel-mid.c b/drivers/i2c/busses/i2c-intel-mid.c
index 7c28f10..de3736b 100644
--- a/drivers/i2c/busses/i2c-intel-mid.c
+++ b/drivers/i2c/busses/i2c-intel-mid.c
@@ -947,7 +947,7 @@ static const struct dev_pm_ops intel_mid_i2c_pm_ops = {
  * 5. Call intel_mid_i2c_hwinit() for hardware initialization
  * 6. Register I2C adapter in i2c-core
  */
-static int __devinit intel_mid_i2c_probe(struct pci_dev *dev,
+static int intel_mid_i2c_probe(struct pci_dev *dev,
 				    const struct pci_device_id *id)
 {
 	struct intel_mid_i2c_private *mrst;
@@ -1079,7 +1079,7 @@ exit:
 	return err;
 }
 
-static void __devexit intel_mid_i2c_remove(struct pci_dev *dev)
+static void intel_mid_i2c_remove(struct pci_dev *dev)
 {
 	struct intel_mid_i2c_private *mrst = pci_get_drvdata(dev);
 	intel_mid_i2c_disable(&mrst->adap);
@@ -1113,7 +1113,7 @@ static struct pci_driver intel_mid_i2c_driver = {
 	.name		= DRIVER_NAME,
 	.id_table	= intel_mid_i2c_ids,
 	.probe		= intel_mid_i2c_probe,
-	.remove		= __devexit_p(intel_mid_i2c_remove),
+	.remove		= intel_mid_i2c_remove,
 };
 
 module_pci_driver(intel_mid_i2c_driver);
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index ca86430..a69459e 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -175,7 +175,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 }
 
 #if defined(CONFIG_PPC_MPC52xx) || defined(CONFIG_PPC_MPC512x)
-static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] __devinitconst = {
+static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] = {
 	{20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
 	{28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
 	{36, 0x26}, {40, 0x27}, {44, 0x04}, {48, 0x28},
@@ -196,7 +196,7 @@ static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] __devinitconst = {
 	{10240, 0x9d}, {12288, 0x9e}, {15360, 0x9f}
 };
 
-static int __devinit mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock,
+static int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock,
 					  int prescaler, u32 *real_clk)
 {
 	const struct mpc_i2c_divider *div = NULL;
@@ -230,7 +230,7 @@ static int __devinit mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock,
 	return (int)div->fdr;
 }
 
-static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
+static void mpc_i2c_setup_52xx(struct device_node *node,
 					 struct mpc_i2c *i2c,
 					 u32 clock, u32 prescaler)
 {
@@ -252,7 +252,7 @@ static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
 			 fdr);
 }
 #else /* !(CONFIG_PPC_MPC52xx || CONFIG_PPC_MPC512x) */
-static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
+static void mpc_i2c_setup_52xx(struct device_node *node,
 					 struct mpc_i2c *i2c,
 					 u32 clock, u32 prescaler)
 {
@@ -260,7 +260,7 @@ static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
 #endif /* CONFIG_PPC_MPC52xx || CONFIG_PPC_MPC512x */
 
 #ifdef CONFIG_PPC_MPC512x
-static void __devinit mpc_i2c_setup_512x(struct device_node *node,
+static void mpc_i2c_setup_512x(struct device_node *node,
 					 struct mpc_i2c *i2c,
 					 u32 clock, u32 prescaler)
 {
@@ -288,7 +288,7 @@ static void __devinit mpc_i2c_setup_512x(struct device_node *node,
 	mpc_i2c_setup_52xx(node, i2c, clock, prescaler);
 }
 #else /* CONFIG_PPC_MPC512x */
-static void __devinit mpc_i2c_setup_512x(struct device_node *node,
+static void mpc_i2c_setup_512x(struct device_node *node,
 					 struct mpc_i2c *i2c,
 					 u32 clock, u32 prescaler)
 {
@@ -296,7 +296,7 @@ static void __devinit mpc_i2c_setup_512x(struct device_node *node,
 #endif /* CONFIG_PPC_MPC512x */
 
 #ifdef CONFIG_FSL_SOC
-static const struct mpc_i2c_divider mpc_i2c_dividers_8xxx[] __devinitconst = {
+static const struct mpc_i2c_divider mpc_i2c_dividers_8xxx[] = {
 	{160, 0x0120}, {192, 0x0121}, {224, 0x0122}, {256, 0x0123},
 	{288, 0x0100}, {320, 0x0101}, {352, 0x0601}, {384, 0x0102},
 	{416, 0x0602}, {448, 0x0126}, {480, 0x0103}, {512, 0x0127},
@@ -316,7 +316,7 @@ static const struct mpc_i2c_divider mpc_i2c_dividers_8xxx[] __devinitconst = {
 	{49152, 0x011e}, {61440, 0x011f}
 };
 
-static u32 __devinit mpc_i2c_get_sec_cfg_8xxx(void)
+static u32 mpc_i2c_get_sec_cfg_8xxx(void)
 {
 	struct device_node *node = NULL;
 	u32 __iomem *reg;
@@ -345,7 +345,7 @@ static u32 __devinit mpc_i2c_get_sec_cfg_8xxx(void)
 	return val;
 }
 
-static int __devinit mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
+static int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
 					  u32 prescaler, u32 *real_clk)
 {
 	const struct mpc_i2c_divider *div = NULL;
@@ -383,7 +383,7 @@ static int __devinit mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
 	return div ? (int)div->fdr : -EINVAL;
 }
 
-static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
+static void mpc_i2c_setup_8xxx(struct device_node *node,
 					 struct mpc_i2c *i2c,
 					 u32 clock, u32 prescaler)
 {
@@ -408,7 +408,7 @@ static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
 }
 
 #else /* !CONFIG_FSL_SOC */
-static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
+static void mpc_i2c_setup_8xxx(struct device_node *node,
 					 struct mpc_i2c *i2c,
 					 u32 clock, u32 prescaler)
 {
@@ -615,7 +615,7 @@ static struct i2c_adapter mpc_ops = {
 };
 
 static const struct of_device_id mpc_i2c_of_match[];
-static int __devinit fsl_i2c_probe(struct platform_device *op)
+static int fsl_i2c_probe(struct platform_device *op)
 {
 	const struct of_device_id *match;
 	struct mpc_i2c *i2c;
@@ -706,7 +706,7 @@ static int __devinit fsl_i2c_probe(struct platform_device *op)
 	return result;
 };
 
-static int __devexit fsl_i2c_remove(struct platform_device *op)
+static int fsl_i2c_remove(struct platform_device *op)
 {
 	struct mpc_i2c *i2c = dev_get_drvdata(&op->dev);
 
@@ -746,24 +746,24 @@ static int mpc_i2c_resume(struct device *dev)
 SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
 #endif
 
-static const struct mpc_i2c_data mpc_i2c_data_512x __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_512x = {
 	.setup = mpc_i2c_setup_512x,
 };
 
-static const struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_52xx = {
 	.setup = mpc_i2c_setup_52xx,
 };
 
-static const struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8313 = {
 	.setup = mpc_i2c_setup_8xxx,
 };
 
-static const struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8543 = {
 	.setup = mpc_i2c_setup_8xxx,
 	.prescaler = 2,
 };
 
-static const struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8544 = {
 	.setup = mpc_i2c_setup_8xxx,
 	.prescaler = 3,
 };
@@ -785,7 +785,7 @@ MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
 /* Structure for a device driver */
 static struct platform_driver mpc_i2c_driver = {
 	.probe		= fsl_i2c_probe,
-	.remove		= __devexit_p(fsl_i2c_remove),
+	.remove		= fsl_i2c_remove,
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = DRV_NAME,
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 2e9d567..8b20ef8 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -495,7 +495,7 @@ static const struct i2c_algorithm mv64xxx_i2c_algo = {
  *
  *****************************************************************************
  */
-static int __devinit
+static int
 mv64xxx_i2c_map_regs(struct platform_device *pd,
 	struct mv64xxx_i2c_data *drv_data)
 {
@@ -530,13 +530,13 @@ mv64xxx_i2c_unmap_regs(struct mv64xxx_i2c_data *drv_data)
 }
 
 #ifdef CONFIG_OF
-static int __devinit
+static int
 mv64xxx_calc_freq(const int tclk, const int n, const int m)
 {
 	return tclk / (10 * (m + 1) * (2 << n));
 }
 
-static bool __devinit
+static bool
 mv64xxx_find_baud_factors(const u32 req_freq, const u32 tclk, u32 *best_n,
 			  u32 *best_m)
 {
@@ -560,7 +560,7 @@ mv64xxx_find_baud_factors(const u32 req_freq, const u32 tclk, u32 *best_n,
 	return true;
 }
 
-static int __devinit
+static int
 mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		  struct device_node *np)
 {
@@ -597,7 +597,7 @@ out:
 #endif
 }
 #else /* CONFIG_OF */
-static int __devinit
+static int
 mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		  struct device_node *np)
 {
@@ -605,7 +605,7 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 }
 #endif /* CONFIG_OF */
 
-static int __devinit
+static int
 mv64xxx_i2c_probe(struct platform_device *pd)
 {
 	struct mv64xxx_i2c_data		*drv_data;
@@ -697,7 +697,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	return rc;
 }
 
-static int __devexit
+static int
 mv64xxx_i2c_remove(struct platform_device *dev)
 {
 	struct mv64xxx_i2c_data		*drv_data = platform_get_drvdata(dev);
@@ -718,7 +718,7 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 	return rc;
 }
 
-static const struct of_device_id mv64xxx_i2c_of_match_table[] __devinitdata = {
+static const struct of_device_id mv64xxx_i2c_of_match_table[] = {
 	{ .compatible = "marvell,mv64xxx-i2c", },
 	{}
 };
@@ -726,7 +726,7 @@ MODULE_DEVICE_TABLE(of, mv64xxx_i2c_of_match_table);
 
 static struct platform_driver mv64xxx_i2c_driver = {
 	.probe	= mv64xxx_i2c_probe,
-	.remove	= __devexit_p(mv64xxx_i2c_remove),
+	.remove	= mv64xxx_i2c_remove,
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= MV64XXX_I2C_CTLR_NAME,
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 6ed53da..1b1a936 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -432,7 +432,7 @@ static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
 	return 0;
 }
 
-static int __devinit mxs_i2c_probe(struct platform_device *pdev)
+static int mxs_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mxs_i2c_dev *i2c;
@@ -515,7 +515,7 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit mxs_i2c_remove(struct platform_device *pdev)
+static int mxs_i2c_remove(struct platform_device *pdev)
 {
 	struct mxs_i2c_dev *i2c = platform_get_drvdata(pdev);
 	int ret;
@@ -546,7 +546,7 @@ static struct platform_driver mxs_i2c_driver = {
 		   .owner = THIS_MODULE,
 		   .of_match_table = mxs_i2c_dt_ids,
 		   },
-	.remove = __devexit_p(mxs_i2c_remove),
+	.remove = mxs_i2c_remove,
 };
 
 static int __init mxs_i2c_init(void)
diff --git a/drivers/i2c/busses/i2c-nuc900.c b/drivers/i2c/busses/i2c-nuc900.c
index a23b91b..865ee35 100644
--- a/drivers/i2c/busses/i2c-nuc900.c
+++ b/drivers/i2c/busses/i2c-nuc900.c
@@ -518,7 +518,7 @@ static const struct i2c_algorithm nuc900_i2c_algorithm = {
  * called by the bus driver when a suitable device is found
 */
 
-static int __devinit nuc900_i2c_probe(struct platform_device *pdev)
+static int nuc900_i2c_probe(struct platform_device *pdev)
 {
 	struct nuc900_i2c *i2c;
 	struct nuc900_platform_i2c *pdata;
@@ -663,7 +663,7 @@ static int __devinit nuc900_i2c_probe(struct platform_device *pdev)
  * called when device is removed from the bus
 */
 
-static int __devexit nuc900_i2c_remove(struct platform_device *pdev)
+static int nuc900_i2c_remove(struct platform_device *pdev)
 {
 	struct nuc900_i2c *i2c = platform_get_drvdata(pdev);
 
@@ -684,7 +684,7 @@ static int __devexit nuc900_i2c_remove(struct platform_device *pdev)
 
 static struct platform_driver nuc900_i2c_driver = {
 	.probe		= nuc900_i2c_probe,
-	.remove		= __devexit_p(nuc900_i2c_remove),
+	.remove		= nuc900_i2c_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "nuc900-i2c0",
diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index f44c835..484ca77 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -446,7 +446,7 @@ static struct i2c_adapter octeon_i2c_ops = {
 /**
  * octeon_i2c_setclock - Calculate and set clock divisors.
  */
-static int __devinit octeon_i2c_setclock(struct octeon_i2c *i2c)
+static int octeon_i2c_setclock(struct octeon_i2c *i2c)
 {
 	int tclk, thp_base, inc, thp_idx, mdiv_idx, ndiv_idx, foscl, diff;
 	int thp = 0x18, mdiv = 2, ndiv = 0, delta_hz = 1000000;
@@ -489,7 +489,7 @@ static int __devinit octeon_i2c_setclock(struct octeon_i2c *i2c)
 	return 0;
 }
 
-static int __devinit octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
+static int octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
 {
 	u8 status;
 	int tries;
@@ -510,7 +510,7 @@ static int __devinit octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
 	return -EIO;
 }
 
-static int __devinit octeon_i2c_probe(struct platform_device *pdev)
+static int octeon_i2c_probe(struct platform_device *pdev)
 {
 	int irq, result = 0;
 	struct octeon_i2c *i2c;
@@ -609,7 +609,7 @@ out:
 	return result;
 };
 
-static int __devexit octeon_i2c_remove(struct platform_device *pdev)
+static int octeon_i2c_remove(struct platform_device *pdev)
 {
 	struct octeon_i2c *i2c = platform_get_drvdata(pdev);
 
@@ -628,7 +628,7 @@ MODULE_DEVICE_TABLE(of, octeon_i2c_match);
 
 static struct platform_driver octeon_i2c_driver = {
 	.probe		= octeon_i2c_probe,
-	.remove		= __devexit_p(octeon_i2c_remove),
+	.remove		= octeon_i2c_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= DRV_NAME,
diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index 3d71395..083d68c 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -270,7 +270,7 @@ static irqreturn_t pmcmsptwi_interrupt(int irq, void *ptr)
 /*
  * Probe for and register the device and return 0 if there is one.
  */
-static int __devinit pmcmsptwi_probe(struct platform_device *pldev)
+static int pmcmsptwi_probe(struct platform_device *pldev)
 {
 	struct resource *res;
 	int rc = -ENODEV;
@@ -368,7 +368,7 @@ ret_err:
 /*
  * Release the device and return 0 if there is one.
  */
-static int __devexit pmcmsptwi_remove(struct platform_device *pldev)
+static int pmcmsptwi_remove(struct platform_device *pldev)
 {
 	struct resource *res;
 
@@ -628,7 +628,7 @@ static struct i2c_adapter pmcmsptwi_adapter = {
 
 static struct platform_driver pmcmsptwi_driver = {
 	.probe  = pmcmsptwi_probe,
-	.remove	= __devexit_p(pmcmsptwi_remove),
+	.remove	= pmcmsptwi_remove,
 	.driver = {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 5285f85..0dd5b33 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -210,7 +210,7 @@ static const struct i2c_algorithm i2c_powermac_algorithm = {
 };
 
 
-static int __devexit i2c_powermac_remove(struct platform_device *dev)
+static int i2c_powermac_remove(struct platform_device *dev)
 {
 	struct i2c_adapter	*adapter = platform_get_drvdata(dev);
 	int			rc;
@@ -227,7 +227,7 @@ static int __devexit i2c_powermac_remove(struct platform_device *dev)
 	return 0;
 }
 
-static u32 __devinit i2c_powermac_get_addr(struct i2c_adapter *adap,
+static u32 i2c_powermac_get_addr(struct i2c_adapter *adap,
 					   struct pmac_i2c_bus *bus,
 					   struct device_node *node)
 {
@@ -255,7 +255,7 @@ static u32 __devinit i2c_powermac_get_addr(struct i2c_adapter *adap,
 	return 0xffffffff;
 }
 
-static void __devinit i2c_powermac_create_one(struct i2c_adapter *adap,
+static void i2c_powermac_create_one(struct i2c_adapter *adap,
 					      const char *type,
 					      u32 addr)
 {
@@ -271,7 +271,7 @@ static void __devinit i2c_powermac_create_one(struct i2c_adapter *adap,
 			type);
 }
 
-static void __devinit i2c_powermac_add_missing(struct i2c_adapter *adap,
+static void i2c_powermac_add_missing(struct i2c_adapter *adap,
 					       struct pmac_i2c_bus *bus,
 					       bool found_onyx)
 {
@@ -297,7 +297,7 @@ static void __devinit i2c_powermac_add_missing(struct i2c_adapter *adap,
 	}
 }
 
-static bool __devinit i2c_powermac_get_type(struct i2c_adapter *adap,
+static bool i2c_powermac_get_type(struct i2c_adapter *adap,
 					    struct device_node *node,
 					    u32 addr, char *type, int type_size)
 {
@@ -336,7 +336,7 @@ static bool __devinit i2c_powermac_get_type(struct i2c_adapter *adap,
 	return false;
 }
 
-static void __devinit i2c_powermac_register_devices(struct i2c_adapter *adap,
+static void i2c_powermac_register_devices(struct i2c_adapter *adap,
 						    struct pmac_i2c_bus *bus)
 {
 	struct i2c_client *newdev;
@@ -403,7 +403,7 @@ static void __devinit i2c_powermac_register_devices(struct i2c_adapter *adap,
 	i2c_powermac_add_missing(adap, bus, found_onyx);
 }
 
-static int __devinit i2c_powermac_probe(struct platform_device *dev)
+static int i2c_powermac_probe(struct platform_device *dev)
 {
 	struct pmac_i2c_bus *bus = dev->dev.platform_data;
 	struct device_node *parent = NULL;
@@ -467,7 +467,7 @@ static int __devinit i2c_powermac_probe(struct platform_device *dev)
 
 static struct platform_driver i2c_powermac_driver = {
 	.probe = i2c_powermac_probe,
-	.remove = __devexit_p(i2c_powermac_remove),
+	.remove = i2c_powermac_remove,
 	.driver = {
 		.name = "i2c-powermac",
 		.bus = &platform_bus_type,
diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index 4dc9bef..3d49856 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -94,7 +94,7 @@ out:
 	return ERR_PTR(ret);
 }
 
-static int __devinit ce4100_i2c_probe(struct pci_dev *dev,
+static int ce4100_i2c_probe(struct pci_dev *dev,
 		const struct pci_device_id *ent)
 {
 	int ret;
@@ -135,7 +135,7 @@ err_mem:
 	return ret;
 }
 
-static void __devexit ce4100_i2c_remove(struct pci_dev *dev)
+static void ce4100_i2c_remove(struct pci_dev *dev)
 {
 	struct ce4100_devices *sds;
 	unsigned int i;
@@ -160,7 +160,7 @@ static struct pci_driver ce4100_i2c_driver = {
 	.name           = "ce4100_i2c",
 	.id_table       = ce4100_i2c_devices,
 	.probe          = ce4100_i2c_probe,
-	.remove         = __devexit_p(ce4100_i2c_remove),
+	.remove         = ce4100_i2c_remove,
 };
 
 module_pci_driver(ce4100_i2c_driver);
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 72a8071..9bd4d73 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -613,7 +613,7 @@ static const struct i2c_algorithm rcar_i2c_algo = {
 	.functionality	= rcar_i2c_func,
 };
 
-static int __devinit rcar_i2c_probe(struct platform_device *pdev)
+static int rcar_i2c_probe(struct platform_device *pdev)
 {
 	struct i2c_rcar_platform_data *pdata = pdev->dev.platform_data;
 	struct rcar_i2c_priv *priv;
@@ -682,7 +682,7 @@ static int __devinit rcar_i2c_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit rcar_i2c_remove(struct platform_device *pdev)
+static int rcar_i2c_remove(struct platform_device *pdev)
 {
 	struct rcar_i2c_priv *priv = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
@@ -699,7 +699,7 @@ static struct platform_driver rcar_i2c_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= rcar_i2c_probe,
-	.remove		= __devexit_p(rcar_i2c_remove),
+	.remove		= rcar_i2c_remove,
 };
 
 module_platform_driver(rcar_i2c_driver);
diff --git a/drivers/i2c/busses/i2c-s6000.c b/drivers/i2c/busses/i2c-s6000.c
index b76a29d..0088364 100644
--- a/drivers/i2c/busses/i2c-s6000.c
+++ b/drivers/i2c/busses/i2c-s6000.c
@@ -248,7 +248,7 @@ static struct i2c_algorithm s6i2c_algorithm = {
 	.functionality = s6i2c_functionality,
 };
 
-static u16 __devinit nanoseconds_on_clk(struct s6i2c_if *iface, u32 ns)
+static u16 nanoseconds_on_clk(struct s6i2c_if *iface, u32 ns)
 {
 	u32 dividend = ((clk_get_rate(iface->clk) / 1000) * ns) / 1000000;
 	if (dividend > 0xffff)
@@ -256,7 +256,7 @@ static u16 __devinit nanoseconds_on_clk(struct s6i2c_if *iface, u32 ns)
 	return dividend;
 }
 
-static int __devinit s6i2c_probe(struct platform_device *dev)
+static int s6i2c_probe(struct platform_device *dev)
 {
 	struct s6i2c_if *iface = &s6i2c_if;
 	struct i2c_adapter *p_adap;
@@ -361,7 +361,7 @@ err_out:
 	return rc;
 }
 
-static int __devexit s6i2c_remove(struct platform_device *pdev)
+static int s6i2c_remove(struct platform_device *pdev)
 {
 	struct s6i2c_if *iface = platform_get_drvdata(pdev);
 	i2c_wr16(iface, S6_I2C_ENABLE, 0);
@@ -378,7 +378,7 @@ static int __devexit s6i2c_remove(struct platform_device *pdev)
 
 static struct platform_driver s6i2c_driver = {
 	.probe		= s6i2c_probe,
-	.remove		= __devexit_p(s6i2c_remove),
+	.remove		= s6i2c_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index c0c9dff..3a2253e 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -390,7 +390,7 @@ static const struct i2c_algorithm sh7760_i2c_algo = {
  * iclk = mclk/(CDF + 1).  iclk must be < 20MHz.
  * scl = iclk/(SCGD*8 + 20).
  */
-static int __devinit calc_CCR(unsigned long scl_hz)
+static int calc_CCR(unsigned long scl_hz)
 {
 	struct clk *mclk;
 	unsigned long mck, m1, dff, odff, iclk;
@@ -430,7 +430,7 @@ static int __devinit calc_CCR(unsigned long scl_hz)
 	return ((scgdm << 2) | cdfm);
 }
 
-static int __devinit sh7760_i2c_probe(struct platform_device *pdev)
+static int sh7760_i2c_probe(struct platform_device *pdev)
 {
 	struct sh7760_i2c_platdata *pd;
 	struct resource *res;
@@ -536,7 +536,7 @@ out0:
 	return ret;
 }
 
-static int __devexit sh7760_i2c_remove(struct platform_device *pdev)
+static int sh7760_i2c_remove(struct platform_device *pdev)
 {
 	struct cami2c *id = platform_get_drvdata(pdev);
 
@@ -557,7 +557,7 @@ static struct platform_driver sh7760_i2c_drv = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= sh7760_i2c_probe,
-	.remove		= __devexit_p(sh7760_i2c_remove),
+	.remove		= sh7760_i2c_remove,
 };
 
 module_platform_driver(sh7760_i2c_drv);
diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 9411c1b..b6e7a83 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -758,7 +758,7 @@ static const struct dev_pm_ops sh_mobile_i2c_dev_pm_ops = {
 	.runtime_resume = sh_mobile_i2c_runtime_nop,
 };
 
-static const struct of_device_id sh_mobile_i2c_dt_ids[] __devinitconst = {
+static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 	{ .compatible = "renesas,rmobile-iic", },
 	{},
 };
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index dcea77b..7b38877 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -642,7 +642,7 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 
 #if defined(CONFIG_OF)
 /* Match table for of_platform binding */
-static const struct of_device_id tegra_i2c_of_match[] __devinitconst = {
+static const struct of_device_id tegra_i2c_of_match[] = {
 	{ .compatible = "nvidia,tegra30-i2c", .data = &tegra30_i2c_hw, },
 	{ .compatible = "nvidia,tegra20-i2c", .data = &tegra20_i2c_hw, },
 	{ .compatible = "nvidia,tegra20-i2c-dvc", .data = &tegra20_i2c_hw, },
@@ -651,7 +651,7 @@ static const struct of_device_id tegra_i2c_of_match[] __devinitconst = {
 MODULE_DEVICE_TABLE(of, tegra_i2c_of_match);
 #endif
 
-static int __devinit tegra_i2c_probe(struct platform_device *pdev)
+static int tegra_i2c_probe(struct platform_device *pdev)
 {
 	struct tegra_i2c_dev *i2c_dev;
 	struct tegra_i2c_platform_data *pdata = pdev->dev.platform_data;
@@ -769,7 +769,7 @@ static int __devinit tegra_i2c_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit tegra_i2c_remove(struct platform_device *pdev)
+static int tegra_i2c_remove(struct platform_device *pdev)
 {
 	struct tegra_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
 	i2c_del_adapter(&i2c_dev->adapter);
@@ -817,7 +817,7 @@ static SIMPLE_DEV_PM_OPS(tegra_i2c_pm, tegra_i2c_suspend, tegra_i2c_resume);
 
 static struct platform_driver tegra_i2c_driver = {
 	.probe   = tegra_i2c_probe,
-	.remove  = __devexit_p(tegra_i2c_remove),
+	.remove  = tegra_i2c_remove,
 	.driver  = {
 		.name  = "tegra-i2c",
 		.owner = THIS_MODULE,
diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c-viperboard.c
index f5fa20d..f45c32c 100644
--- a/drivers/i2c/busses/i2c-viperboard.c
+++ b/drivers/i2c/busses/i2c-viperboard.c
@@ -360,7 +360,7 @@ static const struct i2c_algorithm vprbrd_algorithm = {
 	.functionality	= vprbrd_i2c_func,
 };
 
-static int __devinit vprbrd_i2c_probe(struct platform_device *pdev)
+static int vprbrd_i2c_probe(struct platform_device *pdev)
 {
 	struct vprbrd *vb = dev_get_drvdata(pdev->dev.parent);
 	struct vprbrd_i2c *vb_i2c;
@@ -418,7 +418,7 @@ error:
 	return ret;
 }
 
-static int __devexit vprbrd_i2c_remove(struct platform_device *pdev)
+static int vprbrd_i2c_remove(struct platform_device *pdev)
 {
 	struct vprbrd_i2c *vb_i2c = platform_get_drvdata(pdev);
 	int ret;
@@ -432,7 +432,7 @@ static struct platform_driver vprbrd_i2c_driver = {
 	.driver.name	= "viperboard-i2c",
 	.driver.owner	= THIS_MODULE,
 	.probe		= vprbrd_i2c_probe,
-	.remove		= __devexit_p(vprbrd_i2c_remove),
+	.remove		= vprbrd_i2c_remove,
 };
 
 static int __init vprbrd_i2c_init(void)
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 641d0e5..9aa8837 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -689,7 +689,7 @@ static struct i2c_adapter xiic_adapter = {
 };
 
 
-static int __devinit xiic_i2c_probe(struct platform_device *pdev)
+static int xiic_i2c_probe(struct platform_device *pdev)
 {
 	struct xiic_i2c *i2c;
 	struct xiic_i2c_platform_data *pdata;
@@ -774,7 +774,7 @@ resource_missing:
 	return -ENOENT;
 }
 
-static int __devexit xiic_i2c_remove(struct platform_device* pdev)
+static int xiic_i2c_remove(struct platform_device* pdev)
 {
 	struct xiic_i2c *i2c = platform_get_drvdata(pdev);
 	struct resource *res;
@@ -800,7 +800,7 @@ static int __devexit xiic_i2c_remove(struct platform_device* pdev)
 }
 
 #if defined(CONFIG_OF)
-static const struct of_device_id xiic_of_match[] __devinitconst = {
+static const struct of_device_id xiic_of_match[] = {
 	{ .compatible = "xlnx,xps-iic-2.00.a", },
 	{},
 };
@@ -809,7 +809,7 @@ MODULE_DEVICE_TABLE(of, xiic_of_match);
 
 static struct platform_driver xiic_i2c_driver = {
 	.probe   = xiic_i2c_probe,
-	.remove  = __devexit_p(xiic_i2c_remove),
+	.remove  = xiic_i2c_remove,
 	.driver  = {
 		.owner = THIS_MODULE,
 		.name = DRIVER_NAME,
diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
index 96d3fab..a005265 100644
--- a/drivers/i2c/busses/i2c-xlr.c
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -214,7 +214,7 @@ static struct i2c_algorithm xlr_i2c_algo = {
 	.functionality	= xlr_func,
 };
 
-static int __devinit xlr_i2c_probe(struct platform_device *pdev)
+static int xlr_i2c_probe(struct platform_device *pdev)
 {
 	struct xlr_i2c_private  *priv;
 	struct resource *res;
@@ -251,7 +251,7 @@ static int __devinit xlr_i2c_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit xlr_i2c_remove(struct platform_device *pdev)
+static int xlr_i2c_remove(struct platform_device *pdev)
 {
 	struct xlr_i2c_private *priv;
 
@@ -263,7 +263,7 @@ static int __devexit xlr_i2c_remove(struct platform_device *pdev)
 
 static struct platform_driver xlr_i2c_driver = {
 	.probe  = xlr_i2c_probe,
-	.remove = __devexit_p(xlr_i2c_remove),
+	.remove = xlr_i2c_remove,
 	.driver = {
 		.name   = "xlr-i2cbus",
 		.owner  = THIS_MODULE,
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index 7fa5b24..1e44d04 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -129,7 +129,7 @@ static inline int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
 }
 #endif
 
-static int __devinit i2c_mux_pinctrl_probe(struct platform_device *pdev)
+static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 {
 	struct i2c_mux_pinctrl *mux;
 	int (*deselect)(struct i2c_adapter *, void *, u32);
@@ -241,7 +241,7 @@ err:
 	return ret;
 }
 
-static int __devexit i2c_mux_pinctrl_remove(struct platform_device *pdev)
+static int i2c_mux_pinctrl_remove(struct platform_device *pdev)
 {
 	struct i2c_mux_pinctrl *mux = platform_get_drvdata(pdev);
 	int i;
@@ -255,7 +255,7 @@ static int __devexit i2c_mux_pinctrl_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
-static const struct of_device_id i2c_mux_pinctrl_of_match[] __devinitconst = {
+static const struct of_device_id i2c_mux_pinctrl_of_match[] = {
 	{ .compatible = "i2c-mux-pinctrl", },
 	{},
 };
@@ -269,7 +269,7 @@ static struct platform_driver i2c_mux_pinctrl_driver = {
 		.of_match_table = of_match_ptr(i2c_mux_pinctrl_of_match),
 	},
 	.probe	= i2c_mux_pinctrl_probe,
-	.remove	= __devexit_p(i2c_mux_pinctrl_remove),
+	.remove	= i2c_mux_pinctrl_remove,
 };
 module_platform_driver(i2c_mux_pinctrl_driver);
 
-- 
1.8.0.1
