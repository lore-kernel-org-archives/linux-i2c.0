From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/5] i2c: mux: mlxcpld: make use of __i2c_smbus_xfer
Date: Wed, 20 Jun 2018 10:51:54 +0200
Message-ID: <20180620085157.30121-3-peda@axentia.se>
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
 drivers/i2c/muxes/i2c-mux-mlxcpld.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
index 12ad8d65faf6..f2bf3e57ed67 100644
--- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
+++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
@@ -94,31 +94,11 @@ static int mlxcpld_mux_reg_write(struct i2c_adapter *adap,
 				 struct i2c_client *client, u8 val)
 {
 	struct mlxcpld_mux_plat_data *pdata = dev_get_platdata(&client->dev);
-	int ret = -ENODEV;
-
-	if (adap->algo->master_xfer) {
-		struct i2c_msg msg;
-		u8 msgbuf[] = {pdata->sel_reg_addr, val};
-
-		msg.addr = client->addr;
-		msg.flags = 0;
-		msg.len = 2;
-		msg.buf = msgbuf;
-		ret = __i2c_transfer(adap, &msg, 1);
-
-		if (ret >= 0 && ret != 1)
-			ret = -EREMOTEIO;
-	} else if (adap->algo->smbus_xfer) {
-		union i2c_smbus_data data;
-
-		data.byte = val;
-		ret = adap->algo->smbus_xfer(adap, client->addr,
-					     client->flags, I2C_SMBUS_WRITE,
-					     pdata->sel_reg_addr,
-					     I2C_SMBUS_BYTE_DATA, &data);
-	}
+	union i2c_smbus_data data = { .byte = val };
 
-	return ret;
+	return __i2c_smbus_xfer(adap, client->addr, client->flags,
+				I2C_SMBUS_WRITE, pdata->sel_reg_addr,
+				I2C_SMBUS_BYTE_DATA, &data);
 }
 
 static int mlxcpld_mux_select_chan(struct i2c_mux_core *muxc, u32 chan)
-- 
2.11.0
