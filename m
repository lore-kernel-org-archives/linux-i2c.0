From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH 10/10] i2c: pca954x: get rid of the i2c deadlock workaround
Date: Mon,  4 Jan 2016 16:10:15 +0100
Message-ID: <1451920215-29167-11-git-send-email-peda@lysator.liu.se>
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
 drivers/i2c/muxes/i2c-mux-pca954x.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index bd89da42b417..929ce28bc657 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -119,32 +119,19 @@ static const struct i2c_device_id pca954x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, pca954x_id);
 
-/* Write to mux register. Don't use i2c_transfer()/i2c_smbus_xfer()
-   for this as they will try to lock adapter a second time */
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
-	} else {
-		union i2c_smbus_data data;
-		ret = adap->algo->smbus_xfer(adap, client->addr,
-					     client->flags,
-					     I2C_SMBUS_WRITE,
-					     val, I2C_SMBUS_BYTE, &data);
-	}
+	union i2c_smbus_data data;
 
-	return ret;
+	if (i2c_check_functionality(adap, I2C_FUNC_SMBUS_QUICK))
+		return i2c_smbus_xfer(adap, client->addr, client->flags,
+				      I2C_SMBUS_WRITE, val,
+				      I2C_SMBUS_QUICK, NULL);
+	else
+		return i2c_smbus_xfer(adap, client->addr, client->flags,
+				      I2C_SMBUS_WRITE, val,
+				      I2C_SMBUS_BYTE, &data);
 }
 
 static int pca954x_select_chan(struct i2c_mux_core *muxc, u32 chan)
@@ -227,6 +214,7 @@ static int pca954x_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
+	muxc->i2c_controlled = true;
 	muxc->parent = adap;
 	muxc->select = pca954x_select_chan;
 	muxc->deselect = pca954x_deselect_mux;
-- 
2.1.4
