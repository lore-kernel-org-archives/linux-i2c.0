From: Srinidhi KASAGAR <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] i2c-nomadik: Add 10-bit addressing support
Date: Mon, 25 Jun 2012 17:56:07 +0530
Message-ID: <1340627167-13581-1-git-send-email-srinidhi.kasagar@stericsson.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, Srinidhi KASAGAR <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Srinidhi KASAGAR <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   46 ++++++++++++++++++++++++--------------
 1 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 5267ab9..889a782 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -276,15 +276,32 @@ exit:
 /**
  * load_i2c_mcr_reg() - load the MCR register
  * @dev: private data of controller
+ * @flags: message flags
  */
-static u32 load_i2c_mcr_reg(struct nmk_i2c_dev *dev)
+static u32 load_i2c_mcr_reg(struct nmk_i2c_dev *dev, u16 flags)
 {
 	u32 mcr = 0;
+	unsigned short slave_adr_3msb_bits;
 
-	/* 7-bit address transaction */
-	mcr |= GEN_MASK(1, I2C_MCR_AM, 12);
 	mcr |= GEN_MASK(dev->cli.slave_adr, I2C_MCR_A7, 1);
 
+	if (unlikely(flags & I2C_M_TEN)) {
+		/* 10-bit address transaction */
+		mcr |= GEN_MASK(2, I2C_MCR_AM, 12);
+		/*
+		 * Get the top 3 bits.
+		 * EA10 represents extended address in MCR. This includes
+		 * the extension (MSB bits) of the 7 bit address loaded
+		 * in A7
+		 */
+		slave_adr_3msb_bits = (dev->cli.slave_adr >> 7) & 0x7;
+
+		mcr |= GEN_MASK(slave_adr_3msb_bits, I2C_MCR_EA10, 8);
+	} else {
+		/* 7-bit address transaction */
+		mcr |= GEN_MASK(1, I2C_MCR_AM, 12);
+	}
+
 	/* start byte procedure not applied */
 	mcr |= GEN_MASK(0, I2C_MCR_SB, 11);
 
@@ -381,19 +398,20 @@ static void setup_i2c_controller(struct nmk_i2c_dev *dev)
 /**
  * read_i2c() - Read from I2C client device
  * @dev: private data of I2C Driver
+ * @flags: message flags
  *
  * This function reads from i2c client device when controller is in
  * master mode. There is a completion timeout. If there is no transfer
  * before timeout error is returned.
  */
-static int read_i2c(struct nmk_i2c_dev *dev)
+static int read_i2c(struct nmk_i2c_dev *dev, u16 flags)
 {
 	u32 status = 0;
 	u32 mcr;
 	u32 irq_mask = 0;
 	int timeout;
 
-	mcr = load_i2c_mcr_reg(dev);
+	mcr = load_i2c_mcr_reg(dev, flags);
 	writel(mcr, dev->virtbase + I2C_MCR);
 
 	/* load the current CR value */
@@ -459,17 +477,18 @@ static void fill_tx_fifo(struct nmk_i2c_dev *dev, int no_bytes)
 /**
  * write_i2c() - Write data to I2C client.
  * @dev: private data of I2C Driver
+ * @flags: message flags
  *
  * This function writes data to I2C client
  */
-static int write_i2c(struct nmk_i2c_dev *dev)
+static int write_i2c(struct nmk_i2c_dev *dev, u16 flags)
 {
 	u32 status = 0;
 	u32 mcr;
 	u32 irq_mask = 0;
 	int timeout;
 
-	mcr = load_i2c_mcr_reg(dev);
+	mcr = load_i2c_mcr_reg(dev, flags);
 
 	writel(mcr, dev->virtbase + I2C_MCR);
 
@@ -538,11 +557,11 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *dev, u16 flags)
 	if (flags & I2C_M_RD) {
 		/* read operation */
 		dev->cli.operation = I2C_READ;
-		status = read_i2c(dev);
+		status = read_i2c(dev, flags);
 	} else {
 		/* write operation */
 		dev->cli.operation = I2C_WRITE;
-		status = write_i2c(dev);
+		status = write_i2c(dev, flags);
 	}
 
 	if (status || (dev->result)) {
@@ -644,13 +663,6 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 		setup_i2c_controller(dev);
 
 		for (i = 0; i < num_msgs; i++) {
-			if (unlikely(msgs[i].flags & I2C_M_TEN)) {
-				dev_err(&dev->pdev->dev,
-					"10 bit addressing not supported\n");
-
-				status = -EINVAL;
-				goto out;
-			}
 			dev->cli.slave_adr	= msgs[i].addr;
 			dev->cli.buffer		= msgs[i].buf;
 			dev->cli.count		= msgs[i].len;
@@ -891,7 +903,7 @@ static const struct dev_pm_ops nmk_i2c_pm = {
 
 static unsigned int nmk_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR;
 }
 
 static const struct i2c_algorithm nmk_i2c_algo = {
-- 
1.7.2.dirty
