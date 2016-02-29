From: Jan Glauber <jglauber@cavium.com>
Subject: [Resend PATCH 09/10] i2c: split i2c-octeon driver and add ThunderX support
Date: Mon, 29 Feb 2016 14:46:16 +0100
Message-ID: <25e8960abe506539a230db6d31ab75e7195752b8.1456752497.git.jglauber@cavium.com>
References: <cover.1456752497.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1456752497.git.jglauber@cavium.com>
In-Reply-To: <cover.1456752497.git.jglauber@cavium.com>
References: <cover.1456752497.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, ddaney@caviumnetworks.com, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

The ThunderX SOC uses the same i2c block as the Octeon SOC.
The main difference is that on ThunderX the device is a PCI device
so device probing is done via PCI.

Split the current Octeon driver into an Octeon and a common part
and add the ThunderX support.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/Kconfig             |   10 +
 drivers/i2c/busses/Makefile            |    3 +
 drivers/i2c/busses/i2c-cavium.c        |  828 +++++++++++++++++++++
 drivers/i2c/busses/i2c-cavium.h        |  187 +++++
 drivers/i2c/busses/i2c-octeon-core.c   |  302 ++++++++
 drivers/i2c/busses/i2c-octeon.c        | 1283 --------------------------------
 drivers/i2c/busses/i2c-thunderx-core.c |  263 +++++++
 7 files changed, 1593 insertions(+), 1283 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-cavium.c
 create mode 100644 drivers/i2c/busses/i2c-cavium.h
 create mode 100644 drivers/i2c/busses/i2c-octeon-core.c
 delete mode 100644 drivers/i2c/busses/i2c-octeon.c
 create mode 100644 drivers/i2c/busses/i2c-thunderx-core.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 7b0aa82..97614b3 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -952,6 +952,16 @@ config I2C_OCTEON
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-octeon.
 
+config I2C_THUNDERX
+	tristate "Cavium ThunderX I2C bus support"
+	depends on 64BIT && PCI
+	help
+	  Say yes if you want to support the I2C serial bus on Cavium
+	  ThunderX SOC.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-thunderx.
+
 config I2C_XILINX
 	tristate "Xilinx I2C Controller"
 	depends on HAS_IOMEM
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 37f2819..a32ff14 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -91,7 +91,10 @@ obj-$(CONFIG_I2C_UNIPHIER)	+= i2c-uniphier.o
 obj-$(CONFIG_I2C_UNIPHIER_F)	+= i2c-uniphier-f.o
 obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
 obj-$(CONFIG_I2C_WMT)		+= i2c-wmt.o
+i2c-octeon-objs := i2c-cavium.o i2c-octeon-core.o
 obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
+i2c-thunderx-objs := i2c-cavium.o i2c-thunderx-core.o
+obj-$(CONFIG_I2C_THUNDERX)	+= i2c-thunderx.o
 obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
 obj-$(CONFIG_I2C_XLR)		+= i2c-xlr.o
 obj-$(CONFIG_I2C_XLP9XX)	+= i2c-xlp9xx.o
