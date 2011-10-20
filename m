From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 1/2] i2c/nomadik: cosmetic coding style corrections
Date: Thu, 20 Oct 2011 18:23:01 +0200
Message-ID: <1319127781-13355-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

This fixes a number of whitespace and punctuation problems
around the Nomadik I2C driver.

Signed-off-by: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   89 +++++++++++++++++++------------------
 1 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index b228e09..ce4fd80 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -63,11 +63,11 @@
 /* Master controller (MCR) register */
 #define I2C_MCR_OP		(0x1 << 0)	/* Operation */
 #define I2C_MCR_A7		(0x7f << 1)	/* 7-bit address */
-#define I2C_MCR_EA10		(0x7 << 8) 	/* 10-bit Extended address */
+#define I2C_MCR_EA10		(0x7 << 8)	/* 10-bit Extended address */
 #define I2C_MCR_SB		(0x1 << 11)	/* Extended address */
 #define I2C_MCR_AM		(0x3 << 12)	/* Address type */
-#define I2C_MCR_STOP		(0x1 << 14) 	/* Stop condition */
-#define I2C_MCR_LENGTH		(0x7ff << 15) 	/* Transaction length */
+#define I2C_MCR_STOP		(0x1 << 14)	/* Stop condition */
+#define I2C_MCR_LENGTH		(0x7ff << 15)	/* Transaction length */
 
 /* Status register (SR) */
 #define I2C_SR_OP		(0x3 << 0)	/* Operation */
@@ -77,7 +77,7 @@
 #define I2C_SR_LENGTH		(0x7ff << 9)	/* Transfer length */
 
 /* Interrupt mask set/clear (IMSCR) bits */
-#define I2C_IT_TXFE 		(0x1 << 0)
+#define I2C_IT_TXFE		(0x1 << 0)
 #define I2C_IT_TXFNE		(0x1 << 1)
 #define I2C_IT_TXFF		(0x1 << 2)
 #define I2C_IT_TXFOVR		(0x1 << 3)
@@ -135,31 +135,31 @@ struct i2c_nmk_client {
 };
 
 /**
- * struct nmk_i2c_dev - private data structure of the controller
- * @pdev: parent platform device
- * @adap: corresponding I2C adapter
- * @irq: interrupt line for the controller
- * @virtbase: virtual io memory area
- * @clk: hardware i2c block clock
- * @cfg: machine provided controller configuration
- * @cli: holder of client specific data
- * @stop: stop condition
- * @xfer_complete: acknowledge completion for a I2C message
- * @result: controller propogated result
- * @regulator: pointer to i2c regulator
- * @busy: Busy doing transfer
+ * struct nmk_i2c_dev - private data structure of the controller.
+ * @pdev: parent platform device.
+ * @adap: corresponding I2C adapter.
+ * @irq: interrupt line for the controller.
+ * @virtbase: virtual io memory area.
+ * @clk: hardware i2c block clock.
+ * @cfg: machine provided controller configuration.
+ * @cli: holder of client specific data.
+ * @stop: stop condition.
+ * @xfer_complete: acknowledge completion for a I2C message.
+ * @result: controller propogated result.
+ * @regulator: pointer to i2c regulator.
+ * @busy: Busy doing transfer.
  */
 struct nmk_i2c_dev {
 	struct platform_device		*pdev;
-	struct i2c_adapter 		adap;
-	int 				irq;
+	struct i2c_adapter		adap;
+	int				irq;
 	void __iomem			*virtbase;
 	struct clk			*clk;
 	struct nmk_i2c_controller	cfg;
 	struct i2c_nmk_client		cli;
-	int 				stop;
+	int				stop;
 	struct completion		xfer_complete;
-	int 				result;
+	int				result;
 	struct regulator		*regulator;
 	bool				busy;
 };
@@ -217,8 +217,9 @@ static int flush_i2c_fifo(struct nmk_i2c_dev *dev)
 		}
 	}
 
-	dev_err(&dev->pdev->dev, "flushing operation timed out "
-		"giving up after %d attempts", LOOP_ATTEMPTS);
+	dev_err(&dev->pdev->dev,
+		"flushing operation timed out giving up after %d attempts",
+		LOOP_ATTEMPTS);
 
 	return -ETIMEDOUT;
 }
@@ -270,7 +271,7 @@ exit:
 }
 
 /* enable peripheral, master mode operation */
