From: Dmitriy Baranov <dbaranov@dev.rtsoft.ru>
Subject: [PATCH] i2c: imx: add slave support
Date: Mon, 25 Jan 2016 17:53:35 +0300
Message-ID: <1453733615-11429-1-git-send-email-dbaranov@dev.rtsoft.ru>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:59842 "EHLO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757183AbcAYOxu (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 25 Jan 2016 09:53:50 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitriy Baranov <dbaranov@dev.rtsoft.ru>, Maxim Syrchin <syrchin@dev.rtsoft.ru>

Add I2C slave provider using the generic slave interface.
It also supports master transactions when the slave in the idle mode.
Changes work only in PIO mode (when driver doesn`t use DMA)
These changes weren`t tested with DMA is enabled.

Signed-off-by: Dmitriy Baranov <dbaranov@dev.rtsoft.ru>
Signed-off-by: Maxim Syrchin <syrchin@dev.rtsoft.ru>
---
 drivers/i2c/busses/i2c-imx.c | 311 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 290 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a2b132c..3c286f1 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -53,6 +53,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/kthread.h>
 
 /* This will be the driver name the kernel reports */
 #define DRIVER_NAME "imx-i2c"
@@ -171,6 +172,18 @@ enum imx_i2c_type {
 	VF610_I2C,
 };
 
+enum imx_i2c_mode {
+	I2C_IMX_SLAVE,
+	I2C_IMX_MASTER,
+	I2C_IMX_UNDEFINED
+};
+
+enum imx_i2c_slave_state {
+	I2C_IMX_SLAVE_IDLE,
+	I2C_IMX_SLAVE_IRQ,
+	I2C_IMX_SLAVE_POLLING
+};
+
 struct imx_i2c_hwdata {
 	enum imx_i2c_type	devtype;
 	unsigned		regshift;
@@ -193,10 +206,12 @@ struct imx_i2c_dma {
 
 struct imx_i2c_struct {
 	struct i2c_adapter	adapter;
+	struct i2c_client	*slave;
 	struct clk		*clk;
 	void __iomem		*base;
 	wait_queue_head_t	queue;
 	unsigned long		i2csr;
+	unsigned long		i2csr_slave;
 	unsigned int		disable_delay;
 	int			stopped;
 	unsigned int		ifdr; /* IMX_I2C_IFDR */
@@ -210,6 +225,11 @@ struct imx_i2c_struct {
 	struct pinctrl_state *pinctrl_pins_gpio;
 
 	struct imx_i2c_dma	*dma;
+
+	enum imx_i2c_mode	dev_mode;
+	atomic_t		slave_state;
+	struct task_struct	*slave_task;
+	wait_queue_head_t	slave_queue;
 };
 
 static const struct imx_i2c_hwdata imx1_i2c_hwdata  = {
@@ -510,39 +530,97 @@ static void i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx)
 #endif
 }
 
-static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
+static int i2c_imx_configure_clock(struct imx_i2c_struct *i2c_imx)
 {
-	unsigned int temp = 0;
 	int result;
 
-	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
-
 	i2c_imx_set_clk(i2c_imx);
 
-	imx_i2c_write_reg(i2c_imx->ifdr, i2c_imx, IMX_I2C_IFDR);
-	/* Enable I2C controller */
-	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2SR);
-	imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode, i2c_imx, IMX_I2C_I2CR);
+	result = clk_prepare_enable(i2c_imx->clk);
+	if (result == 0)
+		imx_i2c_write_reg(i2c_imx->ifdr, i2c_imx, IMX_I2C_IFDR);
+
+	return result;
+}
+
+static void i2c_imx_enable_i2c_controller(struct imx_i2c_struct *i2c_imx)
+{
+	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx,
+		IMX_I2C_I2SR);
+	imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode, i2c_imx,
+		IMX_I2C_I2CR);
 
 	/* Wait controller to be stable */
 	udelay(50);
