From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] I2C driver supporting Moorestown and Medfield platform
Date: Mon, 19 Jul 2010 11:17:28 +0100
Message-ID: <20100719101724.31685.76712.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Wen Wang <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Initial release of the driver.

Some clean up table removal by Alan Cox

Signed-off-by: Wen Wang <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 drivers/i2c/busses/Kconfig    |    9 
 drivers/i2c/busses/Makefile   |    1 
 drivers/i2c/busses/i2c-mrst.c |  902 +++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-mrst.h |  269 ++++++++++++
 4 files changed, 1181 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-mrst.c
 create mode 100644 drivers/i2c/busses/i2c-mrst.h


diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 29e01f6..ea0100e 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -420,6 +420,15 @@ config I2C_IXP2000
 	  This driver is deprecated and will be dropped soon. Use i2c-gpio
 	  instead.
 
+config I2C_MRST
+	tristate "Intel Moorestown/Medfield Platform I2C controller"
+	help
+	  Say Y here if you have an Intel Moorestown/Medfield platform I2C
+	  controller.
+
+	  This support is also available as a module. If so, the module
+	  will be called i2c-mrst.
+
 config I2C_MPC
 	tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
 	depends on PPC32
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 936880b..0b9aa00 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
 obj-$(CONFIG_I2C_IMX)		+= i2c-imx.o
 obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
 obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
+obj-$(CONFIG_I2C_MRST)		+= i2c-mrst.o
 obj-$(CONFIG_I2C_MPC)		+= i2c-mpc.o
 obj-$(CONFIG_I2C_MV64XXX)	+= i2c-mv64xxx.o
 obj-$(CONFIG_I2C_NOMADIK)	+= i2c-nomadik.o
