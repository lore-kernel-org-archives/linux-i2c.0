From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 11/12] i2c: xlr: use core to detect 'no zero length' quirk
Date: Mon, 23 Jul 2018 22:26:15 +0200
Message-ID: <20180723202617.15230-12-wsa+renesas@sang-engineering.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

And don't reimplement in the driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Only build tested.

 drivers/i2c/busses/i2c-xlr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
index 484bfa15d58e..34cd4b308540 100644
--- a/drivers/i2c/busses/i2c-xlr.c
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -173,9 +173,6 @@ static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
 	u8 offset;
 	u32 xfer;
 
-	if (!len)
-		return -EOPNOTSUPP;
-
 	offset = buf[0];
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_ADDR, offset);
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
@@ -241,9 +238,6 @@ static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len, u8 *buf, u16 addr)
 	unsigned long timeout, stoptime, checktime;
 	int nbytes, timedout;
 
-	if (!len)
-		return -EOPNOTSUPP;
-
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG,
 			XLR_I2C_CFG_NOADDR | priv->cfg->cfg_extra);
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len - 1);
@@ -340,6 +334,10 @@ static const struct i2c_algorithm xlr_i2c_algo = {
 	.functionality	= xlr_func,
 };
 
+static const struct i2c_adapter_quirks xlr_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static const struct xlr_i2c_config xlr_i2c_config_default = {
 	.status_busy	= XLR_I2C_BUS_BUSY,
 	.cfg_extra	= 0,
@@ -427,6 +425,7 @@ static int xlr_i2c_probe(struct platform_device *pdev)
 	priv->adap.owner	= THIS_MODULE;
 	priv->adap.algo_data	= priv;
 	priv->adap.algo		= &xlr_i2c_algo;
+	priv->adap.quirks	= &xlr_i2c_quirks;
 	priv->adap.nr		= pdev->id;
 	priv->adap.class	= I2C_CLASS_HWMON;
 	snprintf(priv->adap.name, sizeof(priv->adap.name), "xlr-i2c");
-- 
2.11.0
