From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: davinci: rename recover bus functions
Date: Fri, 29 Mar 2013 12:10:36 +0100
Message-ID: <1364555436-30662-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Since we have generic i2c bus recover routines now, these custom ones
need to be renamed to fix the namespace clash. Proper conversion needs
to be done by someone who has access to the hardware.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 7d1e590..61f793b 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -137,7 +137,7 @@ static inline u16 davinci_i2c_read_reg(struct davinci_i2c_dev *i2c_dev, int reg)
 }
 
 /* Generate a pulse on the i2c clock pin. */
-static void generic_i2c_clock_pulse(unsigned int scl_pin)
+static void davinci_i2c_clock_pulse(unsigned int scl_pin)
 {
 	u16 i;
 
@@ -155,7 +155,7 @@ static void generic_i2c_clock_pulse(unsigned int scl_pin)
 /* This routine does i2c bus recovery as specified in the
  * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
  */
-static void i2c_recover_bus(struct davinci_i2c_dev *dev)
+static void davinci_i2c_recover_bus(struct davinci_i2c_dev *dev)
 {
 	u32 flag = 0;
 	struct davinci_i2c_platform_data *pdata = dev->pdata;
@@ -166,7 +166,7 @@ static void i2c_recover_bus(struct davinci_i2c_dev *dev)
 	flag |=  DAVINCI_I2C_MDR_NACK;
 	/* write the data into mode register */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
-	generic_i2c_clock_pulse(pdata->scl_pin);
+	davinci_i2c_clock_pulse(pdata->scl_pin);
 	/* Send STOP */
 	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
 	flag |= DAVINCI_I2C_MDR_STP;
@@ -289,7 +289,7 @@ static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
 				return -ETIMEDOUT;
 			} else {
 				to_cnt = 0;
-				i2c_recover_bus(dev);
+				davinci_i2c_recover_bus(dev);
 				i2c_davinci_init(dev);
 			}
 		}
@@ -379,7 +379,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 						      dev->adapter.timeout);
 	if (r == 0) {
 		dev_err(dev->dev, "controller timed out\n");
-		i2c_recover_bus(dev);
+		davinci_i2c_recover_bus(dev);
 		i2c_davinci_init(dev);
 		dev->buf_len = 0;
 		return -ETIMEDOUT;
-- 
1.7.10.4
