From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] I2C driver supporting Moorestown and Medfield platform
Date: Mon, 19 Jul 2010 16:45:05 +0100
Message-ID: <20100719154505.32024.86252.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Wen Wang <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Initial release of the driver.

Major clean up by Alan Cox. This fixes the points raised in the initial
review except that

- some were no longer relevant
- speed is left 0/1/2 as specifying exact frequencies uses more command line
  and makes it more complex for the user and for us - as we'd need to refuse
  anything but the tested/verified speeds anyway
- the disable function doesn't do a totally time based delay - its ten times
  the speed udelay so its clearly bounded anyway

Signed-off-by: Wen Wang <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 drivers/i2c/busses/Kconfig    |    9 
 drivers/i2c/busses/Makefile   |    1 
 drivers/i2c/busses/i2c-mrst.c | 1045 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1055 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-mrst.c


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
index 0000000..862b4c2
--- /dev/null
+++ b/drivers/i2c/busses/i2c-mrst.c
@@ -0,0 +1,1045 @@
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
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#define DRIVER_NAME	"mrst_i2c"
+#define VERSION		"Version 0.5"
+#define PLATFORM	"Moorestown/Medfield"
+
+#define NUM_PLATFORMS		2
+/* Tables use: 0 Moorestown, 1 Medfield */
+
+enum platform_enum {
+	MOORESTOWN = 0,
+	MEDFIELD = 1,
+};
+
+struct mrst_i2c_private {
+	struct i2c_adapter adap;
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
+	struct mutex lock;
+	spinlock_t slock;
+};
+
+#define ACTIVE			0
+#define STANDBY			1
+
+#define STATUS_IDLE		0
+#define STATUS_READ_START	1
+#define STATUS_READ_IN_PROGRESS	2
+#define STATUS_READ_SUCCESS	3
+#define STATUS_WRITE_START	4
+#define STATUS_WRITE_SUCCESS	5
+#define STATUS_XFER_ABORT	6
+
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
+#define IC_CLR_RX_DONE		0x58
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
+
+#define STANDARD		0
+#define FAST			1
+#define HIGH			2
+	
+#define NUM_SPEEDS		3
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
+
+static int ctl_num;
+module_param_array(speed_mode, int, &ctl_num, S_IRUGO);
+MODULE_PARM_DESC(speed_mode, "Set the speed of the i2c interface (0-2)");
+
+static inline u32 mrst_i2c_read(void __iomem *reg)
+{
+	return __raw_readl(reg);
+}
+
+static inline void mrst_i2c_write(void __iomem *reg, u32 val)
+{
+	__raw_writel(val, reg);
+}
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
+	struct mrst_i2c_private *i2c = i2c_get_adapdata(adap);
+	int err = 0;
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
+		if (count++ > 10) {
+			err = -ETIMEDOUT;
+			break;
+		}
+	}
+
+	/* Clear all interrupts */
+	mrst_i2c_read(i2c->base + IC_CLR_INTR);
+	/* Disable all interupts */
+	mrst_i2c_write(i2c->base + IC_INTR_MASK, 0x0000);
+
+	return err;
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
+	int err;
+
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
+	err = mrst_i2c_disable(&i2c->adap);
+	if (err)
+		return err;
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
+	return 0;
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
+ * mrst_i2c_address_neq - To check if the addresses for different i2c messages
+ * are equal.
+ * @p1: first i2c_msg
+ * @p2: second i2c_msg
+ *
+ * Return Values:
+ * 0	 if addresses are equal
+ * 1	 if not equal
+ *
+ * Within a single transfer, I2C client may need to send its address more
+ * than one time. So a check if the addresses match  is needed.
+ */
+static inline int mrst_i2c_address_neq(const struct i2c_msg *p1,
+				       const struct i2c_msg *p2)
+{
+	if (p1->addr != p2->addr)
+		return 1;
+	if ((p1->flags ^ p2->flags) & I2C_M_TEN)
+		return 1;
+	return 0;
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
+	struct i2c_adapter *adap = &i2c->adap;
+
+	/* Single transfer error check:
+	 * According to databook, TX/RX FIFOs would be flushed when
+	 * the abort interrupt occured.
+	 */
+	if (abort & ABRT_MASTER_DIS)
+		dev_err(&adap->dev,
+		"initiate master operation with master mode disabled.\n");
+	if (abort & ABRT_10B_RD_NORSTRT)
+		dev_err(&adap->dev,
+	"RESTART disabled and master sent READ cmd in 10-bit addressing.\n");
+	if (abort & ABRT_SBYTE_NORSTRT) {
+		dev_err(&adap->dev,
+		"RESTART disabled and user is trying to send START byte.\n");
+		mrst_i2c_write(i2c->base + IC_TX_ABRT_SOURCE,
+			       ~ABRT_SBYTE_NORSTRT);
+		mrst_i2c_write(i2c->base + IC_CON, RESTART);
+		mrst_i2c_write(i2c->base + IC_TAR, ~IC_TAR_SPECIAL);
+	}
+
+	if (abort & ABRT_SBYTE_ACKDET)
+		dev_err(&adap->dev,
+			"START byte was acknowledged.\n");
+	if (abort & ABRT_TXDATA_NOACK)
+		dev_err(&adap->dev,
+			"No acknowledgement received from slave.\n");
+	if (abort & ABRT_10ADDR2_NOACK)
+		dev_dbg(&adap->dev,
+	"The 2nd address byte of the 10-bit address was not acknowledged.\n");
+	if (abort & ABRT_10ADDR1_NOACK)
+		dev_dbg(&adap->dev,
+	"The 1st address byte of 10-bit address was not acknowledged.\n");
+	if (abort & ABRT_7B_ADDR_NOACK)
+		dev_dbg(&adap->dev,
+			"I2C slave device not acknowledged.\n");
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
+ * interrupt is occurred.
+ *
+ * Note there may be two interrupt signals captured, one should read
+ * IC_RAW_INTR_STAT to seperate between errors and actual data.
+ */
+static int xfer_read(struct i2c_adapter *adap, unsigned char *buf, int length)
+{
+	struct mrst_i2c_private *i2c = i2c_get_adapdata(adap);
+	int i = length;
+	int err;
+
+	mrst_i2c_write(i2c->base + IC_INTR_MASK, 0x0044);
+	mrst_i2c_read(i2c->base + IC_CLR_INTR);
+
+	if (length >= 256) {
+		dev_err(&adap->dev,
+			"I2C FIFO cannot support larger than 256 bytes\n");
+		return -EMSGSIZE;
+	}
+
+	INIT_COMPLETION(i2c->complete);
+
+	while (i--)
+		mrst_i2c_write(i2c->base + IC_DATA_CMD, IC_RD);
+
+	i2c->status = STATUS_READ_START;
+	err = wait_for_completion_interruptible_timeout(&i2c->complete, HZ);
+	if (!err) {
+		dev_err(&adap->dev, "Timeout for ACK from I2C slave device\n");
+		mrst_i2c_hwinit(i2c);
+		return -ETIMEDOUT;
+	} else {
+		if (i2c->status == STATUS_READ_SUCCESS)
+			return 0;
+		else
+			return -EIO;
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
+ * data transfer. The actual "write" operation will be performed when the
+ * RX_FULL interrupt signal occurs.
+ *
+ * Note there may be two interrupt signals captured, one should read
+ * IC_RAW_INTR_STAT to separate between errors and actual data.
+ */
+static int xfer_write(struct i2c_adapter *adap,
+		      unsigned char *buf, int length)
+{
+	struct mrst_i2c_private *i2c = i2c_get_adapdata(adap);
+	int i, err;
+
+	mrst_i2c_write(i2c->base + IC_INTR_MASK, 0x0050);
+	mrst_i2c_read(i2c->base + IC_CLR_INTR);
+
+	if (length >= 256) {
+		dev_err(&adap->dev,
+			"I2C FIFO cannot support larger than 256 bytes\n");
+		return -EMSGSIZE;
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
+		dev_err(&adap->dev, "Timeout for ACK from I2C slave device\n");
+		mrst_i2c_hwinit(i2c);
+		return -ETIMEDOUT;
+	} else {
+		if (i2c->status == STATUS_WRITE_SUCCESS)
+			return 0;
+		else
+			return -EIO;
+	}
+}
+
+static int mrst_i2c_setup(struct i2c_adapter *adap,  struct i2c_msg *pmsg)
+{
+	struct mrst_i2c_private *i2c = i2c_get_adapdata(adap);
+	int err;
+	u32 reg;
+	u32 bit_mask;
+	u32 mode;
+
+	/* Disable device first */
+	err = mrst_i2c_disable(adap);
+	if (err) {
+		dev_err(&adap->dev,
+			"Cannot disable i2c controller, timeout\n");
+		return err;
+	}
+
+	mode = (1 + i2c->speed) << 1;
+	/* set the speed mode */
+	reg = mrst_i2c_read(i2c->base + IC_CON);
+	if ((reg & 0x06) != mode) {
+		dev_dbg(&adap->dev, "set mode %d\n", i2c->speed);
+		mrst_i2c_write(i2c->base + IC_CON,
+			       (reg & (~0x6)) | mode);
+	}
+
+	reg = mrst_i2c_read(i2c->base + IC_CON);
+	/* use 7-bit addressing */
+	if (pmsg->flags & I2C_M_TEN) {
+		if ((reg & (1<<4)) != ADDR_10BIT) {
+			dev_dbg(&adap->dev, "set i2c 10 bit address mode\n");
+			mrst_i2c_write(i2c->base + IC_CON,
+				       reg | ADDR_10BIT);
+		}
+	} else {
+		if ((reg & (1<<4)) != 0x0) {
+			dev_dbg(&adap->dev, "set i2c 7 bit address mode\n");
+			mrst_i2c_write(i2c->base + IC_CON, reg & (~(1<<4)));
+		}
+	}
+	/* enable restart conditions */
+	reg = mrst_i2c_read(i2c->base + IC_CON);
+	if ((reg & (1<<5)) != 1<<5) {
+		dev_dbg(&adap->dev, "enable restart conditions\n");
+		mrst_i2c_write(i2c->base + IC_CON, (reg & (~(1 << 5)))
+			       | 1 << 5);
+	}
+
+	/* enable master FSM */
+	reg = mrst_i2c_read(i2c->base + IC_CON);
+	dev_dbg(&adap->dev, "ic_con reg is 0x%x\n", reg);
+	if ((reg & (1<<6)) != 1<<6) {
+		dev_dbg(&adap->dev, "enable master FSM\n");
+		mrst_i2c_write(i2c->base + IC_CON, (reg & (~(1 << 6)))
+			       | 1<<6);
+		dev_dbg(&adap->dev, "ic_con reg is 0x%x\n", reg);
+	}
+
+	/* use target address when initiating transfer */
+	reg = mrst_i2c_read(i2c->base + IC_TAR);
+	bit_mask = 1 << 11 | 1 << 10;
+
+	if ((reg & bit_mask) != 0x0) {
+		dev_dbg(&adap->dev,
+	 "WR: use target address when intiating transfer, i2c_tx_target\n");
+		mrst_i2c_write(i2c->base + IC_TAR, reg & ~bit_mask);
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
+ * 6. Wait until the current transfer is finished (check bus state)
+ * 7. Mask and clear all interrupts
+ */
+static int mrst_i2c_xfer(struct i2c_adapter *adap,
+			 struct i2c_msg *pmsg,
+			 int num)
+{
+	struct mrst_i2c_private *i2c = i2c_get_adapdata(adap);
+	int i, err;
+
+	mutex_lock(&i2c->lock);
+	dev_dbg(&adap->dev, "mrst_i2c_xfer, process %d msg(s)\n", num);
+	dev_dbg(&adap->dev, "slave address is %x\n", pmsg->addr);
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
+	for (i = 1; i < num; i++) {
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
+		i2c->msg = pmsg;
+		i2c->status = STATUS_IDLE;
+		/* Read or Write */
+		if (pmsg->flags & I2C_M_RD) {
+			dev_dbg(&adap->dev, "I2C_M_RD\n");
+			err = xfer_read(adap, pmsg->buf, pmsg->len);
+		} else {
+			dev_dbg(&adap->dev, "I2C_M_WR\n");
+			err = xfer_write(adap, pmsg->buf, pmsg->len);
+		}
+		if (err < 0)
+			goto err_1;
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
+	dev_dbg(&i2c->adap.dev, "%s, stat = 0x%x\n", __func__, stat);
+
+	if (i2c->status != STATUS_WRITE_START &&
+	    i2c->status != STATUS_READ_START &&
+	    i2c->status != STATUS_READ_IN_PROGRESS)
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
+	if (i2c->status == STATUS_READ_SUCCESS ||
+	    i2c->status == STATUS_WRITE_SUCCESS ||
+	    i2c->status == STATUS_XFER_ABORT)
+		complete(&i2c->complete);
+err:
+	return IRQ_HANDLED;
+}
+
+static struct i2c_algorithm mrst_i2c_algorithm = {
+	.master_xfer	= mrst_i2c_xfer,
+	.functionality	= mrst_i2c_func,
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
+	unsigned long start, len;
+	int err, busnum;
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
+	start = pci_resource_start(dev, 0);
+	len = pci_resource_len(dev, 0);
+	if (!start || len == 0) {
+		dev_err(&dev->dev, "base address not set\n");
+		err = -ENODEV;
+		goto exit;
+	}
+	dev_dbg(&dev->dev, "%s i2c resource start 0x%lx, len=%ld\n",
+		PLATFORM, start, len);
+
+	err = pci_request_region(dev, 0, DRIVER_NAME);
+	if (err) {
+		dev_err(&dev->dev, "failed to request I2C region "
+			"0x%lx-0x%lx\n", start,
+			(unsigned long)pci_resource_end(dev, 0));
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
+		dev_err(&dev->dev, "can't allocate interface\n");
+		err = -ENOMEM;
+		goto fail1;
+	}
+
+	/* Initialize struct members */
+	snprintf(mrst->adap.name, sizeof(&mrst->adap.name),
+		"MRST/Medfield I2C at %lx", start);
+	mrst->adap.owner = THIS_MODULE;
+	mrst->adap.algo = &mrst_i2c_algorithm;
+	mrst->adap.dev.parent = &dev->dev;
+	mrst->base = base;
+	mrst->speed = STANDARD;
+	mrst->pm_state = ACTIVE;
+	mrst->abort = 0;
+	mrst->rx_buf_len = 0;
+	mrst->status = STATUS_IDLE;
+
+	pci_set_drvdata(dev, mrst);
+	i2c_set_adapdata(&mrst->adap, mrst);
+
+	mrst->adap.nr = busnum = id->driver_data;
+	if (dev->device <= 0x0804)
+		mrst->platform = MOORESTOWN;
+	else
+		mrst->platform = MEDFIELD;
+
+	dev_dbg(&dev->dev, "I2C%d\n", busnum);
+
+	if (ctl_num > busnum) {
+		if (speed_mode[busnum] < 0 || speed_mode[busnum] >= NUM_SPEEDS)
+			dev_warn(&dev->dev, "invalid speed %d ignored.\n",
+							speed_mode[busnum]);
+		else
+			mrst->speed = speed_mode[busnum];
+	}
+
+	/* Initialize i2c controller */
+	err = mrst_i2c_hwinit(mrst);
+	if (err < 0) {
+		dev_err(&dev->dev, "I2C interface initialization failed\n");
+		goto fail2;
+	}
+
+	mutex_init(&mrst->lock);
+	init_completion(&mrst->complete);
+	err = request_irq(dev->irq, mrst_i2c_isr, IRQF_DISABLED,
+			  mrst->adap.name, mrst);
+	if (err) {
+		dev_err(&dev->dev, "failed to request IRQ for I2C controller: "
+			"%s", mrst->adap.name);
+		goto fail2;
+	}
+	/* Clear all interrupts */
+	mrst_i2c_read(mrst->base + IC_CLR_INTR);
+	mrst_i2c_write(mrst->base + IC_INTR_MASK, 0x0000);
+
+	/* Adapter registration */
+	err = i2c_add_numbered_adapter(&mrst->adap);
+	if (err) {
+		dev_err(&dev->dev, "adapter %s registration failed\n",
+			mrst->adap.name);
+		goto fail3;
+	}
+
+	dev_dbg(&dev->dev, "%s I2C bus %d driver bind success.\n",
+		(mrst->platform == MOORESTOWN) ? "Moorestown" : "Medfield",
+		busnum);
+	return 0;
+
+fail3:
+	free_irq(dev->irq, mrst);
+fail2:
+	pci_set_drvdata(dev, NULL);
+	kfree(mrst);
+fail1:
+	iounmap(base);
+fail0:
+	pci_release_region(dev, 0);
+exit:
+	return err;
+}
+
+static void __devexit mrst_i2c_remove(struct pci_dev *dev)
+{
+	struct mrst_i2c_private *mrst = (struct mrst_i2c_private *)
+					pci_get_drvdata(dev);
+	mrst_i2c_disable(&mrst->adap);
+	if (i2c_del_adapter(&mrst->adap))
+		dev_err(&dev->dev, "Failed to delete i2c adapter");
+
+	free_irq(dev->irq, mrst);
+	pci_set_drvdata(dev, NULL);
+	iounmap(mrst->base);
+	kfree(mrst);
+	pci_release_region(dev, 0);
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
+static struct pci_driver mrst_i2c_driver = {
+	.name		= DRIVER_NAME,
+	.id_table	= mrst_i2c_ids,
+	.probe		= mrst_i2c_probe,
+	.remove		= __devexit_p(mrst_i2c_remove),
+};
+
+static int __init mrst_i2c_init(void)
+{
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