diff --git a/drivers/i2c/busses/i2c-mrst.c b/drivers/i2c/busses/i2c-mrst.c
new file mode 100644
index 0000000..5da3ca5
--- /dev/null
+++ b/drivers/i2c/busses/i2c-mrst.c
@@ -0,0 +1,902 @@
+/*
+ * Support for Moorestown/Medfield I2C chip
+ *
+ * Copyright (c) 2009 Intel Corporation.
+ * Copyright (c) 2009 Synopsys. Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License, version
+ * 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT ANY
+ * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc., 51
+ * Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+
+#include <linux/io.h>
+
+#include "i2c-mrst.h"
+
+#define DEF_BAR		0
+#define VERSION		"Version 0.5"
+#define PLATFORM	"Moorestown/Medfield"
+
+#define mrst_i2c_read(reg)		__raw_readl(reg)
+#define mrst_i2c_write(reg, val)	__raw_writel((val), (reg))
+
+/* Use defines not enumerations so that we can do this with tables */
+
+#define MOOESTOWN	0
+#define	MEDFIELD	1
+
+#define NUM_PLATFORMS	2
+
+#define STANDARD	0
+#define FAST		1
+#define HIGH		2
+
+#define NUM_SPEEDS	3
+
+
+static int speed_mode[6] = {
+	STANDARD,
+	STANDARD,
+	STANDARD,
+	STANDARD,
+	STANDARD,
+	STANDARD
+};
+static int ctl_num;
+module_param_array(speed_mode, int, &ctl_num, S_IRUGO);
+
+/**
+ * mrst_i2c_disable - Disable I2C controller
+ * @adap: struct pointer to i2c_adapter
+ *
+ * Return Value:
+ * 0		success
+ * -EBUSY	if device is busy
+ * -ETIMEOUT	if i2c cannot be disabled within the given time
+ *
+ * I2C bus state should be checked prior to disabling the hardware. If bus is
+ * not in idle state, an errno is returned. Write "0" to IC_ENABLE to disable
+ * I2C controller.
+ */
+static int mrst_i2c_disable(struct i2c_adapter *adap)
+{
+	struct mrst_i2c_private *i2c =
+	    (struct mrst_i2c_private *)i2c_get_adapdata(adap);
+
+	int count = 0;
+	int ret1, ret2;
+	static const u16 delay[NUM_SPEEDS] = {100, 25, 3};
+
+	/* Set IC_ENABLE to 0 */
+	mrst_i2c_write(i2c->base + IC_ENABLE, 0);
+
+	/* Check if device is busy */
+	dev_dbg(&adap->dev, "mrst i2c disable\n");
+	while ((ret1 = mrst_i2c_read(i2c->base + IC_ENABLE_STATUS) & 0x1)
+		|| (ret2 = mrst_i2c_read(i2c->base + IC_STATUS) & 0x1)) {
+		udelay(delay[i2c->speed]);
+		mrst_i2c_write(i2c->base + IC_ENABLE, 0);
+		dev_dbg(&adap->dev, "i2c is busy, count is %d speed %d\n",
+			count, i2c->speed);
+		if (count++ > 10)
+			break;
+	}
+
+	/* Clear all interrupts */
+	mrst_i2c_read(i2c->base + IC_CLR_INTR);
+	/* Disable all interupts */
+	mrst_i2c_write(i2c->base + IC_INTR_MASK, 0x0000);
+
+	return 0;
+}
+
+/**
+ * mrst_i2c_hwinit - Initiate the I2C hardware registers. This function will
+ * be called in mrst_i2c_probe() before device registration.
+ * @dev: pci device struct pointer
+ *
+ * Return Values:
+ * 0		success
+ * -EBUSY	i2c cannot be disabled
+ * -ETIMEDOUT	i2c cannot be disabled
+ * -EFAULT	If APB data width is not 32-bit wide
+ *
+ * I2C should be disabled prior to other register operation. If failed, an
+ * errno is returned. Mask and Clear all interrpts, this should be done at
+ * first.  Set common registers which will not be modified during normal
+ * transfers, including: controll register, FIFO threshold and clock freq.
+ * Check APB data width at last.
+ */
+static int mrst_i2c_hwinit(struct mrst_i2c_private *i2c)
+{
+	int err = 0;
+	static const u16 hcnt[NUM_PLATFORMS][NUM_SPEEDS] = {
+		{ 0x75,  0x15, 0x07 },
+		{ 0x1EC, 0x70, 0x06 }
+	};
+	static const u16 lcnt[NUM_PLATFORMS][NUM_SPEEDS] = {
+		{ 0x7C,  0x21, 0x0E },
+		{ 0x1F3, 0x81, 0x0F }
+	};
+
+	/* Disable i2c first */
+	mrst_i2c_disable(i2c->adap);
+	/* Clear all interrupts */
+	mrst_i2c_read(i2c->base + IC_CLR_INTR);
+	/* Disable all interupts */
+	mrst_i2c_write(i2c->base + IC_INTR_MASK, 0x0000);
+
+	/*
+	 * Setup clock frequency and speed mode
+	 * Enable restart condition,
+	 * enable master FSM, disable slave FSM,
+	 * use target address when initiating transfer
+	 */
+
+	mrst_i2c_write(i2c->base + IC_CON,
+		(i2c->speed + 1) << 1 | SLV_DIS | RESTART | MASTER_EN);
+	mrst_i2c_write(i2c->base + (IC_SS_SCL_HCNT + (i2c->speed << 3)),
+		hcnt[i2c->platform][i2c->speed]);
+	mrst_i2c_write(i2c->base + (IC_SS_SCL_LCNT + (i2c->speed << 3)),
+		lcnt[i2c->platform][i2c->speed]);
+
+	/* Set tranmit & receive FIFO threshold to zero */
+	mrst_i2c_write(i2c->base + IC_RX_TL, 0x0);
+	mrst_i2c_write(i2c->base + IC_TX_TL, 0xFF);
+
+	return err;
+}
+
+/**
+ * mrst_i2c_func - Return the supported three I2C operations.
+ * @adapter: i2c_adapter struct pointer
+ */
+static u32 mrst_i2c_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SMBUS_EMUL;
+}
+
+/**
+ * mrst_i2c_invalid_address - To check if the address in i2c message is
+ * correct.
+ * @p: i2c_msg struct pointer
+ *
+ * Return Values:
+ * 0	if the address is valid
+ * 1	if the address is invalid
+ */
+static inline int mrst_i2c_invalid_address(const struct i2c_msg *p)
+{
+	int ret = ((p->addr > 0x3ff) || (!(p->flags & I2C_M_TEN)
+					 && (p->addr > 0x7f)));
+	return ret;
+}
+
+/**
+ * mrst_i2c_address_neq - To check if the addresses for different i2c messages
+ * are equal.
+ * @p1: first i2c_msg
+ * @p2: second i2c_msg
+ *
+ * Return Values:
+ * 0	 if addresse are equal
+ * 1	 if not equal
+ *
+ * Within a single transfer, I2C client may need to send its address more
+ * than one time. So a check for the address equation is needed.
+ */
+static inline int mrst_i2c_address_neq(const struct i2c_msg *p1,
+				       const struct i2c_msg *p2)
+{
+	int ret = ((p1->addr != p2->addr) || ((p1->flags & (I2C_M_TEN))
+					      != ((p2->flags) & (I2C_M_TEN))));
+	return ret;
+}
+
+/**
+ * mrst_i2c_abort - To handle transfer abortions and print error messages.
+ * @adap: i2c_adapter struct pointer
+ *
+ * By reading register IC_TX_ABRT_SOURCE, various transfer errors can be
+ * distingushed. At present, no circumstances have been found out that
+ * multiple errors would be occured simutaneously, so we simply use the
+ * register value directly.
+ *
+ * At last the error bits are cleared. (Note clear ABRT_SBYTE_NORSTRT bit need
+ * a few extra steps)
+ */
+static void mrst_i2c_abort(struct mrst_i2c_private *i2c)
+{
+	/* Read about source register */
+	int abort = i2c->abort;
+	struct i2c_adapter *adap = i2c->adap;
+
+	/* Single transfer error check:
+	 * According to databook, TX/RX FIFOs would be flushed when
+	 * the abort interrupt occured.
+	 */
+	switch (abort) {
+	case ABRT_MASTER_DIS:
+		dev_err(&adap->dev,
+		"initiate Master operation with Master mode disabled.\n");
+
+		break;
+	case ABRT_10B_RD_NORSTRT:
+		dev_err(&adap->dev,
+	"RESTART disabled and master sends READ cmd in 10-BIT addressing.\n");
+		break;
+	case ABRT_SBYTE_NORSTRT:
+		dev_err(&adap->dev,
+		"RESTART disabled and user is trying to send START byte.\n");
+		mrst_i2c_write(i2c->base + IC_TX_ABRT_SOURCE,
+			       !(ABRT_SBYTE_NORSTRT));
+		mrst_i2c_write(i2c->base + IC_CON, RESTART);
+		mrst_i2c_write(i2c->base + IC_TAR, !(IC_TAR_SPECIAL));
+		break;
+	case ABRT_SBYTE_ACKDET:
+		dev_err(&adap->dev,
+			"START byte was acknowledged.\n");
+		break;
+	case ABRT_TXDATA_NOACK:
+		dev_err(&adap->dev,
+			"No acknowledge received from slave.\n");
+		break;
+	case ABRT_10ADDR2_NOACK:
+		dev_err(&adap->dev,
+	"The 2nd address byte of the 10-bit address not acknowledged.\n");
+		break;
+	case ABRT_10ADDR1_NOACK:
+		dev_dbg(&adap->dev,
+		"The 1st address byte of 10-bit address not acknowledged.\n");
+		break;
+	case ABRT_7B_ADDR_NOACK:
+		dev_err(&adap->dev,
+			"I2C slave device not acknowledge.\n");
+		break;
+	default:
+		;
+	}
+
+	/* Clear TX_ABRT bit */
+	mrst_i2c_read(i2c->base + IC_CLR_TX_ABRT);
+	i2c->status = STATUS_XFER_ABORT;
+}
+
+/**
+ * xfer_read - Internal function to implement master read transfer.
+ * @adap: i2c_adapter struct pointer
+ * @buf: buffer in i2c_msg
+ * @length: number of bytes to be read
+ *
+ * Return Values:
+ * 0		if the read transfer succeeds
+ * -ETIMEDOUT	if cannot read the "raw" interrupt register
+ * -EINVAL	if transfer abort occured
+ *
+ * For every byte, a "READ" command will be loaded into IC_DATA_CMD prior to
+ * data transfer. The actual "read" operation will be performed if the RX_FULL
+ * interrupt is occured.
+ *
+ * Note there may be two interrupt signals captured, one should read
+ * IC_RAW_INTR_STAT to seperate between errors and actual data.
+ */
+static int xfer_read(struct i2c_adapter *adap, unsigned char *buf, int length)
+{
+	struct mrst_i2c_private *i2c =
+	    (struct mrst_i2c_private *) i2c_get_adapdata(adap);
+	int i = length;
+	int err;
+
+	mrst_i2c_write(i2c->base + IC_INTR_MASK, 0x0044);
+	mrst_i2c_read(i2c->base + IC_CLR_INTR);
+
+	if (length >= 256) {
+		dev_err(&adap->dev,
+			"I2C FIFO can not support larger than 256 bytes\n");
+		return -EINVAL;
+	}
+
+	INIT_COMPLETION(i2c->complete);
+
+	while (i--)
+		mrst_i2c_write(i2c->base + IC_DATA_CMD, (uint16_t)0x100);
+
+	i2c->status = STATUS_READ_START;
+	err = wait_for_completion_interruptible_timeout(&i2c->complete, HZ);
+	if (!err) {
+		dev_err(&adap->dev, "Time out for ACK from I2C slave device\n");
+		mrst_i2c_hwinit(i2c);
+		return -ETIMEDOUT;
+	} else {
+		if (i2c->status == STATUS_READ_SUCCESS)
+			return 0;
+		else
+			return -EINVAL;
+	}
+}
+
+/**
+ * xfer_write - Internal function to implement master write transfer.
+ * @adap: i2c_adapter struct pointer
+ * @buf: buffer in i2c_msg
+ * @length: number of bytes to be read
+ *
+ * Return Values:
+ * 0	if the read transfer succeeds
+ * -ETIMEDOUT	if cannot read the "raw" interrupt register
+ * -EINVAL	if transfer abort occured
+ *
+ * For every byte, a "WRITE" command will be loaded into IC_DATA_CMD prior to
+ * data transfer. The actual "write" operation will be performed if the
+ * RX_FULL interrupt siganal is occured.
+ *
+ * Note there may be two interrupt signals captured, one should read
+ * IC_RAW_INTR_STAT to seperate between errors and actual data.
+ */
+static int xfer_write(struct i2c_adapter *adap,
+		      unsigned char *buf, int length)
+{
+	struct mrst_i2c_private *i2c = (struct mrst_i2c_private *)
+	    i2c_get_adapdata(adap);
+
+	int i, err;
+
+	mrst_i2c_write(i2c->base + IC_INTR_MASK, 0x0050);
+	mrst_i2c_read(i2c->base + IC_CLR_INTR);
+
+	if (length >= 256) {
+		dev_err(&adap->dev,
+			"I2C FIFO can not support larger than 256 bytes\n");
+		return -EINVAL;
+	}
+
+	INIT_COMPLETION(i2c->complete);
+	for (i = 0; i < length; i++)
+		mrst_i2c_write(i2c->base + IC_DATA_CMD,
+			       (uint16_t)(*(buf + i)));
+
+	i2c->status = STATUS_WRITE_START;
+	err = wait_for_completion_interruptible_timeout(&i2c->complete, HZ);
+	if (!err) {
+		dev_err(&adap->dev, "Time out for ACK from I2C slave device\n");
+		mrst_i2c_hwinit(i2c);
+		return -ETIMEDOUT;
+	} else {
+		if (i2c->status == STATUS_WRITE_SUCCESS)
+			return 0;
+		else
+			return -EINVAL;
+	}
+}
+
+static int mrst_i2c_setup(struct i2c_adapter *adap,  struct i2c_msg *pmsg)
+{
+	struct mrst_i2c_private *i2c =
+	    (struct mrst_i2c_private *)i2c_get_adapdata(adap);
+	int err;
+	u32 reg_val;
+	u32 bit_mask;
+	u32 mode;
+
+	/* Disable device first */
+	err = mrst_i2c_disable(adap);
+	if (err) {
+		dev_err(&adap->dev,
+			"Cannot disable i2c controller, timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	mode = (1 + i2c->speed) << 1;
+	/* set the speed mode */
+	reg_val = mrst_i2c_read(i2c->base + IC_CON);
+	if ((reg_val & 0x06) != mode) {
+		dev_dbg(&adap->dev, "set mode %d\n", i2c->speed);
+		mrst_i2c_write(i2c->base + IC_CON,
+			       (reg_val & (~0x6)) | mode);
+	}
+
+	reg_val = mrst_i2c_read(i2c->base + IC_CON);
+	/* use 7-bit addressing */
+	if (pmsg->flags & I2C_M_TEN) {
+		if ((reg_val & (1<<4)) != ADDR_10BIT) {
+			dev_dbg(&adap->dev, "set i2c 10 bit address mode\n");
+			mrst_i2c_write(i2c->base + IC_CON,
+				       reg_val | ADDR_10BIT);
+		}
+	} else {
+		if ((reg_val & (1<<4)) != 0x0) {
+			dev_dbg(&adap->dev, "set i2c 7 bit address mode\n");
+			mrst_i2c_write(i2c->base + IC_CON, reg_val & (~(1<<4)));
+		}
+	}
+	/* enable restart conditions */
+	reg_val = mrst_i2c_read(i2c->base + IC_CON);
+	if ((reg_val & (1<<5)) != 1<<5) {
+		dev_dbg(&adap->dev, "enable restart conditions\n");
+		mrst_i2c_write(i2c->base + IC_CON, (reg_val & (~(1 << 5)))
+			       | 1 << 5);
+	}
+
+	/* enable master FSM */
+	reg_val = mrst_i2c_read(i2c->base + IC_CON);
+	dev_dbg(&adap->dev, "ic_con reg_val is 0x%x\n", reg_val);
+	if ((reg_val & (1<<6)) != 1<<6) {
+		dev_dbg(&adap->dev, "enable master FSM\n");
+		mrst_i2c_write(i2c->base + IC_CON, (reg_val & (~(1 << 6)))
+			       | 1<<6);
+		dev_dbg(&adap->dev, "ic_con reg_val is 0x%x\n", reg_val);
+	}
+
+	/* use target address when initiating transfer */
+	reg_val = mrst_i2c_read(i2c->base + IC_TAR);
+	bit_mask = 1 << 11 | 1 << 10;
+
+	if ((reg_val & bit_mask) != 0x0) {
+		dev_dbg(&adap->dev,
+	 "WR: use target address when intiating transfer, i2c_tx_target\n");
+		mrst_i2c_write(i2c->base + IC_TAR, reg_val & ~bit_mask);
+	}
+
+	/* set target address to the I2C slave address */
+	dev_dbg(&adap->dev,
+		"set target address to the I2C slave address, addr is %x\n",
+			pmsg->addr);
+	mrst_i2c_write(i2c->base + IC_TAR, pmsg->addr
+		       | (pmsg->flags & I2C_M_TEN ? IC_TAR_10BIT_ADDR : 0));
+
+	/* Enable I2C controller */
+	mrst_i2c_write(i2c->base + IC_ENABLE, ENABLE);
+
+	return 0;
+}
+
+/**
+ * mrst_i2c_xfer - Main master transfer routine.
+ * @adap: i2c_adapter struct pointer
+ * @pmsg: i2c_msg struct pointer
+ * @num: number of i2c_msg
+ *
+ * Return Values:
+ * +		number of messages transfered
+ * -ETIMEDOUT	If cannot disable I2C controller or read IC_STATUS
+ * -EINVAL	If the address in i2c_msg is invalid
+ *
+ * This function will be registered in i2c-core and exposed to external
+ * I2C clients.
+ * 1. Disable I2C controller
+ * 2. Unmask three interrupts: RX_FULL, TX_EMPTY, TX_ABRT
+ * 3. Check if address in i2c_msg is valid
+ * 4. Enable I2C controller
+ * 5. Perform real transfer (call xfer_read or xfer_write)
+ * 6. Wait until the current transfer is finished(check bus state)
+ * 7. Mask and clear all interrupts
+ */
+static int mrst_i2c_xfer(struct i2c_adapter *adap,
+			 struct i2c_msg *pmsg,
+			 int num)
+{
+	struct mrst_i2c_private *i2c =
+	    (struct mrst_i2c_private *)i2c_get_adapdata(adap);
+	int i, err;
+
+	mutex_lock(&i2c->lock);
+	dev_dbg(&adap->dev, "mrst_i2c_xfer, process %d msg(s)\n", num);
+	dev_dbg(&adap->dev, KERN_INFO "slave address is %x\n", pmsg->addr);
+
+	if (i2c->pm_state == STANDBY) {
+		dev_err(&adap->dev, "Adapter %d in standby\n", adap->nr);
+		mutex_unlock(&i2c->lock);
+		return -1;
+	}
+
+	/* if number of messages equal 0*/
+	if (num == 0) {
+		mutex_unlock(&i2c->lock);
+		return 0;
+	}
+
+	/* Checked the sanity of passed messages. */
+	if (unlikely(mrst_i2c_invalid_address(&pmsg[0]))) {
+		dev_err(&adap->dev, "Invalid address 0x%03x (%d-bit)\n",
+			pmsg[0].addr, pmsg[0].flags & I2C_M_TEN ? 10 : 7);
+		mutex_unlock(&i2c->lock);
+		return -EINVAL;
+	}
+	for (i = 0; i < num; i++) {
+		/* Message address equal? */
+		if (unlikely(mrst_i2c_address_neq(&pmsg[0], &pmsg[i]))) {
+			dev_err(&adap->dev, "Invalid address in msg[%d]\n", i);
+			mutex_unlock(&i2c->lock);
+			return -EINVAL;
+		}
+	}
+
+	if (mrst_i2c_setup(adap, pmsg)) {
+		mutex_unlock(&i2c->lock);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num; i++) {
+		dev_dbg(&adap->dev, " #%d: %sing %d byte%s %s 0x%02x\n", i,
+			pmsg->flags & I2C_M_RD ? "read" : "writ",
+			pmsg->len, pmsg->len > 1 ? "s" : "",
+			pmsg->flags & I2C_M_RD ? "from" : "to",	pmsg->addr);
+
+
+		i2c->msg = pmsg;
+		i2c->status = STATUS_IDLE;
+		/* Read or Write */
+		if (pmsg->len && pmsg->buf) {
+			if (pmsg->flags & I2C_M_RD) {
+				dev_dbg(&adap->dev, "I2C_M_RD\n");
+				err = xfer_read(adap, pmsg->buf, pmsg->len);
+			} else {
+				dev_dbg(&adap->dev, "I2C_M_WR\n");
+				err = xfer_write(adap, pmsg->buf, pmsg->len);
+			}
+			if (err < 0)
+				goto err_1;
+		}
+		dev_dbg(&adap->dev, "msg[%d] transfer complete\n", i);
+		pmsg++;		/* next message */
+	}
+	goto exit;
+
+err_1:
+	i = err;
+exit:
+	/* Mask interrupts */
+	mrst_i2c_write(i2c->base + IC_INTR_MASK, 0x0000);
+	/* Clear all interrupts */
+	mrst_i2c_read(i2c->base + IC_CLR_INTR);
+
+	mutex_unlock(&i2c->lock);
+
+	return i;
+}
+
+static int mrst_i2c_suspend(struct pci_dev *dev, pm_message_t mesg)
+{
+	struct mrst_i2c_private *i2c =
+	    (struct mrst_i2c_private *)pci_get_drvdata(dev);
+	struct i2c_adapter *adap = i2c->adap;
+	int err = 0;
+	adap = adap;
+	/* Doing nothing now */
+
+	return err;
+}
+
+static int mrst_i2c_resume(struct pci_dev *dev)
+{
+	struct mrst_i2c_private *i2c =
+	    (struct mrst_i2c_private *)pci_get_drvdata(dev);
+	struct i2c_adapter *adap = i2c->adap;
+	int err = 0;
+	adap = adap;
+
+	/* Doing nothing now */
+
+	return err;
+}
+
+static void i2c_isr_read(struct mrst_i2c_private *i2c)
+{
+	struct i2c_msg *msg = i2c->msg;
+	int rx_num;
+	u32 len;
+	u8 *buf;
+
+	if (!(msg->flags & I2C_M_RD))
+		return;
+
+	if (i2c->status != STATUS_READ_IN_PROGRESS) {
+		len = msg->len;
+		buf = msg->buf;
+	} else {
+		len = i2c->rx_buf_len;
+		buf = i2c->rx_buf;
+	}
+
+	rx_num = mrst_i2c_read(i2c->base + IC_RXFLR);
+
+	for (; len > 0 && rx_num > 0; len--, rx_num--)
+		*buf++ = mrst_i2c_read(i2c->base + IC_DATA_CMD);
+
+	if (len > 0) {
+		i2c->status = STATUS_READ_IN_PROGRESS;
+		i2c->rx_buf_len = len;
+		i2c->rx_buf = buf;
+	} else
+		i2c->status = STATUS_READ_SUCCESS;
+
+	return;
+}
+
+static irqreturn_t mrst_i2c_isr(int this_irq, void *dev)
+{
+	struct mrst_i2c_private *i2c = dev;
+	u32 stat = mrst_i2c_read(i2c->base + IC_INTR_STAT) & 0x54;
+
+	dev_dbg(&i2c->adap->dev, "%s, stat = 0x%x\n", __func__, stat);
+
+	if ((i2c->status != STATUS_WRITE_START) &&
+	    (i2c->status != STATUS_READ_START) &&
+	    (i2c->status != STATUS_READ_IN_PROGRESS))
+		goto err;
+
+	if (stat & TX_ABRT)
+		i2c->abort = mrst_i2c_read(i2c->base + IC_TX_ABRT_SOURCE);
+
+	mrst_i2c_read(i2c->base + IC_CLR_INTR);
+
+	if (stat & TX_ABRT) {
+		mrst_i2c_abort(i2c);
+		goto exit;
+	}
+
+	if (stat & RX_FULL) {
+		i2c_isr_read(i2c);
+		goto exit;
+	}
+
+	if (stat & TX_EMPTY) {
+		if (mrst_i2c_read(i2c->base + IC_STATUS) & 0x4)
+			i2c->status = STATUS_WRITE_SUCCESS;
+	}
+
+exit:
+	if ((i2c->status == STATUS_READ_SUCCESS) ||
+	   (i2c->status == STATUS_WRITE_SUCCESS) ||
+	   (i2c->status == STATUS_XFER_ABORT))
+		complete(&i2c->complete);
+err:
+	return IRQ_HANDLED;
+}
+
+static struct pci_device_id mrst_i2c_ids[] = {
+	/* Moorestown */
+	{PCI_VDEVICE(INTEL, 0x0802), 0 },
+	{PCI_VDEVICE(INTEL, 0x0803), 1 },
+	{PCI_VDEVICE(INTEL, 0x0804), 2 },
+	/* Medfield */
+	{PCI_VDEVICE(INTEL, 0x0817), 3,},
+	{PCI_VDEVICE(INTEL, 0x0818), 4 },
+	{PCI_VDEVICE(INTEL, 0x0819), 5 },
+	{PCI_VDEVICE(INTEL, 0x082C), 0 },
+	{PCI_VDEVICE(INTEL, 0x082D), 1 },
+	{PCI_VDEVICE(INTEL, 0x082E), 2 },
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, mrst_i2c_ids);
+
+static struct i2c_algorithm mrst_i2c_algorithm = {
+	.master_xfer	= mrst_i2c_xfer,
+	.functionality	= mrst_i2c_func,
+};
+
+static struct pci_driver mrst_i2c_driver = {
+	.name		= "mrst_i2c",
+	.id_table	= mrst_i2c_ids,
+	.probe		= mrst_i2c_probe,
+	.remove		= __devexit_p(mrst_i2c_remove),
+	.suspend	= mrst_i2c_suspend,
+	.resume		= mrst_i2c_resume,
+};
+
+/**
+ * mrst_i2c_probe - I2C controller initialization routine
+ * @dev: pci device
+ * @id: device id
+ *
+ * Return Values:
+ * 0		success
+ * -ENODEV	If cannot allocate pci resource
+ * -ENOMEM	If the register base remapping failed, or
+ *		if kzalloc failed
+ *
+ * Initialization steps:
+ * 1. Request for PCI resource
+ * 2. Remap the start address of PCI resource to register base
+ * 3. Request for device memory region
+ * 4. Fill in the struct members of mrst_i2c_private
+ * 5. Call mrst_i2c_hwinit() for hardware initialization
+ * 6. Register I2C adapter in i2c-core
+ */
+static int __devinit mrst_i2c_probe(struct pci_dev *dev,
+				    const struct pci_device_id *id)
+{
+	struct mrst_i2c_private *mrst;
+	struct i2c_adapter *adap;
+	unsigned int start, len;
+	int err, busnum = 0;
+	void __iomem *base = NULL;
+
+	dev_dbg(&dev->dev, "Get into probe function for I2C\n");
+	err = pci_enable_device(dev);
+	if (err) {
+		dev_err(&dev->dev, "Failed to enable I2C PCI device (%d)\n",
+			err);
+		goto exit;
+	}
+
+	/* Determine the address of the I2C area */
+	start = pci_resource_start(dev, DEF_BAR);
+	len = pci_resource_len(dev, DEF_BAR);
+	if (!start || len <= 0) {
+		dev_err(&dev->dev, "Base address initialization failed\n");
+		err = -ENODEV;
+		goto exit;
+	}
+	dev_dbg(&dev->dev, "%s i2c resource start %x, len=%d\n",
+		PLATFORM, start, len);
+	err = pci_request_region(dev, DEF_BAR, mrst_i2c_driver.name);
+	if (err) {
+		dev_err(&dev->dev, "Failed to request I2C region "
+			"0x%1x-0x%Lx\n", start,
+			(unsigned long long)pci_resource_end(dev, DEF_BAR));
+		goto exit;
+	}
+
+	base = ioremap_nocache(start, len);
+	if (!base) {
+		dev_err(&dev->dev, "I/O memory remapping failed\n");
+		err = -ENOMEM;
+		goto fail0;
+	}
+
+	/* Allocate the per-device data structure, mrst_i2c_private */
+	mrst = kzalloc(sizeof(struct mrst_i2c_private), GFP_KERNEL);
+	if (mrst == NULL) {
+		dev_err(&dev->dev, "Can't allocate interface\n");
+		err = -ENOMEM;
+		goto fail1;
+	}
+
+	adap = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
+	if (adap == NULL) {
+		dev_err(&dev->dev, "Can't allocate interface\n");
+		err = -ENOMEM;
+		goto fail2;
+	}
+
+	/* Initialize struct members */
+	snprintf(adap->name, sizeof(adap->name), "mrst_i2c");
+	adap->owner = THIS_MODULE;
+	adap->algo = &mrst_i2c_algorithm;
+	adap->class = I2C_CLASS_HWMON;
+	adap->dev.parent = &dev->dev;
+	mrst->adap = adap;
+	mrst->base = base;
+	mrst->speed = STANDARD;
+	mrst->pm_state = ACTIVE;
+	mrst->abort = 0;
+	mrst->rx_buf_len = 0;
+	mrst->status = STATUS_IDLE;
+
+	pci_set_drvdata(dev, mrst);
+	i2c_set_adapdata(adap, mrst);
+
+	adap->nr = busnum = id->driver_data;
+	if (dev->device <= 0x0804)
+		mrst->platform = MOORESTOWN;
+	else
+		mrst->platform = MEDFIELD;
+
+	dev_dbg(&dev->dev, "I2C%d\n", busnum);
+
+	if (ctl_num > busnum) {
+		if (speed_mode[busnum] < 0 || speed_mode[busnum] >= NUM_SPEEDS)
+			dev_warn(&dev->dev, "Invalid speed %d ignored.\n",
+							speed_mode[busnum]);
+		else
+			mrst->speed = speed_mode[busnum];
+	}
+
+	/* Initialize i2c controller */
+	err = mrst_i2c_hwinit(mrst);
+	if (err < 0) {
+		dev_err(&dev->dev, "I2C interface initialization failed\n");
+		goto fail3;
+	}
+
+	mutex_init(&mrst->lock);
+	init_completion(&mrst->complete);
+	err = request_irq(dev->irq, mrst_i2c_isr, IRQF_DISABLED,
+			  adap->name, mrst);
+	if (err) {
+		dev_err(&dev->dev, "Failed to request IRQ for I2C controller: "
+			"%s", adap->name);
+		goto fail3;
+	}
+	/* Clear all interrupts */
+	mrst_i2c_read(mrst->base + IC_CLR_INTR);
+	mrst_i2c_write(mrst->base + IC_INTR_MASK, 0x0000);
+
+	/* Adapter registration */
+	err = i2c_add_numbered_adapter(adap);
+	if (err) {
+		dev_err(&dev->dev, "Adapter %s registration failed\n",
+			adap->name);
+		goto fail4;
+	}
+
+	dev_err(&dev->dev, "%s I2C bus %d driver bind success.\n",
+		(mrst->platform == MOORESTOWN) ? "Moorestown" : "Medfield",
+		busnum);
+	return 0;
+
+fail4:
+	free_irq(dev->irq, mrst);
+fail3:
+	i2c_set_adapdata(adap, NULL);
+	pci_set_drvdata(dev, NULL);
+	kfree(adap);
+fail2:
+	kfree(mrst);
+fail1:
+	iounmap(base);
+fail0:
+	pci_release_region(dev, DEF_BAR);
+exit:
+	return err;
+}
+
+static void __devexit mrst_i2c_remove(struct pci_dev *dev)
+{
+	struct mrst_i2c_private *mrst = (struct mrst_i2c_private *)
+					pci_get_drvdata(dev);
+	mrst_i2c_disable(mrst->adap);
+	if (i2c_del_adapter(mrst->adap))
+		dev_err(&dev->dev, "Failed to delete i2c adapter");
+
+	free_irq(dev->irq, mrst);
+	pci_set_drvdata(dev, NULL);
+	iounmap(mrst->base);
+	kfree(mrst);
+	pci_release_region(dev, DEF_BAR);
+}
+
+static int __init mrst_i2c_init(void)
+{
+	printk(KERN_NOTICE "%s I2C driver %s\n", PLATFORM, VERSION);
+	return pci_register_driver(&mrst_i2c_driver);
+}
+
+static void __exit mrst_i2c_exit(void)
+{
+	pci_unregister_driver(&mrst_i2c_driver);
+}
+
+module_init(mrst_i2c_init);
+module_exit(mrst_i2c_exit);
+
+MODULE_AUTHOR("Ba Zheng <zheng.ba-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("I2C driver for Moorestown Platform");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(VERSION);
diff --git a/drivers/i2c/busses/i2c-mrst.h b/drivers/i2c/busses/i2c-mrst.h
new file mode 100644
index 0000000..b0e4951
--- /dev/null
+++ b/drivers/i2c/busses/i2c-mrst.h
@@ -0,0 +1,269 @@
+#ifndef __I2C_MFLD_H
+#define __I2C_MFLD_H
+
+#include <linux/i2c.h>
+
+/* PCI config table macros */
+/* Offests */
+#define I2C_INFO_TABLE_LENGTH		4
+#define I2C_INFO_DEV_BLOCK		10
+#define I2C_DEV_ADDR			2
+#define I2C_DEV_IRQ			4
+#define I2C_DEV_NAME			6
+#define I2C_DEV_INFO			22
+/* Length */
+#define HEAD_LENGTH			10
+#define BLOCK_LENGTH			32
+#define ADDR_LENGTH			2
+#define IRQ_LENGTH			2
+#define NAME_LENGTH			16
+#define INFO_LENGTH			10
+
+enum platform_enum {
+	MOORESTOWN,
+	MEDFIELD,
+};
+
+struct mrst_i2c_private {
+	struct i2c_adapter *adap;
+	/* Register base address */
+	void __iomem *base;
+	/* Speed mode */
+	int speed;
+	int pm_state;
+	struct completion complete;
+	int abort;
+	u8 *rx_buf;
+	int rx_buf_len;
+	int status;
+	struct i2c_msg *msg;
+	enum platform_enum platform;
+	struct mutex	lock;
+	spinlock_t	slock;
+};
+
+#define ACTIVE		0
+#define STANDBY		1
+
+#define STATUS_IDLE		0
+#define STATUS_READ_START	1
+#define STATUS_READ_IN_PROGRESS	2
+#define STATUS_READ_SUCCESS	3
+#define STATUS_WRITE_START	4
+#define STATUS_WRITE_SUCCESS	5
+#define STATUS_XFER_ABORT	6
+/* Control register */
+#define IC_CON			0x00
+#define SLV_DIS			(1 << 6)	/* Disable slave mode */
+#define RESTART			(1 << 5)	/* Send a Restart condition */
+#define	ADDR_10BIT		(1 << 4)	/* 10-bit addressing */
+#define	STANDARD_MODE		(1 << 1)	/* standard mode */
+#define FAST_MODE		(2 << 1)	/* fast mode */
+#define HIGH_MODE		(3 << 1)	/* high speed mode */
+#define	MASTER_EN		(1 << 0)	/* Master mode */
+
+/* Target address register */
+#define IC_TAR			0x04
+#define IC_TAR_10BIT_ADDR	(1 << 12)	/* 10-bit addressing */
+#define IC_TAR_SPECIAL		(1 << 11)	/* Perform special I2C cmd */
+#define IC_TAR_GC_OR_START	(1 << 10)	/* 0: Gerneral Call Address */
+						/* 1: START BYTE */
+
+/* Slave Address Register */
+#define IC_SAR			0x08		/* Not used in Master mode */
+
+/* High Speed Master Mode Code Address Register */
+#define IC_HS_MADDR		0x0c
+
+/* Rx/Tx Data Buffer and Command Register */
+#define IC_DATA_CMD		0x10
+#define IC_RD			(1 << 8)	/* 1: Read 0: Write */
+
+/* Standard Speed Clock SCL High Count Register */
+#define IC_SS_SCL_HCNT		0x14
+
+/* Standard Speed Clock SCL Low Count Register */
+#define IC_SS_SCL_LCNT		0x18
+
+/* Fast Speed Clock SCL High Count Register */
+#define IC_FS_SCL_HCNT		0x1c
+
+/* Fast Spedd Clock SCL Low Count Register */
+#define IC_FS_SCL_LCNT		0x20
+
+/* High Speed Clock SCL High Count Register */
+#define IC_HS_SCL_HCNT		0x24
+
+/* High Speed Clock SCL Low Count Register */
+#define IC_HS_SCL_LCNT		0x28
+
+/* Interrupt Status Register */
+#define IC_INTR_STAT		0x2c		/* Read only */
+#define R_GEN_CALL		(1 << 11)
+#define R_START_DET		(1 << 10)
+#define R_STOP_DET		(1 << 9)
+#define R_ACTIVITY		(1 << 8)
+#define R_RX_DONE		(1 << 7)
+#define	R_TX_ABRT		(1 << 6)
+#define R_RD_REQ		(1 << 5)
+#define R_TX_EMPTY		(1 << 4)
+#define R_TX_OVER		(1 << 3)
+#define	R_RX_FULL		(1 << 2)
+#define	R_RX_OVER		(1 << 1)
+#define R_RX_UNDER		(1 << 0)
+
+/* Interrupt Mask Register */
+#define IC_INTR_MASK		0x30		/* Read and Write */
+#define M_GEN_CALL		(1 << 11)
+#define M_START_DET		(1 << 10)
+#define M_STOP_DET		(1 << 9)
+#define M_ACTIVITY		(1 << 8)
+#define M_RX_DONE		(1 << 7)
+#define	M_TX_ABRT		(1 << 6)
+#define M_RD_REQ		(1 << 5)
+#define M_TX_EMPTY		(1 << 4)
+#define M_TX_OVER		(1 << 3)
+#define	M_RX_FULL		(1 << 2)
+#define	M_RX_OVER		(1 << 1)
+#define M_RX_UNDER		(1 << 0)
+
+/* Raw Interrupt Status Register */
+#define IC_RAW_INTR_STAT	0x34		/* Read Only */
+#define GEN_CALL		(1 << 11)	/* General call */
+#define START_DET		(1 << 10)	/* (RE)START occured */
+#define STOP_DET		(1 << 9)	/* STOP occured */
+#define ACTIVITY		(1 << 8)	/* Bus busy */
+#define RX_DONE			(1 << 7)	/* Not used in Master mode */
+#define	TX_ABRT			(1 << 6)	/* Transmit Abort */
+#define RD_REQ			(1 << 5)	/* Not used in Master mode */
+#define TX_EMPTY		(1 << 4)	/* TX FIFO <= threshold */
+#define TX_OVER			(1 << 3)	/* TX FIFO overflow */
+#define	RX_FULL			(1 << 2)	/* RX FIFO >= threshold */
+#define	RX_OVER			(1 << 1)	/* RX FIFO overflow */
+#define RX_UNDER		(1 << 0)	/* RX FIFO empty */
+
+/* Receive FIFO Threshold Register */
+#define IC_RX_TL		0x38
+
+/* Transmit FIFO Treshold Register */
+#define IC_TX_TL		0x3c
+
+/* Clear Combined and Individual Interrupt Register */
+#define IC_CLR_INTR		0x40
+#define CLR_INTR		(1 << 0)
+
+/* Clear RX_UNDER Interrupt Register */
+#define IC_CLR_RX_UNDER		0x44
+#define CLR_RX_UNDER		(1 << 0)
+
+/* Clear RX_OVER Interrupt Register */
+#define IC_CLR_RX_OVER		0x48
+#define CLR_RX_OVER		(1 << 0)
+
+/* Clear TX_OVER Interrupt Register */
+#define IC_CLR_TX_OVER		0x4c
+#define CLR_TX_OVER		(1 << 0)
+
+#define IC_CLR_RD_REQ		0x50
+
+/* Clear TX_ABRT Interrupt Register */
+#define IC_CLR_TX_ABRT		0x54
+#define CLR_TX_ABRT		(1 << 0)
+
+#define IC_CLR_RX_DONE		0x58
+
+
+/* Clear ACTIVITY Interrupt Register */
+#define IC_CLR_ACTIVITY		0x5c
+#define CLR_ACTIVITY		(1 << 0)
+
+/* Clear STOP_DET Interrupt Register */
+#define IC_CLR_STOP_DET		0x60
+#define CLR_STOP_DET		(1 << 0)
+
+/* Clear START_DET Interrupt Register */
+#define IC_CLR_START_DET	0x64
+#define CLR_START_DET		(1 << 0)
+
+/* Clear GEN_CALL Interrupt Register */
+#define IC_CLR_GEN_CALL		0x68
+#define CLR_GEN_CALL		(1 << 0)
+
+/* Enable Register */
+#define IC_ENABLE		0x6c
+#define ENABLE			(1 << 0)
+
+/* Status Register */
+#define IC_STATUS		0x70		/* Read Only */
+#define STAT_SLV_ACTIVITY	(1 << 6)	/* Slave not in idle */
+#define STAT_MST_ACTIVITY	(1 << 5)	/* Master not in idle */
+#define STAT_RFF		(1 << 4)	/* RX FIFO Full */
+#define STAT_RFNE		(1 << 3)	/* RX FIFO Not Empty */
+#define STAT_TFE		(1 << 2)	/* TX FIFO Empty */
+#define STAT_TFNF		(1 << 1)	/* TX FIFO Not Full */
+#define STAT_ACTIVITY		(1 << 0)	/* Activity Status */
+
+/* Transmit FIFO Level Register */
+#define IC_TXFLR		0x74		/* Read Only */
+#define TXFLR			(1 << 0)	/* TX FIFO level */
+
+/* Receive FIFO Level Register */
+#define IC_RXFLR		0x78		/* Read Only */
+#define RXFLR			(1 << 0)	/* RX FIFO level */
+
+/* Transmit Abort Source Register */
+#define IC_TX_ABRT_SOURCE	0x80
+#define ABRT_SLVRD_INTX		(1 << 15)
+#define ABRT_SLV_ARBLOST	(1 << 14)
+#define ABRT_SLVFLUSH_TXFIFO	(1 << 13)
+#define	ARB_LOST		(1 << 12)
+#define ABRT_MASTER_DIS		(1 << 11)
+#define ABRT_10B_RD_NORSTRT	(1 << 10)
+#define ABRT_SBYTE_NORSTRT	(1 << 9)
+#define ABRT_HS_NORSTRT		(1 << 8)
+#define ABRT_SBYTE_ACKDET	(1 << 7)
+#define ABRT_HS_ACKDET		(1 << 6)
+#define ABRT_GCALL_READ		(1 << 5)
+#define ABRT_GCALL_NOACK	(1 << 4)
+#define ABRT_TXDATA_NOACK	(1 << 3)
+#define ABRT_10ADDR2_NOACK	(1 << 2)
+#define ABRT_10ADDR1_NOACK	(1 << 1)
+#define ABRT_7B_ADDR_NOACK	(1 << 0)
+
+/* Enable Status Register */
+#define IC_ENABLE_STATUS	0x9c
+#define IC_EN			(1 << 0)	/* I2C in an enabled state */
+
+/* Component Parameter Register 1*/
+#define IC_COMP_PARAM_1		0xf4
+#define APB_DATA_WIDTH		(0x3 << 0)
+
+/* added by xiaolin --begin */
+#define SS_MIN_SCL_HIGH         4000
+#define SS_MIN_SCL_LOW          4700
+#define FS_MIN_SCL_HIGH         600
+#define FS_MIN_SCL_LOW          1300
+#define HS_MIN_SCL_HIGH_100PF   60
+#define HS_MIN_SCL_LOW_100PF    120
+
+/* Function declarations */
+
+static int mrst_i2c_disable(struct i2c_adapter *);
+static int mrst_i2c_hwinit(struct mrst_i2c_private *);
+static u32 mrst_i2c_func(struct i2c_adapter *);
+static inline int mrst_i2c_invalid_address(const struct i2c_msg *);
+static inline int mrst_i2c_address_neq(const struct i2c_msg *,
+				       const struct i2c_msg *);
+static int mrst_i2c_xfer(struct i2c_adapter *,
+			 struct i2c_msg *,
+			 int);
+static int __devinit mrst_i2c_probe(struct pci_dev *,
+				    const struct pci_device_id *);
+static void __devexit mrst_i2c_remove(struct pci_dev *);
+static int __init mrst_i2c_init(void);
+static void __exit mrst_i2c_exit(void);
+static int xfer_read(struct i2c_adapter *,
+		     unsigned char *, int);
+static int xfer_write(struct i2c_adapter *,
+		      unsigned char *, int);
+#endif /* __I2C_MFLD_H */
