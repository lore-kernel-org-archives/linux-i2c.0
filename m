From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] I2C: various updates to the Nomadik I2C controller
Date: Thu, 9 Sep 2010 14:29:32 +0200
Message-ID: <1284035372-27994-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This applies a few fixes and improvements to the Nomadik I2C
controller:
- Add dynamic clocking so the bus is only clocked when it's
  really necessary.
- Support SMBUS emulation, drop other flags that are already
  implied from SMBUS emulation.
- Fixups for proper timeouts and delays on the controller.
- Minor coding style and kerneldoc updates.

Acked-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   36 +++++++++++++++++++++---------------
 1 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 73de8ad..1a3bd22 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009 ST-Ericsson
+ * Copyright (C) 2009 ST-Ericsson SA
  * Copyright (C) 2009 STMicroelectronics
  *
  * I2C master mode controller driver, used in Nomadik 8815
@@ -103,6 +103,9 @@
 /* maximum threshold value */
 #define MAX_I2C_FIFO_THRESHOLD	15
 
+/* delay for i2c transfers */
+#define I2C_DELAY		150
+
 enum i2c_status {
 	I2C_NOP,
 	I2C_ON_GOING,
@@ -118,7 +121,7 @@ enum i2c_operation {
 };
 
 /* controller response timeout in ms */
-#define I2C_TIMEOUT_MS	500
+#define I2C_TIMEOUT_MS	2000
 
 /**
  * struct i2c_nmk_client - client specific data
@@ -250,6 +253,8 @@ static int init_hw(struct nmk_i2c_dev *dev)
 {
 	int stat;
 
+	clk_enable(dev->clk);
+
 	stat = flush_i2c_fifo(dev);
 	if (stat)
 		return stat;
@@ -263,6 +268,9 @@ static int init_hw(struct nmk_i2c_dev *dev)
 
 	dev->cli.operation = I2C_NO_OPERATION;
 
+	clk_disable(dev->clk);
+
+	udelay(I2C_DELAY);
 	return 0;
 }
 
@@ -431,7 +439,6 @@ static int read_i2c(struct nmk_i2c_dev *dev)
 		(void) init_hw(dev);
 		status = -ETIMEDOUT;
 	}
-
 	return status;
 }
 
@@ -502,9 +509,9 @@ static int write_i2c(struct nmk_i2c_dev *dev)
 
 /**
  * nmk_i2c_xfer() - I2C transfer function used by kernel framework
- * @i2c_adap 	- Adapter pointer to the controller
- * @msgs[] - Pointer to data to be written.
- * @num_msgs - Number of messages to be executed
+ * @i2c_adap: Adapter pointer to the controller
+ * @msgs: Pointer to data to be written.
+ * @num_msgs: Number of messages to be executed
  *
  * This is the function called by the generic kernel i2c_transfer()
  * or i2c_smbus...() API calls. Note that this code is protected by the
@@ -559,6 +566,8 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (status)
 		return status;
 
+	clk_enable(dev->clk);
+
 	/* setup the i2c controller */
 	setup_i2c_controller(dev);
 
@@ -591,10 +600,13 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 			dev_err(&dev->pdev->dev, "%s\n",
 				cause >= ARRAY_SIZE(abort_causes)
 				? "unknown reason" : abort_causes[cause]);
+			clk_disable(dev->clk);
 			return status;
 		}
-		mdelay(1);
+		udelay(I2C_DELAY);
 	}
+	clk_disable(dev->clk);
+
 	/* return the no. messages processed */
 	if (status)
 		return status;
@@ -605,6 +617,7 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 /**
  * disable_interrupts() - disable the interrupts
  * @dev: private data of controller
+ * @irq: interrupt number
  */
 static int disable_interrupts(struct nmk_i2c_dev *dev, u32 irq)
 {
@@ -794,10 +807,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 
 static unsigned int nmk_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C
-		| I2C_FUNC_SMBUS_BYTE_DATA
-		| I2C_FUNC_SMBUS_WORD_DATA
-		| I2C_FUNC_SMBUS_I2C_BLOCK;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 static const struct i2c_algorithm nmk_i2c_algo = {
@@ -857,8 +867,6 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 		goto err_no_clk;
 	}
 
-	clk_enable(dev->clk);
-
 	adap = &dev->adap;
 	adap->dev.parent = &pdev->dev;
 	adap->owner	= THIS_MODULE;
@@ -895,7 +903,6 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 	return 0;
 
  err_init_hw:
-	clk_disable(dev->clk);
  err_add_adap:
 	clk_put(dev->clk);
  err_no_clk:
@@ -928,7 +935,6 @@ static int __devexit nmk_i2c_remove(struct platform_device *pdev)
 	iounmap(dev->virtbase);
 	if (res)
 		release_mem_region(res->start, resource_size(res));
-	clk_disable(dev->clk);
 	clk_put(dev->clk);
 	platform_set_drvdata(pdev, NULL);
 	kfree(dev);
-- 
1.6.3.3
