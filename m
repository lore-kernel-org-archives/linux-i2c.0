From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] i2c: nomadik: support elder Nomadiks
Date: Mon, 10 Jun 2013 00:00:58 +0200
Message-ID: <1370815258-1351-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The Nomadik I2C block was introduced with the Nomadik STn8815
SoC (the STn8810 incidentally is identical to the one named
i2c-stu300.c). However as developments have only been tested
on the DB8500 family, it was not properly working with the
STn8815 anymore.

Rectify this by adding some vendor variant data in the same
manner as other PrimeCells, and switch code path depending
on version.

Tested on the S8815 Nomadik dongle.

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c | 43 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 37353b3..f6d18ce 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -106,6 +106,16 @@
 /* maximum threshold value */
 #define MAX_I2C_FIFO_THRESHOLD	15
 
+/**
+ * struct i2c_vendor_data - per-vendor variations
+ * @has_mtdws: variant has the MTDWS bit
+ * @fifodepth: variant FIFO depth
+ */
+struct i2c_vendor_data {
+	bool has_mtdws;
+	u32 fifodepth;
+};
+
 enum i2c_status {
 	I2C_NOP,
 	I2C_ON_GOING,
@@ -138,6 +148,7 @@ struct i2c_nmk_client {
 
 /**
  * struct nmk_i2c_dev - private data structure of the controller.
+ * @vendor: vendor data for this variant.
  * @adev: parent amba device.
  * @adap: corresponding I2C adapter.
  * @irq: interrupt line for the controller.
@@ -155,6 +166,7 @@ struct i2c_nmk_client {
  * @busy: Busy doing transfer.
  */
 struct nmk_i2c_dev {
+	struct i2c_vendor_data		*vendor;
 	struct amba_device		*adev;
 	struct i2c_adapter		adap;
 	int				irq;
@@ -431,7 +443,7 @@ static int read_i2c(struct nmk_i2c_dev *dev, u16 flags)
 	irq_mask = (I2C_IT_RXFNF | I2C_IT_RXFF |
 			I2C_IT_MAL | I2C_IT_BERR);
 
-	if (dev->stop)
+	if (dev->stop || !dev->vendor->has_mtdws)
 		irq_mask |= I2C_IT_MTD;
 	else
 		irq_mask |= I2C_IT_MTDWS;
@@ -511,7 +523,7 @@ static int write_i2c(struct nmk_i2c_dev *dev, u16 flags)
 	 * set the MTDWS bit (Master Transaction Done Without Stop)
 	 * to start repeated start operation
 	 */
-	if (dev->stop)
+	if (dev->stop || !dev->vendor->has_mtdws)
 		irq_mask |= I2C_IT_MTD;
 	else
 		irq_mask |= I2C_IT_MTDWS;
@@ -978,6 +990,8 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	struct device_node *np = adev->dev.of_node;
 	struct nmk_i2c_dev	*dev;
 	struct i2c_adapter *adap;
+	struct i2c_vendor_data *vendor = id->data;
+	u32 max_fifo_threshold = (vendor->fifodepth / 2) - 1;
 
 	if (!pdata) {
 		if (np) {
@@ -994,12 +1008,25 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 			pdata = &u8500_i2c;
 	}
 
+	if (pdata->tft > max_fifo_threshold) {
+		dev_warn(&adev->dev, "requested TX FIFO threshold %u, adjusted down to %u\n",
+			pdata->tft, max_fifo_threshold);
+		pdata->tft = max_fifo_threshold;
+	}
+
+	if (pdata->rft > max_fifo_threshold) {
+		dev_warn(&adev->dev, "requested RX FIFO threshold %u, adjusted down to %u\n",
+			pdata->rft, max_fifo_threshold);
+		pdata->rft = max_fifo_threshold;
+	}
+
 	dev = kzalloc(sizeof(struct nmk_i2c_dev), GFP_KERNEL);
 	if (!dev) {
 		dev_err(&adev->dev, "cannot allocate memory\n");
 		ret = -ENOMEM;
 		goto err_no_mem;
 	}
+	dev->vendor = vendor;
 	dev->busy = false;
 	dev->adev = adev;
 	amba_set_drvdata(adev, dev);
@@ -1134,14 +1161,26 @@ static int nmk_i2c_remove(struct amba_device *adev)
 	return 0;
 }
 
+static struct i2c_vendor_data vendor_stn8815 = {
+	.has_mtdws = false,
+	.fifodepth = 16, /* Guessed from TFTR/RFTR = 7 */
+};
+
+static struct i2c_vendor_data vendor_db8500 = {
+	.has_mtdws = true,
+	.fifodepth = 32, /* Guessed from TFTR/RFTR = 15 */
+};
+
 static struct amba_id nmk_i2c_ids[] = {
 	{
 		.id	= 0x00180024,
 		.mask	= 0x00ffffff,
+		.data	= &vendor_stn8815,
 	},
 	{
 		.id	= 0x00380024,
 		.mask	= 0x00ffffff,
+		.data	= &vendor_db8500,
 	},
 	{},
 };
-- 
1.8.1.4
