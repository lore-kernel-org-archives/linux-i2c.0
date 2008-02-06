From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCHv2 2/3] Extend the PCA9564-algorithm and adapt its only
	user (pca-isa).
Date: Wed, 06 Feb 2008 21:20:58 +0100
Message-ID: <20080206203036.863518353@pengutronix.de>
References: <20080206202056.364404622@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline; filename=i2c-pca-algo_extensions.diff
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The separation between algorithm and adapter was unsharp at places. This was
partly hidden by the fact, that the ISA-driver allowed just one instance and
had all private data in static variables. This patch makes neccessary
preparations to add a platform driver on top of the algorithm, while still
supporting ISA. Note: Due to lack of hardware, the ISA-driver could not be
tested except that it builds.

Concerning the core struct i2c_algo_pca_data:

- A private data field was added, all hardware dependant data may go here.
  Similar to other algorithms, now a pointer to this data is passed to the
  adapter's functions. In order to make as less changes as possible to the
  ISA-driver, it leaves the private data empty and still only uses its static
  variables.

- A "reset_chip" function pointer was added; such a functionality must come
  from the adapter, not the algorithm.

- use a variable "i2c_clock" instead of a function pointer "get_clock",
  allowing for write access to a default in case a wrong value was supplied.

In the algorithm-file:

- move "i2c-pca-algo.h" into "linux/i2c-algo-pca.h"
- now using per_instance timeout values (i2c_adap->timeout)
- error messages specify the device, not only the driver name
- restructure initialization to easily support "i2c_add_numbered_adapter"
- drop "retries" and "own" (i2c address) as they were unused

(The state-machine for I2C-communication was not touched.)

In the ISA-driver:

- adapt to new algorithm
- updated tests to variable "irq" to the convention that 0 is NO_IRQ

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

---
 drivers/i2c/algos/i2c-algo-pca.c |   87 +++++++++++++++++++--------------------
 drivers/i2c/algos/i2c-algo-pca.h |   26 -----------
 drivers/i2c/busses/i2c-pca-isa.c |   59 ++++++++++----------------
 include/linux/i2c-algo-pca.h     |   37 ++++++++++++++--
 4 files changed, 98 insertions(+), 111 deletions(-)

Index: linux-playground/include/linux/i2c-algo-pca.h
===================================================================
--- linux-playground.orig/include/linux/i2c-algo-pca.h	2008-02-06 20:15:37.000000000 +0100
+++ linux-playground/include/linux/i2c-algo-pca.h	2008-02-06 20:15:48.000000000 +0100
@@ -1,14 +1,41 @@
 #ifndef _LINUX_I2C_ALGO_PCA_H
 #define _LINUX_I2C_ALGO_PCA_H
 
