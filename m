From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 3/6] i2c: davinci: Add helper functions
Date: Tue, 26 Jan 2010 15:41:30 -0800
Message-ID: <1264549293-25556-4-git-send-email-khilman@deeprootsystems.com>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1264549293-25556-1-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>

Add i2c reset control and clock divider calculation functions
which will be useful for power management features.

Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |   56 +++++++++++++++++++++++++-------------
 1 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 34a48d0..aacef7b 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -125,12 +125,21 @@ static inline u16 davinci_i2c_read_reg(struct davinci_i2c_dev *i2c_dev, int reg)
 	return __raw_readw(i2c_dev->base + reg);
 }
 
-/*
- * This functions configures I2C and brings I2C out of reset.
- * This function is called during I2C init function. This function
- * also gets called if I2C encounters any errors.
- */
-static int i2c_davinci_init(struct davinci_i2c_dev *dev)
+static inline void davinci_i2c_reset_ctrl(struct davinci_i2c_dev *i2c_dev,
+								int val)
+{
+	u16 w;
+
+	w = davinci_i2c_read_reg(i2c_dev, DAVINCI_I2C_MDR_REG);
+	if (!val)	/* put I2C into reset */
+		w &= ~DAVINCI_I2C_MDR_IRS;
+	else		/* take I2C out of reset */
+		w |= DAVINCI_I2C_MDR_IRS;
+
+	davinci_i2c_write_reg(i2c_dev, DAVINCI_I2C_MDR_REG, w);
+}
+
+static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 {
 	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
 	u16 psc;
@@ -139,15 +148,6 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	u32 clkh;
 	u32 clkl;
 	u32 input_clock = clk_get_rate(dev->clk);
-	u16 w;
-
-	if (!pdata)
-		pdata = &davinci_i2c_platform_data_default;
-
-	/* put I2C into reset */
-	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
-	w &= ~DAVINCI_I2C_MDR_IRS;
-	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
 
 	/* NOTE: I2C Clock divider programming info
 	 * As per I2C specs the following formulas provide prescaler
@@ -179,12 +179,32 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKH_REG, clkh);
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKL_REG, clkl);
 
+	dev_dbg(dev->dev, "input_clock = %d, CLK = %d\n", input_clock, clk);
+}
+
+/*
+ * This function configures I2C and brings I2C out of reset.
+ * This function is called during I2C init function. This function
+ * also gets called if I2C encounters any errors.
+ */
+static int i2c_davinci_init(struct davinci_i2c_dev *dev)
+{
+	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
+
+	if (!pdata)
+		pdata = &davinci_i2c_platform_data_default;
+
+	/* put I2C into reset */
+	davinci_i2c_reset_ctrl(dev, 0);
+
+	/* compute clock dividers */
+	i2c_davinci_calc_clk_dividers(dev);
+
 	/* Respond at reserved "SMBus Host" slave address" (and zero);
 	 * we seem to have no option to not respond...
 	 */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_OAR_REG, 0x08);
 
-	dev_dbg(dev->dev, "input_clock = %d, CLK = %d\n", input_clock, clk);
 	dev_dbg(dev->dev, "PSC  = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_PSC_REG));
 	dev_dbg(dev->dev, "CLKL = %d\n",
@@ -195,9 +215,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 		pdata->bus_freq, pdata->bus_delay);
 
 	/* Take the I2C module out of reset: */
-	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
-	w |= DAVINCI_I2C_MDR_IRS;
-	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
+	davinci_i2c_reset_ctrl(dev, 1);
 
 	/* Enable interrupts */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, I2C_DAVINCI_INTR_ALL);
-- 
1.6.6
