From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH] I2C-mv64xxx.c: work around signals causing I2C transactions
 to be aborted
Date: Wed, 15 May 2013 15:33:10 +0100
Message-ID: <E1UcclS-0001z3-PT@rmk-PC.arm.linux.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Do not use interruptible waits in an I2C driver; if a process uses
signals (eg, Xorg uses SIGALRM and SIGPIPE) then these signals can
cause the I2C driver to abort a transaction in progress by another
driver, which can cause that driver to fail.  I2C drivers are not
expected to abort transactions on signals.

Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Tested-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
Mark Greer seems to be unreachable now; the address in this driver no
longer works, and there is no maintainer entry.  This patch has been
run on my Cubox (Marvell Dove) for quite a number of months without
ill effect.

 drivers/i2c/busses/i2c-mv64xxx.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 2e9d567..44d8045 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -252,7 +252,7 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		writel(drv_data->cntl_bits,
 			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
 		drv_data->block = 0;
-		wake_up_interruptible(&drv_data->waitq);
+		wake_up(&drv_data->waitq);
 		break;
 
 	case MV64XXX_I2C_ACTION_CONTINUE:
@@ -300,7 +300,7 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
 			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
 		drv_data->block = 0;
-		wake_up_interruptible(&drv_data->waitq);
+		wake_up(&drv_data->waitq);
 		break;
 
 	case MV64XXX_I2C_ACTION_INVALID:
@@ -315,7 +315,7 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
 			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
 		drv_data->block = 0;
-		wake_up_interruptible(&drv_data->waitq);
+		wake_up(&drv_data->waitq);
 		break;
 	}
 }
@@ -381,7 +381,7 @@ mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_data *drv_data)
 	unsigned long	flags;
 	char		abort = 0;
 
-	time_left = wait_event_interruptible_timeout(drv_data->waitq,
+	time_left = wait_event_timeout(drv_data->waitq,
 		!drv_data->block, drv_data->adapter.timeout);
 
 	spin_lock_irqsave(&drv_data->lock, flags);
-- 
1.7.4.4
