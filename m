From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/14] i2c/i2c-nomadik: change the TX and RX threshold
Date: Fri, 13 May 2011 12:30:34 +0200
Message-ID: <1305282634-20833-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

1) Increase RX FIFO threshold so that there is a reduction in
the number of interrupts handled to complete a transaction.

2) Fill TX FIFO in the write function.

Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Reviewed-by: Jonas Aberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   39 +++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index b49ff25..e3cd62e 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -447,6 +447,24 @@ static int read_i2c(struct nmk_i2c_dev *dev)
 	return status;
 }
 
+static void fill_tx_fifo(struct nmk_i2c_dev *dev, int no_bytes)
+{
+	int count;
+
+	for (count = (no_bytes - 2);
+			(count > 0) &&
+			(dev->cli.count != 0);
+			count--) {
+		/* write to the Tx FIFO */
+		writeb(*dev->cli.buffer,
+			dev->virtbase + I2C_TFR);
+		dev->cli.buffer++;
+		dev->cli.count--;
+		dev->cli.xfer_bytes++;
+	}
+
+}
+
 /**
  * write_i2c() - Write data to I2C client.
  * @dev: private data of I2C Driver
@@ -474,8 +492,13 @@ static int write_i2c(struct nmk_i2c_dev *dev)
 	init_completion(&dev->xfer_complete);
 
 	/* enable interrupts by settings the masks */
-	irq_mask = (I2C_IT_TXFNE | I2C_IT_TXFOVR |
-			I2C_IT_MAL | I2C_IT_BERR);
+	irq_mask = (I2C_IT_TXFOVR | I2C_IT_MAL | I2C_IT_BERR);
+
+	/* Fill the TX FIFO with transmit data */
+	fill_tx_fifo(dev, MAX_I2C_FIFO_THRESHOLD);
+
+	if (dev->cli.count != 0)
+		irq_mask |= I2C_IT_TXFNE;
 
 	/*
 	 * check if we want to transfer a single or multiple bytes, if so
@@ -702,17 +725,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 			 */
 			disable_interrupts(dev, I2C_IT_TXFNE);
 		} else {
-			for (count = (MAX_I2C_FIFO_THRESHOLD - tft - 2);
-					(count > 0) &&
-					(dev->cli.count != 0);
-					count--) {
-				/* write to the Tx FIFO */
-				writeb(*dev->cli.buffer,
-					dev->virtbase + I2C_TFR);
-				dev->cli.buffer++;
-				dev->cli.count--;
-				dev->cli.xfer_bytes++;
-			}
+			fill_tx_fifo(dev, (MAX_I2C_FIFO_THRESHOLD - tft));
 			/*
 			 * if done, close the transfer by disabling the
 			 * corresponding TXFNE interrupt
-- 
1.7.5.1
