From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] i2c: i2c-mxs: Check the return value from stmp_reset_block()
Date: Wed, 10 Jul 2013 22:19:28 -0300
Message-ID: <1373505568-21477-1-git-send-email-festevam@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: marex-ynQEQJNshbs@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

stmp_reset_block() may fail, so let's check its return value and propagate it in
the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
Changes since v1:
- Check the return value of all occurences of mxs_i2c_reset()

 drivers/i2c/busses/i2c-mxs.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index df8ff5a..90c052e 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -123,9 +123,11 @@ struct mxs_i2c_dev {
 	bool				dma_read;
 };
 
-static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
+static int mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 {
-	stmp_reset_block(i2c->regs);
+	int ret = stmp_reset_block(i2c->regs);
+	if (ret)
+		return ret;
 
 	/*
 	 * Configure timing for the I2C block. The I2C TIMING2 register has to
@@ -139,6 +141,8 @@ static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 	writel(0x00300030, i2c->regs + MXS_I2C_TIMING2);
 
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
+
+	return 0;
 }
 
 static void mxs_i2c_dma_finish(struct mxs_i2c_dev *i2c)
@@ -475,7 +479,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 				int stop)
 {
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
-	int ret;
+	int ret, err;
 	int flags;
 
 	flags = stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
@@ -495,8 +499,11 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	i2c->cmd_err = 0;
 	if (msg->len < 8) {
 		ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
-		if (ret)
-			mxs_i2c_reset(i2c);
+		if (ret) {
+			err = mxs_i2c_reset(i2c);
+			if (err)
+				return err;
+		}
 	} else {
 		INIT_COMPLETION(i2c->cmd_complete);
 		ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
@@ -527,7 +534,10 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 timeout:
 	dev_dbg(i2c->dev, "Timeout!\n");
 	mxs_i2c_dma_finish(i2c);
-	mxs_i2c_reset(i2c);
+	ret = mxs_i2c_reset(i2c);
+	if (ret)
+		return ret;
+
 	return -ETIMEDOUT;
 }
 
@@ -683,7 +693,9 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, i2c);
 
 	/* Do reset to enforce correct startup after pinmuxing */
-	mxs_i2c_reset(i2c);
+	err = mxs_i2c_reset(i2c);
+	if (err)
+		return err;
 
 	adap = &i2c->adapter;
 	strlcpy(adap->name, "MXS I2C adapter", sizeof(adap->name));
-- 
1.8.1.2
