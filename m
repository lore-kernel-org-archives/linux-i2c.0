From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] i2c: i2c-adi: replace blackfin string with adi in ADI TWI driver
Date: Sun, 26 Jan 2014 15:06:59 +0800
Message-ID: <1390720020-315-3-git-send-email-sonic.adi@gmail.com>
References: <1390720020-315-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390720020-315-1-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

remove unnecessary SSYNC from the driver
move necessary SSYNC into MMR access functions.
rename i2c-bfin-twi to i2c-adi-twi in file MAINTAINERS

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 MAINTAINERS                      |   2 +-
 arch/blackfin/include/asm/twi.h  |  23 ++++++-
 drivers/i2c/busses/i2c-adi-twi.c | 128 +++++++++++++++++----------------------
 3 files changed, 78 insertions(+), 75 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1912139..0d01172 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1786,7 +1786,7 @@ M:	Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
 L:	uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
 W:	http://blackfin.uclinux.org/
 S:	Supported
-F:	drivers/i2c/busses/i2c-bfin-twi.c
+F:	drivers/i2c/busses/i2c-adi-twi.c
 
 BLACKFIN MEDIA DRIVER
 M:	Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
diff --git a/arch/blackfin/include/asm/twi.h b/arch/blackfin/include/asm/twi.h
index 6f057ee..2cd47e9 100644
--- a/arch/blackfin/include/asm/twi.h
+++ b/arch/blackfin/include/asm/twi.h
@@ -19,7 +19,6 @@ static inline void write_##reg_name(struct adi_twi_iface *iface, u16 v) \
 	{ bfin_write16(&iface->regs_base->reg, v); }
 
 DEFINE_TWI_REG(CLKDIV, clkdiv)
-DEFINE_TWI_REG(CONTROL, control)
 DEFINE_TWI_REG(SLAVE_CTL, slave_ctl)
 DEFINE_TWI_REG(SLAVE_STAT, slave_stat)
 DEFINE_TWI_REG(SLAVE_ADDR, slave_addr)
@@ -28,7 +27,6 @@ DEFINE_TWI_REG(MASTER_STAT, master_stat)
 DEFINE_TWI_REG(MASTER_ADDR, master_addr)
 DEFINE_TWI_REG(INT_STAT, int_stat)
 DEFINE_TWI_REG(INT_MASK, int_mask)
-DEFINE_TWI_REG(FIFO_CTL, fifo_ctl)
 DEFINE_TWI_REG(FIFO_STAT, fifo_stat)
 DEFINE_TWI_REG(XMT_DATA8, xmt_data8)
 DEFINE_TWI_REG(XMT_DATA16, xmt_data16)
@@ -61,4 +59,25 @@ static inline u16 read_RCV_DATA16(struct adi_twi_iface *iface)
 }
 #endif
 
+static inline u16 read_FIFO_CTL(struct adi_twi_iface *iface)
+{
+	return bfin_read16(&iface->regs_base->fifo_ctl);
+}
+
+static inline void write_FIFO_CTL(struct adi_twi_iface *iface, u16 v)
+{
+	bfin_write16(&iface->regs_base->fifo_ctl, v);
+	SSYNC();
+}
+
+static inline u16 read_CONTROL(struct adi_twi_iface *iface)
+{
+	return bfin_read16(&iface->regs_base->control);
+}
+
+static inline void write_CONTROL(struct adi_twi_iface *iface, u16 v)
+{
+	SSYNC();
+	bfin_write16(&iface->regs_base->control, v);
+}
 #endif
diff --git a/drivers/i2c/busses/i2c-adi-twi.c b/drivers/i2c/busses/i2c-adi-twi.c
index 3b9bd9a..9076943 100644
--- a/drivers/i2c/busses/i2c-adi-twi.c
+++ b/drivers/i2c/busses/i2c-adi-twi.c
@@ -1,10 +1,8 @@
 /*
- * Blackfin On-Chip Two Wire Interface Driver
+ * ADI on-chip Two Wire Interface Driver
  *
  * Copyright 2005-2007 Analog Devices Inc.
  *
- * Enter bugs at http://blackfin.uclinux.org/
- *
  * Licensed under the GPL-2 or later.
  */
 
