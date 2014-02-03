From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2] i2c: nomadik: factor platform data into state container
Date: Mon,  3 Feb 2014 11:27:26 +0100
Message-ID: <1391423246-32410-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Move the former platform data struct nmk_i2c_controller into the
per-device state container struct i2c_nmk_client, and remove all
the platform data probe path hacks.

Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
ChangeLog v1->v2:
- Drop pointless check for np, as the device can only probe from
  the device tree now.
---
 drivers/i2c/busses/i2c-nomadik.c | 115 ++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 73 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 4443613514ee..b0b93902facf 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -111,22 +111,6 @@ enum i2c_freq_mode {
 };
 
 /**
- * struct nmk_i2c_controller - client specific controller configuration
- * @clk_freq:	clock frequency for the operation mode
- * @tft:	Tx FIFO Threshold in bytes
- * @rft:	Rx FIFO Threshold in bytes
- * @timeout	Slave response timeout(ms)
- * @sm:		speed mode
- */
-struct nmk_i2c_controller {
-	u32             clk_freq;
-	unsigned char	tft;
-	unsigned char	rft;
-	int timeout;
-	enum i2c_freq_mode	sm;
-};
-
-/**
  * struct i2c_vendor_data - per-vendor variations
  * @has_mtdws: variant has the MTDWS bit
  * @fifodepth: variant FIFO depth
@@ -174,8 +158,12 @@ struct i2c_nmk_client {
  * @irq: interrupt line for the controller.
  * @virtbase: virtual io memory area.
  * @clk: hardware i2c block clock.
- * @cfg: machine provided controller configuration.
  * @cli: holder of client specific data.
+ * @clk_freq: clock frequency for the operation mode
+ * @tft: Tx FIFO Threshold in bytes
+ * @rft: Rx FIFO Threshold in bytes
+ * @timeout Slave response timeout (ms)
+ * @sm: speed mode
  * @stop: stop condition.
  * @xfer_complete: acknowledge completion for a I2C message.
  * @result: controller propogated result.
@@ -188,8 +176,12 @@ struct nmk_i2c_dev {
 	int				irq;
 	void __iomem			*virtbase;
 	struct clk			*clk;
-	struct nmk_i2c_controller	cfg;
 	struct i2c_nmk_client		cli;
+	u32				clk_freq;
+	unsigned char			tft;
+	unsigned char			rft;
+	int				timeout;
+	enum i2c_freq_mode		sm;
 	int				stop;
 	struct completion		xfer_complete;
 	int				result;
@@ -386,7 +378,7 @@ static void setup_i2c_controller(struct nmk_i2c_dev *dev)
 	 * slsu = cycles / (1000000000 / f) + 1
 	 */
 	ns = DIV_ROUND_UP_ULL(1000000000ULL, i2c_clk);
-	switch (dev->cfg.sm) {
+	switch (dev->sm) {
 	case I2C_FREQ_MODE_FAST:
 	case I2C_FREQ_MODE_FAST_PLUS:
 		slsu = DIV_ROUND_UP(100, ns); /* Fast */
@@ -409,7 +401,7 @@ static void setup_i2c_controller(struct nmk_i2c_dev *dev)
 	 * 2 whereas it is 3 for fast and fastplus mode of
 	 * operation. TODO - high speed support.
 	 */
-	div = (dev->cfg.clk_freq > 100000) ? 3 : 2;
+	div = (dev->clk_freq > 100000) ? 3 : 2;
 
 	/*
 	 * generate the mask for baud rate counters. The controller
@@ -419,7 +411,7 @@ static void setup_i2c_controller(struct nmk_i2c_dev *dev)
 	 * so set brcr1 to 0.
 	 */
 	brcr1 = 0 << 16;
-	brcr2 = (i2c_clk/(dev->cfg.clk_freq * div)) & 0xffff;
+	brcr2 = (i2c_clk/(dev->clk_freq * div)) & 0xffff;
 
 	/* set the baud rate counter register */
 	writel((brcr1 | brcr2), dev->virtbase + I2C_BRCR);
@@ -430,7 +422,7 @@ static void setup_i2c_controller(struct nmk_i2c_dev *dev)
 	 * TODO - support for fast mode plus (up to 1Mb/s)
 	 * and high speed (up to 3.4 Mb/s)
 	 */
-	if (dev->cfg.sm > I2C_FREQ_MODE_FAST) {
+	if (dev->sm > I2C_FREQ_MODE_FAST) {
 		dev_err(&dev->adev->dev,
 			"do not support this mode defaulting to std. mode\n");
 		brcr2 = i2c_clk/(100000 * 2) & 0xffff;
@@ -438,11 +430,11 @@ static void setup_i2c_controller(struct nmk_i2c_dev *dev)
 		writel(I2C_FREQ_MODE_STANDARD << 4,
 				dev->virtbase + I2C_CR);
 	}
-	writel(dev->cfg.sm << 4, dev->virtbase + I2C_CR);
+	writel(dev->sm << 4, dev->virtbase + I2C_CR);
 
 	/* set the Tx and Rx FIFO threshold */
-	writel(dev->cfg.tft, dev->virtbase + I2C_TFTR);
-	writel(dev->cfg.rft, dev->virtbase + I2C_RFTR);
+	writel(dev->tft, dev->virtbase + I2C_TFTR);
+	writel(dev->rft, dev->virtbase + I2C_RFTR);
 }
 
 /**
@@ -958,63 +950,32 @@ static const struct i2c_algorithm nmk_i2c_algo = {
 	.functionality	= nmk_i2c_functionality
 };
 
-static struct nmk_i2c_controller u8500_i2c = {
-	.tft            = 1,      /* Tx FIFO threshold */
-	.rft            = 8,      /* Rx FIFO threshold */
-	.clk_freq       = 400000, /* fast mode operation */
-	.timeout        = 200,    /* Slave response timeout(ms) */
-	.sm             = I2C_FREQ_MODE_FAST,
-};
-
 static void nmk_i2c_of_probe(struct device_node *np,
-			struct nmk_i2c_controller *pdata)
+			     struct nmk_i2c_dev *nmk)
 {
-	of_property_read_u32(np, "clock-frequency", &pdata->clk_freq);
+	/* Default to 400 kHz if no frequency is given in the node */
+	if (of_property_read_u32(np, "clock-frequency", &nmk->clk_freq))
+		nmk->clk_freq = 400000;
 
 	/* This driver only supports 'standard' and 'fast' modes of operation. */
-	if (pdata->clk_freq <= 100000)
-		pdata->sm = I2C_FREQ_MODE_STANDARD;
+	if (nmk->clk_freq <= 100000)
+		nmk->sm = I2C_FREQ_MODE_STANDARD;
 	else
-		pdata->sm = I2C_FREQ_MODE_FAST;
+		nmk->sm = I2C_FREQ_MODE_FAST;
+	nmk->tft = 1; /* Tx FIFO threshold */
+	nmk->rft = 8; /* Rx FIFO threshold */
+	nmk->timeout = 200; /* Slave response timeout(ms) */
 }
 
 static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret = 0;
