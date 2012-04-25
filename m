From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: mxs: handle spurious interrupt
Date: Wed, 25 Apr 2012 22:57:30 +0200
Message-ID: <1335387450-26406-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

After an error interrupt setting cmd->err, I see another interrupt that
the data engine is empty which clears cmd->err before being processed.
So, clear cmd->err at the beginning of a transfer only to handle these
consecutive interrupts.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 3d471d5..4c37347 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -227,6 +227,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 		return -EINVAL;
 
 	init_completion(&i2c->cmd_complete);
+	i2c->cmd_err = 0;
 
 	flags = stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
 
@@ -299,8 +300,6 @@ static irqreturn_t mxs_i2c_isr(int this_irq, void *dev_id)
 		    MXS_I2C_CTRL1_SLAVE_STOP_IRQ | MXS_I2C_CTRL1_SLAVE_IRQ))
 		/* MXS_I2C_CTRL1_OVERSIZE_XFER_TERM_IRQ is only for slaves */
 		i2c->cmd_err = -EIO;
-	else
-		i2c->cmd_err = 0;
 
 	is_last_cmd = (readl(i2c->regs + MXS_I2C_QUEUESTAT) &
 		MXS_I2C_QUEUESTAT_WRITE_QUEUE_CNT_MASK) == 0;
-- 
1.7.10
