From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [v6] i2c: imx: support slave mode for imx I2C driver
Date: Wed, 4 Dec 2019 11:00:05 +0100
Message-ID: <20191204100005.r56huywxa7h3c6zr@pengutronix.de>
References: <20191203114809.21226-1-biwen.li@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191203114809.21226-1-biwen.li@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Biwen Li <biwen.li@nxp.com>
Cc: shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, wsa@the-dreams.de, leoyang.li@nxp.com, aisheng.dong@nxp.com, xiaoning.wang@nxp.com, o.rempel@pengutronix.de, xiaobo.xie@nxp.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, jiafei.pan@nxp.com, linux-arm-kernel@lists.infradead.org, laurentiu.tudor@nxp.com
List-Id: linux-i2c@vger.kernel.org

Hi,

The patch looks ok to me now, but I still do not like the #ifdeffery
around CONFIG_I2C_SLAVE. With the patch I just sent (You are on Cc:)
we could apply the following on your patch which makes it more readable
and increases compile coverage.

Wolfram, Biwen, what do you think?

Sascha

---------------------------8<------------------------------

>From 52f7c2bf59db61d4b27b59ca6404136e3ed77310 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 4 Dec 2019 10:56:34 +0100
Subject: [PATCH] fixup! i2c: imx: support slave mode for imx I2C driver

---
 drivers/i2c/busses/i2c-imx.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 40ccfca600bf..c5d9ae8226cd 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -203,9 +203,7 @@ struct imx_i2c_struct {
 	struct pinctrl_state *pinctrl_pins_gpio;
 
 	struct imx_i2c_dma	*dma;
-#if IS_ENABLED(CONFIG_I2C_SLAVE)
 	struct i2c_client	*slave;
-#endif
 };
 
 static const struct imx_i2c_hwdata imx1_i2c_hwdata = {
@@ -913,12 +911,10 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
-#if IS_ENABLED(CONFIG_I2C_SLAVE)
 	if (i2c_imx->slave) {
 		dev_err(&i2c_imx->adapter.dev, "Please not do operations of master mode in slave mode");
 		return -EBUSY;
 	}
-#endif
 
 	result = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
 	if (result < 0)
@@ -1068,7 +1064,6 @@ static u32 i2c_imx_func(struct i2c_adapter *adapter)
 		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
 }
 
-#if IS_ENABLED(CONFIG_I2C_SLAVE)
 static int i2c_imx_slave_init(struct imx_i2c_struct *i2c_imx)
 {
 	int temp;
@@ -1159,6 +1154,10 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
 {
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(client->adapter);
 	int ret;
+
+	if (!IS_ENABLED(CONFIG_I2C_SLAVE))
+		return -EINVAL;
+
 	if (i2c_imx->slave)
 		return -EBUSY;
 
@@ -1173,6 +1172,9 @@ static int i2c_imx_unreg_slave(struct i2c_client *client)
 {
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(client->adapter);
 
+	if (!IS_ENABLED(CONFIG_I2C_SLAVE))
+		return -EINVAL;
+
 	if (!i2c_imx->slave)
 		return -EINVAL;
 
@@ -1188,15 +1190,12 @@ static int i2c_imx_unreg_slave(struct i2c_client *client)
 
 	return 0;
 }
-#endif
 
 static const struct i2c_algorithm i2c_imx_algo = {
 	.master_xfer	= i2c_imx_xfer,
 	.functionality	= i2c_imx_func,
-#if IS_ENABLED(CONFIG_I2C_SLAVE)
 	.reg_slave	= i2c_imx_reg_slave,
 	.unreg_slave	= i2c_imx_unreg_slave,
-#endif
 };
 
 static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
@@ -1208,10 +1207,10 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
 
 	if (status & I2SR_IIF) {
 		i2c_imx_clr_if_bit(status, i2c_imx);
-#if IS_ENABLED(CONFIG_I2C_SLAVE)
-		if (i2c_imx->slave)
+
+		if (IS_ENABLED(CONFIG_I2C_SLAVE) && i2c_imx->slave)
 			return i2c_imx_slave_isr(i2c_imx);
-#endif
+
 		i2c_imx->i2csr = status;
 		return i2c_imx_master_isr(i2c_imx);
 	}
-- 
2.24.0


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
