From: Amit Singh Tomar <amit.tomar-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 1/1] i2c/mpc: Fix ISR return value
Date: Fri, 27 Mar 2015 18:19:00 +0530
Message-ID: <1427460540-7754-1-git-send-email-amit.tomar@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Amit Singh Tomar <amit.tomar-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ISR should not return IRQ_HANDLED for not handling anything.
This patch fixes the return value of ISR for the same case.

Signed-off-by: Amit Singh Tomar <amit.tomar-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-mpc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index c74cc2b..2f20db1 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -95,8 +95,9 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
 		i2c->interrupt = readb(i2c->base + MPC_I2C_SR);
 		writeb(0, i2c->base + MPC_I2C_SR);
 		wake_up(&i2c->queue);
+		return IRQ_HANDLED;
 	}
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 /* Sometimes 9th clock pulse isn't generated, and slave doesn't release
-- 
1.7.9.5