@@ -21,11 +19,11 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/i2c/i2c-adi.h>
 
-#include <asm/blackfin.h>
 #include <asm/portmux.h>
 #include <asm/irq.h>
-#include <asm/bfin_twi.h>
+#include <asm/twi.h>
 
 /* SMBus mode*/
 #define TWI_I2C_MODE_STANDARD		1
@@ -33,7 +31,7 @@
 #define TWI_I2C_MODE_COMBINED		3
 #define TWI_I2C_MODE_REPEAT		4
 
-static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
+static void adi_twi_handle_interrupt(struct adi_twi_iface *iface,
 					unsigned short twi_int_status)
 {
 	unsigned short mast_stat = read_MASTER_STAT(iface);
@@ -65,7 +63,6 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
 		/* Transmit next data */
 		while (iface->writeNum > 0 &&
 			(read_FIFO_STAT(iface) & XMTSTAT) != XMT_FULL) {
-			SSYNC();
 			write_XMT_DATA8(iface, *(iface->transPtr++));
 			iface->writeNum--;
 		}
@@ -234,9 +231,9 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
 }
 
 /* Interrupt handler */
-static irqreturn_t bfin_twi_interrupt_entry(int irq, void *dev_id)
+static irqreturn_t adi_twi_interrupt_entry(int irq, void *dev_id)
 {
-	struct bfin_twi_iface *iface = dev_id;
+	struct adi_twi_iface *iface = dev_id;
 	unsigned long flags;
 	unsigned short twi_int_status;
 
@@ -247,8 +244,7 @@ static irqreturn_t bfin_twi_interrupt_entry(int irq, void *dev_id)
 			break;
 		/* Clear interrupt status */
 		write_INT_STAT(iface, twi_int_status);
-		bfin_twi_handle_interrupt(iface, twi_int_status);
-		SSYNC();
+		adi_twi_handle_interrupt(iface, twi_int_status);
 	}
 	spin_unlock_irqrestore(&iface->lock, flags);
 	return IRQ_HANDLED;
@@ -257,10 +253,10 @@ static irqreturn_t bfin_twi_interrupt_entry(int irq, void *dev_id)
 /*
  * One i2c master transfer
  */
-static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
+static int adi_twi_do_master_xfer(struct i2c_adapter *adap,
 				struct i2c_msg *msgs, int num)
 {
-	struct bfin_twi_iface *iface = adap->algo_data;
+	struct adi_twi_iface *iface = adap->algo_data;
 	struct i2c_msg *pmsg;
 	int rc = 0;
 
@@ -294,9 +290,7 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
 	 *  discarded before start a new operation.
 	 */
 	write_FIFO_CTL(iface, 0x3);
-	SSYNC();
 	write_FIFO_CTL(iface, 0);
-	SSYNC();
 
 	if (pmsg->flags & I2C_M_RD)
 		iface->read_write = I2C_SMBUS_READ;
@@ -306,7 +300,6 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
 		if (iface->writeNum > 0) {
 			write_XMT_DATA8(iface, *(iface->transPtr++));
 			iface->writeNum--;
-			SSYNC();
 		}
 	}
 
@@ -315,7 +308,6 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
 
 	/* Interrupt mask . Enable XMT, RCV interrupt */
 	write_INT_MASK(iface, MCOMP | MERR | RCVSERV | XMTSERV);
-	SSYNC();
 
 	if (pmsg->len <= 255)
 		write_MASTER_CTL(iface, pmsg->len << 6);
@@ -328,8 +320,7 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
 	write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN |
 		(iface->msg_num > 1 ? RSTART : 0) |
 		((iface->read_write == I2C_SMBUS_READ) ? MDIR : 0) |