+/* Clock speeds for the bus */
+#define I2C_PCA_CON_330kHz	0x00
+#define I2C_PCA_CON_288kHz	0x01
+#define I2C_PCA_CON_217kHz	0x02
+#define I2C_PCA_CON_146kHz	0x03
+#define I2C_PCA_CON_88kHz	0x04
+#define I2C_PCA_CON_59kHz	0x05
+#define I2C_PCA_CON_44kHz	0x06
+#define I2C_PCA_CON_36kHz	0x07
+
+/* PCA9564 registers */
+#define I2C_PCA_STA		0x00 /* STATUS  Read Only  */
+#define I2C_PCA_TO		0x00 /* TIMEOUT Write Only */
+#define I2C_PCA_DAT		0x01 /* DATA    Read/Write */
+#define I2C_PCA_ADR		0x02 /* OWN ADR Read/Write */
+#define I2C_PCA_CON		0x03 /* CONTROL Read/Write */
+
+#define I2C_PCA_CON_AA		0x80 /* Assert Acknowledge */
+#define I2C_PCA_CON_ENSIO	0x40 /* Enable */
+#define I2C_PCA_CON_STA		0x20 /* Start */
+#define I2C_PCA_CON_STO		0x10 /* Stop */
+#define I2C_PCA_CON_SI		0x08 /* Serial Interrupt */
+#define I2C_PCA_CON_CR		0x07 /* Clock Rate (MASK) */
+
 struct i2c_algo_pca_data {
-	int  (*get_own)			(struct i2c_algo_pca_data *adap); /* Obtain own address */
-	int  (*get_clock)		(struct i2c_algo_pca_data *adap);
-	void (*write_byte)		(struct i2c_algo_pca_data *adap, int reg, int val);
-	int  (*read_byte)		(struct i2c_algo_pca_data *adap, int reg);
-	int  (*wait_for_interrupt)	(struct i2c_algo_pca_data *adap);
+	void 				*data;	/* private low level data */
+	void (*write_byte)		(void *data, int reg, int val);
+	int  (*read_byte)		(void *data, int reg);
+	int  (*wait_for_completion)	(void *data);
+	void (*reset_chip)		(void *data);
+	/* i2c_clock values are defined in linux/i2c-algo-pca.h */
+	unsigned int			i2c_clock;
 };
 
 int i2c_pca_add_bus(struct i2c_adapter *);
+int i2c_pca_add_numbered_bus(struct i2c_adapter *);
 
 #endif /* _LINUX_I2C_ALGO_PCA_H */
Index: linux-playground/drivers/i2c/algos/i2c-algo-pca.h
===================================================================
--- linux-playground.orig/drivers/i2c/algos/i2c-algo-pca.h	2008-02-06 20:15:37.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,26 +0,0 @@
-#ifndef I2C_PCA9564_H
-#define I2C_PCA9564_H 1
-
-#define I2C_PCA_STA		0x00 /* STATUS  Read Only  */
-#define I2C_PCA_TO		0x00 /* TIMEOUT Write Only */
-#define I2C_PCA_DAT		0x01 /* DATA    Read/Write */
-#define I2C_PCA_ADR		0x02 /* OWN ADR Read/Write */
-#define I2C_PCA_CON		0x03 /* CONTROL Read/Write */
-
-#define I2C_PCA_CON_AA		0x80 /* Assert Acknowledge */
-#define I2C_PCA_CON_ENSIO	0x40 /* Enable */
-#define I2C_PCA_CON_STA		0x20 /* Start */
-#define I2C_PCA_CON_STO		0x10 /* Stop */
-#define I2C_PCA_CON_SI		0x08 /* Serial Interrupt */
-#define I2C_PCA_CON_CR		0x07 /* Clock Rate (MASK) */
-
-#define I2C_PCA_CON_330kHz	0x00
-#define I2C_PCA_CON_288kHz	0x01
-#define I2C_PCA_CON_217kHz	0x02
-#define I2C_PCA_CON_146kHz	0x03
-#define I2C_PCA_CON_88kHz	0x04
-#define I2C_PCA_CON_59kHz	0x05
-#define I2C_PCA_CON_44kHz	0x06
-#define I2C_PCA_CON_36kHz	0x07
-
-#endif /* I2C_PCA9564_H */
Index: linux-playground/drivers/i2c/algos/i2c-algo-pca.c
===================================================================
--- linux-playground.orig/drivers/i2c/algos/i2c-algo-pca.c	2008-02-06 20:15:41.000000000 +0100
+++ linux-playground/drivers/i2c/algos/i2c-algo-pca.c	2008-02-06 20:15:48.000000000 +0100
@@ -1,6 +1,7 @@
 /*
  *  i2c-algo-pca.c i2c driver algorithms for PCA9564 adapters
  *    Copyright (C) 2004 Arcom Control Systems
+ *    Copyright (C) 2008 Pengutronix
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -21,14 +22,10 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-pca.h>
-#include "i2c-algo-pca.h"
-
-#define DRIVER "i2c-algo-pca"
 
 #define DEB1(fmt, args...) do { if (i2c_debug>=1) printk(fmt, ## args); } while(0)
 #define DEB2(fmt, args...) do { if (i2c_debug>=2) printk(fmt, ## args); } while(0)
@@ -36,15 +33,15 @@
 
 static int i2c_debug;
 
-#define pca_outw(adap, reg, val) adap->write_byte(adap, reg, val)
-#define pca_inw(adap, reg) adap->read_byte(adap, reg)
+#define pca_outw(adap, reg, val) adap->write_byte(adap->data, reg, val)
+#define pca_inw(adap, reg) adap->read_byte(adap->data, reg)
 
 #define pca_status(adap) pca_inw(adap, I2C_PCA_STA)
-#define pca_clock(adap) adap->get_clock(adap)
-#define pca_own(adap) adap->get_own(adap)
+#define pca_clock(adap) adap->i2c_clock
 #define pca_set_con(adap, val) pca_outw(adap, I2C_PCA_CON, val)
 #define pca_get_con(adap) pca_inw(adap, I2C_PCA_CON)
-#define pca_wait(adap) adap->wait_for_interrupt(adap)
+#define pca_wait(adap) adap->wait_for_completion(adap->data)
+#define pca_reset(adap) adap->reset_chip(adap->data)
 
 /*
  * Generate a start condition on the i2c bus.
@@ -168,15 +165,6 @@
 	pca_wait(adap);
 }
 
-/*
- * Reset the i2c bus / SIO
- */
-static void pca_reset(struct i2c_algo_pca_data *adap)
-{
-	/* apparently only an external reset will do it. not a lot can be done */
-	printk(KERN_ERR DRIVER ": Haven't figured out how to do a reset yet\n");
-}
-
 static int pca_xfer(struct i2c_adapter *i2c_adap,
                     struct i2c_msg *msgs,
                     int num)
