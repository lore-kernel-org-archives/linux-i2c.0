From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: i2c-mxs: Check the return value from stmp_reset_block()
Date: Wed, 10 Jul 2013 22:07:23 -0300
Message-ID: <1373504843-15259-1-git-send-email-festevam@gmail.com>
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
 drivers/i2c/busses/i2c-mxs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index df8ff5a..1891ae7 100644
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
@@ -683,7 +687,9 @@ static int mxs_i2c_probe(struct platform_device *pdev)
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
