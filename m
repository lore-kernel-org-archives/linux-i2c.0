From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] i2c: davinci: Add block read functionality for IPMI
Date: Thu, 1 May 2014 14:49:46 -0400
Message-ID: <1398970186-12204-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Garrett Ding <g-ding-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Intelligent Plaform Management Interface (IPMI) requires I2C driver
to support block read, where the first byte received from slave is
the length of following data:-
 Added length check if the read type is block read (I2C_M_RECV_LEN)
 Send NACK/STOP bits before last byte is received

Signed-off-by: Garrett Ding <g-ding-l0cyMroinI0@public.gmane.org>
Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Tested-by: Garrett Ding <g-ding-l0cyMroinI0@public.gmane.org>
CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
CC: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
CC: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
---
 Tested on a customer board based on K2HK SoC
 drivers/i2c/busses/i2c-davinci.c |   42 +++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 389bc68..cd97920 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -97,6 +97,10 @@
 #define DAVINCI_I2C_IMR_NACK	BIT(1)
 #define DAVINCI_I2C_IMR_AL	BIT(0)
 
+/* capabilities */
+#define I2C_CAPABILITIES	(I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | \
+				 I2C_FUNC_SMBUS_READ_BLOCK_DATA)
+
 struct davinci_i2c_dev {
 	struct device           *dev;
 	void __iomem		*base;
@@ -318,7 +322,13 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_SAR_REG, msg->addr);
 
 	dev->buf = msg->buf;
-	dev->buf_len = msg->len;
+
+	 /* if first received byte is length, set buf_len = 0xffff as flag */
+	if (msg->flags & I2C_M_RECV_LEN)
+		dev->buf_len = 0xffff;
+	else
+		dev->buf_len = msg->len;
+
 	dev->stop = stop;
 
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CNT_REG, dev->buf_len);
@@ -456,7 +466,7 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 static u32 i2c_davinci_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	return I2C_CAPABILITIES;
 }
 
 static void terminate_read(struct davinci_i2c_dev *dev)
@@ -528,10 +538,32 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
 
 		case DAVINCI_I2C_IVR_RDR:
 			if (dev->buf_len) {
-				*dev->buf++ =
-				    davinci_i2c_read_reg(dev,
-							 DAVINCI_I2C_DRR_REG);
+				*dev->buf++ = davinci_i2c_read_reg(dev,
+							DAVINCI_I2C_DRR_REG);
+				/*
+				 * check if the first received byte is message
+				 * length, i.e, I2C_M_RECV_LEN
+				 */
+				if (dev->buf_len == 0xffff)
+					dev->buf_len = *(dev->buf - 1) + 1;
+
 				dev->buf_len--;
+				/*
+				 * send NACK/STOP bits BEFORE last byte is
+				 * received
+				 */
+				if (dev->buf_len == 1) {
+					w = davinci_i2c_read_reg(dev,
+							DAVINCI_I2C_MDR_REG);
+					w |= DAVINCI_I2C_MDR_NACK;
+					davinci_i2c_write_reg(dev,
+							DAVINCI_I2C_MDR_REG, w);
+
+					w |= DAVINCI_I2C_MDR_STP;
+					davinci_i2c_write_reg(dev,
+							DAVINCI_I2C_MDR_REG, w);
+				}
+
 				if (dev->buf_len)
 					continue;
 
-- 
1.7.9.5
