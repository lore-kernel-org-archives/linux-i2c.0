From: Mikael Pettersson <mikpe-1zs4UD6AkMk@public.gmane.org>
Subject: [PATCH 2.6.31-rc9] i2c-mv64xxx.c: correct mv64xxx_i2c_intr() return type
Date: Mon, 7 Sep 2009 12:00:13 +0200 (MEST)
Message-ID: <200909071000.n87A0CBF019863@pilspetsen.it.uu.se>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The mv64xxx_i2c_intr() irq handler in drivers/i2c/busses/i2c-mv64xxx.c
is declared as returning 'int', resulting in this compile-time warning:

drivers/i2c/busses/i2c-mv64xxx.c: In function 'mv64xxx_i2c_probe':
drivers/i2c/busses/i2c-mv64xxx.c:540: warning: passing argument 2 of 'request_irq' from incompatible pointer type

Fix: correct the return type to 'irqreturn_t'.

Signed-off-by: Mikael Pettersson <mikpe-1zs4UD6AkMk@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.31-rc9/drivers/i2c/busses/i2c-mv64xxx.c.~1~	2009-09-06 12:20:56.000000000 +0200
+++ linux-2.6.31-rc9/drivers/i2c/busses/i2c-mv64xxx.c	2009-09-07 11:31:43.000000000 +0200
@@ -293,13 +293,13 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c
 	}
 }
 
-static int
+static irqreturn_t
 mv64xxx_i2c_intr(int irq, void *dev_id)
 {
 	struct mv64xxx_i2c_data	*drv_data = dev_id;
 	unsigned long	flags;
 	u32		status;
-	int		rc = IRQ_NONE;
+	irqreturn_t	rc = IRQ_NONE;
 
 	spin_lock_irqsave(&drv_data->lock, flags);
 	while (readl(drv_data->reg_base + MV64XXX_I2C_REG_CONTROL) &