-#define DEFAULT_I2C_REG_CR 	((1 << 1) | I2C_CR_PE)
+#define DEFAULT_I2C_REG_CR	((1 << 1) | I2C_CR_PE)
 
 /**
  * load_i2c_mcr_reg() - load the MCR register
@@ -363,8 +364,8 @@ static void setup_i2c_controller(struct nmk_i2c_dev *dev)
 	 * and high speed (up to 3.4 Mb/s)
 	 */
 	if (dev->cfg.sm > I2C_FREQ_MODE_FAST) {
-		dev_err(&dev->pdev->dev, "do not support this mode "
-			"defaulting to std. mode\n");
+		dev_err(&dev->pdev->dev,
+			"do not support this mode defaulting to std. mode\n");
 		brcr2 = i2c_clk/(100000 * 2) & 0xffff;
 		writel((brcr1 | brcr2), dev->virtbase + I2C_BRCR);
 		writel(I2C_FREQ_MODE_STANDARD << 4,
@@ -423,7 +424,7 @@ static int read_i2c(struct nmk_i2c_dev *dev)
 
 	if (timeout < 0) {
 		dev_err(&dev->pdev->dev,
-			"wait_for_completion_timeout"
+			"wait_for_completion_timeout "
 			"returned %d waiting for event\n", timeout);
 		status = timeout;
 	}
@@ -556,8 +557,8 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *dev, u16 flags)
 		if (((i2c_sr >> 2) & 0x3) == 0x3) {
 			/* get the abort cause */
 			cause =	(i2c_sr >> 4) & 0x7;
-			dev_err(&dev->pdev->dev, "%s\n", cause
-				>= ARRAY_SIZE(abort_causes) ?
+			dev_err(&dev->pdev->dev, "%s\n",
+				cause >= ARRAY_SIZE(abort_causes) ?
 				"unknown reason" :
 				abort_causes[cause]);
 		}
@@ -582,13 +583,13 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *dev, u16 flags)
  *
  * NOTE:
  * READ TRANSFER : We impose a restriction of the first message to be the
- * 		index message for any read transaction.
- * 		- a no index is coded as '0',
- * 		- 2byte big endian index is coded as '3'
- * 		!!! msg[0].buf holds the actual index.
- * 		This is compatible with generic messages of smbus emulator
- * 		that send a one byte index.
- * 		eg. a I2C transation to read 2 bytes from index 0
+ *		index message for any read transaction.
+ *		- a no index is coded as '0',
+ *		- 2byte big endian index is coded as '3'
+ *		!!! msg[0].buf holds the actual index.
+ *		This is compatible with generic messages of smbus emulator
+ *		that send a one byte index.
+ *		eg. a I2C transation to read 2 bytes from index 0
  *			idx = 0;
  *			msg[0].addr = client->addr;
  *			msg[0].flags = 0x0;
@@ -644,8 +645,8 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 		for (i = 0; i < num_msgs; i++) {
 			if (unlikely(msgs[i].flags & I2C_M_TEN)) {
-				dev_err(&dev->pdev->dev, "10 bit addressing"
-						"not supported\n");
+				dev_err(&dev->pdev->dev,
+					"10 bit addressing not supported\n");
 
 				status = -EINVAL;
 				goto out;
@@ -789,8 +790,9 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 
 		if (dev->cli.count) {
 			dev->result = -EIO;
-			dev_err(&dev->pdev->dev, "%lu bytes still remain to be"
-					"xfered\n", dev->cli.count);
+			dev_err(&dev->pdev->dev,
+				"%lu bytes still remain to be xfered\n",
+				dev->cli.count);
 			(void) init_hw(dev);
 		}
 		complete(&dev->xfer_complete);
@@ -923,7 +925,7 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 	}
 
 	if (request_mem_region(res->start, resource_size(res),
-		DRIVER_NAME "I/O region") == 	NULL)	{
+		DRIVER_NAME "I/O region") == NULL) {
 		ret = -EBUSY;
 		goto err_no_region;
 	}
@@ -980,8 +982,9 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 
 	i2c_set_adapdata(adap, dev);
 
-	dev_info(&pdev->dev, "initialize %s on virtual "
-		"base %p\n", adap->name, dev->virtbase);
+	dev_info(&pdev->dev,
+		 "initialize %s on virtual base %p\n",
+		 adap->name, dev->virtbase);
 
 	ret = i2c_add_numbered_adapter(adap);
 	if (ret) {
-- 
1.7.3.2
