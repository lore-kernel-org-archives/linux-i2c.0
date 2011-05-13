From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 02/14] i2c/i2c-nomadik: make i2c timeout specific per i2c bus
Date: Fri, 13 May 2011 12:29:12 +0200
Message-ID: <1305282552-20568-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Add option to have different i2c timeout delay for different i2c buses
specified in platform data. Default to the old value unless specified.

Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/plat-nomadik/include/plat/i2c.h |    6 ++++--
 drivers/i2c/busses/i2c-nomadik.c         |   10 ++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-nomadik/include/plat/i2c.h b/arch/arm/plat-nomadik/include/plat/i2c.h
index 1621db6..4ed4e27 100644
--- a/arch/arm/plat-nomadik/include/plat/i2c.h
+++ b/arch/arm/plat-nomadik/include/plat/i2c.h
@@ -24,13 +24,15 @@ enum i2c_freq_mode {
  *		to the values of 14, 6, 2 for a 48 MHz i2c clk
  * @tft:	Tx FIFO Threshold in bytes
  * @rft:	Rx FIFO Threshold in bytes
+ * @timeout	Slave response timeout(ms)
  * @sm:		speed mode
  */
 struct nmk_i2c_controller {
 	unsigned long	clk_freq;
 	unsigned short	slsu;
-	unsigned char 	tft;
-	unsigned char 	rft;
+	unsigned char	tft;
+	unsigned char	rft;
+	int timeout;
 	enum i2c_freq_mode	sm;
 };
 
diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 182761e..3bf95b9 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -121,9 +121,6 @@ enum i2c_operation {
 	I2C_READ = 0x01
 };
 
-/* controller response timeout in ms */
-#define I2C_TIMEOUT_MS	2000
-
 /**
  * struct i2c_nmk_client - client specific data
  * @slave_adr: 7-bit slave address
@@ -213,7 +210,7 @@ static int flush_i2c_fifo(struct nmk_i2c_dev *dev)
 	writel((I2C_CR_FTX | I2C_CR_FRX), dev->virtbase + I2C_CR);
 
 	for (i = 0; i < LOOP_ATTEMPTS; i++) {
-		timeout = jiffies + msecs_to_jiffies(I2C_TIMEOUT_MS);
+		timeout = jiffies + msecs_to_jiffies(dev->adap.timeout);
 
 		while (!time_after(jiffies, timeout)) {
 			if ((readl(dev->virtbase + I2C_CR) &
@@ -434,7 +431,7 @@ static int read_i2c(struct nmk_i2c_dev *dev)
 			dev->virtbase + I2C_IMSCR);
 
 	timeout = wait_for_completion_interruptible_timeout(
-		&dev->xfer_complete, msecs_to_jiffies(I2C_TIMEOUT_MS));
+		&dev->xfer_complete, msecs_to_jiffies(dev->adap.timeout));
 
 	if (timeout < 0) {
 		dev_err(&dev->pdev->dev,
@@ -498,7 +495,7 @@ static int write_i2c(struct nmk_i2c_dev *dev)
 			dev->virtbase + I2C_IMSCR);
 
 	timeout = wait_for_completion_interruptible_timeout(
-		&dev->xfer_complete, msecs_to_jiffies(I2C_TIMEOUT_MS));
+		&dev->xfer_complete, msecs_to_jiffies(dev->adap.timeout));
 
 	if (timeout < 0) {
 		dev_err(&dev->pdev->dev,
@@ -917,6 +914,7 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 	adap->owner	= THIS_MODULE;
 	adap->class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->algo	= &nmk_i2c_algo;
+	adap->timeout	= pdata->timeout ? pdata->timeout : 20000;
 	snprintf(adap->name, sizeof(adap->name),
 		 "Nomadik I2C%d at %lx", pdev->id, (unsigned long)res->start);
 
-- 
1.7.5.1
