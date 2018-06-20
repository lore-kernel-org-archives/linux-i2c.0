From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 3/5] i2c: mux: pca9541: make use of __i2c_smbus_xfer
Date: Wed, 20 Jun 2018 10:51:55 +0200
Message-ID: <20180620085157.30121-4-peda@axentia.se>
References: <20180620085157.30121-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620085157.30121-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, Akinobu Mita <akinobu.mita@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This simplifies the code, and you get retries for free if the adapter
does not support ->master_xfer.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 69 ++++++-------------------------------
 1 file changed, 11 insertions(+), 58 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 6a39adaf433f..3d8c938e99e7 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -99,31 +99,11 @@ MODULE_DEVICE_TABLE(of, pca9541_of_match);
 static int pca9541_reg_write(struct i2c_client *client, u8 command, u8 val)
 {
 	struct i2c_adapter *adap = client->adapter;
-	int ret;
-
-	if (adap->algo->master_xfer) {
-		struct i2c_msg msg;
-		char buf[2];
-
-		msg.addr = client->addr;
-		msg.flags = 0;
-		msg.len = 2;
-		buf[0] = command;
-		buf[1] = val;
-		msg.buf = buf;
-		ret = __i2c_transfer(adap, &msg, 1);
-	} else {
-		union i2c_smbus_data data;
-
-		data.byte = val;
-		ret = adap->algo->smbus_xfer(adap, client->addr,
-					     client->flags,
-					     I2C_SMBUS_WRITE,
-					     command,
-					     I2C_SMBUS_BYTE_DATA, &data);
-	}
+	union i2c_smbus_data data = { .byte = val };
 
-	return ret;
+	return __i2c_smbus_xfer(adap, client->addr, client->flags,
+				I2C_SMBUS_WRITE, command,
+				I2C_SMBUS_BYTE_DATA, &data);
 }
 
 /*
@@ -133,41 +113,14 @@ static int pca9541_reg_write(struct i2c_client *client, u8 command, u8 val)
 static int pca9541_reg_read(struct i2c_client *client, u8 command)
 {
 	struct i2c_adapter *adap = client->adapter;
+	union i2c_smbus_data data;
 	int ret;
-	u8 val;
-
-	if (adap->algo->master_xfer) {
-		struct i2c_msg msg[2] = {
-			{
-				.addr = client->addr,
-				.flags = 0,
-				.len = 1,
-				.buf = &command
-			},
-			{
-				.addr = client->addr,
-				.flags = I2C_M_RD,
-				.len = 1,
-				.buf = &val
-			}
-		};
-		ret = __i2c_transfer(adap, msg, 2);
-		if (ret == 2)
-			ret = val;
-		else if (ret >= 0)
-			ret = -EIO;
-	} else {
-		union i2c_smbus_data data;
-
-		ret = adap->algo->smbus_xfer(adap, client->addr,
-					     client->flags,
-					     I2C_SMBUS_READ,
-					     command,
-					     I2C_SMBUS_BYTE_DATA, &data);
-		if (!ret)
-			ret = data.byte;
-	}
-	return ret;
+
+	ret = __i2c_smbus_xfer(adap, client->addr, client->flags,
+			       I2C_SMBUS_READ, command,
+			       I2C_SMBUS_BYTE_DATA, &data);
+
+	return ret ?: data.byte;
 }
 
 /*
-- 
2.11.0
