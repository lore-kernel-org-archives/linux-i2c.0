From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c-imx: do not allow interruptions when waiting for I2C to complete
Date: Thu, 27 May 2010 13:36:27 +0200
Message-ID: <1274960188-12601-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sha-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arnaud Patard <apatard-4qZELD6FgxhWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The i2c_imx_trx_complete() function is using
wait_event_interruptible_timeout() to wait for the I2C controller to
signal that it has completed an I2C bus operation. If the process that
causes the I2C operation receives a signal, the wait will be
interrupted, returning an error. It is better to let the I2C operation
finished before handling the signal (i.e. returning into userspace).

It is safe to use wait_event_timeout() instead, because the timeout
will allow the process to exit if the I2C bus hangs. It's also better
to allow the I2C operation to finish, because unacknowledged I2C
operations can cause the I2C bus to hang.

Signed-off-by: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d1ff940..d7051fe 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -161,7 +161,7 @@ static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)
 {
 	int result;
 
-	result = wait_event_interruptible_timeout(i2c_imx->queue,
+	result = wait_event_timeout(i2c_imx->queue,
 		i2c_imx->i2csr & I2SR_IIF, HZ / 10);
 
 	if (unlikely(result < 0)) {
@@ -295,7 +295,7 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
 		i2c_imx->i2csr = temp;
 		temp &= ~I2SR_IIF;
 		writeb(temp, i2c_imx->base + IMX_I2C_I2SR);
-		wake_up_interruptible(&i2c_imx->queue);
+		wake_up(&i2c_imx->queue);
 		return IRQ_HANDLED;
 	}
 
-- 
1.7.1
