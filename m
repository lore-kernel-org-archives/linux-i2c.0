From: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] Fix I2C combined access on Marvell mv64xxxx
Date: Thu, 31 Mar 2011 16:40:07 +0200
Message-ID: <1301582411-2437-1-git-send-email-kostap@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Eliminate erroneus data send in combined access mode when INT
is cleared in i2c controller. Instead disable INT delivery to CPU
and re-enable it on the next START.

Signed-off-by: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index a9941c6..d013e25 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -15,6 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/delay.h>
 #include <linux/mv643xx_i2c.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
@@ -98,6 +99,7 @@ struct mv64xxx_i2c_data {
 	int			rc;
 	u32			freq_m;
 	u32			freq_n;
+	int			irq_disabled;
 	wait_queue_head_t	waitq;
 	spinlock_t		lock;
 	struct i2c_msg		*msg;
@@ -239,10 +241,11 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 {
 	switch(drv_data->action) {
 	case MV64XXX_I2C_ACTION_SEND_RESTART:
-		drv_data->cntl_bits |= MV64XXX_I2C_REG_CONTROL_START;
-		drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_INTEN;
-		writel(drv_data->cntl_bits,
-			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+		/* can't mask interrupts by clearing the INTEN as this
+		 * triggers the controller to send the data.
+		 */
+		drv_data->irq_disabled = 1;
+		disable_irq_nosync(drv_data->irq);
 		drv_data->block = 0;
 		wake_up_interruptible(&drv_data->waitq);
 		break;
@@ -255,6 +258,11 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 	case MV64XXX_I2C_ACTION_SEND_START:
 		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_START,
 			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+		if (drv_data->irq_disabled) {
+			udelay(3);
+			drv_data->irq_disabled = 0;
+			enable_irq(drv_data->irq);
+		}
 		break;
 
 	case MV64XXX_I2C_ACTION_SEND_ADDR_1:
@@ -327,6 +335,8 @@ mv64xxx_i2c_intr(int irq, void *dev_id)
 		mv64xxx_i2c_fsm(drv_data, status);
 		mv64xxx_i2c_do_action(drv_data);
 		rc = IRQ_HANDLED;
+		if (drv_data->state == MV64XXX_I2C_STATE_WAITING_FOR_RESTART)
+			break;
 	}
 	spin_unlock_irqrestore(&drv_data->lock, flags);
 
@@ -553,6 +563,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 		rc = -ENXIO;
 		goto exit_unmap_regs;
 	}
+	drv_data->irq_disabled = 0;
 	drv_data->adapter.dev.parent = &pd->dev;
 	drv_data->adapter.algo = &mv64xxx_i2c_algo;
 	drv_data->adapter.owner = THIS_MODULE;
-- 
1.7.4.1