-		((CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ > 100) ? FAST : 0));
-	SSYNC();
+		((CONFIG_I2C_ADI_TWI_CLK_KHZ > 100) ? FAST : 0));
 
 	while (!iface->result) {
 		if (!wait_for_completion_timeout(&iface->complete,
@@ -350,20 +341,20 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
 /*
  * Generic i2c master transfer entrypoint
  */
-static int bfin_twi_master_xfer(struct i2c_adapter *adap,
+static int adi_twi_master_xfer(struct i2c_adapter *adap,
 				struct i2c_msg *msgs, int num)
 {
-	return bfin_twi_do_master_xfer(adap, msgs, num);
+	return adi_twi_do_master_xfer(adap, msgs, num);
 }
 
 /*
  * One I2C SMBus transfer
  */
-int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
+int adi_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 			unsigned short flags, char read_write,
 			u8 command, int size, union i2c_smbus_data *data)
 {
-	struct bfin_twi_iface *iface = adap->algo_data;
+	struct adi_twi_iface *iface = adap->algo_data;
 	int rc = 0;
 
 	if (!(read_CONTROL(iface) & TWI_ENA))
@@ -453,7 +444,6 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 	 * start a new operation.
 	 */
 	write_FIFO_CTL(iface, 0x3);
-	SSYNC();
 	write_FIFO_CTL(iface, 0);
 
 	/* clear int stat */
@@ -461,7 +451,6 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 
 	/* Set Transmit device address */
 	write_MASTER_ADDR(iface, addr);
-	SSYNC();
 
 	switch (iface->cur_mode) {
 	case TWI_I2C_MODE_STANDARDSUB:
@@ -469,7 +458,6 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 		write_INT_MASK(iface, MCOMP | MERR |
 			((iface->read_write == I2C_SMBUS_READ) ?
 			RCVSERV : XMTSERV));
-		SSYNC();
 
 		if (iface->writeNum + 1 <= 255)
 			write_MASTER_CTL(iface, (iface->writeNum + 1) << 6);
@@ -479,12 +467,11 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 		}
 		/* Master enable */
 		write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN |
-			((CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ>100) ? FAST : 0));
+			((CONFIG_I2C_ADI_TWI_CLK_KHZ>100) ? FAST : 0));
 		break;
 	case TWI_I2C_MODE_COMBINED:
 		write_XMT_DATA8(iface, iface->command);
 		write_INT_MASK(iface, MCOMP | MERR | RCVSERV | XMTSERV);
-		SSYNC();
 
 		if (iface->writeNum > 0)
 			write_MASTER_CTL(iface, (iface->writeNum + 1) << 6);
@@ -492,7 +479,7 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 			write_MASTER_CTL(iface, 0x1 << 6);
 		/* Master enable */
 		write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN | RSTART |
-			((CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ>100) ? FAST : 0));
+			((CONFIG_I2C_ADI_TWI_CLK_KHZ>100) ? FAST : 0));
 		break;
 	default:
 		write_MASTER_CTL(iface, 0);
@@ -531,15 +518,13 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 		write_INT_MASK(iface, MCOMP | MERR |
 			((iface->read_write == I2C_SMBUS_READ) ?
 			RCVSERV : XMTSERV));
-		SSYNC();
 
 		/* Master enable */
 		write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN |
 			((iface->read_write == I2C_SMBUS_READ) ? MDIR : 0) |
-			((CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ > 100) ? FAST : 0));
+			((CONFIG_I2C_ADI_TWI_CLK_KHZ > 100) ? FAST : 0));
 		break;
 	}
