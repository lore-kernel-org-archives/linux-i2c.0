From: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] Add-delay-after-setting-the-STOP-bit-i2c-mv64xxx
Date: Thu, 31 Mar 2011 16:40:08 +0200
Message-ID: <1301582411-2437-2-git-send-email-kostap@marvell.com>
References: <1301582411-2437-1-git-send-email-kostap@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301582411-2437-1-git-send-email-kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add delay after setting the STOP bit in i2c control register

Signed-off-by: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c |   25 +++++++++++++++++++++++++
 include/linux/mv643xx_i2c.h      |    1 +
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index d013e25..a6e9a3f 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -99,6 +99,7 @@ struct mv64xxx_i2c_data {
 	int			rc;
 	u32			freq_m;
 	u32			freq_n;
+	u32			delay_after_stop;
 	int			irq_disabled;
 	wait_queue_head_t	waitq;
 	spinlock_t		lock;
@@ -114,6 +115,25 @@ struct mv64xxx_i2c_data {
  *****************************************************************************
  */
 
+static void
+mv64xxx_i2c_wait_after_stop(struct mv64xxx_i2c_data *drv_data)
+{
+	int i = 0;
+
+	udelay(drv_data->delay_after_stop);
+
+	/* wait for the stop bit up to 100 usec more */
+	while (readl(drv_data->reg_base + MV64XXX_I2C_REG_CONTROL) &
+	       MV64XXX_I2C_REG_CONTROL_STOP){
+		udelay(1);
+		if (i++ > 100) {
+			dev_err(&drv_data->adapter.dev,
+				" I2C bus locked, stop bit not cleared\n");
+			break;
+		}
+	}
+
+}
 /* Reset hardware and initialize FSM */
 static void
 mv64xxx_i2c_hw_init(struct mv64xxx_i2c_data *drv_data)
@@ -125,6 +145,7 @@ mv64xxx_i2c_hw_init(struct mv64xxx_i2c_data *drv_data)
 	writel(0, drv_data->reg_base + MV64XXX_I2C_REG_EXT_SLAVE_ADDR);
 	writel(MV64XXX_I2C_REG_CONTROL_TWSIEN | MV64XXX_I2C_REG_CONTROL_STOP,
 		drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+	mv64xxx_i2c_wait_after_stop(drv_data);
 	drv_data->state = MV64XXX_I2C_STATE_IDLE;
 }
 
@@ -299,6 +320,7 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_INTEN;
 		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
 			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+		mv64xxx_i2c_wait_after_stop(drv_data);
 		drv_data->block = 0;
 		wake_up_interruptible(&drv_data->waitq);
 		break;
@@ -314,6 +336,7 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_INTEN;
 		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
 			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+		mv64xxx_i2c_wait_after_stop(drv_data);
 		drv_data->block = 0;
 		wake_up_interruptible(&drv_data->waitq);
 		break;
@@ -558,6 +581,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 
 	drv_data->freq_m = pdata->freq_m;
 	drv_data->freq_n = pdata->freq_n;
+	drv_data->delay_after_stop = pdata->delay_after_stop ?
+		pdata->delay_after_stop : 10;
 	drv_data->irq = platform_get_irq(pd, 0);
 	if (drv_data->irq < 0) {
 		rc = -ENXIO;
diff --git a/include/linux/mv643xx_i2c.h b/include/linux/mv643xx_i2c.h
index 5db5152..6d151c4 100644
--- a/include/linux/mv643xx_i2c.h
+++ b/include/linux/mv643xx_i2c.h
@@ -16,6 +16,7 @@
 struct mv64xxx_i2c_pdata {
 	u32	freq_m;
 	u32	freq_n;
+	u32	delay_after_stop;
 	u32	timeout;	/* In milliseconds */
 };
 
-- 
1.7.4.1
