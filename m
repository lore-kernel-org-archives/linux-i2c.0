From: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 2/5] I2C: DaVinci: clock between 7-12 Mhz
Date: Thu, 20 Mar 2008 20:06:07 -0700
Message-ID: <1206068770-15458-3-git-send-email-troy.kisky@boundarydevices.com>
References: <1206068770-15458-1-git-send-email-troy.kisky@boundarydevices.com>
	<1206068770-15458-2-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1206068770-15458-2-git-send-email-troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
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
Cc: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ensure psc value gives a clock between 7-12 Mhz
Signed-off-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index fde2634..82d4b7f 100755
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -142,6 +142,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
 	u16 psc;
 	u32 clk;
+	u32 d;
 	u32 clkh;
 	u32 clkl;
 	u32 input_clock = clk_get_rate(dev->clk);
@@ -171,23 +172,29 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	 *       if PSC > 1 , d = 5
 	 */
 
-	psc = 26; /* To get 1MHz clock */
+	/* get minimum of 7mHz clock, but max of 12mHz */
+	psc = (input_clock/7000000)-1;
+	if ((input_clock/(psc+1)) > 12000000)
+		psc++;
+	d = (psc >= 2)? 5 : 7 - psc;
 
-	clk = ((input_clock / (psc + 1)) / (pdata->bus_freq * 1000)) - 10;
-	clkh = (50 * clk) / 100;
+	clk = ((input_clock/(psc+1)) / (pdata->bus_freq * 1000)) - (d<<1);
+	clkh = clk>>1;
 	clkl = clk - clkh;
 
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_PSC_REG, psc);
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKH_REG, clkh);
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKL_REG, clkl);
 
-	dev_dbg(dev->dev, "CLK  = %d\n", clk);
+	dev_dbg(dev->dev, "input_clock=%d, CLK  = %d\n", input_clock, clk);
 	dev_dbg(dev->dev, "PSC  = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_PSC_REG));
 	dev_dbg(dev->dev, "CLKL = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKL_REG));
 	dev_dbg(dev->dev, "CLKH = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKH_REG));
+	dev_dbg(dev->dev, "bus_freq = %dkHz bus_delay = %d\n",
+		pdata->bus_freq, pdata->bus_delay);
 
 	/* Take the I2C module out of reset: */
 	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
@@ -338,12 +345,10 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	for (i = 0; i < num; i++) {
 		ret = i2c_davinci_xfer_msg(adap, &msgs[i], (i == (num - 1)));
+		dev_dbg(dev->dev, "%s ret: %d\n", __func__, ret);
 		if (ret < 0)
 			return ret;
 	}
-
-	dev_dbg(dev->dev, "%s:%d ret: %d\n", __FUNCTION__, __LINE__, ret);
-
 	return num;
 }
 
-- 
1.5.4


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