@@ -187,7 +175,7 @@
 	int numbytes = 0;
 	int state;
 	int ret;
-	int timeout = 100;
+	int timeout = i2c_adap->timeout;
 
 	while ((state = pca_status(adap)) != 0xf8 && timeout--) {
 		msleep(10);
@@ -317,7 +305,7 @@
 			pca_reset(adap);
 			goto out;
 		default:
-			printk(KERN_ERR DRIVER ": unhandled SIO state 0x%02x\n", state);
+			dev_err(&i2c_adap->dev, "unhandled SIO state 0x%02x\n", state);
 			break;
 		}
 
@@ -337,53 +325,64 @@
         return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
-static int pca_init(struct i2c_algo_pca_data *adap)
+static const struct i2c_algorithm pca_algo = {
+	.master_xfer	= pca_xfer,
+	.functionality	= pca_func,
+};
+
+static int pca_init(struct i2c_adapter *adap)
 {
 	static int freqs[] = {330,288,217,146,88,59,44,36};
-	int own, clock;
+	int clock;
+	struct i2c_algo_pca_data *pca_data = adap->algo_data;
+
+	if (pca_data->i2c_clock > 7) {
+		dev_warn(&adap->dev, "Invalid I2C clock speed selected. Trying default.\n");
+		pca_data->i2c_clock = I2C_PCA_CON_59kHz;
+	}
+
+	adap->algo = &pca_algo;
 
-	own = pca_own(adap);
-	clock = pca_clock(adap);
-	DEB1(KERN_INFO DRIVER ": own address is %#04x\n", own);
-	DEB1(KERN_INFO DRIVER ": clock freqeuncy is %dkHz\n", freqs[clock]);
+	pca_reset(pca_data);
 
-	pca_outw(adap, I2C_PCA_ADR, own << 1);
+	clock = pca_clock(pca_data);
+	DEB1(KERN_INFO "%s: Clock frequency is %dkHz\n", adap->name, freqs[clock]);
 
-	pca_set_con(adap, I2C_PCA_CON_ENSIO | clock);
+	pca_set_con(pca_data, I2C_PCA_CON_ENSIO | clock);
 	udelay(500); /* 500 us for oscilator to stabilise */
 
 	return 0;
 }
 
