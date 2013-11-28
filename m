From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/3] i2c: nomadik: auto-calculate slave setup time
Date: Thu, 28 Nov 2013 23:11:45 +0100
Message-ID: <1385676705-15051-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The Nomadik I2C controller needs to have the slave set-up time
configured based off the clock used to drive the I2C bus block.
Currently this is done with static assignments assuming that the
block is clocked 48MHz which is pretty likely to be bug-prone.
Calculate the SLSU from the equation given in the datasheet
instead.

Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c          | 40 +++++++++++++++++++++----------
 include/linux/platform_data/i2c-nomadik.h |  5 ----
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 8bf9ac01301a..51e61d8127cb 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -340,6 +340,8 @@ static void setup_i2c_controller(struct nmk_i2c_dev *dev)
 {
 	u32 brcr1, brcr2;
 	u32 i2c_clk, div;
+	u32 ns;
+	u16 slsu;
 
 	writel(0x0, dev->virtbase + I2C_CR);
 	writel(0x0, dev->virtbase + I2C_HSMCR);
@@ -347,18 +349,38 @@ static void setup_i2c_controller(struct nmk_i2c_dev *dev)
 	writel(0x0, dev->virtbase + I2C_RFTR);
 	writel(0x0, dev->virtbase + I2C_DMAR);
 
+	i2c_clk = clk_get_rate(dev->clk);
+
 	/*
 	 * set the slsu:
 	 *
 	 * slsu defines the data setup time after SCL clock
-	 * stretching in terms of i2c clk cycles. The
-	 * needed setup time for the three modes are 250ns,
-	 * 100ns, 10ns respectively thus leading to the values
-	 * of 14, 6, 2 for a 48 MHz i2c clk.
+	 * stretching in terms of i2c clk cycles + 1 (zero means
+	 * "wait one cycle"), the needed setup time for the three
+	 * modes are 250ns, 100ns, 10ns respectively.
+	 *
+	 * As the time for one cycle T in nanoseconds is
+	 * T = (1/f) * 1000000000 =>
+	 * slsu = cycles / (1000000000 / f) + 1
 	 */
-	writel(dev->cfg.slsu << 16, dev->virtbase + I2C_SCR);
+	ns = DIV_ROUND_UP_ULL(1000000000ULL, i2c_clk);
+	switch (dev->cfg.sm) {
+	case I2C_FREQ_MODE_FAST:
+	case I2C_FREQ_MODE_FAST_PLUS:
+		slsu = DIV_ROUND_UP(100, ns); /* Fast */
+		break;
+	case I2C_FREQ_MODE_HIGH_SPEED:
+		slsu = DIV_ROUND_UP(10, ns); /* High */
+		break;
+	case I2C_FREQ_MODE_STANDARD:
+	default:
+		slsu = DIV_ROUND_UP(250, ns); /* Standard */
+		break;
+	}
+	slsu += 1;
 
-	i2c_clk = clk_get_rate(dev->clk);
+	dev_dbg(&dev->adev->dev, "calculated SLSU = %04x\n", slsu);
+	writel(slsu << 16, dev->virtbase + I2C_SCR);
 
 	/*
 	 * The spec says, in case of std. mode the divider is
@@ -915,11 +937,6 @@ static const struct i2c_algorithm nmk_i2c_algo = {
 };
 
 static struct nmk_i2c_controller u8500_i2c = {
-	/*
-	 * Slave data setup time; 250ns, 100ns, and 10ns, which
-	 * is 14, 6 and 2 respectively for a 48Mhz i2c clock.
-	 */
-	.slsu           = 0xe,
 	.tft            = 1,      /* Tx FIFO threshold */
 	.rft            = 8,      /* Rx FIFO threshold */
 	.clk_freq       = 400000, /* fast mode operation */
@@ -1027,7 +1044,6 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 	/* fetch the controller configuration from machine */
 	dev->cfg.clk_freq = pdata->clk_freq;
-	dev->cfg.slsu	= pdata->slsu;
 	dev->cfg.tft	= pdata->tft;
 	dev->cfg.rft	= pdata->rft;
 	dev->cfg.sm	= pdata->sm;
diff --git a/include/linux/platform_data/i2c-nomadik.h b/include/linux/platform_data/i2c-nomadik.h
index 3a8be9cdc95c..8681893f7b66 100644
--- a/include/linux/platform_data/i2c-nomadik.h
+++ b/include/linux/platform_data/i2c-nomadik.h
@@ -18,10 +18,6 @@ enum i2c_freq_mode {
 /**
  * struct nmk_i2c_controller - client specific controller configuration
  * @clk_freq:	clock frequency for the operation mode
- * @slsu:	Slave data setup time in ns.
- *		The needed setup time for three modes of operation
- *		are 250ns, 100ns and 10ns respectively thus leading
- *		to the values of 14, 6, 2 for a 48 MHz i2c clk
  * @tft:	Tx FIFO Threshold in bytes
  * @rft:	Rx FIFO Threshold in bytes
  * @timeout	Slave response timeout(ms)
@@ -29,7 +25,6 @@ enum i2c_freq_mode {
  */
 struct nmk_i2c_controller {
 	u32             clk_freq;
-	unsigned short	slsu;
 	unsigned char	tft;
 	unsigned char	rft;
 	int timeout;
-- 
1.8.3.1
