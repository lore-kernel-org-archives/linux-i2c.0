From: Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
Subject: [RESEND PATCH 2/3] i2c: added I2C_FUNC_NO_CLK_STRETCH to i2c-algo-bit.c
Date: Wed, 16 Sep 2015 15:35:46 +0200
Message-ID: <1442410547-9952-1-git-send-email-nicola@corna.info>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Added I2C_FUNC_NO_CLK_STRETCH to drivers/i2c/algos/i2c-algo-bit.c when
getscl is not available.

Signed-off-by: Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 899bede..82cad0b 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -602,10 +602,13 @@ bailout:
 
 static u32 bit_func(struct i2c_adapter *adap)
 {
+	struct i2c_algo_bit_data *bit_adap = adap->algo_data;
+
 	return I2C_FUNC_I2C | I2C_FUNC_NOSTART | I2C_FUNC_SMBUS_EMUL |
 	       I2C_FUNC_SMBUS_READ_BLOCK_DATA |
 	       I2C_FUNC_SMBUS_BLOCK_PROC_CALL |
-	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING;
+	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING |
+	       (bit_adap->getscl ? 0 : I2C_FUNC_NO_CLK_STRETCH);
 }
 
 
-- 
2.5.1
