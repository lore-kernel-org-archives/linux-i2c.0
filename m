From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 11/14] i2c/i2c-nomadik: remove the unnecessary delay
Date: Fri, 13 May 2011 12:30:42 +0200
Message-ID: <1305282642-20864-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

The delay in the driver seems to be not needed, so remove it.

Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Reviewed-by: Markus Grape <markus.grape-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Tested-by: Per Persson <per.xb.persson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Tested-by: Chethan Krishna N <chethan.krishna-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   20 ++------------------
 1 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index e3cd62e..b2de1a5 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
@@ -105,9 +104,6 @@
 /* maximum threshold value */
 #define MAX_I2C_FIFO_THRESHOLD	15
 
-/* per-transfer delay, required for the hardware to stabilize */
-#define I2C_DELAY		150
-
 enum i2c_status {
 	I2C_NOP,
 	I2C_ON_GOING,
@@ -269,12 +265,6 @@ static int init_hw(struct nmk_i2c_dev *dev)
 	dev->cli.operation = I2C_NO_OPERATION;
 
 exit:
-	/*
-	 * TODO: What is this delay for?
-	 * Must be pretty pointless since the hw block
-	 * is frozen. Or?
-	 */
-	udelay(I2C_DELAY);
 	return stat;
 }
 
@@ -652,7 +642,6 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 				break;
 			}
-			udelay(I2C_DELAY);
 		}
 		if (status == 0)
 			break;
@@ -778,13 +767,8 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 			}
 		}
 
-		i2c_set_bit(dev->virtbase + I2C_ICR, I2C_IT_MTD);
-		i2c_set_bit(dev->virtbase + I2C_ICR, I2C_IT_MTDWS);
-
-		disable_interrupts(dev,
-				(I2C_IT_TXFNE | I2C_IT_TXFE | I2C_IT_TXFF
-					| I2C_IT_TXFOVR | I2C_IT_RXFNF
-					| I2C_IT_RXFF | I2C_IT_RXFE));
+		disable_all_interrupts(dev);
+		clear_all_interrupts(dev);
 
 		if (dev->cli.count) {
 			dev->result = -EIO;
-- 
1.7.5.1
