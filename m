From: Kaushal Butala <kaushalkernelmailinglist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH-v2] SMBus block read support to imx_i2c
Date: Fri, 4 Apr 2014 14:56:10 +0200
Message-ID: <1396616170-6659-1-git-send-email-kaushalkernelmailinglist@gmail.com>
References: <20140402083046.GB8753@dragon>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140402083046.GB8753@dragon>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kaushal Butala <kaushalkernelmailinglist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The smbus block read is not currently supported for imx i2c devices.
This patchset adds the support to imx i2c bus so that blocks of data
can be read using SMbus block reads.(using i2c_smbus_read_block_data()
function from the i2c_core.c.). Tested with 3.10.9 kernel.

Reviewed-by: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Signed-off-by: Kaushal Butala <kaushalkernelmailinglist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
Updated after review comments from Shawn Guo. Removed unnecessary parenthesis
around 'block_data'.

 drivers/i2c/busses/i2c-imx.c |   31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index db895fb..886217f 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -462,6 +462,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
 {
 	int i, result;
 	unsigned int temp;
+	int block_data = msgs->flags & I2C_M_RECV_LEN;
 
 	dev_dbg(&i2c_imx->adapter.dev,
 		"<%s> write slave address: addr=0x%x\n",
@@ -481,7 +482,12 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
 	/* setup bus to read data */
 	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 	temp &= ~I2CR_MTX;
-	if (msgs->len - 1)
+
+	/*
+	 * Reset the I2CR_TXAK flag initially for SMBus block read since the
+	 * length is unknown
+	 */
+	if ((msgs->len - 1) || block_data)
 		temp &= ~I2CR_TXAK;
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR); /* dummy read */
@@ -490,9 +496,24 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
 
 	/* read data */
 	for (i = 0; i < msgs->len; i++) {
+		u8 len = 0;
 		result = i2c_imx_trx_complete(i2c_imx);
 		if (result)
 			return result;
+		/*
+		 * First byte is the length of remaining packet
+		 * in the SMBus block data read. Add it to
+		 * msgs->len.
+		 */
+		if ((!i) && block_data) {
+			len = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
+			if ((len == 0) || (len > I2C_SMBUS_BLOCK_MAX))
+				return -EPROTO;
+			dev_dbg(&i2c_imx->adapter.dev,
+				"<%s> read length: 0x%X\n",
+				__func__, len);
+			msgs->len += len;
+		}
 		if (i == (msgs->len - 1)) {
 			/* It must generate STOP before read I2DR to prevent
 			   controller from generating another clock cycle */
@@ -510,7 +531,10 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
 			temp |= I2CR_TXAK;
 			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 		}
-		msgs->buf[i] = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
+		if ((!i) && block_data)
+			msgs->buf[0] = len;
+		else
+			msgs->buf[i] =  imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
 		dev_dbg(&i2c_imx->adapter.dev,
 			"<%s> read byte: B%d=0x%X\n",
 			__func__, i, msgs->buf[i]);
@@ -583,7 +607,8 @@ fail0:
 
 static u32 i2c_imx_func(struct i2c_adapter *adapter)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
+		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
 }
 
 static struct i2c_algorithm i2c_imx_algo = {
-- 
1.7.9.5
