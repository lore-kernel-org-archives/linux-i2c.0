From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH 1/3 V2] i2c: mxs: distinguish i.MX23 and i.MX28 based I2C controller
Date: Mon, 30 Sep 2013 01:23:53 +0200
Message-ID: <1380497035-7457-1-git-send-email-marex@denx.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

It seems the PIO mode does not work, or at least not like it works
on a i.MX28. Each short transfer needs about one second (without an
error message) but does not send anything on the I2C lines.

From: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>
Cc: Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

V2: Rebase on top of next/master as of next-20130927

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index f4a0167..2cb0317 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -95,10 +95,17 @@
 #define MXS_CMD_I2C_READ	(MXS_I2C_CTRL0_SEND_NAK_ON_LAST | \
 				 MXS_I2C_CTRL0_MASTER_MODE)
 
+enum mxs_i2c_devtype {
+	MXS_I2C_UNKNOWN = 0,
+	MXS_I2C_V1,
+	MXS_I2C_V2,
+};
+
 /**
  * struct mxs_i2c_dev - per device, private MXS-I2C data
  *
  * @dev: driver model device node
+ * @dev_type: distinguish i.MX23/i.MX28 features
  * @regs: IO registers pointer
  * @cmd_complete: completion object for transaction wait
  * @cmd_err: error code for last transaction
@@ -106,6 +113,7 @@
  */
 struct mxs_i2c_dev {
 	struct device *dev;
+	enum mxs_i2c_devtype dev_type;
 	void __iomem *regs;
 	struct completion cmd_complete;
 	int cmd_err;
@@ -495,6 +503,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	 * is set to 8 bytes, transfers shorter than 8 bytes are transfered
 	 * using PIO mode while longer transfers use DMA. The 8 byte border is
 	 * based on this empirical measurement and a lot of previous frobbing.
+	 * Note: this special feature only works on i.MX28 SoC
 	 */
 	i2c->cmd_err = 0;
 	if (0) {	/* disable PIO mode until a proper fix is made */
@@ -680,8 +689,28 @@ static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
 	return 0;
 }
 
+static struct platform_device_id mxs_i2c_devtype[] = {
+	{
+		.name = "imx23-i2c",
+		.driver_data = MXS_I2C_V1,
+	}, {
+		.name = "imx28-i2c",
+		.driver_data = MXS_I2C_V2,
+	}, { /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, mxs_i2c_devtype);
+
+static const struct of_device_id mxs_i2c_dt_ids[] = {
+	{ .compatible = "fsl,imx23-i2c", .data = &mxs_i2c_devtype[0], },
+	{ .compatible = "fsl,imx28-i2c", .data = &mxs_i2c_devtype[1], },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_i2c_dt_ids);
+
 static int mxs_i2c_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id =
+				of_match_device(mxs_i2c_dt_ids, &pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct mxs_i2c_dev *i2c;
 	struct i2c_adapter *adap;
@@ -693,6 +722,11 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
+	if (of_id) {
+		const struct platform_device_id *device_id = of_id->data;
+		i2c->dev_type = device_id->driver_data;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 
@@ -768,12 +802,6 @@ static int mxs_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mxs_i2c_dt_ids[] = {
-	{ .compatible = "fsl,imx28-i2c", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, mxs_i2c_dt_ids);
-
 static struct platform_driver mxs_i2c_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
-- 
1.8.4.rc3
