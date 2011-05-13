From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 04/14] i2c/i2c-nomadik: corrrect returned error numbers
Date: Fri, 13 May 2011 12:29:28 +0200
Message-ID: <1305282568-20630-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

The code was returning bad error numbers or just -1 in some cases.

Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 3bf95b9..a02141a 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -615,6 +615,8 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 				cause >= ARRAY_SIZE(abort_causes)
 				? "unknown reason" : abort_causes[cause]);
 
+			status = status ? status : dev->result;
+
 			goto out;
 		}
 		udelay(I2C_DELAY);
@@ -759,7 +761,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 					| I2C_IT_RXFF | I2C_IT_RXFE));
 
 		if (dev->cli.count) {
-			dev->result = -1;
+			dev->result = -EIO;
 			dev_err(&dev->pdev->dev, "%lu bytes still remain to be"
 					"xfered\n", dev->cli.count);
 			(void) init_hw(dev);
@@ -770,7 +772,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 
 	/* Master Arbitration lost interrupt */
 	case I2C_IT_MAL:
-		dev->result = -1;
+		dev->result = -EIO;
 		(void) init_hw(dev);
 
 		i2c_set_bit(dev->virtbase + I2C_ICR, I2C_IT_MAL);
@@ -784,7 +786,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 	 * during the transaction.
 	 */
 	case I2C_IT_BERR:
-		dev->result = -1;
+		dev->result = -EIO;
 		/* get the status */
 		if (((readl(dev->virtbase + I2C_SR) >> 2) & 0x3) == I2C_ABORT)
 			(void) init_hw(dev);
@@ -800,7 +802,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 	 * the Tx FIFO is full.
 	 */
 	case I2C_IT_TXFOVR:
-		dev->result = -1;
+		dev->result = -EIO;
 		(void) init_hw(dev);
 
 		dev_err(&dev->pdev->dev, "Tx Fifo Over run\n");
-- 
1.7.5.1
