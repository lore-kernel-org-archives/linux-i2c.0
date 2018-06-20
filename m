From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 4/5] i2c: mux: pca954x: make use of __i2c_smbus_xfer
Date: Wed, 20 Jun 2018 10:51:56 +0200
Message-ID: <20180620085157.30121-5-peda@axentia.se>
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
 drivers/i2c/muxes/i2c-mux-pca954x.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index fbc748027087..0e9a0e66e92f 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -220,30 +220,11 @@ MODULE_DEVICE_TABLE(of, pca954x_of_match);
 static int pca954x_reg_write(struct i2c_adapter *adap,
 			     struct i2c_client *client, u8 val)
 {
-	int ret = -ENODEV;
-
-	if (adap->algo->master_xfer) {
-		struct i2c_msg msg;
-		char buf[1];
-
-		msg.addr = client->addr;
-		msg.flags = 0;
-		msg.len = 1;
-		buf[0] = val;
-		msg.buf = buf;
-		ret = __i2c_transfer(adap, &msg, 1);
-
-		if (ret >= 0 && ret != 1)
-			ret = -EREMOTEIO;
-	} else {
-		union i2c_smbus_data data;
-		ret = adap->algo->smbus_xfer(adap, client->addr,
-					     client->flags,
-					     I2C_SMBUS_WRITE,
-					     val, I2C_SMBUS_BYTE, &data);
-	}
+	union i2c_smbus_data dummy;
 
-	return ret;
+	return __i2c_smbus_xfer(adap, client->addr, client->flags,
+				I2C_SMBUS_WRITE, val,
+				I2C_SMBUS_BYTE, &dummy);
 }
 
 static int pca954x_select_chan(struct i2c_mux_core *muxc, u32 chan)
-- 
2.11.0
