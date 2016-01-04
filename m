From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH 09/10] i2c: pca9541: get rid of the i2c deadlock workaround
Date: Mon,  4 Jan 2016 16:10:14 +0100
Message-ID: <1451920215-29167-10-git-send-email-peda@lysator.liu.se>
References: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@lysator.liu.se>
List-Id: linux-i2c@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 82 +++++++------------------------------
 1 file changed, 15 insertions(+), 67 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 9ee0d8b70283..7d2e5dbd8617 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -85,81 +85,28 @@ static const struct i2c_device_id pca9541_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, pca9541_id);
 
-/*
- * Write to chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
- * as they will try to lock the adapter a second time.
- */
 static int pca9541_reg_write(struct i2c_client *client, u8 command, u8 val)
 {
-	struct i2c_adapter *adap = client->adapter;
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
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
+	union i2c_smbus_data data;
 
-	return ret;
+	data.byte = val;
+	return i2c_smbus_xfer(muxc->parent, client->addr, client->flags,
+			      I2C_SMBUS_WRITE, command,
+			      I2C_SMBUS_BYTE_DATA, &data);
 }
 
-/*
- * Read from chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
- * as they will try to lock adapter a second time.
- */
 static int pca9541_reg_read(struct i2c_client *client, u8 command)
 {
-	struct i2c_adapter *adap = client->adapter;
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
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
+
+	ret = i2c_smbus_xfer(muxc->parent, client->addr, client->flags,
+			     I2C_SMBUS_READ, command,
+			     I2C_SMBUS_BYTE_DATA, &data);
+	if (!ret)
+		ret = data.byte;
 	return ret;
 }
 
@@ -347,6 +294,7 @@ static int pca9541_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, muxc);
 
 	data->client = client;
+	muxc->i2c_controlled = true;
 	muxc->parent = adap;
 	muxc->select = pca9541_select_chan;
 	muxc->deselect = pca9541_release_chan;
-- 
2.1.4
