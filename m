From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: mxs: set controller to pio queue mode after reset
Date: Fri, 25 Feb 2011 18:54:51 +0100
Message-ID: <1298656491-30686-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

mxs_reset_block() clears the PIO_QUEUE_MODE bit. So we have
to set it again after a controller reset.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 8022e23..caf96dc 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -118,6 +118,8 @@ static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 {
 	mxs_reset_block(i2c->regs);
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
+	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
+			i2c->regs + MXS_I2C_QUEUECTRL_SET);
 }
 
 static void mxs_i2c_pioq_setup_read(struct mxs_i2c_dev *i2c, u8 addr, int len,
@@ -347,8 +349,6 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 
 	/* Do reset to enforce correct startup after pinmuxing */
 	mxs_i2c_reset(i2c);
-	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
-			i2c->regs + MXS_I2C_QUEUECTRL_SET);
 
 	adap = &i2c->adapter;
 	strlcpy(adap->name, "MXS I2C adapter", sizeof(adap->name));
-- 
1.7.2.3