-	SSYNC();
 
 	while (!iface->result) {
 		if (!wait_for_completion_timeout(&iface->complete,
@@ -557,18 +542,18 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 /*
  * Generic I2C SMBus transfer entrypoint
  */
-int bfin_twi_smbus_xfer(struct i2c_adapter *adap, u16 addr,
+int adi_twi_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 			unsigned short flags, char read_write,
 			u8 command, int size, union i2c_smbus_data *data)
 {
-	return bfin_twi_do_smbus_xfer(adap, addr, flags,
+	return adi_twi_do_smbus_xfer(adap, addr, flags,
 			read_write, command, size, data);
 }
 
 /*
  * Return what the adapter supports
  */
-static u32 bfin_twi_functionality(struct i2c_adapter *adap)
+static u32 adi_twi_functionality(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
@@ -576,16 +561,16 @@ static u32 bfin_twi_functionality(struct i2c_adapter *adap)
 	       I2C_FUNC_I2C | I2C_FUNC_SMBUS_I2C_BLOCK;
 }
 
-static struct i2c_algorithm bfin_twi_algorithm = {
-	.master_xfer   = bfin_twi_master_xfer,
-	.smbus_xfer    = bfin_twi_smbus_xfer,
-	.functionality = bfin_twi_functionality,
+static struct i2c_algorithm adi_twi_algorithm = {
+	.master_xfer   = adi_twi_master_xfer,
+	.smbus_xfer    = adi_twi_smbus_xfer,
+	.functionality = adi_twi_functionality,
 };
 
 #ifdef CONFIG_PM_SLEEP
-static int i2c_bfin_twi_suspend(struct device *dev)
+static int i2c_adi_twi_suspend(struct device *dev)
 {
-	struct bfin_twi_iface *iface = dev_get_drvdata(dev);
+	struct adi_twi_iface *iface = dev_get_drvdata(dev);
 
 	iface->saved_clkdiv = read_CLKDIV(iface);
 	iface->saved_control = read_CONTROL(iface);
@@ -598,11 +583,11 @@ static int i2c_bfin_twi_suspend(struct device *dev)
 	return 0;
 }
 
-static int i2c_bfin_twi_resume(struct device *dev)
+static int i2c_adi_twi_resume(struct device *dev)
 {
-	struct bfin_twi_iface *iface = dev_get_drvdata(dev);
+	struct adi_twi_iface *iface = dev_get_drvdata(dev);
 
-	int rc = request_irq(iface->irq, bfin_twi_interrupt_entry,
+	int rc = request_irq(iface->irq, adi_twi_interrupt_entry,
 		0, to_platform_device(dev)->name, iface);
 	if (rc) {
 		dev_err(dev, "Can't get IRQ %d !\n", iface->irq);
@@ -618,22 +603,22 @@ static int i2c_bfin_twi_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(i2c_bfin_twi_pm,
-			 i2c_bfin_twi_suspend, i2c_bfin_twi_resume);
-#define I2C_BFIN_TWI_PM_OPS	(&i2c_bfin_twi_pm)
+static SIMPLE_DEV_PM_OPS(i2c_adi_twi_pm,
+			 i2c_adi_twi_suspend, i2c_adi_twi_resume);
+#define I2C_ADI_TWI_PM_OPS    (&i2c_adi_twi_pm)
 #else
-#define I2C_BFIN_TWI_PM_OPS	NULL
+#define I2C_ADI_TWI_PM_OPS    NULL
 #endif
 
-static int i2c_bfin_twi_probe(struct platform_device *pdev)
+static int i2c_adi_twi_probe(struct platform_device *pdev)
 {
-	struct bfin_twi_iface *iface;
+	struct adi_twi_iface *iface;
 	struct i2c_adapter *p_adap;
 	struct resource *res;
 	int rc;
 	unsigned int clkhilow;
 
-	iface = kzalloc(sizeof(struct bfin_twi_iface), GFP_KERNEL);
+	iface = kzalloc(sizeof(struct adi_twi_iface), GFP_KERNEL);
 	if (!iface) {
 		dev_err(&pdev->dev, "Cannot allocate memory\n");
 		rc = -ENOMEM;
@@ -667,7 +652,7 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 	p_adap = &iface->adap;
 	p_adap->nr = pdev->id;
 	strlcpy(p_adap->name, pdev->name, sizeof(p_adap->name));
-	p_adap->algo = &bfin_twi_algorithm;
+	p_adap->algo = &adi_twi_algorithm;
 	p_adap->algo_data = iface;
 	p_adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	p_adap->dev.parent = &pdev->dev;
@@ -676,13 +661,13 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 
 	rc = peripheral_request_list(
 			dev_get_platdata(&pdev->dev),
-			"i2c-bfin-twi");
+			"i2c-adi-twi");
 	if (rc) {
 		dev_err(&pdev->dev, "Can't setup pin mux!\n");
 		goto out_error_pin_mux;
 	}
 
-	rc = request_irq(iface->irq, bfin_twi_interrupt_entry,
+	rc = request_irq(iface->irq, adi_twi_interrupt_entry,
 		0, pdev->name, iface);
 	if (rc) {
 		dev_err(&pdev->dev, "Can't get IRQ %d !\n", iface->irq);
@@ -697,14 +682,13 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 	 * We will not end up with a CLKDIV=0 because no one will specify
 	 * 20kHz SCL or less in Kconfig now. (5 * 1000 / 20 = 250)
 	 */
-	clkhilow = ((10 * 1000 / CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ) + 1) / 2;
+	clkhilow = ((10 * 1000 / CONFIG_I2C_ADI_TWI_CLK_KHZ) + 1) / 2;
 
 	/* Set Twi interface clock as specified */
 	write_CLKDIV(iface, (clkhilow << 8) | clkhilow);
 
 	/* Enable TWI */
 	write_CONTROL(iface, read_CONTROL(iface) | TWI_ENA);
-	SSYNC();
 
 	rc = i2c_add_numbered_adapter(p_adap);
 	if (rc < 0) {
@@ -714,7 +698,7 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, iface);
 
-	dev_info(&pdev->dev, "Blackfin BF5xx on-chip I2C TWI Contoller, "
+	dev_info(&pdev->dev, "ADI on-chip I2C TWI Contoller, "
 		"regs_base@%p\n", iface->regs_base);
 
 	return 0;
@@ -733,9 +717,9 @@ out_error_nomem:
 	return rc;
 }
 
-static int i2c_bfin_twi_remove(struct platform_device *pdev)
+static int i2c_adi_twi_remove(struct platform_device *pdev)
 {
-	struct bfin_twi_iface *iface = platform_get_drvdata(pdev);
+	struct adi_twi_iface *iface = platform_get_drvdata(pdev);
 
 	i2c_del_adapter(&(iface->adap));
 	free_irq(iface->irq, iface);
@@ -746,30 +730,30 @@ static int i2c_bfin_twi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver i2c_bfin_twi_driver = {
-	.probe		= i2c_bfin_twi_probe,
-	.remove		= i2c_bfin_twi_remove,
+static struct platform_driver i2c_adi_twi_driver = {
+	.probe		= i2c_adi_twi_probe,
+	.remove		= i2c_adi_twi_remove,
 	.driver		= {
-		.name	= "i2c-bfin-twi",
+		.name	= "i2c-adi-twi",
 		.owner	= THIS_MODULE,
-		.pm	= I2C_BFIN_TWI_PM_OPS,
+		.pm	= I2C_ADI_TWI_PM_OPS,
 	},
 };
 
-static int __init i2c_bfin_twi_init(void)
+static int __init i2c_adi_twi_init(void)
 {
-	return platform_driver_register(&i2c_bfin_twi_driver);
+	return platform_driver_register(&i2c_adi_twi_driver);
 }
 
-static void __exit i2c_bfin_twi_exit(void)
+static void __exit i2c_adi_twi_exit(void)
 {
-	platform_driver_unregister(&i2c_bfin_twi_driver);
+	platform_driver_unregister(&i2c_adi_twi_driver);
 }
 
-subsys_initcall(i2c_bfin_twi_init);
-module_exit(i2c_bfin_twi_exit);
+subsys_initcall(i2c_adi_twi_init);
+module_exit(i2c_adi_twi_exit);
 
 MODULE_AUTHOR("Bryan Wu, Sonic Zhang");
-MODULE_DESCRIPTION("Blackfin BF5xx on-chip I2C TWI Contoller Driver");
+MODULE_DESCRIPTION("ADI on-chip I2C TWI Contoller Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:i2c-bfin-twi");
+MODULE_ALIAS("platform:i2c-adi-twi");
-- 
1.8.2.3