+}
+
+static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
+{
+	unsigned int temp = 0;
+	int result;
+
+	i2c_imx->dev_mode = I2C_IMX_UNDEFINED;
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
+
+	result = i2c_imx_configure_clock(i2c_imx);
+	if (result != 0)
+		return result;
+
+	i2c_imx_enable_i2c_controller(i2c_imx);
 
 	/* Start I2C transaction */
 	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 	temp |= I2CR_MSTA;
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+
 	result = i2c_imx_bus_busy(i2c_imx, 1);
 	if (result)
 		return result;
 	i2c_imx->stopped = 0;
 
+	i2c_imx->dev_mode = I2C_IMX_MASTER;
+
 	temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
 	temp &= ~I2CR_DMAEN;
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 	return result;
 }
 
-static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
+static int i2c_imx_start_slave_mode(struct imx_i2c_struct *i2c_imx, bool enable)
+{
+	unsigned int temp;
+	int result;
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
+
+	i2c_imx->dev_mode = I2C_IMX_UNDEFINED;
+
+	if (enable) {
+		result = i2c_imx_configure_clock(i2c_imx);
+		if (result != 0)
+			return result;
+	}
+
+	/* Set the Slave bit */
+	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+	temp &= ~I2CR_MSTA;
+	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+
+	/* Set the Slave address */
+	imx_i2c_write_reg((i2c_imx->slave->addr << 1), i2c_imx, IMX_I2C_IADR);
+
+	i2c_imx->dev_mode = I2C_IMX_SLAVE;
+
+	i2c_imx_enable_i2c_controller(i2c_imx);
+
+	imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode | I2CR_IIEN, i2c_imx,
+		IMX_I2C_I2CR);
+
+	return 0;
+}
+
+static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx, bool disable)
 {
 	unsigned int temp = 0;
 
@@ -568,24 +646,152 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 		i2c_imx->stopped = 1;
 	}
 
