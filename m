From: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] Support i2c expander on mv64xxx adapter
Date: Thu, 31 Mar 2011 16:40:11 +0200
Message-ID: <1301582411-2437-5-git-send-email-kostap@marvell.com>
References: <1301582411-2437-1-git-send-email-kostap@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301582411-2437-1-git-send-email-kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Support i2c bus expander on Marvell mv64xxx platforms

Signed-off-by: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/Kconfig       |    7 ++
 drivers/i2c/busses/i2c-mv64xxx.c |  185 ++++++++++++++++++++++++++++++++------
 include/linux/mv643xx_i2c.h      |    8 ++
 3 files changed, 174 insertions(+), 26 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 326652f..d125142 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -453,6 +453,13 @@ config I2C_MV64XXX
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mv64xxx.
 
+config I2C_MV64XXX_PORT_EXPANDER
+	bool "Marvell mv64xxx I2C Port Expander"
+	depends on I2C_MV64XXX
+	help
+	  If you say yes to this option, support will be included for the
+	  I2C port expander on some of Marvell SoC's.
+
 config I2C_MXS
 	tristate "Freescale i.MX28 I2C interface"
 	depends on SOC_IMX28
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index b246dab..bc69506 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -19,6 +19,7 @@
 #include <linux/mv643xx_i2c.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/semaphore.h>
 
 /* Register defines */
 #define	MV64XXX_I2C_REG_SLAVE_ADDR			0x00
@@ -104,6 +105,15 @@ struct mv64xxx_i2c_data {
 	wait_queue_head_t	waitq;
 	spinlock_t		lock;
 	struct i2c_msg		*msg;
+	struct i2c_adapter	*adapter;
+#ifdef CONFIG_I2C_MV64XXX_PORT_EXPANDER
+	struct semaphore	exp_sem;
+	int	(*select_exp_port)(unsigned int port_id);
+#endif
+};
+
+struct mv64xxx_i2c_exp_data {
+	struct mv64xxx_i2c_data	*hw_adapter;
 	struct i2c_adapter	adapter;
 };
 
