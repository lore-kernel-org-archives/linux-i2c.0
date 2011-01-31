From: Fabien Marteau <fabien.marteau@armadeus.com>
Subject: [PATCH] i2c: Adding mangling capability to i2c imx bus controller.
Date: Mon, 31 Jan 2011 16:29:53 +0100
Message-ID: <4D46D571.5010907@armadeus.com>
Reply-To: "Fabien Marteau" <fabien.marteau@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, =?ISO-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <u.kleine-koenig@pengutronix>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Adding Mangling capability to i2c imx bus controller.

Signed-off-by: Fabien Marteau <fabien.marteau@armadeus.com>
---
Index: linux-2.6.36/drivers/i2c/busses/i2c-imx.c
===================================================================
--- linux-2.6.36.orig/drivers/i2c/busses/i2c-imx.c	2010-10-20 22:30:22.000000000 +0200
+++ linux-2.6.36/drivers/i2c/busses/i2c-imx.c	2011-01-31 16:23:34.000000000 +0100
@@ -300,17 +300,28 @@
 {
 	int i, result;

-	dev_dbg(&i2c_imx->adapter.dev, "<%s> write slave address: addr=0x%x\n",
-		__func__, msgs->addr << 1);
+	if ((msgs->flags & I2C_M_NOSTART) == 0) {
+		/* write slave address */
+		if (msgs->flags & I2C_M_REV_DIR_ADDR) {
+			dev_dbg(&i2c_imx->adapter.dev,
+				"<%s> write slave address: addr=0x%x\n",
+				__func__, msgs->addr << 1 | 0x01);
+			writeb((msgs->addr << 1) | 0x01,
+			       i2c_imx->base + IMX_I2C_I2DR);
+		} else {
+			dev_dbg(&i2c_imx->adapter.dev,
+				"<%s> write slave address: addr=0x%x\n",
+				__func__, msgs->addr << 1);
+			writeb((msgs->addr << 1), i2c_imx->base + IMX_I2C_I2DR);
+		}
+		result = i2c_imx_trx_complete(i2c_imx);
+		if (result)
+			return result;
+		result = i2c_imx_acked(i2c_imx);
+		if (result != 0)
+			return result;
+	}

-	/* write slave address */
-	writeb(msgs->addr << 1, i2c_imx->base + IMX_I2C_I2DR);
-	result = i2c_imx_trx_complete(i2c_imx);
-	if (result)
-		return result;
-	result = i2c_imx_acked(i2c_imx);
-	if (result)
-		return result;
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> write data\n", __func__);

 	/* write data */
@@ -323,7 +334,7 @@
 		if (result)
 			return result;
 		result = i2c_imx_acked(i2c_imx);
-		if (result)
+		if ((result != 0) && ((msgs[0].flags & I2C_M_IGNORE_NAK) == 0))
 			return result;
 	}
 	return 0;
@@ -334,18 +345,27 @@
 	int i, result;
 	unsigned int temp;

-	dev_dbg(&i2c_imx->adapter.dev,
-		"<%s> write slave address: addr=0x%x\n",
-		__func__, (msgs->addr << 1) | 0x01);
-
-	/* write slave address */
-	writeb((msgs->addr << 1) | 0x01, i2c_imx->base + IMX_I2C_I2DR);
-	result = i2c_imx_trx_complete(i2c_imx);
-	if (result)
-		return result;
-	result = i2c_imx_acked(i2c_imx);
-	if (result)
-		return result;
+	if ((msgs->flags & I2C_M_NOSTART) == 0) {
+		/* write slave address */
+		if (msgs->flags & I2C_M_REV_DIR_ADDR) {
+			dev_dbg(&i2c_imx->adapter.dev,
+			"<%s> write slave address: addr=0x%x\n",
+			__func__, (msgs->addr << 1));
+			writeb((msgs->addr << 1), i2c_imx->base + IMX_I2C_I2DR);
+		} else {
+			dev_dbg(&i2c_imx->adapter.dev,
+			"<%s> write slave address: addr=0x%x\n",
+			__func__, (msgs->addr << 1) | 0x01);
+			writeb((msgs->addr << 1) | 0x01,
+			       i2c_imx->base + IMX_I2C_I2DR);
+		}
+		result = i2c_imx_trx_complete(i2c_imx);
+		if (result)
+			return result;
+		result = i2c_imx_acked(i2c_imx);
+		if (result != 0)
+			return result;
+	}

 	dev_dbg(&i2c_imx->adapter.dev, "<%s> setup bus\n", __func__);

@@ -405,7 +425,7 @@

 	/* read/write data */
 	for (i = 0; i < num; i++) {
-		if (i) {
+		if (i && ((msgs[i].flags & I2C_M_NOSTART) == 0)) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> repeated start\n", __func__);
 			temp = readb(i2c_imx->base + IMX_I2C_I2CR);
@@ -454,7 +474,7 @@

 static u32 i2c_imx_func(struct i2c_adapter *adapter)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_PROTOCOL_MANGLING;
 }

 static struct i2c_algorithm i2c_imx_algo = {