-	/* Disable I2C controller */
-	temp = i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
+	temp = i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN;
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+
+	if (disable)
+		clk_disable_unprepare(i2c_imx->clk);
+
+	i2c_imx->dev_mode = I2C_IMX_UNDEFINED;
+}
+
+static void i2c_imx_clear_isr_bit(struct imx_i2c_struct *i2c_imx,
+	unsigned int status)
+{
+	status &= ~I2SR_IIF;
+	status |= (i2c_imx->hwdata->i2sr_clr_opcode & I2SR_IIF);
+	imx_i2c_write_reg(status, i2c_imx, IMX_I2C_I2SR);
+}
+
+static void i2c_imx_master_isr_handler(struct imx_i2c_struct *i2c_imx,
+	unsigned int status)
+{
+	/* save status register */
+	i2c_imx->i2csr = status;
+	wake_up(&i2c_imx->queue);
+}
+
+static int i2c_imx_slave_threadfn(void *pdata)
+{
+	unsigned int ctl, status, timeout = HZ;
+	u8 data;
+	struct imx_i2c_struct *i2c_imx = (struct imx_i2c_struct *) pdata;
+
+	do {
+		wait_event_timeout(i2c_imx->slave_queue,
+			atomic_read(&i2c_imx->slave_state) == I2C_IMX_SLAVE_IRQ,
+			timeout);
+
+		if (atomic_read(&i2c_imx->slave_state) == I2C_IMX_SLAVE_IRQ) {
+			atomic_set(&i2c_imx->slave_state,
+				I2C_IMX_SLAVE_POLLING);
+
+			timeout	= HZ/10;
+			status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
+			ctl = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+
+			if (status & I2SR_IAAS) {
+				if (status & I2SR_SRW) {
+					/* master wants to read from us */
+					i2c_slave_event(i2c_imx->slave,
+						I2C_SLAVE_READ_REQUESTED, &data);
+					ctl |= I2CR_MTX;
+					imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
+
+					/*send data */
+					imx_i2c_write_reg(data, i2c_imx, IMX_I2C_I2DR);
+				} else {
+					dev_dbg(&i2c_imx->adapter.dev, "write requested");
+					i2c_slave_event(i2c_imx->slave,
+						I2C_SLAVE_WRITE_REQUESTED, &data);
+					/*slave receive */
+					ctl &= ~I2CR_MTX;
+					imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
+
+					/*dummy read */
+					data = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
+				}
+			} else {
+				/* slave send */
+				if (ctl & I2CR_MTX) {
+					if (!(status & I2SR_RXAK)) {	/*ACK received */
+						i2c_slave_event(i2c_imx->slave,
+							I2C_SLAVE_READ_PROCESSED, &data);
+						ctl |= I2CR_MTX;
+						imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
+						/*send data */
+						imx_i2c_write_reg(data, i2c_imx, IMX_I2C_I2DR);
+					} else {
+						/*no ACK. */
+						/*dummy read */
+						dev_dbg(&i2c_imx->adapter.dev, "read requested");
+						i2c_slave_event(i2c_imx->slave,
+							I2C_SLAVE_READ_REQUESTED, &data);
+
+						ctl &= ~I2CR_MTX;
+						imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
+						imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
+					}
+				} else {	/*read */
+					ctl &= ~I2CR_MTX;
+					imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
+
+					/*read */
+					data = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
+					dev_dbg(&i2c_imx->adapter.dev, "received %x",
+						(unsigned int) data);
+					i2c_slave_event(i2c_imx->slave,
+						I2C_SLAVE_WRITE_RECEIVED, &data);
+				}
+			}
+		}
+
+		if (atomic_read(&i2c_imx->slave_state) == I2C_IMX_SLAVE_POLLING) {
+			udelay(50);
+			status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
+
+			if ((status & I2SR_IBB) == 0) {
+				pr_debug("end of package");
+				i2c_slave_event(i2c_imx->slave, I2C_SLAVE_STOP, &data);
+				atomic_set(&i2c_imx->slave_state, I2C_IMX_SLAVE_IDLE);
+				timeout	= HZ;
+			}
+		}
+	} while (kthread_should_stop() == 0);
+
+	return 0;
+}
+
+static void i2c_imx_slave_isr_handler(struct imx_i2c_struct *i2c_imx,
+	unsigned int status)
+{
+	atomic_set(&i2c_imx->slave_state, I2C_IMX_SLAVE_IRQ);
+	wake_up(&i2c_imx->slave_queue);
 }
 
 static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
 {
 	struct imx_i2c_struct *i2c_imx = dev_id;
-	unsigned int temp;
+	unsigned int current_status;
+
+	current_status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
+	if (current_status & I2SR_IIF) {
+		i2c_imx_clear_isr_bit(i2c_imx, current_status);
+
+		switch (i2c_imx->dev_mode) {
+		case I2C_IMX_SLAVE:
+			dev_dbg(&i2c_imx->adapter.dev, "slave interrupt");
+			i2c_imx_slave_isr_handler(i2c_imx, current_status);
+			break;
+		case I2C_IMX_MASTER:
+			dev_dbg(&i2c_imx->adapter.dev, "master interrupt");
+			i2c_imx_master_isr_handler(i2c_imx, current_status);
+			break;
+		case I2C_IMX_UNDEFINED:
+			dev_dbg(&i2c_imx->adapter.dev, "undefined interrupt");
+			break;
+		}
 
-	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
-	if (temp & I2SR_IIF) {
-		/* save status register */
-		i2c_imx->i2csr = temp;
-		temp &= ~I2SR_IIF;
-		temp |= (i2c_imx->hwdata->i2sr_clr_opcode & I2SR_IIF);
-		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2SR);
-		wake_up(&i2c_imx->queue);
 		return IRQ_HANDLED;
 	}
 
@@ -889,6 +1095,11 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
+	if (atomic_read(&i2c_imx->slave_state) != I2C_IMX_SLAVE_IDLE) {
+		dev_dbg(&i2c_imx->adapter.dev, "slave is working now\n");
+		return -EBUSY;
+	}
+
 	result = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
 	if (result < 0)
 		goto out;
@@ -954,7 +1165,14 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 
 fail0:
 	/* Stop I2C transfer */
-	i2c_imx_stop(i2c_imx);
+	if (i2c_imx->slave != NULL) {
+		/* Stop I2C transfer */
+		i2c_imx_stop(i2c_imx, false);
+
+		i2c_imx_start_slave_mode(i2c_imx, false);
+	} else {
+		i2c_imx_stop(i2c_imx, true);
+	}
 
 	pm_runtime_mark_last_busy(i2c_imx->adapter.dev.parent);
 	pm_runtime_put_autosuspend(i2c_imx->adapter.dev.parent);
@@ -1013,6 +1231,46 @@ static void i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 	i2c_imx->adapter.bus_recovery_info = rinfo;
 }
 
