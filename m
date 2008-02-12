From: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Subject: [PATCH] ARM: DaVinci: i2c fix lost interrupt
Date: Mon, 11 Feb 2008 19:01:42 -0700
Message-ID: <1202781702-3378-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

ARM: DaVinci: i2c fix lost interrupt
DAVINCI_I2C_STR_REG is a write 1 to clear register,
so don't use a read/modify/write cycle.
EVM doesn't have platform data yet, make bus_delay default correct
Ensure psc value gives a clock between 7-12 Mhz
Make sure no interrupts are pending before starting transfer

Signed-off-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Acked-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>

---
 drivers/i2c/busses/i2c-davinci.c |   38 ++++++++++++++++++--------------------
 1 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index f348ee0..488bd7c 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -123,7 +123,7 @@ struct davinci_i2c_dev {
 /* default platform data to use if not supplied in the platform_device */
 static struct davinci_i2c_platform_data davinci_i2c_platform_data_default = {
 	.bus_freq	= 100,
-	.bus_delay	= 0,
+	.bus_delay	= 100,
 };
 
 static inline void davinci_i2c_write_reg(struct davinci_i2c_dev *i2c_dev,
@@ -147,6 +147,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
 	u16 psc;
 	u32 clk;
+	u32 d;
 	u32 clkh;
 	u32 clkl;
 	u32 input_clock = clk_get_rate(dev->clk);
@@ -176,23 +177,26 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	 *       if PSC > 1 , d = 5
 	 */
 
-	psc = 26; /* To get 1MHz clock */
+	psc = (input_clock/7000000)-1;			 /* To get  minimum of 7 MHz clock */
+	if ( (input_clock/(psc+1)) > 12000000) psc++;	 /* maximum of 12Mhz */
+	d = (psc>=2)? 5 : 7 - psc;
 
-	clk = ((input_clock / (psc + 1)) / (pdata->bus_freq * 1000)) - 10;
-	clkh = (50 * clk) / 100;
+	clk = ((input_clock/(psc+1)) / (pdata->bus_freq * 1000)) - (d<<1);
+	clkh = clk>>1;
 	clkl = clk - clkh;
 
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_PSC_REG, psc);
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKH_REG, clkh);
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKL_REG, clkl);
 
-	dev_dbg(dev->dev, "CLK  = %d\n", clk);
+	dev_dbg(dev->dev, "input_clock=%d, CLK  = %d\n", input_clock,clk);
 	dev_dbg(dev->dev, "PSC  = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_PSC_REG));
 	dev_dbg(dev->dev, "CLKL = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKL_REG));
 	dev_dbg(dev->dev, "CLKH = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKH_REG));
+	dev_dbg(dev->dev, "bus_freq = %dKHz bus_delay = %d\n",pdata->bus_freq,pdata->bus_delay);
 
 	/* Take the I2C module out of reset: */
 	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
@@ -278,7 +282,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	dev->cmd_err = 0;
 
 	/* Clear any pending interrupts by reading the IVR */
-	stat = davinci_i2c_read_reg(dev, DAVINCI_I2C_IVR_REG);
+	do {
+		stat = davinci_i2c_read_reg(dev, DAVINCI_I2C_IVR_REG);
+	} while (stat);
 
 	/* Take I2C out of reset, configure it as master and set the
 	 * start bit */
@@ -358,12 +364,10 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	for (i = 0; i < num; i++) {
 		ret = i2c_davinci_xfer_msg(adap, &msgs[i], (i == (num - 1)));
+		dev_dbg(dev->dev, "%s ret: %d\n", __FUNCTION__, ret);
 		if (ret < 0)
 			return ret;
 	}
-
-	dev_dbg(dev->dev, "%s:%d ret: %d\n", __FUNCTION__, __LINE__, ret);
-
 	return num;
 }
 
@@ -406,9 +410,8 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
 			break;
 
 		case DAVINCI_I2C_IVR_ARDY:
-			w = davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG);
-			MOD_REG_BIT(w, DAVINCI_I2C_STR_ARDY, 1);
-			davinci_i2c_write_reg(dev, DAVINCI_I2C_STR_REG, w);
+			davinci_i2c_write_reg(dev,
+				DAVINCI_I2C_STR_REG, DAVINCI_I2C_STR_ARDY);
 			complete(&dev->cmd_complete);
 			break;
 
@@ -421,12 +424,8 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
 				if (dev->buf_len)
 					continue;
 
-				w = davinci_i2c_read_reg(dev,
-							 DAVINCI_I2C_STR_REG);
-				MOD_REG_BIT(w, DAVINCI_I2C_IMR_RRDY, 0);
 				davinci_i2c_write_reg(dev,
-						      DAVINCI_I2C_STR_REG,
-						      w);
+					DAVINCI_I2C_STR_REG,DAVINCI_I2C_IMR_RRDY);
 			} else
 				dev_err(dev->dev, "RDR IRQ while no "
 					"data requested\n");
@@ -452,9 +451,8 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
 			break;
 
 		case DAVINCI_I2C_IVR_SCD:
-			w = davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG);
-			MOD_REG_BIT(w, DAVINCI_I2C_STR_SCD, 1);
-			davinci_i2c_write_reg(dev, DAVINCI_I2C_STR_REG, w);
+			davinci_i2c_write_reg(dev,
+				DAVINCI_I2C_STR_REG, DAVINCI_I2C_STR_SCD);
 			complete(&dev->cmd_complete);
 			break;
 
-- 
1.5.4


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