@@ -127,7 +137,7 @@ mv64xxx_i2c_wait_after_stop(struct mv64xxx_i2c_data *drv_data)
 	       MV64XXX_I2C_REG_CONTROL_STOP){
 		udelay(1);
 		if (i++ > 100) {
-			dev_err(&drv_data->adapter.dev,
+			dev_err(&drv_data->adapter->dev,
 				" I2C bus locked, stop bit not cleared\n");
 			break;
 		}
@@ -246,7 +256,7 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
 		break;
 
 	default:
-		dev_err(&drv_data->adapter.dev,
+		dev_err(&drv_data->adapter->dev,
 			"mv64xxx_i2c_fsm: Ctlr Error -- state: 0x%x, "
 			"status: 0x%x, addr: 0x%x, flags: 0x%x\n",
 			 drv_data->state, status, drv_data->msg->addr,
@@ -327,7 +337,7 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 
 	case MV64XXX_I2C_ACTION_INVALID:
 	default:
-		dev_err(&drv_data->adapter.dev,
+		dev_err(&drv_data->adapter->dev,
 			"mv64xxx_i2c_do_action: Invalid action: %d\n",
 			drv_data->action);
 		drv_data->rc = -EIO;
@@ -407,7 +417,7 @@ mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_data *drv_data)
 	char		abort = 0;
 
 	time_left = wait_event_interruptible_timeout(drv_data->waitq,
-		!drv_data->block, drv_data->adapter.timeout);
+		!drv_data->block, drv_data->adapter->timeout);
 
 	spin_lock_irqsave(&drv_data->lock, flags);
 	if (!time_left) { /* Timed out */
@@ -423,11 +433,11 @@ mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_data *drv_data)
 		spin_unlock_irqrestore(&drv_data->lock, flags);
 
 		time_left = wait_event_timeout(drv_data->waitq,
-			!drv_data->block, drv_data->adapter.timeout);
+			!drv_data->block, drv_data->adapter->timeout);
 
 		if ((time_left <= 0) && drv_data->block) {
 			drv_data->state = MV64XXX_I2C_STATE_IDLE;
-			dev_err(&drv_data->adapter.dev,
+			dev_err(&drv_data->adapter->dev,
 				"mv64xxx: I2C bus locked, block: %d, "
 				"time_left: %d\n", drv_data->block,
 				(int)time_left);
@@ -491,7 +501,7 @@ mv64xxx_i2c_functionality(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SMBUS_EMUL;
 }
-
+#ifndef CONFIG_I2C_MV64XXX_PORT_EXPANDER
 static int
 mv64xxx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 {
@@ -512,7 +522,7 @@ static const struct i2c_algorithm mv64xxx_i2c_algo = {
 	.master_xfer = mv64xxx_i2c_xfer,
 	.functionality = mv64xxx_i2c_functionality,
 };
-
+#endif
 /*
  *****************************************************************************
  *
@@ -532,7 +542,7 @@ mv64xxx_i2c_map_regs(struct platform_device *pd,
 
 	size = resource_size(r);
 
-	if (!request_mem_region(r->start, size, drv_data->adapter.name))
+	if (!request_mem_region(r->start, size, drv_data->adapter->name))
 		return -EBUSY;
 
 	drv_data->reg_base = ioremap(r->start, size);
@@ -559,6 +569,9 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 {
 	struct mv64xxx_i2c_data		*drv_data;
 	struct mv64xxx_i2c_pdata	*pdata = pd->dev.platform_data;
+#ifndef CONFIG_I2C_MV64XXX_PORT_EXPANDER
+	struct i2c_adapter	*adapter;
+#endif
 	int	rc;
 
 	if ((pd->id != 0) || !pdata)
@@ -567,18 +580,30 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	drv_data = kzalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
 	if (!drv_data)
 		return -ENOMEM;
+#ifndef CONFIG_I2C_MV64XXX_PORT_EXPANDER
+	adapter = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
+	if (!adapter)
+		return -ENOMEM;
 
+	drv_data->adapter = adapter;
+#endif
 	if (mv64xxx_i2c_map_regs(pd, drv_data)) {
 		rc = -ENODEV;
 		goto exit_kfree;
 	}
 
-	strlcpy(drv_data->adapter.name, MV64XXX_I2C_CTLR_NAME " adapter",
-		sizeof(drv_data->adapter.name));
-
 	init_waitqueue_head(&drv_data->waitq);
 	spin_lock_init(&drv_data->lock);
-
+#ifdef CONFIG_I2C_MV64XXX_PORT_EXPANDER
+	sema_init(&drv_data->exp_sem, 1);
+	drv_data->select_exp_port = pdata->select_exp_port;
+	if (drv_data->select_exp_port == 0) {
+		dev_err(&drv_data->adapter->dev,
+			"mv64xxx expander: Invalid i2c port selector\n");
+		rc = -EINVAL;
+		goto exit_unmap_regs;
+	}
+#endif
 	drv_data->freq_m = pdata->freq_m;
 	drv_data->freq_n = pdata->freq_n;
 	drv_data->delay_after_stop = pdata->delay_after_stop ?
@@ -589,34 +614,45 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 		goto exit_unmap_regs;
 	}
 	drv_data->irq_disabled = 0;
-	drv_data->adapter.dev.parent = &pd->dev;
-	drv_data->adapter.algo = &mv64xxx_i2c_algo;
-	drv_data->adapter.owner = THIS_MODULE;
-	drv_data->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
-	drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
-	drv_data->adapter.nr = pd->id;
+#ifndef CONFIG_I2C_MV64XXX_PORT_EXPANDER
+	strlcpy(drv_data->adapter->name, MV64XXX_I2C_CTLR_NAME " adapter",
+		sizeof(drv_data->adapter->name));
+
+	drv_data->adapter->dev.parent = &pd->dev;
+	drv_data->adapter->algo = &mv64xxx_i2c_algo;
+	drv_data->adapter->owner = THIS_MODULE;
+	drv_data->adapter->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	drv_data->adapter->timeout = msecs_to_jiffies(pdata->timeout);
+	drv_data->adapter->nr = pd->id;
+	i2c_set_adapdata(drv_data->adapter, drv_data);
+#endif
 	platform_set_drvdata(pd, drv_data);
-	i2c_set_adapdata(&drv_data->adapter, drv_data);
 
 	mv64xxx_i2c_hw_init(drv_data);
 
 	if (request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
 			MV64XXX_I2C_CTLR_NAME, drv_data)) {
-		dev_err(&drv_data->adapter.dev,
+		dev_err(&drv_data->adapter->dev,
 			"mv64xxx: Can't register intr handler irq: %d\n",
 			drv_data->irq);
 		rc = -EINVAL;
 		goto exit_unmap_regs;
-	} else if ((rc = i2c_add_numbered_adapter(&drv_data->adapter)) != 0) {
-		dev_err(&drv_data->adapter.dev,
+#ifndef CONFIG_I2C_MV64XXX_PORT_EXPANDER
+	}
+	rc = i2c_add_numbered_adapter(drv_data->adapter);
+	if (rc != 0) {
+		dev_err(&drv_data->adapter->dev,
 			"mv64xxx: Can't add i2c adapter, rc: %d\n", -rc);
 		goto exit_free_irq;
+#endif
 	}
 
 	return 0;
 
+#ifndef CONFIG_I2C_MV64XXX_PORT_EXPANDER
 	exit_free_irq:
 		free_irq(drv_data->irq, drv_data);
+#endif
 	exit_unmap_regs:
 		mv64xxx_i2c_unmap_regs(drv_data);
 	exit_kfree:
@@ -628,9 +664,11 @@ static int __devexit
 mv64xxx_i2c_remove(struct platform_device *dev)
 {
 	struct mv64xxx_i2c_data		*drv_data = platform_get_drvdata(dev);
-	int	rc;
+	int	rc = 0;
 
-	rc = i2c_del_adapter(&drv_data->adapter);
+#ifndef CONFIG_I2C_MV64XXX_PORT_EXPANDER
+	rc = i2c_del_adapter(drv_data->adapter);
+#endif
 	free_irq(drv_data->irq, drv_data);
 	mv64xxx_i2c_unmap_regs(drv_data);
 	kfree(drv_data);
@@ -661,15 +699,110 @@ static struct platform_driver mv64xxx_i2c_driver = {
 	},
 };
 
+#ifdef CONFIG_I2C_MV64XXX_PORT_EXPANDER
+static int
+mv64xxx_i2c_exp_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+	struct mv64xxx_i2c_exp_data *exp_drv_data = i2c_get_adapdata(adap);
+	struct mv64xxx_i2c_data *drv_data = exp_drv_data->hw_adapter;
+	int	i, rc;
+
+	down(&drv_data->exp_sem);
+	drv_data->adapter = adap;
+	drv_data->select_exp_port(adap->nr);
+	for (i = 0; i < num; i++) {
+		rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i],
+						i == 0, i + 1 == num);
+		if (rc < 0) {
+			up(&drv_data->exp_sem);
+			return rc;
+		}
+	}
+	up(&drv_data->exp_sem);
+	return num;
+}
+
+static const struct i2c_algorithm mv64xxx_i2c_exp_algo = {
+	.master_xfer = mv64xxx_i2c_exp_xfer,
+	.functionality = mv64xxx_i2c_functionality,
+};
+
+static int __devinit
+mv64xxx_i2c_exp_probe(struct platform_device *pd)
+{
+	struct mv64xxx_i2c_exp_data	*exp_drv_data;
+	struct mv64xxx_i2c_exp_pdata	*pdata = pd->dev.platform_data;
+	int	rc = 0;
+
+	if (!pdata)
+		return -ENODEV;
+
+	exp_drv_data = devm_kzalloc(&pd->dev,
+				sizeof(struct mv64xxx_i2c_exp_data),
+				GFP_KERNEL);
+	if (!exp_drv_data)
+		return -ENOMEM;
+
+	strlcpy(exp_drv_data->adapter.name,
+		MV64XXX_I2C_EXPANDER_NAME " adapter",
+		sizeof(exp_drv_data->adapter.name));
+	exp_drv_data->adapter.dev.parent = &pd->dev;
+	exp_drv_data->adapter.algo = &mv64xxx_i2c_exp_algo;
+	exp_drv_data->adapter.owner = THIS_MODULE;
+	exp_drv_data->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	exp_drv_data->adapter.timeout = pdata->timeout;
+	exp_drv_data->adapter.nr = pd->id;
+	exp_drv_data->hw_adapter = platform_get_drvdata(pdata->hw_adapter);
+	platform_set_drvdata(pd, exp_drv_data);
+	i2c_set_adapdata(&exp_drv_data->adapter, exp_drv_data);
+
+	rc = i2c_add_numbered_adapter(&exp_drv_data->adapter);
+	if (rc != 0) {
+		dev_err(&pd->dev,
+			"mv64xxx expander: Can't add i2c adapter, rc: %d\n",
+			-rc);
+	}
+	return rc;
+}
+
+static int __devexit
+mv64xxx_i2c_exp_remove(struct platform_device *dev)
+{
+	struct mv64xxx_i2c_exp_data	*exp_drv_data =
+						platform_get_drvdata(dev);
+
+	return i2c_del_adapter(&exp_drv_data->adapter);
+}
+
+static struct platform_driver mv64xxx_i2c_exp_driver = {
+	.probe	= mv64xxx_i2c_exp_probe,
+	.remove	= __devexit_p(mv64xxx_i2c_exp_remove),
+	.driver	= {
+		.owner	= THIS_MODULE,
+		.name	= MV64XXX_I2C_EXPANDER_NAME,
+	},
+};
+#endif
+
 static int __init
 mv64xxx_i2c_init(void)
 {
-	return platform_driver_register(&mv64xxx_i2c_driver);
+	int rc = platform_driver_register(&mv64xxx_i2c_driver);
+	if (rc < 0)
+		return rc;
+
+#ifdef CONFIG_I2C_MV64XXX_PORT_EXPANDER
+	rc = platform_driver_register(&mv64xxx_i2c_exp_driver);
+#endif
+	return rc;
 }
 
 static void __exit
 mv64xxx_i2c_exit(void)
 {
+#ifdef CONFIG_I2C_MV64XXX_PORT_EXPANDER
+	platform_driver_unregister(&mv64xxx_i2c_exp_driver);
+#endif
 	platform_driver_unregister(&mv64xxx_i2c_driver);
 }
 
diff --git a/include/linux/mv643xx_i2c.h b/include/linux/mv643xx_i2c.h
index 6d151c4..559c839 100644
--- a/include/linux/mv643xx_i2c.h
+++ b/include/linux/mv643xx_i2c.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 
 #define MV64XXX_I2C_CTLR_NAME	"mv64xxx_i2c"
+#define MV64XXX_I2C_EXPANDER_NAME	"mv64xxx_i2c_exp"
 
 /* i2c Platform Device, Driver Data */
 struct mv64xxx_i2c_pdata {
@@ -18,6 +19,13 @@ struct mv64xxx_i2c_pdata {
 	u32	freq_n;
 	u32	delay_after_stop;
 	u32	timeout;	/* In milliseconds */
+	int     (*select_exp_port)	(unsigned int port_id);
+};
+
+/* i2c expander driver data */
+struct mv64xxx_i2c_exp_pdata {
+	struct platform_device  *hw_adapter;
+	u32	timeout;	/* In milliseconds */
 };
 
 #endif /*_MV64XXX_I2C_H_*/
-- 
1.7.4.1