+static int i2c_imx_reg_slave(struct i2c_client *slave)
+{
+	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(slave->adapter);
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
+
+	if (i2c_imx->slave)
+		return -EBUSY;
+
+	if (slave->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+
+	i2c_imx->slave = slave;
+
+	i2c_imx->slave_task = kthread_run(i2c_imx_slave_threadfn, (void *) i2c_imx, "i2c-slave-%s", i2c_imx->adapter.name);
+
+	return i2c_imx_start_slave_mode(i2c_imx, true);
+}
+
+static int i2c_imx_unreg_slave(struct i2c_client *slave)
+{
+	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(slave->adapter);
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
+
+	if (i2c_imx->slave_task != NULL)
+		kthread_stop(i2c_imx->slave_task);
+	i2c_imx->slave_task = NULL;
+
+	/* slave_state is still tested by xfer() code */
+	atomic_set(&i2c_imx->slave_state, I2C_IMX_SLAVE_IDLE);
+	i2c_imx->dev_mode = I2C_IMX_UNDEFINED;
+
+	i2c_imx->slave = NULL;
+
+	i2c_imx_stop(i2c_imx, true);
+
+	return 0;
+}
+
 static u32 i2c_imx_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
@@ -1022,6 +1280,8 @@ static u32 i2c_imx_func(struct i2c_adapter *adapter)
 static struct i2c_algorithm i2c_imx_algo = {
 	.master_xfer	= i2c_imx_xfer,
 	.functionality	= i2c_imx_func,
+	.reg_slave	= i2c_imx_reg_slave,
+	.unreg_slave	= i2c_imx_unreg_slave,
 };
 
 static int i2c_imx_probe(struct platform_device *pdev)
@@ -1097,6 +1357,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 
 	/* Init queue */
 	init_waitqueue_head(&i2c_imx->queue);
+	init_waitqueue_head(&i2c_imx->slave_queue);
 
 	/* Set up adapter data */
 	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
@@ -1146,6 +1407,11 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	/* Init DMA config if supported */
 	i2c_imx_dma_request(i2c_imx, phy_addr);
 
+	/* init slave_state to IDLE */
+	atomic_set(&i2c_imx->slave_state, I2C_IMX_SLAVE_IDLE);
+
+	i2c_imx->dev_mode = I2C_IMX_UNDEFINED;
+
 	return 0;   /* Return OK */
 
 rpm_disable:
@@ -1172,6 +1438,9 @@ static int i2c_imx_remove(struct platform_device *pdev)
 	dev_dbg(&i2c_imx->adapter.dev, "adapter removed\n");
 	i2c_del_adapter(&i2c_imx->adapter);
 
+	if (i2c_imx->slave_task != NULL)
+		kthread_stop(i2c_imx->slave_task);
+
 	if (i2c_imx->dma)
 		i2c_imx_dma_free(i2c_imx);
 
-- 
2.5.0
