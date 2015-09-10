From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 6/7] i2c: img-scb: Clear line and interrupt status before starting a transfer
Date: Thu, 10 Sep 2015 15:50:06 +0100
Message-ID: <1441896607-16310-7-git-send-email-sifan.naeem@imgtec.com>
References: <1441896607-16310-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441896607-16310-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Clear line status and all generated interrupts from the interrupt
status register before starting a transfer, as we may have
unserviced interrupts from previous transfers that might be
handled in the context of the new transfer.

Fixes: commit 27bce457d588 ("i2c: img-scb: Add Imagination Technologies I2C SCB driver")
Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Reviewed-by: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 049d193d01ac..0fa47158dbe4 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1060,6 +1060,15 @@ static int img_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		i2c->last_msg = (i == num - 1);
 		reinit_completion(&i2c->msg_complete);
 
+		/*
+		 * Clear line status and all interrupts before starting a
+		 * transfer, as we may have unserviced interrupts from
+		 * previous transfers that might be handled in the context
+		 * of the new transfer.
+		 */
+		img_i2c_writel(i2c, SCB_INT_CLEAR_REG, ~0);
+		img_i2c_writel(i2c, SCB_CLEAR_REG, ~0);
+
 		if (atomic)
 			img_i2c_atomic_start(i2c);
 		else if (msg->flags & I2C_M_RD)
-- 
1.7.9.5
