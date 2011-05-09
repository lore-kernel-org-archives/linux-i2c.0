From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 06/13] i2c/i2c-nomadik: correct adapter timeout initialization
Date: Mon,  9 May 2011 23:37:07 +0200
Message-ID: <1304977027-31587-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Correct the incorrect initialization of adapter timeout not to be
in milliseconds, as it needs to be done in jiffies.

Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index dbd93b2..28389c2 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -210,7 +210,7 @@ static int flush_i2c_fifo(struct nmk_i2c_dev *dev)
 	writel((I2C_CR_FTX | I2C_CR_FRX), dev->virtbase + I2C_CR);
 
 	for (i = 0; i < LOOP_ATTEMPTS; i++) {
-		timeout = jiffies + msecs_to_jiffies(dev->adap.timeout);
+		timeout = jiffies + dev->adap.timeout;
 
 		while (!time_after(jiffies, timeout)) {
 			if ((readl(dev->virtbase + I2C_CR) &
@@ -431,7 +431,7 @@ static int read_i2c(struct nmk_i2c_dev *dev)
 			dev->virtbase + I2C_IMSCR);
 
 	timeout = wait_for_completion_interruptible_timeout(
-		&dev->xfer_complete, msecs_to_jiffies(dev->adap.timeout));
+		&dev->xfer_complete, dev->adap.timeout);
 
 	if (timeout < 0) {
 		dev_err(&dev->pdev->dev,
@@ -495,7 +495,7 @@ static int write_i2c(struct nmk_i2c_dev *dev)
 			dev->virtbase + I2C_IMSCR);
 
 	timeout = wait_for_completion_interruptible_timeout(
-		&dev->xfer_complete, msecs_to_jiffies(dev->adap.timeout));
+		&dev->xfer_complete, dev->adap.timeout);
 
 	if (timeout < 0) {
 		dev_err(&dev->pdev->dev,
@@ -914,7 +914,8 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 	adap->owner	= THIS_MODULE;
 	adap->class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->algo	= &nmk_i2c_algo;
-	adap->timeout	= pdata->timeout ? pdata->timeout : 20000;
+	adap->timeout	= pdata->timeout ? msecs_to_jiffies(pdata->timeout) :
+		msecs_to_jiffies(20000);
 	snprintf(adap->name, sizeof(adap->name),
 		 "Nomadik I2C%d at %lx", pdev->id, (unsigned long)res->start);
 
-- 
1.7.5.1
