From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] i2c: mxs: Better error handling
Date: Wed,  3 Jul 2013 10:59:22 +0200
Message-ID: <1372841962-26310-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch fixes two error handling cases in mxs_i2c_xfer_msg():

 - in PIO mode, mxs_i2c_pio_setup_xfer() may return an error but i2c->cmd_err
 will not be set so mxs_i2c_xfer_msg() fails silently.

 - in DMA mode, mxs_i2c_dma_setup_xfer() may return an error and have
 i2c->cmd_err set to -ENXIO. In that case, we want to go through the
 MXS_I2C_CTRL1_CLR_GOT_A_NAK before returning.

Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 2039f23..92f22b0 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -502,7 +502,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 		INIT_COMPLETION(i2c->cmd_complete);
 		ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
 		if (ret)
-			return ret;
+			goto exit;
 
 		ret = wait_for_completion_timeout(&i2c->cmd_complete,
 						msecs_to_jiffies(1000));
@@ -510,6 +510,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 			goto timeout;
 	}
 
+exit:
 	if (i2c->cmd_err == -ENXIO) {
 		/*
 		 * If the transfer fails with a NAK from the slave the
@@ -519,7 +520,8 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 		       i2c->regs + MXS_I2C_CTRL1_SET);
 	}
 
-	ret = i2c->cmd_err;
+	if (i2c->cmd_err)
+		ret = i2c->cmd_err;
 
 	dev_dbg(i2c->dev, "Done with err=%d\n", ret);
 
-- 
1.8.1.2