-static const struct i2c_algorithm pca_algo = {
-	.master_xfer	= pca_xfer,
-	.functionality	= pca_func,
-};
-
 /*
  * registering functions to load algorithms at runtime
  */
 int i2c_pca_add_bus(struct i2c_adapter *adap)
 {
-	struct i2c_algo_pca_data *pca_adap = adap->algo_data;
 	int rval;
 
-	/* register new adapter to i2c module... */
-	adap->algo = &pca_algo;
+	rval = pca_init(adap);
+	if (rval)
+		return rval;
 
-	adap->timeout = 100;		/* default values, should	*/
-	adap->retries = 3;		/* be replaced by defines	*/
+	return i2c_add_adapter(adap);
+}
+EXPORT_SYMBOL(i2c_pca_add_bus);
 
-	if ((rval = pca_init(pca_adap)))
-		return rval;
+int i2c_pca_add_numbered_bus(struct i2c_adapter *adap)
+{
+	int rval;
 
-	rval = i2c_add_adapter(adap);
+	rval = pca_init(adap);
+	if (rval)
+		return rval;
 
-	return rval;
+	return i2c_add_numbered_adapter(adap);
 }
-EXPORT_SYMBOL(i2c_pca_add_bus);
+EXPORT_SYMBOL(i2c_pca_add_numbered_bus);
 
-MODULE_AUTHOR("Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>");
+MODULE_AUTHOR("Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>, "
+	"Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
 MODULE_DESCRIPTION("I2C-Bus PCA9564 algorithm");
 MODULE_LICENSE("GPL");
 
Index: linux-playground/drivers/i2c/busses/i2c-pca-isa.c
===================================================================
--- linux-playground.orig/drivers/i2c/busses/i2c-pca-isa.c	2008-02-06 20:15:41.000000000 +0100
+++ linux-playground/drivers/i2c/busses/i2c-pca-isa.c	2008-02-06 20:15:48.000000000 +0100
@@ -1,6 +1,7 @@
 /*
  *  i2c-pca-isa.c driver for PCA9564 on ISA boards
  *    Copyright (C) 2004 Arcom Control Systems
+ *    Copyright (C) 2008 Pengutronix
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -22,11 +23,9 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/wait.h>
-
 #include <linux/isa.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-pca.h>
@@ -34,13 +33,9 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "../algos/i2c-algo-pca.h"
-
+#define DRIVER "i2c-pca-isa"
 #define IO_SIZE 4
 
-#undef DEBUG_IO
-//#define DEBUG_IO
-
 static unsigned long base   = 0x330;
 static int irq 	  = 10;
 
@@ -48,22 +43,9 @@
  * in the actual clock rate */
 static int clock  = I2C_PCA_CON_59kHz;
 
-static int own    = 0x55;
-
 static wait_queue_head_t pca_wait;
 
-static int pca_isa_getown(struct i2c_algo_pca_data *adap)
-{
-	return (own);
-}
-
-static int pca_isa_getclock(struct i2c_algo_pca_data *adap)
-{
-	return (clock);
-}
-
-static void
-pca_isa_writebyte(struct i2c_algo_pca_data *adap, int reg, int val)
+static void pca_isa_writebyte(void *pd, int reg, int val)
 {
 #ifdef DEBUG_IO
 	static char *names[] = { "T/O", "DAT", "ADR", "CON" };
@@ -72,8 +54,7 @@
 	outb(val, base+reg);
 }
 
-static int
-pca_isa_readbyte(struct i2c_algo_pca_data *adap, int reg)
+static int pca_isa_readbyte(void *pd, int reg)
 {
 	int res = inb(base+reg);
 #ifdef DEBUG_IO
@@ -85,31 +66,37 @@
 	return res;
 }
 
-static int pca_isa_waitforinterrupt(struct i2c_algo_pca_data *adap)
+static int pca_isa_waitforcompletion(void *pd)
 {
 	int ret = 0;
 
-	if (irq > -1) {
+	if (irq) {
 		ret = wait_event_interruptible(pca_wait,
-					       pca_isa_readbyte(adap, I2C_PCA_CON) & I2C_PCA_CON_SI);
+					       pca_isa_readbyte(pd, I2C_PCA_CON) & I2C_PCA_CON_SI);
 	} else {
-		while ((pca_isa_readbyte(adap, I2C_PCA_CON) & I2C_PCA_CON_SI) == 0)
+		while ((pca_isa_readbyte(pd, I2C_PCA_CON) & I2C_PCA_CON_SI) == 0)
 			udelay(100);
 	}
 	return ret;
 }
 
+static void pca_isa_resetchip(void *pd)
+{
+	/* apparently only an external reset will do it. not a lot can be done */
+	printk(KERN_WARNING DRIVER ": Haven't figured out how to do a reset yet\n");
+}
+
 static irqreturn_t pca_handler(int this_irq, void *dev_id) {
 	wake_up_interruptible(&pca_wait);
 	return IRQ_HANDLED;
 }
 
 static struct i2c_algo_pca_data pca_isa_data = {
-	.get_own		= pca_isa_getown,
-	.get_clock		= pca_isa_getclock,
+	/* .data intentionally left NULL, not needed with ISA */
 	.write_byte		= pca_isa_writebyte,
 	.read_byte		= pca_isa_readbyte,
-	.wait_for_interrupt	= pca_isa_waitforinterrupt,
+	.wait_for_completion	= pca_isa_waitforcompletion,
+	.reset_chip		= pca_isa_resetchip,
 };
 
 static struct i2c_adapter pca_isa_ops = {
@@ -117,6 +104,7 @@
 	.id		= I2C_HW_A_ISA,
 	.algo_data	= &pca_isa_data,
 	.name		= "PCA9564 ISA Adapter",
+	.timeout	= 100,
 };
 
 static int __devinit pca_isa_probe(struct device *dev, unsigned int id)
@@ -130,13 +118,14 @@
 		goto out;
 	}
 