diff --git a/drivers/i2c/busses/i2c-cavium.c b/drivers/i2c/busses/i2c-cavium.c
new file mode 100644
index 0000000..93d8c0f
--- /dev/null
+++ b/drivers/i2c/busses/i2c-cavium.c
@@ -0,0 +1,828 @@
+/*
+ * (C) Copyright 2009-2010
+ * Nokia Siemens Networks, michael.lawnick.ext@nsn.com
+ *
+ * Portions Copyright (C) 2010 - 2016 Cavium, Inc.
+ *
+ * This file contains the shared part of the driver for the i2c adapter in
+ * Cavium Networks' OCTEON processors and ThunderX SOCs.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "i2c-cavium.h"
+
+static int reset_how;
+
+/*
+ * On some hardware IFLG is not visible in TWSI_CTL until after low-level IRQ,
+ * so re-sample CTL a short time later to avoid stalls.
+ */
+static int irq_early_us = 80;
+module_param(irq_early_us, int, 0644);
+MODULE_PARM_DESC(irq_early_us, "Re-poll for IFLG after IRQ (us)");
+
+static void octeon_i2c_disable_hlc(struct octeon_i2c *i2c)
+{
+	if (!i2c->hlc_enabled)
+		return;
+
+	i2c->hlc_enabled = false;
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
+}
+
+/* interrupt service routine */
+irqreturn_t octeon_i2c_isr(int irq, void *dev_id)
+{
+	struct octeon_i2c *i2c = dev_id;
+
+	i2c->int_dis(i2c);
+	wake_up(&i2c->queue);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Wait-helper which addresses the delayed-IFLAG problem by re-polling for
+ * missing TWSI_CTL[IFLG] a few us later, when irq has signalled an event,
+ * but none found. Skip this re-poll on the first (non-wakeup) call.
+ */
+static int poll_iflg(struct octeon_i2c *i2c, int *first_p)
+{
+	int iflg = octeon_i2c_test_iflg(i2c);
+
+	if (iflg)
+		return 1;
+	if (*first_p)
+		*first_p = 0;
+	else {
+		usleep_range(irq_early_us, 2 * irq_early_us);
+		iflg = octeon_i2c_test_iflg(i2c);
+	}
+	return iflg;
+}
+
+/**
+ * octeon_i2c_wait - wait for the IFLG to be set
+ * @i2c: The struct octeon_i2c
+ *
+ * Returns 0 on success, otherwise a negative errno.
+ */
+static int octeon_i2c_wait(struct octeon_i2c *i2c)
+{
+	int first = 1;
+	long result;
+
+	if (i2c->broken_irq_mode) {
+		/*
+		 * Some chip revisions seem to not assert the irq in
+		 * the interrupt controller.  So we must poll for the
+		 * IFLG change.
+		 */
+		u64 end = get_jiffies_64() + i2c->adap.timeout;
+
+		while (!octeon_i2c_test_iflg(i2c) &&
+		       time_before64(get_jiffies_64(), end))
+			udelay(50);
+
+		return octeon_i2c_test_iflg(i2c) ? 0 : -ETIMEDOUT;
+	}
+
+	i2c->int_en(i2c);
+	result = wait_event_timeout(i2c->queue, poll_iflg(i2c, &first),
+				    i2c->adap.timeout);
+	i2c->int_dis(i2c);
+
+	if (result <= 0 && i2c->broken_irq_check &&
+	    octeon_i2c_test_iflg(i2c)) {
+		dev_err(i2c->dev,
+			"broken irq connection detected, switching to polling mode.\n");
+		i2c->broken_irq_mode = 1;
+		return 0;
+	}
+	if (!result) {
+		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+/*
+ * Cleanup low-level state & enable high-level.
+ *
+ * Returns -EAGAIN if low-level state could not be cleaned
+ */
+static int octeon_i2c_enable_hlc(struct octeon_i2c *i2c)
+{
+	int try = 0, ret = 0;
+	u64 val;
+
+	if (i2c->hlc_enabled)
+		return 0;
+
+	i2c->hlc_enabled = true;
+
+	while (1) {
+		val = octeon_i2c_read_ctl(i2c) & (TWSI_CTL_STA | TWSI_CTL_STP);
+		if (!val)
+			break;
+
+		/* clear _IFLG event */
+		if (val & TWSI_CTL_IFLG)
+			octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
+					    TWSI_CTL_ENAB);
+
+		if (try++ > 100) {
+			pr_err("%s: giving up\n", __func__);
+			ret = -EAGAIN;
+			break;
+		}
+
+		/* spin until any start/stop has finished */
+		udelay(10);
+	}
+
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
+			    TWSI_CTL_CE | TWSI_CTL_AAK | TWSI_CTL_ENAB);
+	return ret;
+}
+
+static int octeon_i2c_lost_arb(u8 code, int final_read)
+{
+	switch (code) {
+	/* Arbitration lost */
+	case STAT_LOST_ARB_38:
+	case STAT_LOST_ARB_68:
+	case STAT_LOST_ARB_78:
+	case STAT_LOST_ARB_B0:
+		return -EAGAIN;
+
+	/* Being addressed as slave, should back off & listen */
+	case STAT_SLAVE_60:
+	case STAT_SLAVE_70:
+	case STAT_GENDATA_ACK:
+	case STAT_GENDATA_NAK:
+		return -EIO;
+
+	/* Core busy as slave */
+	case STAT_SLAVE_80:
+	case STAT_SLAVE_88:
+	case STAT_SLAVE_A0:
+	case STAT_SLAVE_A8:
+	case STAT_SLAVE_LOST:
+	case STAT_SLAVE_NAK:
+	case STAT_SLAVE_ACK:
+		return -EIO;
+
+	/* ACK allowed on pre-terminal bytes only */
+	case STAT_RXDATA_ACK:
+		if (!final_read)
+			return 0;
+		return -EAGAIN;
+
+	/* NAK allowed on terminal byte only */
+	case STAT_RXDATA_NAK:
+		if (final_read)
+			return 0;
+		return -EAGAIN;
+	case STAT_TXDATA_NAK:
+	case STAT_TXADDR_NAK:
+	case STAT_RXADDR_NAK:
+	case STAT_AD2W_NAK:
+		return -EAGAIN;
+	}
+	return 0;
+}
+
+static int octeon_i2c_check_arb(struct octeon_i2c *i2c, int final_read)
+{
+	return octeon_i2c_lost_arb(octeon_i2c_read_sw(i2c,
+			SW_TWSI_EOP_TWSI_STAT),	final_read);
+}
+
+/* send STOP to the bus */
+static void octeon_i2c_stop(struct octeon_i2c *i2c)
+{
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
+			    TWSI_CTL_ENAB | TWSI_CTL_STP);
+}
+
+int octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
+{
+	u8 status = 0;
+	int tries;
+
+	/* reset controller */
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_RST, 0);
+
+	for (tries = 10; tries && status != STAT_IDLE; tries--) {
+		udelay(1);
+		status = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
+	}
+
+	if (status != STAT_IDLE) {
+		dev_err(i2c->dev, "%s: TWSI_RST failed! (0x%x)\n",
+			__func__, status);
+		return -EIO;
+	}
+
+	/* toggle twice to force both teardowns */
+	octeon_i2c_enable_hlc(i2c);
+	octeon_i2c_disable_hlc(i2c);
+	return 0;
+}
+
+/**
+ * bitbang_unblock - unblock the bus
+ * @i2c: The struct octeon_i2c
+ *
+ * If there was a reset while a device was driving 0 to bus, bus is blocked.
+ * We toggle it free manually by some clock cycles and send a stop.
+ */
+static void bitbang_unblock(struct octeon_i2c *i2c)
+{
+	int state, i;
+
+	octeon_i2c_disable_hlc(i2c);
+	dev_dbg(i2c->dev, "%s\n", __func__);
+
+	/* cycle 8+1 clocks with SDA high */
+	for (i = 0; i < 9; i++) {
+		octeon_i2c_write_int(i2c, 0);
+		udelay(5);
+		state = __raw_readq(i2c->twsi_base + TWSI_INT);
+		if (state & (SDA | SCL))
+			break;
+		octeon_i2c_write_int(i2c, SCL_OVR);
+		udelay(5);
+	}
+	/* hand-crank a STOP */
+	octeon_i2c_write_int(i2c, SDA_OVR | SCL_OVR);
+	udelay(5);
+	octeon_i2c_write_int(i2c, SDA_OVR);
+	udelay(5);
+	octeon_i2c_write_int(i2c, 0);
+}
+
+/*
+ * TWSI state seems stuck. Not sure if it's TWSI-engine state or something
+ * else on bus. The initial _stop() is always harmless, it just resets state
+ * machine, does not _transmit_ STOP unless engine was active.
+ */
+static int start_unstick(struct octeon_i2c *i2c)
+{
+	octeon_i2c_stop(i2c);
+
+	/*
+	 * Response is escalated over successive calls,
+	 * as EAGAIN provokes retries from i2c/core.
+	 */
+	switch (reset_how++ % 4) {
+	case 0:
+		/* just the stop above */
+		break;
+	case 1:
+		/*
+		 * Controller refused to send start flag. May be a
+		 * client is holding SDA low? Let's try to free it.
+		 */
+		bitbang_unblock(i2c);
+		break;
+	case 2:
+		/* re-init our TWSI hardware */
+		octeon_i2c_initlowlevel(i2c);
+		break;
+	default:
+		/* retry in caller */
+		reset_how = 0;
+		return -EAGAIN;
+	}
+	return 0;
+}
+
+/**
+ * octeon_i2c_start - send START to the bus
+ * @i2c: The struct octeon_i2c
+ * @first: first msg in combined operation?
+ *
+ * Returns 0 on success, otherwise a negative errno.
+ */
+static int octeon_i2c_start(struct octeon_i2c *i2c, int first)
+{
+	int result;
+	u8 data;
+
+	octeon_i2c_disable_hlc(i2c);
+
+	while (1) {
+		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
+				    TWSI_CTL_ENAB | TWSI_CTL_STA);
+
+		result = octeon_i2c_wait(i2c);
+		data = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
+
+		switch (data) {
+		case STAT_START:
+		case STAT_RSTART:
+			if (!first)
+				return -EAGAIN;
+			reset_how = 0;
+			return 0;
+		case STAT_RXADDR_ACK:
+			if (first)
+				return -EAGAIN;
+			return start_unstick(i2c);
+		/*
+		 * case STAT_IDLE:
+		 * case STAT_ERROR:
+		 */
+		default:
+			if (!first)
+				return -EAGAIN;
+			start_unstick(i2c);
+		}
+	}
+	return 0;
+}
+
+/* calculate and set clock divisors */
+void octeon_i2c_setclock(struct octeon_i2c *i2c)
+{
+	int tclk, thp_base, inc, thp_idx, mdiv_idx, ndiv_idx, foscl, diff;
+	int thp = 0x18, mdiv = 2, ndiv = 0, delta_hz = 1000000;
+
+	for (ndiv_idx = 0; ndiv_idx < 8 && delta_hz != 0; ndiv_idx++) {
+		/*
+		 * An mdiv value of less than 2 seems to not work well
+		 * with ds1337 RTCs, so we constrain it to larger values.
+		 */
+		for (mdiv_idx = 15; mdiv_idx >= 2 && delta_hz != 0; mdiv_idx--) {
+			/*
+			 * For given ndiv and mdiv values check the
+			 * two closest thp values.
+			 */
+			tclk = i2c->twsi_freq * (mdiv_idx + 1) * 10;
+			tclk *= (1 << ndiv_idx);
+			thp_base = (i2c->sys_freq / (tclk * 2)) - 1;
+
+			for (inc = 0; inc <= 1; inc++) {
+				thp_idx = thp_base + inc;
+				if (thp_idx < 5 || thp_idx > 0xff)
+					continue;
+
+				foscl = i2c->sys_freq / (2 * (thp_idx + 1));
+				foscl = foscl / (1 << ndiv_idx);
+				foscl = foscl / (mdiv_idx + 1) / 10;
+				diff = abs(foscl - i2c->twsi_freq);
+				if (diff < delta_hz) {
+					delta_hz = diff;
+					thp = thp_idx;
+					mdiv = mdiv_idx;
+					ndiv = ndiv_idx;
+				}
+			}
+		}
+	}
+	octeon_i2c_write_sw(i2c, SW_TWSI_OP_TWSI_CLK, thp);
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CLKCTL, (mdiv << 3) | ndiv);
+}
+
+static bool octeon_i2c_hlc_test_ready(struct octeon_i2c *i2c)
+{
+	u64 val = __raw_readq(i2c->twsi_base + SW_TWSI);
+
+	return (val & SW_TWSI_V) == 0;
+}
+
+static void octeon_i2c_hlc_int_clear(struct octeon_i2c *i2c)
+{
+	/* clear ST/TS events, listen for neither */
+	octeon_i2c_write_int(i2c, ST_INT | TS_INT);
+}
+
+/**
+ * octeon_i2c_hlc_wait - wait for an HLC operation to complete
+ * @i2c: The struct octeon_i2c
+ *
+ * Returns 0 on success, otherwise a negative errno.
+ */
+static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
+{
+	int result;
+
+	if (i2c->broken_irq_mode) {
+		/*
+		 * Some cn38xx boards did not assert the irq in
+		 * the interrupt controller.  So we must poll for the
+		 * IFLG change.
+		 */
+		u64 end = get_jiffies_64() + i2c->adap.timeout;
+
+		while (!octeon_i2c_hlc_test_ready(i2c) &&
+		       time_before64(get_jiffies_64(), end))
+			udelay(50);
+
+		return octeon_i2c_hlc_test_ready(i2c) ? 0 : -ETIMEDOUT;
+	}
+
+	i2c->hlc_int_en(i2c);
+	result = wait_event_interruptible_timeout(i2c->queue,
+			octeon_i2c_hlc_test_ready(i2c), i2c->adap.timeout);
+	i2c->hlc_int_dis(i2c);
+	if (!result)
+		octeon_i2c_hlc_int_clear(i2c);
+
+	if (result <= 0 && i2c->broken_irq_check &&
+	    octeon_i2c_hlc_test_ready(i2c)) {
+		dev_err(i2c->dev, "broken irq connection detected, switching to polling mode.\n");
+			i2c->broken_irq_mode = 1;
+			return 0;
+	}
+
+	if (result < 0) {
+		dev_dbg(i2c->dev, "%s: wait interrupted\n", __func__);
+		return result;
+	} else if (!result) {
+		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+/**
+ * octeon_i2c_read - receive data from the bus via low-level controller
+ * @i2c: The struct octeon_i2c
+ * @target: Target address
+ * @data: Pointer to the location to store the data
+ * @rlength: Length of the data
+ * @phase: which phase of a combined operation.
+ * @recv_len: flag for length byte
+ *
+ * The address is sent over the bus, then the data is read.
+ *
+ * Returns 0 on success, otherwise a negative errno.
+ */
+static int octeon_i2c_read(struct octeon_i2c *i2c, int target, u8 *data,
+			   u16 *rlength, bool first, bool last, bool recv_len)
+{
+	u8 ctl = TWSI_CTL_ENAB | TWSI_CTL_AAK;
+	int length = *rlength;
+	int i, result;
+	u8 tmp;
+
+	if (length < 1)
+		return -EINVAL;
+
+	result = octeon_i2c_start(i2c, first);
+	if (result)
+		return result;
+
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, (target<<1) | 1);
+
+	for (i = 0; i < length; ) {
+		tmp = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
+		result = octeon_i2c_lost_arb(tmp, !(ctl & TWSI_CTL_AAK));
+		if (result)
+			return result;
+
+		switch (tmp) {
+		case STAT_RXDATA_ACK:
+		case STAT_RXDATA_NAK:
+			data[i++] = octeon_i2c_read_sw(i2c,
+					SW_TWSI_EOP_TWSI_DATA);
+		}
+
+		/* NAK last recv'd byte, as a no-more-please */
+		if (last && i == length - 1)
+			ctl &= ~TWSI_CTL_AAK;
+
+		/* clr iflg to allow next event */
+		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, ctl);
+		result = octeon_i2c_wait(i2c);
+		if (result)
+			return result;
+		if (recv_len && i == 0) {
+			if (data[i] > I2C_SMBUS_BLOCK_MAX + 1) {
+				dev_err(i2c->dev,
+					"%s: read len > I2C_SMBUS_BLOCK_MAX %d\n",
+					__func__, data[i]);
+				return -EIO;
+			}
+			length += data[i];
+		}
+	}
+	*rlength = length;
+	return 0;
+}
+
+/**
+ * octeon_i2c_write - send data to the bus via low-level controller
+ * @i2c: The struct octeon_i2c
+ * @target: Target address
+ * @data: Pointer to the data to be sent
+ * @length: Length of the data
+ * @last: is last msg in combined operation?
+ *
+ * The address is sent over the bus, then the data.
+ *
+ * Returns 0 on success, otherwise a negative errno.
+ */
+static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
+			    u8 *data, int length, int first, int last)
+{
+	int result, i;
+
+	result = octeon_i2c_start(i2c, first);
+	if (result)
+		return result;
+
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, target << 1);
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
+
+	result = octeon_i2c_wait(i2c);
+	if (result)
+		return result;
+
+	for (i = 0; i < length; i++) {
+		result = octeon_i2c_check_arb(i2c, false);
+		if (result)
+			return result;
+
+		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, data[i]);
+		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
+
+		result = octeon_i2c_wait(i2c);
+		if (result)
+			return result;
+		result = octeon_i2c_check_arb(i2c, false);
+		if (result)
+			return result;
+	}
+
+	return 0;
+}
+
+/* high-level-controller pure read of up to 8 bytes */
+static int octeon_i2c_simple_read(struct octeon_i2c *i2c, struct i2c_msg *msgs)
+{
+	int i, j, ret = 0;
+	u64 cmd;
+
+	octeon_i2c_enable_hlc(i2c);
+	cmd = SW_TWSI_V | SW_TWSI_R | SW_TWSI_SOVR;
+	/* SIZE */
+	cmd |= (u64) (msgs[0].len - 1) << SW_TWSI_SIZE_SHIFT;
+	/* A */
+	cmd |= (u64) (msgs[0].addr & 0x7full) << SW_TWSI_A_SHIFT;
+
+	if (msgs[0].flags & I2C_M_TEN)
+		cmd |= SW_TWSI_OP_10;
+	else
+		cmd |= SW_TWSI_OP_7;
+
+	octeon_i2c_hlc_int_clear(i2c);
+	__raw_writeq(cmd, i2c->twsi_base + SW_TWSI);
+
+	ret = octeon_i2c_hlc_wait(i2c);
+	if (ret)
+		goto err;
+
+	cmd = __raw_readq(i2c->twsi_base + SW_TWSI);
+	if ((cmd & SW_TWSI_R) == 0)
+		return -EAGAIN;
+
+	for (i = 0, j = msgs[0].len - 1; i  < msgs[0].len && i < 4; i++, j--)
+		msgs[0].buf[j] = (cmd >> (8 * i)) & 0xff;
+
+	if (msgs[0].len > 4) {
+		cmd = __raw_readq(i2c->twsi_base + SW_TWSI_EXT);
+		for (i = 0; i  < msgs[0].len - 4 && i < 4; i++, j--)
+			msgs[0].buf[j] = (cmd >> (8 * i)) & 0xff;
+	}
+
+err:
+	return ret;
+}
+
+/* high-level-controller pure write of up to 8 bytes */
+static int octeon_i2c_simple_write(struct octeon_i2c *i2c, struct i2c_msg *msgs)
+{
+	int i, j, ret = 0;
+	u64 cmd;
+
+	octeon_i2c_enable_hlc(i2c);
+	octeon_i2c_hlc_int_clear(i2c);
+
+	ret = octeon_i2c_check_arb(i2c, false);
+	if (ret)
+		goto err;
+
+	cmd = SW_TWSI_V | SW_TWSI_SOVR;
+	/* SIZE */
+	cmd |= (u64) (msgs[0].len - 1) << SW_TWSI_SIZE_SHIFT;
+	/* A */
+	cmd |= (u64) (msgs[0].addr & 0x7full) << SW_TWSI_A_SHIFT;
+
+	if (msgs[0].flags & I2C_M_TEN)
+		cmd |= SW_TWSI_OP_10;
+	else
+		cmd |= SW_TWSI_OP_7;
+
+	for (i = 0, j = msgs[0].len - 1; i  < msgs[0].len && i < 4; i++, j--)
+		cmd |= (u64)msgs[0].buf[j] << (8 * i);
+
+	if (msgs[0].len > 4) {
+		u64 ext = 0;
+
+		for (i = 0; i < msgs[0].len - 4 && i < 4; i++, j--)
+			ext |= (u64) msgs[0].buf[j] << (8 * i);
+		writeqflush(ext, i2c->twsi_base + SW_TWSI_EXT);
+	}
+
+	writeqflush(cmd, i2c->twsi_base + SW_TWSI);
+
+	ret = octeon_i2c_hlc_wait(i2c);
+	if (ret)
+		goto err;
+
+	cmd = __raw_readq(i2c->twsi_base + SW_TWSI);
+	if ((cmd & SW_TWSI_R) == 0)
+		return -EAGAIN;
+
+	ret = octeon_i2c_check_arb(i2c, false);
+
+err:
+	return ret;
+}
+
+/* high-level-controller composite write+read, msg0=addr, msg1=data */
+static int octeon_i2c_ia_read(struct octeon_i2c *i2c, struct i2c_msg *msgs)
+{
+	int i, j, ret = 0;
+	u64 cmd;
+
+	octeon_i2c_enable_hlc(i2c);
+
+	cmd = SW_TWSI_V | SW_TWSI_R | SW_TWSI_SOVR;
+	/* SIZE */
+	cmd |= (u64)(msgs[1].len - 1) << SW_TWSI_SIZE_SHIFT;
+	/* A */
+	cmd |= (u64)(msgs[0].addr & 0x7full) << SW_TWSI_A_SHIFT;
+
+	if (msgs[0].flags & I2C_M_TEN)
+		cmd |= SW_TWSI_OP_10_IA;
+	else
+		cmd |= SW_TWSI_OP_7_IA;
+
+	if (msgs[0].len == 2) {
+		u64 ext = 0;
+
+		cmd |= SW_TWSI_EIA;
+		ext = (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
+		cmd |= (u64) msgs[0].buf[1] << SW_TWSI_IA_SHIFT;
+		__raw_writeq(ext, i2c->twsi_base + SW_TWSI_EXT);
+	} else
+		cmd |= (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
+
+	octeon_i2c_hlc_int_clear(i2c);
+	writeqflush(cmd, i2c->twsi_base + SW_TWSI);
+
+	ret = octeon_i2c_hlc_wait(i2c);
+	if (ret)
+		goto err;
+
+	cmd = __raw_readq(i2c->twsi_base + SW_TWSI);
+	if ((cmd & SW_TWSI_R) == 0)
+		return -EAGAIN;
+
+	for (i = 0, j = msgs[1].len - 1; i  < msgs[1].len && i < 4; i++, j--)
+		msgs[1].buf[j] = (cmd >> (8 * i)) & 0xff;
+
+	if (msgs[1].len > 4) {
+		cmd = __raw_readq(i2c->twsi_base + SW_TWSI_EXT);
+		for (i = 0; i  < msgs[1].len - 4 && i < 4; i++, j--)
+			msgs[1].buf[j] = (cmd >> (8 * i)) & 0xff;
+	}
+
+err:
+	return ret;
+}
+
+/* high-level-controller composite write+write, m[0]len<=2, m[1]len<=8 */
+static int octeon_i2c_ia_write(struct octeon_i2c *i2c, struct i2c_msg *msgs)
+{
+	bool set_ext = false;
+	int i, j, ret = 0;
+	u64 cmd, ext = 0;
+
+	octeon_i2c_enable_hlc(i2c);
+
+	cmd = SW_TWSI_V | SW_TWSI_SOVR;
+	/* SIZE */
+	cmd |= (u64) (msgs[1].len - 1) << SW_TWSI_SIZE_SHIFT;
+	/* A */
+	cmd |= (u64) (msgs[0].addr & 0x7full) << SW_TWSI_A_SHIFT;
+
+	if (msgs[0].flags & I2C_M_TEN)
+		cmd |= SW_TWSI_OP_10_IA;
+	else
+		cmd |= SW_TWSI_OP_7_IA;
+
+	if (msgs[0].len == 2) {
+		cmd |= SW_TWSI_EIA;
+		ext |= (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
+		set_ext = true;
+		cmd |= (u64) msgs[0].buf[1] << SW_TWSI_IA_SHIFT;
+	} else
+		cmd |= (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
+
+	for (i = 0, j = msgs[1].len - 1; i  < msgs[1].len && i < 4; i++, j--)
+		cmd |= (u64) msgs[1].buf[j] << (8 * i);
+
+	if (msgs[1].len > 4) {
+		for (i = 0; i < msgs[1].len - 4 && i < 4; i++, j--)
+			ext |= (u64)msgs[1].buf[j] << (8 * i);
+		set_ext = true;
+	}
+	if (set_ext)
+		writeqflush(ext, i2c->twsi_base + SW_TWSI_EXT);
+
+	octeon_i2c_hlc_int_clear(i2c);
+	writeqflush(cmd, i2c->twsi_base + SW_TWSI);
+
+	ret = octeon_i2c_hlc_wait(i2c);
+	if (ret)
+		goto err;
+
+	cmd = octeon_i2c_read_sw64(i2c, SW_TWSI_EOP_TWSI_STAT);
+	if ((cmd & SW_TWSI_R) == 0)
+		return -EAGAIN;
+	ret = octeon_i2c_lost_arb(cmd, false);
+
+err:
+	return ret;
+}
+
+/**
+ * octeon_i2c_xfer - The driver's master_xfer function
+ * @adap: Pointer to the i2c_adapter structure
+ * @msgs: Pointer to the messages to be processed
+ * @num: Length of the MSGS array
+ *
+ * Returns the number of messages processed, or a negative errno on failure.
+ */
+int octeon_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
+	int i, ret = 0;
+
+	if (num == 1) {
+		if (msgs[0].len > 0 && msgs[0].len <= 8) {
+			if (msgs[0].flags & I2C_M_RD)
+				ret = octeon_i2c_simple_read(i2c, msgs);
+			else
+				ret = octeon_i2c_simple_write(i2c, msgs);
+			goto out;
+		}
+	} else if (num == 2) {
+		if ((msgs[0].flags & I2C_M_RD) == 0 &&
+		    (msgs[1].flags & I2C_M_RECV_LEN) == 0 &&
+		    msgs[0].len > 0 && msgs[0].len <= 2 &&
+		    msgs[1].len > 0 && msgs[1].len <= 8 &&
+		    msgs[0].addr == msgs[1].addr) {
+			if (msgs[1].flags & I2C_M_RD)
+				ret = octeon_i2c_ia_read(i2c, msgs);
+			else
+				ret = octeon_i2c_ia_write(i2c, msgs);
+			goto out;
+		}
+	}
+
+	for (i = 0; ret == 0 && i < num; i++) {
+		struct i2c_msg *pmsg = &msgs[i];
+		bool last = (i == (num - 1));
+
+		dev_dbg(i2c->dev,
+			"Doing %s %d byte(s) to/from 0x%02x - %d of %d messages\n",
+			 pmsg->flags & I2C_M_RD ? "read" : "write",
+			 pmsg->len, pmsg->addr, i + 1, num);
+		if (pmsg->flags & I2C_M_RD)
+			ret = octeon_i2c_read(i2c, pmsg->addr, pmsg->buf,
+					      &pmsg->len, !i, last,
+					      pmsg->flags & I2C_M_RECV_LEN);
+		else
+			ret = octeon_i2c_write(i2c, pmsg->addr, pmsg->buf,
+					       pmsg->len, !i, last);
+	}
+	octeon_i2c_stop(i2c);
+out:
+	return ret ? -EAGAIN : num;
+}
diff --git a/drivers/i2c/busses/i2c-cavium.h b/drivers/i2c/busses/i2c-cavium.h
new file mode 100644
index 0000000..db80c0f
--- /dev/null
+++ b/drivers/i2c/busses/i2c-cavium.h
@@ -0,0 +1,187 @@
+#include <linux/atomic.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+/* Register offsets */
+#ifdef CONFIG_ARCH_THUNDER
+	#define SW_TWSI			0x1000
+	#define TWSI_INT		0x1010
+	#define SW_TWSI_EXT		0x1018
+	#define TWSI_INT_ENA_W1C	0x1028
+	#define TWSI_INT_ENA_W1S	0x1030
+#else
+	#define SW_TWSI			0x00
+	#define TWSI_INT		0x10
+	#define SW_TWSI_EXT		0x18
+#endif /* CONFIG_ARCH_THUNDER */
+
+#define INT_ENA_ST		0x1
+#define INT_ENA_TS		0x2
+#define INT_ENA_CORE		0x4
+
+/* Controller command patterns */
+#define SW_TWSI_V		(1ULL << 63)
+#define SW_TWSI_EIA		(1ULL << 61)
+#define SW_TWSI_R		(1ULL << 56)
+#define SW_TWSI_SOVR		(1ULL << 55)
+#define SW_TWSI_OP_7		(0ULL << 57)
+#define SW_TWSI_OP_7_IA		(1ULL << 57)
+#define SW_TWSI_OP_10		(2ULL << 57)
+#define SW_TWSI_OP_10_IA	(3ULL << 57)
+#define SW_TWSI_OP_TWSI_CLK	(1ULL << 59)
+#define SW_TWSI_SIZE_SHIFT	52
+#define SW_TWSI_A_SHIFT		40
+#define SW_TWSI_IA_SHIFT	32
+#define SW_TWSI_EOP_TWSI_DATA	0x0C00000100000000ULL
+#define SW_TWSI_EOP_TWSI_CTL	0x0C00000200000000ULL
+#define SW_TWSI_EOP_TWSI_CLKCTL	0x0C00000300000000ULL
+#define SW_TWSI_EOP_TWSI_STAT	0x0C00000300000000ULL
+#define SW_TWSI_EOP_TWSI_RST	0x0C00000700000000ULL
+
+/* Controller command and status bits */
+#define TWSI_CTL_CE		0x80	/* High level controller enable */
+#define TWSI_CTL_ENAB		0x40	/* Bus enable */
+#define TWSI_CTL_STA		0x20	/* Master-mode start, HW clears when done */
+#define TWSI_CTL_STP		0x10	/* Master-mode stop, HW clears when done */
+#define TWSI_CTL_IFLG		0x08	/* HW event, SW writes 0 to ACK */
+#define TWSI_CTL_AAK		0x04	/* Assert ACK */
+
+/* Some status values */
+#define STAT_ERROR		0x00
+#define STAT_START		0x08
+#define STAT_RSTART		0x10
+#define STAT_TXADDR_ACK		0x18
+#define STAT_TXADDR_NAK		0x20
+#define STAT_TXDATA_ACK		0x28
+#define STAT_TXDATA_NAK		0x30
+#define STAT_LOST_ARB_38	0x38
+#define STAT_RXADDR_ACK		0x40
+#define STAT_RXADDR_NAK		0x48
+#define STAT_RXDATA_ACK		0x50
+#define STAT_RXDATA_NAK		0x58
+#define STAT_SLAVE_60		0x60
+#define STAT_LOST_ARB_68	0x68
+#define STAT_SLAVE_70		0x70
+#define STAT_LOST_ARB_78	0x78
+#define STAT_SLAVE_80		0x80
+#define STAT_SLAVE_88		0x88
+#define STAT_GENDATA_ACK	0x90
+#define STAT_GENDATA_NAK	0x98
+#define STAT_SLAVE_A0		0xA0
+#define STAT_SLAVE_A8		0xA8
+#define STAT_LOST_ARB_B0	0xB0
+#define STAT_SLAVE_LOST		0xB8
+#define STAT_SLAVE_NAK		0xC0
+#define STAT_SLAVE_ACK		0xC8
+#define STAT_AD2W_ACK		0xD0
+#define STAT_AD2W_NAK		0xD8
+#define STAT_IDLE		0xF8
+
+/* TWSI_INT values */
+#define ST_INT			0x01
+#define TS_INT			0x02
+#define CORE_INT		0x04
+#define ST_EN			0x10
+#define TS_EN			0x20
+#define CORE_EN			0x40
+#define SDA_OVR			0x100
+#define SCL_OVR			0x200
+#define SDA			0x400
+#define SCL			0x800
+
+struct octeon_i2c {
+	wait_queue_head_t	queue;
+	struct i2c_adapter	adap;
+	struct clk		*clk;
+	int			irq;
+	int			hlc_irq;	/* For cn7890 only */
+	u32			twsi_freq;
+	int			sys_freq;
+	void __iomem		*twsi_base;
+	struct device		*dev;
+	int			broken_irq_check;
+	int			broken_irq_mode;
+	bool			hlc_enabled;
+
+	void			(*int_en)	(struct octeon_i2c *);
+	void			(*int_dis)	(struct octeon_i2c *);
+	void			(*hlc_int_en)	(struct octeon_i2c *);
+	void			(*hlc_int_dis)	(struct octeon_i2c *);
+
+	atomic_t		int_en_cnt;
+	atomic_t		hlc_int_en_cnt;
+
+#ifdef CONFIG_ARCH_THUNDER
+	struct msix_entry       i2c_msix;
+#endif
+};
+
+static inline void writeqflush(u64 val, void __iomem *addr)
+{
+	__raw_writeq(val, addr);
+	__raw_readq(addr);	/* wait for write to land */
+}
+
+static inline void octeon_i2c_write_int(struct octeon_i2c *i2c, u64 data)
+{
+	writeqflush(data, i2c->twsi_base + TWSI_INT);
+}
+
+/*
+ * Write an I2C core register. Access is indirect via the SW_TWSI CSR.
+ */
+static inline void octeon_i2c_write_sw(struct octeon_i2c *i2c, u64 eop_reg,
+				       u32 data)
+{
+	u64 tmp;
+
+	__raw_writeq(SW_TWSI_V | eop_reg | data, i2c->twsi_base + SW_TWSI);
+	do
+		tmp = __raw_readq(i2c->twsi_base + SW_TWSI);
+	while ((tmp & SW_TWSI_V) != 0);
+}
+
+/*
+ * Read an I2C core register. Access is indirect via the SW_TWSI CSR.
+ */
+static inline u64 octeon_i2c_read_sw64(struct octeon_i2c *i2c, u64 eop_reg)
+{
+	u64 tmp;
+
+	__raw_writeq(SW_TWSI_V | eop_reg | SW_TWSI_R, i2c->twsi_base + SW_TWSI);
+	do
+		tmp = __raw_readq(i2c->twsi_base + SW_TWSI);
+	while ((tmp & SW_TWSI_V) != 0);
+
+	return tmp;
+}
+
+/*
+ * Read the lower bits of an I2C core register.
+ * Access is indirect via the SW_TWSI CSR.
+ */
+static inline u8 octeon_i2c_read_sw(struct octeon_i2c *i2c, u64 eop_reg)
+{
+	return (u8) octeon_i2c_read_sw64(i2c, eop_reg);
+}
+
+static inline u64 octeon_i2c_read_ctl(struct octeon_i2c *i2c)
+{
+	return octeon_i2c_read_sw64(i2c, SW_TWSI_EOP_TWSI_CTL);
+}
+
+static inline int octeon_i2c_test_iflg(struct octeon_i2c *i2c)
+{
+	return (octeon_i2c_read_ctl(i2c) & TWSI_CTL_IFLG) != 0;
+}
+
+/* Prototypes */
+int octeon_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num);
+irqreturn_t octeon_i2c_isr(int irq, void *dev_id);
+int octeon_i2c_initlowlevel(struct octeon_i2c *i2c);
+void octeon_i2c_setclock(struct octeon_i2c *i2c);
diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
new file mode 100644
index 0000000..f8228cf
--- /dev/null
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -0,0 +1,302 @@
+/*
+ * (C) Copyright 2009-2010
+ * Nokia Siemens Networks, michael.lawnick.ext@nsn.com
+ *
+ * Portions Copyright (C) 2010 - 2016 Cavium, Inc.
+ *
+ * This is a driver for the i2c adapter in Cavium Networks' OCTEON processors.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/atomic.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+#include <asm/octeon/octeon.h>
+#include "i2c-cavium.h"
+
+#define DRV_NAME		"i2c-octeon"
+
+static int timeout = 2;
+module_param(timeout, int, 0444);
+MODULE_PARM_DESC(timeout, "Low-level device timeout (ms)");
+
+/**
+ * octeon_i2c_int_enable - enable the CORE interrupt
+ * @i2c: The struct octeon_i2c
+ *
+ * The interrupt will be asserted when there is non-STAT_IDLE state in the
+ * SW_TWSI_EOP_TWSI_STAT register.
+ */
+static void octeon_i2c_int_enable(struct octeon_i2c *i2c)
+{
+	octeon_i2c_write_int(i2c, CORE_EN);
+}
+
+/* disable the CORE interrupt */
+static void octeon_i2c_int_disable(struct octeon_i2c *i2c)
+{
+	/* clear TS/ST/IFLG events */
+	octeon_i2c_write_int(i2c, TS_INT | ST_INT);
+}
+
+/**
+ * octeon_i2c_int_enable78 - enable the CORE interrupt
+ * @i2c: The struct octeon_i2c
+ *
+ * The interrupt will be asserted when there is non-STAT_IDLE state in the
+ * SW_TWSI_EOP_TWSI_STAT register.
+ */
+static void octeon_i2c_int_enable78(struct octeon_i2c *i2c)
+{
+	atomic_inc_return(&i2c->int_en_cnt);
+	enable_irq(i2c->irq);
+}
+
+static void __octeon_i2c_irq_disable(atomic_t *cnt, int irq)
+{
+	int count;
+
+	/*
+	 * The interrupt can be disabled in two places, but we only
+	 * want to make the disable_irq_nosync() call once, so keep
+	 * track with the atomic variable.
+	 */
+	count = atomic_dec_if_positive(cnt);
+	if (count >= 0)
+		disable_irq_nosync(irq);
+}
+
+/* disable the CORE interrupt */
+static void octeon_i2c_int_disable78(struct octeon_i2c *i2c)
+{
+	__octeon_i2c_irq_disable(&i2c->int_en_cnt, i2c->irq);
+}
+
+/**
+ * octeon_i2c_hlc_int_enable78 - enable the ST interrupt
+ * @i2c: The struct octeon_i2c
+ *
+ * The interrupt will be asserted when there is non-STAT_IDLE state in
+ * the SW_TWSI_EOP_TWSI_STAT register.
+ */
+static void octeon_i2c_hlc_int_enable78(struct octeon_i2c *i2c)
+{
+	atomic_inc_return(&i2c->hlc_int_en_cnt);
+	enable_irq(i2c->hlc_irq);
+}
+
+/* disable the ST interrupt */
+static void octeon_i2c_hlc_int_disable78(struct octeon_i2c *i2c)
+{
+	__octeon_i2c_irq_disable(&i2c->hlc_int_en_cnt, i2c->hlc_irq);
+}
+
+/* interrupt service routine */
+static irqreturn_t octeon_i2c_hlc_isr78(int irq, void *dev_id)
+{
+	struct octeon_i2c *i2c = dev_id;
+
+	i2c->hlc_int_dis(i2c);
+	wake_up(&i2c->queue);
+
+	return IRQ_HANDLED;
+}
+
+static void octeon_i2c_hlc_int_enable(struct octeon_i2c *i2c)
+{
+	octeon_i2c_write_int(i2c, ST_EN);
+}
+
+static u32 octeon_i2c_functionality(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm octeon_i2c_algo = {
+	.master_xfer = octeon_i2c_xfer,
+	.functionality = octeon_i2c_functionality,
+};
+
+static struct i2c_adapter octeon_i2c_ops = {
+	.owner = THIS_MODULE,
+	.name = "OCTEON adapter",
+	.algo = &octeon_i2c_algo,
+};
+
+static int octeon_i2c_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	int irq, hlc_irq = 0, result = 0;
+	struct resource *res_mem;
+	struct octeon_i2c *i2c;
+	bool cn78xx_style;
+
+	cn78xx_style = of_device_is_compatible(node, "cavium,octeon-7890-twsi");
+	if (cn78xx_style) {
+		hlc_irq = platform_get_irq(pdev, 0);
+		if (hlc_irq < 0)
+			return hlc_irq;
+
+		irq = platform_get_irq(pdev, 2);
+		if (irq < 0)
+			return irq;
+	} else {
+		/* All adaptors have an irq.  */
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0)
+			return irq;
+	}
+
+	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
+	if (!i2c) {
+		result = -ENOMEM;
+		goto out;
+	}
+	i2c->dev = &pdev->dev;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (res_mem == NULL) {
+		dev_err(i2c->dev, "found no memory resource\n");
+		result = -ENXIO;
+		goto out;
+	}
+
+	/*
+	 * "clock-rate" is a legacy binding, the official binding is
+	 * "clock-frequency".  Try the official one first and then
+	 * fall back if it doesn't exist.
+	 */
+	if (of_property_read_u32(node, "clock-frequency", &i2c->twsi_freq) &&
+	    of_property_read_u32(node, "clock-rate", &i2c->twsi_freq)) {
+		dev_err(i2c->dev,
+			"no I2C 'clock-rate' or 'clock-frequency' property\n");
+		result = -ENXIO;
+		goto out;
+	}
+
+	i2c->sys_freq = octeon_get_io_clock_rate();
+
+	if (!devm_request_mem_region(&pdev->dev, res_mem->start,
+				     resource_size(res_mem), res_mem->name)) {
+		dev_err(i2c->dev, "request_mem_region failed\n");
+		goto out;
+	}
+
+	i2c->twsi_base = devm_ioremap(&pdev->dev, res_mem->start,
+				      resource_size(res_mem));
+	init_waitqueue_head(&i2c->queue);
+	i2c->irq = irq;
+
+	if (cn78xx_style) {
+		i2c->hlc_irq = hlc_irq;
+
+		i2c->int_en = octeon_i2c_int_enable78;
+		i2c->int_dis = octeon_i2c_int_disable78;
+		i2c->hlc_int_en = octeon_i2c_hlc_int_enable78;
+		i2c->hlc_int_dis = octeon_i2c_hlc_int_disable78;
+
+		irq_set_status_flags(i2c->irq, IRQ_NOAUTOEN);
+		irq_set_status_flags(i2c->hlc_irq, IRQ_NOAUTOEN);
+
+		result = devm_request_irq(&pdev->dev, i2c->irq,
+					  octeon_i2c_isr, 0, DRV_NAME, i2c);
+
+		if (result < 0) {
+			dev_err(i2c->dev, "failed to attach interrupt\n");
+			goto out;
+		}
+		result = devm_request_irq(&pdev->dev, i2c->hlc_irq,
+					  octeon_i2c_hlc_isr78, 0,
+					  DRV_NAME, i2c);
+
+		if (result < 0) {
+			dev_err(i2c->dev, "failed to attach interrupt\n");
+			goto out;
+		}
+	} else {
+		i2c->int_en = octeon_i2c_int_enable;
+		i2c->int_dis = octeon_i2c_int_disable;
+		i2c->hlc_int_en = octeon_i2c_hlc_int_enable;
+		i2c->hlc_int_dis = octeon_i2c_int_disable;
+
+		result = devm_request_irq(&pdev->dev, i2c->irq,
+					  octeon_i2c_isr, 0, DRV_NAME, i2c);
+		if (result < 0) {
+			dev_err(i2c->dev, "failed to attach interrupt\n");
+			goto out;
+		}
+	}
+
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX))
+		i2c->broken_irq_check = 1;
+
+	result = octeon_i2c_initlowlevel(i2c);
+	if (result) {
+		dev_err(i2c->dev, "init low level failed\n");
+		goto  out;
+	}
+
+	octeon_i2c_setclock(i2c);
+
+	i2c->adap = octeon_i2c_ops;
+	i2c->adap.timeout = msecs_to_jiffies(timeout);
+	i2c->adap.retries = 10;
+	i2c->adap.dev.parent = &pdev->dev;
+	i2c->adap.dev.of_node = node;
+	i2c_set_adapdata(&i2c->adap, i2c);
+	platform_set_drvdata(pdev, i2c);
+
+	result = i2c_add_adapter(&i2c->adap);
+	if (result < 0) {
+		dev_err(i2c->dev, "failed to add adapter\n");
+		goto out;
+	}
+	dev_info(i2c->dev, "probed\n");
+	return 0;
+
+out:
+	return result;
+};
+
+static int octeon_i2c_remove(struct platform_device *pdev)
+{
+	struct octeon_i2c *i2c = platform_get_drvdata(pdev);
+
+	i2c_del_adapter(&i2c->adap);
+	return 0;
+};
+
+static const struct of_device_id octeon_i2c_match[] = {
+	{	.compatible = "cavium,octeon-3860-twsi",	},
+	{	.compatible = "cavium,octeon-7890-twsi",	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_i2c_match);
+
+static struct platform_driver octeon_i2c_driver = {
+	.probe		= octeon_i2c_probe,
+	.remove		= octeon_i2c_remove,
+	.driver		= {
+		.name	= DRV_NAME,
+		.of_match_table = octeon_i2c_match,
+	},
+};
+
+module_platform_driver(octeon_i2c_driver);
+
+MODULE_AUTHOR("Michael Lawnick <michael.lawnick.ext@nsn.com>");
+MODULE_DESCRIPTION("I2C-Bus adapter for Cavium OCTEON processors");
+MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
deleted file mode 100644
index 3c2f848..0000000
--- a/drivers/i2c/busses/i2c-octeon.c
+++ /dev/null
@@ -1,1283 +0,0 @@
-/*
- * (C) Copyright 2009-2010
- * Nokia Siemens Networks, michael.lawnick.ext@nsn.com
- *
- * Portions Copyright (C) 2010 - 2016 Cavium, Inc.
- *
- * This is a driver for the i2c adapter in Cavium Networks' OCTEON processors.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/atomic.h>
-#include <linux/delay.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/io.h>
-#include <linux/of.h>
-
-#include <asm/octeon/octeon.h>
-
-#define DRV_NAME		"i2c-octeon"
-
-/* Register offsets */
-#define SW_TWSI			0x00
-#define TWSI_INT		0x10
-#define SW_TWSI_EXT		0x18
-
-#define INT_ENA_ST		0x1
-#define INT_ENA_TS		0x2
-#define INT_ENA_CORE		0x4
-
-/* Controller command patterns */
-#define SW_TWSI_V		(1ULL << 63)
-#define SW_TWSI_EIA		(1ULL << 61)
-#define SW_TWSI_R		(1ULL << 56)
-#define SW_TWSI_SOVR		(1ULL << 55)
-#define SW_TWSI_OP_7		(0ULL << 57)
-#define SW_TWSI_OP_7_IA		(1ULL << 57)
-#define SW_TWSI_OP_10		(2ULL << 57)
-#define SW_TWSI_OP_10_IA	(3ULL << 57)
-#define SW_TWSI_OP_TWSI_CLK	(1ULL << 59)
-#define SW_TWSI_SIZE_SHIFT	52
-#define SW_TWSI_A_SHIFT		40
-#define SW_TWSI_IA_SHIFT	32
-#define SW_TWSI_EOP_TWSI_DATA	0x0C00000100000000ULL
-#define SW_TWSI_EOP_TWSI_CTL	0x0C00000200000000ULL
-#define SW_TWSI_EOP_TWSI_CLKCTL	0x0C00000300000000ULL
-#define SW_TWSI_EOP_TWSI_STAT	0x0C00000300000000ULL
-#define SW_TWSI_EOP_TWSI_RST	0x0C00000700000000ULL
-
-/* Controller command and status bits */
-#define TWSI_CTL_CE		0x80	/* High level controller enable */
-#define TWSI_CTL_ENAB		0x40	/* Bus enable */
-#define TWSI_CTL_STA		0x20	/* Master-mode start, HW clears when done */
-#define TWSI_CTL_STP		0x10	/* Master-mode stop, HW clears when done */
-#define TWSI_CTL_IFLG		0x08	/* HW event, SW writes 0 to ACK */
-#define TWSI_CTL_AAK		0x04	/* Assert ACK */
-
-/* Some status values */
-#define STAT_ERROR		0x00
-#define STAT_START		0x08
-#define STAT_RSTART		0x10
-#define STAT_TXADDR_ACK		0x18
-#define STAT_TXADDR_NAK		0x20
-#define STAT_TXDATA_ACK		0x28
-#define STAT_TXDATA_NAK		0x30
-#define STAT_LOST_ARB_38	0x38
-#define STAT_RXADDR_ACK		0x40
-#define STAT_RXADDR_NAK		0x48
-#define STAT_RXDATA_ACK		0x50
-#define STAT_RXDATA_NAK		0x58
-#define STAT_SLAVE_60		0x60
-#define STAT_LOST_ARB_68	0x68
-#define STAT_SLAVE_70		0x70
-#define STAT_LOST_ARB_78	0x78
-#define STAT_SLAVE_80		0x80
-#define STAT_SLAVE_88		0x88
-#define STAT_GENDATA_ACK	0x90
-#define STAT_GENDATA_NAK	0x98
-#define STAT_SLAVE_A0		0xA0
-#define STAT_SLAVE_A8		0xA8
-#define STAT_LOST_ARB_B0	0xB0
-#define STAT_SLAVE_LOST		0xB8
-#define STAT_SLAVE_NAK		0xC0
-#define STAT_SLAVE_ACK		0xC8
-#define STAT_AD2W_ACK		0xD0
-#define STAT_AD2W_NAK		0xD8
-#define STAT_IDLE		0xF8
-
-/* TWSI_INT values */
-#define ST_INT			0x01
-#define TS_INT			0x02
-#define CORE_INT		0x04
-#define ST_EN			0x10
-#define TS_EN			0x20
-#define CORE_EN			0x40
-#define SDA_OVR			0x100
-#define SCL_OVR			0x200
-#define SDA			0x400
-#define SCL			0x800
-
-struct octeon_i2c {
-	wait_queue_head_t	queue;
-	struct i2c_adapter	adap;
-	int			irq;
-	int			hlc_irq;	/* For cn7890 only */
-	u32			twsi_freq;
-	int			sys_freq;
-	void __iomem		*twsi_base;
-	struct device		*dev;
-	int			broken_irq_mode;
-	bool			hlc_enabled;
-	void			(*int_en)	(struct octeon_i2c *);
-	void			(*int_dis)	(struct octeon_i2c *);
-	void			(*hlc_int_en)	(struct octeon_i2c *);
-	void			(*hlc_int_dis)	(struct octeon_i2c *);
-	atomic_t		int_en_cnt;
-	atomic_t		hlc_int_en_cnt;
-};
-
-static int reset_how;
-
-static int timeout = 2;
-module_param(timeout, int, 0444);
-MODULE_PARM_DESC(timeout, "Low-level device timeout (ms)");
-
-/*
- * On some hardware IFLG is not visible in TWSI_CTL until after low-level IRQ,
- * so re-sample CTL a short time later to avoid stalls.
- */
-static int irq_early_us = 80;
-module_param(irq_early_us, int, 0644);
-MODULE_PARM_DESC(irq_early_us, "Re-poll for IFLG after IRQ (us)");
-
-static void writeqflush(u64 val, void __iomem *addr)
-{
-	__raw_writeq(val, addr);
-	__raw_readq(addr);	/* wait for write to land */
-}
-
-/**
- * octeon_i2c_write_sw - write an I2C core register
- * @i2c: The struct octeon_i2c
- * @eop_reg: Register selector
- * @data: Value to be written
- *
- * The I2C core registers are accessed indirectly via the SW_TWSI CSR.
- */
-static void octeon_i2c_write_sw(struct octeon_i2c *i2c, u64 eop_reg, u32 data)
-{
-	u64 tmp;
-
-	__raw_writeq(SW_TWSI_V | eop_reg | data, i2c->twsi_base + SW_TWSI);
-	do
-		tmp = __raw_readq(i2c->twsi_base + SW_TWSI);
-	while ((tmp & SW_TWSI_V) != 0);
-}
-
-/**
- * octeon_i2c_read_sw64 - read an I2C core register
- * @i2c: The struct octeon_i2c
- * @eop_reg: Register selector
- *
- * Returns the data.
- *
- * The I2C core registers are accessed indirectly via the SW_TWSI CSR.
- */
-static u64 octeon_i2c_read_sw64(struct octeon_i2c *i2c, u64 eop_reg)
-{
-	u64 tmp;
-
-	__raw_writeq(SW_TWSI_V | eop_reg | SW_TWSI_R, i2c->twsi_base + SW_TWSI);
-	do
-		tmp = __raw_readq(i2c->twsi_base + SW_TWSI);
-	while ((tmp & SW_TWSI_V) != 0);
-
-	return tmp;
-}
-
-/**
- * octeon_i2c_read_sw - read lower bits of an I2C core register
- * @i2c: The struct octeon_i2c
- * @eop_reg: Register selector
- *
- * Returns the data.
- *
- * The I2C core registers are accessed indirectly via the SW_TWSI CSR.
- */
-static u8 octeon_i2c_read_sw(struct octeon_i2c *i2c, u64 eop_reg)
-{
-	return (u8) octeon_i2c_read_sw64(i2c, eop_reg);
-}
-
-/**
- * octeon_i2c_write_int - write the TWSI_INT register
- * @i2c: The struct octeon_i2c
- * @data: Value to be written
- */
-static void octeon_i2c_write_int(struct octeon_i2c *i2c, u64 data)
-{
-	writeqflush(data, i2c->twsi_base + TWSI_INT);
-}
-
-/**
- * octeon_i2c_int_enable - enable the CORE interrupt
- * @i2c: The struct octeon_i2c
- *
- * The interrupt will be asserted when there is non-STAT_IDLE state in the
- * SW_TWSI_EOP_TWSI_STAT register.
- */
-static void octeon_i2c_int_enable(struct octeon_i2c *i2c)
-{
-	octeon_i2c_write_int(i2c, CORE_EN);
-}
-
-/* disable the CORE interrupt */
-static void octeon_i2c_int_disable(struct octeon_i2c *i2c)
-{
-	/* clear TS/ST/IFLG events */
-	octeon_i2c_write_int(i2c, TS_INT | ST_INT);
-}
-
-static void octeon_i2c_disable_hlc(struct octeon_i2c *i2c)
-{
-	if (!i2c->hlc_enabled)
-		return;
-
-	i2c->hlc_enabled = false;
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
-}
-
-/**
- * octeon_i2c_int_enable78 - enable the CORE interrupt
- * @i2c: The struct octeon_i2c
- *
- * The interrupt will be asserted when there is non-STAT_IDLE state in the
- * SW_TWSI_EOP_TWSI_STAT register.
- */
-static void octeon_i2c_int_enable78(struct octeon_i2c *i2c)
-{
-	atomic_inc_return(&i2c->int_en_cnt);
-	enable_irq(i2c->irq);
-}
-
-static void __octeon_i2c_irq_disable(atomic_t *cnt, int irq)
-{
-	int count;
-
-	/*
-	 * The interrupt can be disabled in two places, but we only
-	 * want to make the disable_irq_nosync() call once, so keep
-	 * track with the atomic variable.
-	 */
-	count = atomic_dec_if_positive(cnt);
-	if (count >= 0)
-		disable_irq_nosync(irq);
-}
-
-/* disable the CORE interrupt */
-static void octeon_i2c_int_disable78(struct octeon_i2c *i2c)
-{
-	__octeon_i2c_irq_disable(&i2c->int_en_cnt, i2c->irq);
-}
-
-/**
- * octeon_i2c_hlc_int_enable78 - enable the ST interrupt
- * @i2c: The struct octeon_i2c
- *
- * The interrupt will be asserted when there is non-STAT_IDLE state in
- * the SW_TWSI_EOP_TWSI_STAT register.
- */
-static void octeon_i2c_hlc_int_enable78(struct octeon_i2c *i2c)
-{
-	atomic_inc_return(&i2c->hlc_int_en_cnt);
-	enable_irq(i2c->hlc_irq);
-}
-
-/* disable the ST interrupt */
-static void octeon_i2c_hlc_int_disable78(struct octeon_i2c *i2c)
-{
-	__octeon_i2c_irq_disable(&i2c->hlc_int_en_cnt, i2c->hlc_irq);
-}
-
-/**
- * bitbang_unblock - unblock the bus
- * @i2c: The struct octeon_i2c
- *
- * If there was a reset while a device was driving 0 to bus, bus is blocked.
- * We toggle it free manually by some clock cycles and send a stop.
- */
-static void bitbang_unblock(struct octeon_i2c *i2c)
-{
-	int state, i;
-
-	octeon_i2c_disable_hlc(i2c);
-	dev_dbg(i2c->dev, "%s\n", __func__);
-
-	/* cycle 8+1 clocks with SDA high */
-	for (i = 0; i < 9; i++) {
-		octeon_i2c_write_int(i2c, 0);
-		udelay(5);
-		state = __raw_readq(i2c->twsi_base + TWSI_INT);
-		if (state & (SDA | SCL))
-			break;
-		octeon_i2c_write_int(i2c, SCL_OVR);
-		udelay(5);
-	}
-	/* hand-crank a STOP */
-	octeon_i2c_write_int(i2c, SDA_OVR | SCL_OVR);
-	udelay(5);
-	octeon_i2c_write_int(i2c, SDA_OVR);
-	udelay(5);
-	octeon_i2c_write_int(i2c, 0);
-}
-
-/* interrupt service routine */
-static irqreturn_t octeon_i2c_isr(int irq, void *dev_id)
-{
-	struct octeon_i2c *i2c = dev_id;
-
-	i2c->int_dis(i2c);
-	wake_up(&i2c->queue);
-
-	return IRQ_HANDLED;
-}
-
-/* interrupt service routine */
-static irqreturn_t octeon_i2c_hlc_isr78(int irq, void *dev_id)
-{
-	struct octeon_i2c *i2c = dev_id;
-
-	i2c->hlc_int_dis(i2c);
-	wake_up(&i2c->queue);
-
-	return IRQ_HANDLED;
-}
-
-static u64 octeon_i2c_read_ctl(struct octeon_i2c *i2c)
-{
-	return octeon_i2c_read_sw64(i2c, SW_TWSI_EOP_TWSI_CTL);
-}
-
-static int octeon_i2c_test_iflg(struct octeon_i2c *i2c)
-{
-	return (octeon_i2c_read_ctl(i2c) & TWSI_CTL_IFLG) != 0;
-}
-
-/*
- * Wait-helper which addresses the delayed-IFLAG problem by re-polling for
- * missing TWSI_CTL[IFLG] a few us later, when irq has signalled an event,
- * but none found. Skip this re-poll on the first (non-wakeup) call.
- */
-static int poll_iflg(struct octeon_i2c *i2c, int *first_p)
-{
-	int iflg = octeon_i2c_test_iflg(i2c);
-
-	if (iflg)
-		return 1;
-	if (*first_p)
-		*first_p = 0;
-	else {
-		usleep_range(irq_early_us, 2 * irq_early_us);
-		iflg = octeon_i2c_test_iflg(i2c);
-	}
-	return iflg;
-}
-
-/**
- * octeon_i2c_wait - wait for the IFLG to be set
- * @i2c: The struct octeon_i2c
- *
- * Returns 0 on success, otherwise a negative errno.
- */
-static int octeon_i2c_wait(struct octeon_i2c *i2c)
-{
-	int first = 1;
-	long result;
-
-	if (i2c->broken_irq_mode) {
-		/*
-		 * Some chip revisions seem to not assert the irq in
-		 * the interrupt controller.  So we must poll for the
-		 * IFLG change.
-		 */
-		u64 end = get_jiffies_64() + i2c->adap.timeout;
-
-		while (!octeon_i2c_test_iflg(i2c) &&
-		       time_before64(get_jiffies_64(), end))
-			udelay(50);
-
-		return octeon_i2c_test_iflg(i2c) ? 0 : -ETIMEDOUT;
-	}
-
-	i2c->int_en(i2c);
-	result = wait_event_timeout(i2c->queue, poll_iflg(i2c, &first),
-				    i2c->adap.timeout);
-	i2c->int_dis(i2c);
-
-	if (result <= 0 && OCTEON_IS_MODEL(OCTEON_CN38XX) &&
-	    octeon_i2c_test_iflg(i2c)) {
-		dev_err(i2c->dev,
-			"broken irq connection detected, switching to polling mode.\n");
-		i2c->broken_irq_mode = 1;
-		return 0;
-	}
-	if (!result) {
-		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
-		return -ETIMEDOUT;
-	}
-	return 0;
-}
-
-/*
- * Cleanup low-level state & enable high-level.
- *
- * Returns -EAGAIN if low-level state could not be cleaned
- */
-static int octeon_i2c_enable_hlc(struct octeon_i2c *i2c)
-{
-	int try = 0, ret = 0;
-	u64 val;
-
-	if (i2c->hlc_enabled)
-		return 0;
-
-	i2c->hlc_enabled = true;
-
-	while (1) {
-		val = octeon_i2c_read_ctl(i2c) & (TWSI_CTL_STA | TWSI_CTL_STP);
-		if (!val)
-			break;
-
-		/* clear _IFLG event */
-		if (val & TWSI_CTL_IFLG)
-			octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
-					    TWSI_CTL_ENAB);
-
-		if (try++ > 100) {
-			pr_err("%s: giving up\n", __func__);
-			ret = -EAGAIN;
-			break;
-		}
-
-		/* spin until any start/stop has finished */
-		udelay(10);
-	}
-
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
-			    TWSI_CTL_CE | TWSI_CTL_AAK | TWSI_CTL_ENAB);
-	return ret;
-}
-
-static int octeon_i2c_lost_arb(u8 code, int final_read)
-{
-	switch (code) {
-	/* Arbitration lost */
-	case STAT_LOST_ARB_38:
-	case STAT_LOST_ARB_68:
-	case STAT_LOST_ARB_78:
-	case STAT_LOST_ARB_B0:
-		return -EAGAIN;
-
-	/* Being addressed as slave, should back off & listen */
-	case STAT_SLAVE_60:
-	case STAT_SLAVE_70:
-	case STAT_GENDATA_ACK:
-	case STAT_GENDATA_NAK:
-		return -EIO;
-
-	/* Core busy as slave */
-	case STAT_SLAVE_80:
-	case STAT_SLAVE_88:
-	case STAT_SLAVE_A0:
-	case STAT_SLAVE_A8:
-	case STAT_SLAVE_LOST:
-	case STAT_SLAVE_NAK:
-	case STAT_SLAVE_ACK:
-		return -EIO;
-
-	/* ACK allowed on pre-terminal bytes only */
-	case STAT_RXDATA_ACK:
-		if (!final_read)
-			return 0;
-		return -EAGAIN;
-
-	/* NAK allowed on terminal byte only */
-	case STAT_RXDATA_NAK:
-		if (final_read)
-			return 0;
-		return -EAGAIN;
-	case STAT_TXDATA_NAK:
-	case STAT_TXADDR_NAK:
-	case STAT_RXADDR_NAK:
-	case STAT_AD2W_NAK:
-		return -EAGAIN;
-	}
-	return 0;
-}
-
-static int check_arb(struct octeon_i2c *i2c, int final_read)
-{
-	return octeon_i2c_lost_arb(octeon_i2c_read_sw(i2c,
-			SW_TWSI_EOP_TWSI_STAT),	final_read);
-}
-
-/* send STOP to the bus */
-static void octeon_i2c_stop(struct octeon_i2c *i2c)
-{
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
-			    TWSI_CTL_ENAB | TWSI_CTL_STP);
-}
-
-static int octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
-{
-	u8 status = 0;
-	int tries;
-
-	/* reset controller */
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_RST, 0);
-
-	for (tries = 10; tries && status != STAT_IDLE; tries--) {
-		udelay(1);
-		status = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
-	}
-
-	if (status != STAT_IDLE) {
-		dev_err(i2c->dev, "%s: TWSI_RST failed! (0x%x)\n",
-			__func__, status);
-		return -EIO;
-	}
-
-	/* toggle twice to force both teardowns */
-	octeon_i2c_enable_hlc(i2c);
-	octeon_i2c_disable_hlc(i2c);
-	return 0;
-}
-
-/*
- * TWSI state seems stuck. Not sure if it's TWSI-engine state or something
- * else on bus. The initial _stop() is always harmless, it just resets state
- * machine, does not _transmit_ STOP unless engine was active.
- */
-static int start_unstick(struct octeon_i2c *i2c)
-{
-	octeon_i2c_stop(i2c);
-
-	/*
-	 * Response is escalated over successive calls,
-	 * as EAGAIN provokes retries from i2c/core.
-	 */
-	switch (reset_how++ % 4) {
-	case 0:
-		/* just the stop above */
-		break;
-	case 1:
-		/*
-		 * Controller refused to send start flag. May be a
-		 * client is holding SDA low? Let's try to free it.
-		 */
-		bitbang_unblock(i2c);
-		break;
-	case 2:
-		/* re-init our TWSI hardware */
-		octeon_i2c_initlowlevel(i2c);
-		break;
-	default:
-		/* retry in caller */
-		reset_how = 0;
-		return -EAGAIN;
-	}
-	return 0;
-}
-
-/**
- * octeon_i2c_start - send START to the bus
- * @i2c: The struct octeon_i2c
- * @first: first msg in combined operation?
- *
- * Returns 0 on success, otherwise a negative errno.
- */
-static int octeon_i2c_start(struct octeon_i2c *i2c, int first)
-{
-	int result;
-	u8 data;
-
-	octeon_i2c_disable_hlc(i2c);
-
-	while (1) {
-		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
-				    TWSI_CTL_ENAB | TWSI_CTL_STA);
-
-		result = octeon_i2c_wait(i2c);
-		data = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
-
-		switch (data) {
-		case STAT_START:
-		case STAT_RSTART:
-			if (!first)
-				return -EAGAIN;
-			reset_how = 0;
-			return 0;
-		case STAT_RXADDR_ACK:
-			if (first)
-				return -EAGAIN;
-			return start_unstick(i2c);
-		/*
-		 * case STAT_IDLE:
-		 * case STAT_ERROR:
-		 */
-		default:
-			if (!first)
-				return -EAGAIN;
-			start_unstick(i2c);
-		}
-	}
-	return 0;
-}
-
-/**
- * octeon_i2c_write - send data to the bus via low-level controller
- * @i2c: The struct octeon_i2c
- * @target: Target address
- * @data: Pointer to the data to be sent
- * @length: Length of the data
- * @last: is last msg in combined operation?
- *
- * The address is sent over the bus, then the data.
- *
- * Returns 0 on success, otherwise a negative errno.
- */
-static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
-			    u8 *data, int length, int first, int last)
-{
-	int result, i;
-
-	result = octeon_i2c_start(i2c, first);
-	if (result)
-		return result;
-
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, target << 1);
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
-
-	result = octeon_i2c_wait(i2c);
-	if (result)
-		return result;
-
-	for (i = 0; i < length; i++) {
-		result = check_arb(i2c, false);
-		if (result)
-			return result;
-
-		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, data[i]);
-		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
-
-		result = octeon_i2c_wait(i2c);
-		if (result)
-			return result;
-		result = check_arb(i2c, false);
-		if (result)
-			return result;
-	}
-
-	return 0;
-}
-
-/**
- * octeon_i2c_read - receive data from the bus via low-level controller
- * @i2c: The struct octeon_i2c
- * @target: Target address
- * @data: Pointer to the location to store the data
- * @rlength: Length of the data
- * @phase: which phase of a combined operation.
- * @recv_len: flag for length byte
- *
- * The address is sent over the bus, then the data is read.
- *
- * Returns 0 on success, otherwise a negative errno.
- */
-static int octeon_i2c_read(struct octeon_i2c *i2c, int target, u8 *data,
-			   u16 *rlength, bool first, bool last, bool recv_len)
-{
-	u8 ctl = TWSI_CTL_ENAB | TWSI_CTL_AAK;
-	int length = *rlength;
-	int i, result;
-	u8 tmp;
-
-	if (length < 1)
-		return -EINVAL;
-
-	result = octeon_i2c_start(i2c, first);
-	if (result)
-		return result;
-
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, (target<<1) | 1);
-
-	for (i = 0; i < length; ) {
-		tmp = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
-		result = octeon_i2c_lost_arb(tmp, !(ctl & TWSI_CTL_AAK));
-		if (result)
-			return result;
-
-		switch (tmp) {
-		case STAT_RXDATA_ACK:
-		case STAT_RXDATA_NAK:
-			data[i++] = octeon_i2c_read_sw(i2c,
-					SW_TWSI_EOP_TWSI_DATA);
-		}
-
-		/* NAK last recv'd byte, as a no-more-please */
-		if (last && i == length - 1)
-			ctl &= ~TWSI_CTL_AAK;
-
-		/* clr iflg to allow next event */
-		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, ctl);
-		result = octeon_i2c_wait(i2c);
-		if (result)
-			return result;
-		if (recv_len && i == 0) {
-			if (data[i] > I2C_SMBUS_BLOCK_MAX + 1) {
-				dev_err(i2c->dev,
-					"%s: read len > I2C_SMBUS_BLOCK_MAX %d\n",
-					__func__, data[i]);
-				return -EIO;
-			}
-			length += data[i];
-		}
-	}
-	*rlength = length;
-	return 0;
-}
-
-static bool octeon_i2c_hlc_test_ready(struct octeon_i2c *i2c)
-{
-	u64 val = __raw_readq(i2c->twsi_base + SW_TWSI);
-
-	return (val & SW_TWSI_V) == 0;
-}
-
-static void octeon_i2c_hlc_int_enable(struct octeon_i2c *i2c)
-{
-	octeon_i2c_write_int(i2c, ST_EN);
-}
-
-static void octeon_i2c_hlc_int_clear(struct octeon_i2c *i2c)
-{
-	/* clear ST/TS events, listen for neither */
-	octeon_i2c_write_int(i2c, ST_INT | TS_INT);
-}
-
-/**
- * octeon_i2c_hlc_wait - wait for an HLC operation to complete
- * @i2c: The struct octeon_i2c
- *
- * Returns 0 on success, otherwise a negative errno.
- */
-static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
-{
-	int result;
-
-	if (i2c->broken_irq_mode) {
-		/*
-		 * Some cn38xx boards did not assert the irq in
-		 * the interrupt controller.  So we must poll for the
-		 * IFLG change.
-		 */
-		u64 end = get_jiffies_64() + i2c->adap.timeout;
-
-		while (!octeon_i2c_hlc_test_ready(i2c) &&
-		       time_before64(get_jiffies_64(), end))
-			udelay(50);
-
-		return octeon_i2c_hlc_test_ready(i2c) ? 0 : -ETIMEDOUT;
-	}
-
-	i2c->hlc_int_en(i2c);
-	result = wait_event_interruptible_timeout(i2c->queue,
-			octeon_i2c_hlc_test_ready(i2c), i2c->adap.timeout);
-	i2c->hlc_int_dis(i2c);
-	if (!result)
-		octeon_i2c_hlc_int_clear(i2c);
-
-	if (result <= 0 && OCTEON_IS_MODEL(OCTEON_CN38XX) &&
-	    octeon_i2c_hlc_test_ready(i2c)) {
-		dev_err(i2c->dev, "broken irq connection detected, switching to polling mode.\n");
-			i2c->broken_irq_mode = 1;
-			return 0;
-	}
-
-	if (result < 0) {
-		dev_dbg(i2c->dev, "%s: wait interrupted\n", __func__);
-		return result;
-	} else if (!result) {
-		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
-		return -ETIMEDOUT;
-	}
-	return 0;
-}
-
-/* high-level-controller pure read of up to 8 bytes */
-static int octeon_i2c_simple_read(struct octeon_i2c *i2c, struct i2c_msg *msgs)
-{
-	int i, j, ret = 0;
-	u64 cmd;
-
-	octeon_i2c_enable_hlc(i2c);
-	cmd = SW_TWSI_V | SW_TWSI_R | SW_TWSI_SOVR;
-	/* SIZE */
-	cmd |= (u64) (msgs[0].len - 1) << SW_TWSI_SIZE_SHIFT;
-	/* A */
-	cmd |= (u64) (msgs[0].addr & 0x7full) << SW_TWSI_A_SHIFT;
-
-	if (msgs[0].flags & I2C_M_TEN)
-		cmd |= SW_TWSI_OP_10;
-	else
-		cmd |= SW_TWSI_OP_7;
-
-	octeon_i2c_hlc_int_clear(i2c);
-	__raw_writeq(cmd, i2c->twsi_base + SW_TWSI);
-
-	ret = octeon_i2c_hlc_wait(i2c);
-	if (ret)
-		goto err;
-
-	cmd = __raw_readq(i2c->twsi_base + SW_TWSI);
-	if ((cmd & SW_TWSI_R) == 0)
-		return -EAGAIN;
-
-	for (i = 0, j = msgs[0].len - 1; i  < msgs[0].len && i < 4; i++, j--)
-		msgs[0].buf[j] = (cmd >> (8 * i)) & 0xff;
-
-	if (msgs[0].len > 4) {
-		cmd = __raw_readq(i2c->twsi_base + SW_TWSI_EXT);
-		for (i = 0; i  < msgs[0].len - 4 && i < 4; i++, j--)
-			msgs[0].buf[j] = (cmd >> (8 * i)) & 0xff;
-	}
-
-err:
-	return ret;
-}
-
-/* high-level-controller pure write of up to 8 bytes */
-static int octeon_i2c_simple_write(struct octeon_i2c *i2c, struct i2c_msg *msgs)
-{
-	int i, j, ret = 0;
-	u64 cmd;
-
-	octeon_i2c_enable_hlc(i2c);
-	octeon_i2c_hlc_int_clear(i2c);
-
-	ret = check_arb(i2c, false);
-	if (ret)
-		goto err;
-
-	cmd = SW_TWSI_V | SW_TWSI_SOVR;
-	/* SIZE */
-	cmd |= (u64) (msgs[0].len - 1) << SW_TWSI_SIZE_SHIFT;
-	/* A */
-	cmd |= (u64) (msgs[0].addr & 0x7full) << SW_TWSI_A_SHIFT;
-
-	if (msgs[0].flags & I2C_M_TEN)
-		cmd |= SW_TWSI_OP_10;
-	else
-		cmd |= SW_TWSI_OP_7;
-
-	for (i = 0, j = msgs[0].len - 1; i  < msgs[0].len && i < 4; i++, j--)
-		cmd |= (u64)msgs[0].buf[j] << (8 * i);
-
-	if (msgs[0].len > 4) {
-		u64 ext = 0;
-
-		for (i = 0; i < msgs[0].len - 4 && i < 4; i++, j--)
-			ext |= (u64) msgs[0].buf[j] << (8 * i);
-		writeqflush(ext, i2c->twsi_base + SW_TWSI_EXT);
-	}
-
-	writeqflush(cmd, i2c->twsi_base + SW_TWSI);
-
-	ret = octeon_i2c_hlc_wait(i2c);
-	if (ret)
-		goto err;
-
-	cmd = __raw_readq(i2c->twsi_base + SW_TWSI);
-	if ((cmd & SW_TWSI_R) == 0)
-		return -EAGAIN;
-
-	ret = check_arb(i2c, false);
-
-err:
-	return ret;
-}
-
-/* high-level-controller composite write+read, msg0=addr, msg1=data */
-static int octeon_i2c_ia_read(struct octeon_i2c *i2c, struct i2c_msg *msgs)
-{
-	int i, j, ret = 0;
-	u64 cmd;
-
-	octeon_i2c_enable_hlc(i2c);
-
-	cmd = SW_TWSI_V | SW_TWSI_R | SW_TWSI_SOVR;
-	/* SIZE */
-	cmd |= (u64)(msgs[1].len - 1) << SW_TWSI_SIZE_SHIFT;
-	/* A */
-	cmd |= (u64)(msgs[0].addr & 0x7full) << SW_TWSI_A_SHIFT;
-
-	if (msgs[0].flags & I2C_M_TEN)
-		cmd |= SW_TWSI_OP_10_IA;
-	else
-		cmd |= SW_TWSI_OP_7_IA;
-
-	if (msgs[0].len == 2) {
-		u64 ext = 0;
-
-		cmd |= SW_TWSI_EIA;
-		ext = (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
-		cmd |= (u64) msgs[0].buf[1] << SW_TWSI_IA_SHIFT;
-		__raw_writeq(ext, i2c->twsi_base + SW_TWSI_EXT);
-	} else
-		cmd |= (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
-
-	octeon_i2c_hlc_int_clear(i2c);
-	writeqflush(cmd, i2c->twsi_base + SW_TWSI);
-
-	ret = octeon_i2c_hlc_wait(i2c);
-	if (ret)
-		goto err;
-
-	cmd = __raw_readq(i2c->twsi_base + SW_TWSI);
-	if ((cmd & SW_TWSI_R) == 0)
-		return -EAGAIN;
-
-	for (i = 0, j = msgs[1].len - 1; i  < msgs[1].len && i < 4; i++, j--)
-		msgs[1].buf[j] = (cmd >> (8 * i)) & 0xff;
-
-	if (msgs[1].len > 4) {
-		cmd = __raw_readq(i2c->twsi_base + SW_TWSI_EXT);
-		for (i = 0; i  < msgs[1].len - 4 && i < 4; i++, j--)
-			msgs[1].buf[j] = (cmd >> (8 * i)) & 0xff;
-	}
-
-err:
-	return ret;
-}
-
-/* high-level-controller composite write+write, m[0]len<=2, m[1]len<=8 */
-static int octeon_i2c_ia_write(struct octeon_i2c *i2c, struct i2c_msg *msgs)
-{
-	bool set_ext = false;
-	int i, j, ret = 0;
-	u64 cmd, ext = 0;
-
-	octeon_i2c_enable_hlc(i2c);
-
-	cmd = SW_TWSI_V | SW_TWSI_SOVR;
-	/* SIZE */
-	cmd |= (u64) (msgs[1].len - 1) << SW_TWSI_SIZE_SHIFT;
-	/* A */
-	cmd |= (u64) (msgs[0].addr & 0x7full) << SW_TWSI_A_SHIFT;
-
-	if (msgs[0].flags & I2C_M_TEN)
-		cmd |= SW_TWSI_OP_10_IA;
-	else
-		cmd |= SW_TWSI_OP_7_IA;
-
-	if (msgs[0].len == 2) {
-		cmd |= SW_TWSI_EIA;
-		ext |= (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
-		set_ext = true;
-		cmd |= (u64) msgs[0].buf[1] << SW_TWSI_IA_SHIFT;
-	} else
-		cmd |= (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
-
-	for (i = 0, j = msgs[1].len - 1; i  < msgs[1].len && i < 4; i++, j--)
-		cmd |= (u64) msgs[1].buf[j] << (8 * i);
-
-	if (msgs[1].len > 4) {
-		for (i = 0; i < msgs[1].len - 4 && i < 4; i++, j--)
-			ext |= (u64)msgs[1].buf[j] << (8 * i);
-		set_ext = true;
-	}
-	if (set_ext)
-		writeqflush(ext, i2c->twsi_base + SW_TWSI_EXT);
-
-	octeon_i2c_hlc_int_clear(i2c);
-	writeqflush(cmd, i2c->twsi_base + SW_TWSI);
-
-	ret = octeon_i2c_hlc_wait(i2c);
-	if (ret)
-		goto err;
-
-	cmd = octeon_i2c_read_sw64(i2c, SW_TWSI_EOP_TWSI_STAT);
-	if ((cmd & SW_TWSI_R) == 0)
-		return -EAGAIN;
-	ret = octeon_i2c_lost_arb(cmd, false);
-
-err:
-	return ret;
-}
-
-/**
- * octeon_i2c_xfer - The driver's master_xfer function
- * @adap: Pointer to the i2c_adapter structure
- * @msgs: Pointer to the messages to be processed
- * @num: Length of the MSGS array
- *
- * Returns the number of messages processed, or a negative errno on failure.
- */
-static int octeon_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
-			   int num)
-{
-	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
-	int i, ret = 0;
-
-	if (num == 1) {
-		if (msgs[0].len > 0 && msgs[0].len <= 8) {
-			if (msgs[0].flags & I2C_M_RD)
-				ret = octeon_i2c_simple_read(i2c, msgs);
-			else
-				ret = octeon_i2c_simple_write(i2c, msgs);
-			goto out;
-		}
-	} else if (num == 2) {
-		if ((msgs[0].flags & I2C_M_RD) == 0 &&
-		    (msgs[1].flags & I2C_M_RECV_LEN) == 0 &&
-		    msgs[0].len > 0 && msgs[0].len <= 2 &&
-		    msgs[1].len > 0 && msgs[1].len <= 8 &&
-		    msgs[0].addr == msgs[1].addr) {
-			if (msgs[1].flags & I2C_M_RD)
-				ret = octeon_i2c_ia_read(i2c, msgs);
-			else
-				ret = octeon_i2c_ia_write(i2c, msgs);
-			goto out;
-		}
-	}
-
-	for (i = 0; ret == 0 && i < num; i++) {
-		struct i2c_msg *pmsg = &msgs[i];
-		bool last = (i == (num - 1));
-
-		dev_dbg(i2c->dev,
-			"Doing %s %d byte(s) to/from 0x%02x - %d of %d messages\n",
-			 pmsg->flags & I2C_M_RD ? "read" : "write",
-			 pmsg->len, pmsg->addr, i + 1, num);
-		if (pmsg->flags & I2C_M_RD)
-			ret = octeon_i2c_read(i2c, pmsg->addr, pmsg->buf,
-					      &pmsg->len, !i, last,
-					      pmsg->flags & I2C_M_RECV_LEN);
-		else
-			ret = octeon_i2c_write(i2c, pmsg->addr, pmsg->buf,
-					       pmsg->len, !i, last);
-	}
-	octeon_i2c_stop(i2c);
-out:
-	return ret ? -EAGAIN : num;
-}
-
-static u32 octeon_i2c_functionality(struct i2c_adapter *adap)
-{
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
-}
-
-static const struct i2c_algorithm octeon_i2c_algo = {
-	.master_xfer = octeon_i2c_xfer,
-	.functionality = octeon_i2c_functionality,
-};
-
-static struct i2c_adapter octeon_i2c_ops = {
-	.owner = THIS_MODULE,
-	.name = "OCTEON adapter",
-	.algo = &octeon_i2c_algo,
-};
-
-/* calculate and set clock divisors */
-static void octeon_i2c_setclock(struct octeon_i2c *i2c)
-{
-	int tclk, thp_base, inc, thp_idx, mdiv_idx, ndiv_idx, foscl, diff;
-	int thp = 0x18, mdiv = 2, ndiv = 0, delta_hz = 1000000;
-
-	for (ndiv_idx = 0; ndiv_idx < 8 && delta_hz != 0; ndiv_idx++) {
-		/*
-		 * An mdiv value of less than 2 seems to not work well
-		 * with ds1337 RTCs, so we constrain it to larger values.
-		 */
-		for (mdiv_idx = 15; mdiv_idx >= 2 && delta_hz != 0; mdiv_idx--) {
-			/*
-			 * For given ndiv and mdiv values check the
-			 * two closest thp values.
-			 */
-			tclk = i2c->twsi_freq * (mdiv_idx + 1) * 10;
-			tclk *= (1 << ndiv_idx);
-			thp_base = (i2c->sys_freq / (tclk * 2)) - 1;
-
-			for (inc = 0; inc <= 1; inc++) {
-				thp_idx = thp_base + inc;
-				if (thp_idx < 5 || thp_idx > 0xff)
-					continue;
-
-				foscl = i2c->sys_freq / (2 * (thp_idx + 1));
-				foscl = foscl / (1 << ndiv_idx);
-				foscl = foscl / (mdiv_idx + 1) / 10;
-				diff = abs(foscl - i2c->twsi_freq);
-				if (diff < delta_hz) {
-					delta_hz = diff;
-					thp = thp_idx;
-					mdiv = mdiv_idx;
-					ndiv = ndiv_idx;
-				}
-			}
-		}
-	}
-	octeon_i2c_write_sw(i2c, SW_TWSI_OP_TWSI_CLK, thp);
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CLKCTL, (mdiv << 3) | ndiv);
-}
-
-static int octeon_i2c_probe(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	int irq, hlc_irq = 0, result = 0;
-	struct resource *res_mem;
-	struct octeon_i2c *i2c;
-	bool cn78xx_style;
-
-	cn78xx_style = of_device_is_compatible(node, "cavium,octeon-7890-twsi");
-	if (cn78xx_style) {
-		hlc_irq = platform_get_irq(pdev, 0);
-		if (hlc_irq < 0)
-			return hlc_irq;
-
-		irq = platform_get_irq(pdev, 2);
-		if (irq < 0)
-			return irq;
-	} else {
-		/* All adaptors have an irq.  */
-		irq = platform_get_irq(pdev, 0);
-		if (irq < 0)
-			return irq;
-	}
-
-	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
-	if (!i2c) {
-		result = -ENOMEM;
-		goto out;
-	}
-	i2c->dev = &pdev->dev;
-
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	if (res_mem == NULL) {
-		dev_err(i2c->dev, "found no memory resource\n");
-		result = -ENXIO;
-		goto out;
-	}
-
-	/*
-	 * "clock-rate" is a legacy binding, the official binding is
-	 * "clock-frequency".  Try the official one first and then
-	 * fall back if it doesn't exist.
-	 */
-	if (of_property_read_u32(node, "clock-frequency", &i2c->twsi_freq) &&
-	    of_property_read_u32(node, "clock-rate", &i2c->twsi_freq)) {
-		dev_err(i2c->dev,
-			"no I2C 'clock-rate' or 'clock-frequency' property\n");
-		result = -ENXIO;
-		goto out;
-	}
-
-	i2c->sys_freq = octeon_get_io_clock_rate();
-
-	if (!devm_request_mem_region(&pdev->dev, res_mem->start,
-				     resource_size(res_mem), res_mem->name)) {
-		dev_err(i2c->dev, "request_mem_region failed\n");
-		goto out;
-	}
-
-	i2c->twsi_base = devm_ioremap(&pdev->dev, res_mem->start,
-				      resource_size(res_mem));
-	init_waitqueue_head(&i2c->queue);
-	i2c->irq = irq;
-
-	if (cn78xx_style) {
-		i2c->hlc_irq = hlc_irq;
-
-		i2c->int_en = octeon_i2c_int_enable78;
-		i2c->int_dis = octeon_i2c_int_disable78;
-		i2c->hlc_int_en = octeon_i2c_hlc_int_enable78;
-		i2c->hlc_int_dis = octeon_i2c_hlc_int_disable78;
-
-		irq_set_status_flags(i2c->irq, IRQ_NOAUTOEN);
-		irq_set_status_flags(i2c->hlc_irq, IRQ_NOAUTOEN);
-
-		result = devm_request_irq(&pdev->dev, i2c->irq,
-					  octeon_i2c_isr, 0, DRV_NAME, i2c);
-
-		if (result < 0) {
-			dev_err(i2c->dev, "failed to attach interrupt\n");
-			goto out;
-		}
-		result = devm_request_irq(&pdev->dev, i2c->hlc_irq,
-					  octeon_i2c_hlc_isr78, 0,
-					  DRV_NAME, i2c);
-
-		if (result < 0) {
-			dev_err(i2c->dev, "failed to attach interrupt\n");
-			goto out;
-		}
-	} else {
-		i2c->int_en = octeon_i2c_int_enable;
-		i2c->int_dis = octeon_i2c_int_disable;
-		i2c->hlc_int_en = octeon_i2c_hlc_int_enable;
-		i2c->hlc_int_dis = octeon_i2c_int_disable;
-
-		result = devm_request_irq(&pdev->dev, i2c->irq,
-					  octeon_i2c_isr, 0, DRV_NAME, i2c);
-		if (result < 0) {
-			dev_err(i2c->dev, "failed to attach interrupt\n");
-			goto out;
-		}
-	}
-
-	result = octeon_i2c_initlowlevel(i2c);
-	if (result) {
-		dev_err(i2c->dev, "init low level failed\n");
-		goto  out;
-	}
-
-	octeon_i2c_setclock(i2c);
-
-	i2c->adap = octeon_i2c_ops;
-	i2c->adap.timeout = msecs_to_jiffies(timeout);
-	i2c->adap.retries = 10;
-	i2c->adap.dev.parent = &pdev->dev;
-	i2c->adap.dev.of_node = node;
-	i2c_set_adapdata(&i2c->adap, i2c);
-	platform_set_drvdata(pdev, i2c);
-
-	result = i2c_add_adapter(&i2c->adap);
-	if (result < 0) {
-		dev_err(i2c->dev, "failed to add adapter\n");
-		goto out;
-	}
-	dev_info(i2c->dev, "probed\n");
-	return 0;
-
-out:
-	return result;
-};
-
-static int octeon_i2c_remove(struct platform_device *pdev)
-{
-	struct octeon_i2c *i2c = platform_get_drvdata(pdev);
-
-	i2c_del_adapter(&i2c->adap);
-	return 0;
-};
-
-static const struct of_device_id octeon_i2c_match[] = {
-	{	.compatible = "cavium,octeon-3860-twsi",	},
-	{	.compatible = "cavium,octeon-7890-twsi",	},
-	{},
-};
-MODULE_DEVICE_TABLE(of, octeon_i2c_match);
-
-static struct platform_driver octeon_i2c_driver = {
-	.probe		= octeon_i2c_probe,
-	.remove		= octeon_i2c_remove,
-	.driver		= {
-		.name	= DRV_NAME,
-		.of_match_table = octeon_i2c_match,
-	},
-};
-
-module_platform_driver(octeon_i2c_driver);
-
-MODULE_AUTHOR("Michael Lawnick <michael.lawnick.ext@nsn.com>");
-MODULE_DESCRIPTION("I2C-Bus adapter for Cavium OCTEON processors");
-MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-thunderx-core.c b/drivers/i2c/busses/i2c-thunderx-core.c
new file mode 100644
index 0000000..0a95891
--- /dev/null
+++ b/drivers/i2c/busses/i2c-thunderx-core.c
@@ -0,0 +1,263 @@
+/*
+ * Cavium ThunderX i2c driver.
+ *
+ * Copyright (C) 2015,2016 Cavium Inc.
+ * Authors: Fred Martin <fmartin@caviumnetworks.com>
+ *	    Jan Glauber <jglauber@cavium.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "i2c-cavium.h"
+
+#define DRV_NAME			"i2c-thunderx"
+
+#define PCI_CFG_REG_BAR_NUM		0
+#define PCI_DEVICE_ID_THUNDER_TWSI	0xa012
+
+#define TWSI_DFL_RATE			100000
+#define SYS_FREQ_DEFAULT		800000000
+
+/*
+ * Enable the CORE interrupt.
+ * The interrupt will be asserted when there is non-STAT_IDLE state in the
+ * SW_TWSI_EOP_TWSI_STAT register.
+ */
+static void thunder_i2c_int_enable(struct octeon_i2c *i2c)
+{
+	__raw_writeq(INT_ENA_CORE, i2c->twsi_base + TWSI_INT_ENA_W1S);
+	__raw_readq(i2c->twsi_base + TWSI_INT_ENA_W1S);
+}
+
+/*
+ * Disable the CORE interrupt.
+ */
+static void thunder_i2c_int_disable(struct octeon_i2c *i2c)
+{
+	__raw_writeq(INT_ENA_CORE, i2c->twsi_base + TWSI_INT_ENA_W1C);
+	__raw_readq(i2c->twsi_base + TWSI_INT_ENA_W1C);
+}
+
+static void thunder_i2c_hlc_int_enable(struct octeon_i2c *i2c)
+{
+	__raw_writeq(INT_ENA_ST | INT_ENA_TS,
+		     i2c->twsi_base + TWSI_INT_ENA_W1S);
+	__raw_readq(i2c->twsi_base + TWSI_INT_ENA_W1S);
+}
+
+static void thunder_i2c_hlc_int_disable(struct octeon_i2c *i2c)
+{
+	__raw_writeq(INT_ENA_ST | INT_ENA_TS,
+		     i2c->twsi_base + TWSI_INT_ENA_W1C);
+	__raw_readq(i2c->twsi_base + TWSI_INT_ENA_W1C);
+}
+
+static u32 thunderx_i2c_functionality(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm thunderx_i2c_algo = {
+	.master_xfer = octeon_i2c_xfer,
+	.functionality = thunderx_i2c_functionality,
+};
+
+static struct i2c_adapter thunderx_i2c_ops = {
+	.owner	= THIS_MODULE,
+	.name	= "ThunderX adapter",
+	.algo	= &thunderx_i2c_algo,
+};
+
+static void thunder_i2c_clock_enable(struct device *dev, struct octeon_i2c *i2c)
+{
+	int ret;
+
+	i2c->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(i2c->clk)) {
+		i2c->clk = NULL;
+		goto skip;
+	}
+
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret)
+		goto skip;
+	i2c->sys_freq = clk_get_rate(i2c->clk);
+
+skip:
+	if (!i2c->sys_freq)
+		i2c->sys_freq = SYS_FREQ_DEFAULT;
+
+	dev_info(dev, "Set system clock to %u\n", i2c->sys_freq);
+}
+
+static void thunder_i2c_clock_disable(struct device *dev, struct clk *clk)
+{
+	if (!clk)
+		return;
+	clk_disable_unprepare(clk);
+	devm_clk_put(dev, clk);
+}
+
+static void thunder_i2c_set_name(struct pci_dev *pdev, struct octeon_i2c *i2c,
+				 char *name)
+{
+	u8 i2c_bus_id, soc_node;
+	resource_size_t start;
+
+	start = pci_resource_start(pdev, PCI_CFG_REG_BAR_NUM);
+	soc_node = (start >> 44) & 0x3;
+	i2c_bus_id = (start >> 24) & 0x7;
+	snprintf(name, 10, "i2c%d", soc_node * 6 + i2c_bus_id);
+
+	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "thunderx-i2c-%d.%d",
+		 soc_node, i2c_bus_id);
+}
+
+static int thunder_i2c_probe_pci(struct pci_dev *pdev,
+				 const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = NULL;
+	struct octeon_i2c *i2c;
+	char i2c_name[10];
+	int ret = 0;
+
+	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+
+	i2c->dev = dev;
+	pci_set_drvdata(pdev, i2c);
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		dev_err(dev, "Failed to enable PCI device\n");
+		goto out_free_i2c;
+	}
+
+	ret = pci_request_regions(pdev, DRV_NAME);
+	if (ret) {
+		dev_err(dev, "PCI request regions failed 0x%x\n", ret);
+		goto out_disable_device;
+	}
+
+	i2c->twsi_base = pci_ioremap_bar(pdev, PCI_CFG_REG_BAR_NUM);
+	if (!i2c->twsi_base) {
+		dev_err(dev, "Cannot map CSR memory space\n");
+		ret = -EINVAL;
+		goto out_release_regions;
+	}
+
+	thunder_i2c_clock_enable(dev, i2c);
+
+	thunder_i2c_set_name(pdev, i2c, i2c_name);
+	node = of_find_node_by_name(NULL, i2c_name);
+	if (!node || of_property_read_u32(node, "clock-frequency",
+	    &i2c->twsi_freq))
+		i2c->twsi_freq = TWSI_DFL_RATE;
+
+	init_waitqueue_head(&i2c->queue);
+
+	ret = octeon_i2c_initlowlevel(i2c);
+	if (ret) {
+		dev_err(dev, "Init low level failed\n");
+		goto out_unmap;
+	}
+
+	octeon_i2c_setclock(i2c);
+
+	ret = pci_enable_msix(pdev, &i2c->i2c_msix, 1);
+	if (ret) {
+		dev_err(dev, "Unable to enable MSI-X\n");
+		goto out_unmap;
+	}
+
+	ret = devm_request_irq(dev, i2c->i2c_msix.vector, octeon_i2c_isr, 0,
+			       DRV_NAME, i2c);
+	if (ret < 0) {
+		dev_err(dev, "Failed to attach i2c interrupt\n");
+		goto out_msix;
+	}
+
+	i2c->int_en = thunder_i2c_int_enable;
+	i2c->int_dis = thunder_i2c_int_disable;
+	i2c->hlc_int_en = thunder_i2c_hlc_int_enable;
+	i2c->hlc_int_dis = thunder_i2c_hlc_int_disable;
+
+	i2c->adap = thunderx_i2c_ops;
+	i2c->adap.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	i2c->adap.timeout = HZ / 50;
+	i2c->adap.dev.parent = dev;
+	i2c->adap.dev.of_node = pdev->dev.of_node;
+	i2c_set_adapdata(&i2c->adap, i2c);
+
+	ret = i2c_add_adapter(&i2c->adap);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add i2c adapter\n");
+		goto out_irq;
+	}
+
+	dev_info(i2c->dev, "probed\n");
+	return 0;
+
+out_irq:
+	devm_free_irq(dev, i2c->i2c_msix.vector, i2c);
+out_msix:
+	pci_disable_msix(pdev);
+out_unmap:
+	iounmap(i2c->twsi_base);
+	thunder_i2c_clock_disable(dev, i2c->clk);
+out_release_regions:
+	pci_release_regions(pdev);
+out_disable_device:
+	pci_disable_device(pdev);
+out_free_i2c:
+	pci_set_drvdata(pdev, NULL);
+	devm_kfree(dev, i2c);
+	return ret;
+}
+
+static void thunder_i2c_remove_pci(struct pci_dev *pdev)
+{
+	struct octeon_i2c *i2c = pci_get_drvdata(pdev);
+	struct device *dev;
+
+	if (!i2c)
+		return;
+
+	dev = i2c->dev;
+	thunder_i2c_clock_disable(dev, i2c->clk);
+	i2c_del_adapter(&i2c->adap);
+	devm_free_irq(dev, i2c->i2c_msix.vector, i2c);
+	pci_disable_msix(pdev);
+	iounmap(i2c->twsi_base);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+	devm_kfree(dev, i2c);
+}
+
+static const struct pci_device_id thunder_i2c_pci_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_THUNDER_TWSI) },
+	{ 0, }  /* end of table */
+};
+
+MODULE_DEVICE_TABLE(pci, thunder_i2c_pci_id_table);
+
+static struct pci_driver thunder_i2c_pci_driver = {
+	.name		= DRV_NAME,
+	.id_table	= thunder_i2c_pci_id_table,
+	.probe		= thunder_i2c_probe_pci,
+	.remove		= thunder_i2c_remove_pci,
+};
+
+module_pci_driver(thunder_i2c_pci_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Fred Martin <fmartin@caviumnetworks.com>");
+MODULE_DESCRIPTION("I2C-Bus adapter for Cavium ThunderX SOC");
-- 
1.9.1