-	struct nmk_i2c_controller *pdata = dev_get_platdata(&adev->dev);
 	struct device_node *np = adev->dev.of_node;
 	struct nmk_i2c_dev	*dev;
 	struct i2c_adapter *adap;
 	struct i2c_vendor_data *vendor = id->data;
 	u32 max_fifo_threshold = (vendor->fifodepth / 2) - 1;
 
-	if (!pdata) {
-		if (np) {
-			pdata = devm_kzalloc(&adev->dev, sizeof(*pdata), GFP_KERNEL);
-			if (!pdata) {
-				ret = -ENOMEM;
-				goto err_no_mem;
-			}
-			/* Provide the default configuration as a base. */
-			memcpy(pdata, &u8500_i2c, sizeof(struct nmk_i2c_controller));
-			nmk_i2c_of_probe(np, pdata);
-		} else
-			/* No i2c configuration found, using the default. */
-			pdata = &u8500_i2c;
-	}
-
-	if (pdata->tft > max_fifo_threshold) {
-		dev_warn(&adev->dev, "requested TX FIFO threshold %u, adjusted down to %u\n",
-			pdata->tft, max_fifo_threshold);
-		pdata->tft = max_fifo_threshold;
-	}
-
-	if (pdata->rft > max_fifo_threshold) {
-		dev_warn(&adev->dev, "requested RX FIFO threshold %u, adjusted down to %u\n",
-			pdata->rft, max_fifo_threshold);
-		pdata->rft = max_fifo_threshold;
-	}
-
 	dev = kzalloc(sizeof(struct nmk_i2c_dev), GFP_KERNEL);
 	if (!dev) {
 		dev_err(&adev->dev, "cannot allocate memory\n");
@@ -1024,6 +985,20 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	dev->vendor = vendor;
 	dev->busy = false;
 	dev->adev = adev;
+	nmk_i2c_of_probe(np, dev);
+
+	if (dev->tft > max_fifo_threshold) {
+		dev_warn(&adev->dev, "requested TX FIFO threshold %u, adjusted down to %u\n",
+			 dev->tft, max_fifo_threshold);
+		dev->tft = max_fifo_threshold;
+	}
+
+	if (dev->rft > max_fifo_threshold) {
+		dev_warn(&adev->dev, "requested RX FIFO threshold %u, adjusted down to %u\n",
+			dev->rft, max_fifo_threshold);
+		dev->rft = max_fifo_threshold;
+	}
+
 	amba_set_drvdata(adev, dev);
 
 	/* Select default pin state */
@@ -1060,16 +1035,10 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	adap->owner	= THIS_MODULE;
 	adap->class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->algo	= &nmk_i2c_algo;
-	adap->timeout	= msecs_to_jiffies(pdata->timeout);
+	adap->timeout	= msecs_to_jiffies(dev->timeout);
 	snprintf(adap->name, sizeof(adap->name),
 		 "Nomadik I2C at %pR", &adev->res);
 
-	/* fetch the controller configuration from machine */
-	dev->cfg.clk_freq = pdata->clk_freq;
-	dev->cfg.tft	= pdata->tft;
-	dev->cfg.rft	= pdata->rft;
-	dev->cfg.sm	= pdata->sm;
-
 	i2c_set_adapdata(adap, dev);
 
 	dev_info(&adev->dev,
-- 
1.8.5.3