-	if (irq > -1) {
+	if (irq) {
 		if (request_irq(irq, pca_handler, 0, "i2c-pca-isa", &pca_isa_ops) < 0) {
 			dev_err(dev, "Request irq%d failed\n", irq);
 			goto out_region;
 		}
 	}
 
+	pca_isa_data.i2c_clock = clock;
 	if (i2c_pca_add_bus(&pca_isa_ops) < 0) {
 		dev_err(dev, "Failed to add i2c bus\n");
 		goto out_irq;
@@ -145,7 +134,7 @@
 	return 0;
 
  out_irq:
-	if (irq > -1)
+	if (irq)
 		free_irq(irq, &pca_isa_ops);
  out_region:
 	release_region(base, IO_SIZE);
@@ -157,7 +146,7 @@
 {
 	i2c_del_adapter(&pca_isa_ops);
 
-	if (irq > 0) {
+	if (irq) {
 		disable_irq(irq);
 		free_irq(irq, &pca_isa_ops);
 	}
@@ -171,7 +160,7 @@
 	.remove		= __devexit_p(pca_isa_remove),
 	.driver = {
 		.owner	= THIS_MODULE,
-		.name	= "i2c-pca-isa",
+		.name	= DRIVER,
 	}
 };
 
@@ -197,7 +186,5 @@
 module_param(clock, int, 0);
 MODULE_PARM_DESC(clock, "Clock rate as described in table 1 of PCA9564 datasheet");
 
-module_param(own, int, 0); /* the driver can't do slave mode, so there's no real point in this */
-
 module_init(pca_isa_init);
 module_exit(pca_isa_exit);

-- 
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
