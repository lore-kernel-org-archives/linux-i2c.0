From: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Subject: [PATCH] i2c: davinci: Fix null dereference bug in i2c_davinci_calc_clk_dividers
Date: Sat, 23 Apr 2011 13:31:35 -0400
Message-ID: <1303579895-9441-1-git-send-email-michael.williamson@criticallink.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, chaithrika-l0cyMroinI0@public.gmane.org, Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The davinci-i2c bus driver currently supports being probed with a NULL
platform_data structure by using a default configuration when none is
provided.  However, the i2c_davinci_calc_clk_dividers does not
check the provided platform_data for NULL prior to using it, so
the support is incomplete.

Rather than have each runtime call check for NULL and avoid future
problems, copy a pointer to the default data to the device structure
during the probe.  This should be OK, as the information in this
structure is not modified by the driver.

Tested on a MityDSP-L138 module (OMAP-L138 based SOM).

Signed-off-by: Micahel Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 5795c83..1db8fc9 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -163,8 +163,7 @@ static void i2c_recover_bus(struct davinci_i2c_dev *dev)
 	flag |=  DAVINCI_I2C_MDR_NACK;
 	/* write the data into mode register */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
-	if (pdata)
-		generic_i2c_clock_pulse(pdata->scl_pin);
+	generic_i2c_clock_pulse(pdata->scl_pin);
 	/* Send STOP */
 	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
 	flag |= DAVINCI_I2C_MDR_STP;
@@ -235,10 +234,11 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
  */
 static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 {
-	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
+	struct davinci_i2c_platform_data *pdata;
 
-	if (!pdata)
-		pdata = &davinci_i2c_platform_data_default;
+	if (!dev->dev->platform_data)
+		dev->dev->platform_data = &davinci_i2c_platform_data_default;
+	pdata = dev->dev->platform_data;
 
 	/* put I2C into reset */
 	davinci_i2c_reset_ctrl(dev, 0);
@@ -313,8 +313,6 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	u16 w;
 	int r;
 
-	if (!pdata)
-		pdata = &davinci_i2c_platform_data_default;
 	/* Introduce a delay, required for some boards (e.g Davinci EVM) */
 	if (pdata->bus_delay)
 		udelay(pdata->bus_delay);
-- 
1.7.0.4
