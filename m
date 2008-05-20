From: Darius <augulis.darius@gmail.com>
Subject: [PATCH V6] I2C driver for IMX
Date: Tue, 20 May 2008 09:41:59 +0300
Message-ID: <g0ts5c$mm$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030006080801020108060301"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------030006080801020108060301
Content-Type: text/plain; charset=ISO-8859-13; format=flowed
Content-Transfer-Encoding: 7bit

Changes from V5 version:

- Trent Piepho suggestions added (except debug macro)
- Debug printing fixed
- Calculations of clock divider and delay improved

Checked with checkpatch.pl again and tested on MXLADS V2.0 board with several i2c clients.

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---

--------------030006080801020108060301
Content-Type: text/plain;
 name="patch-i2c-imx"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-i2c-imx"

Index: linux-2.6.26-rc1/arch/arm/mach-imx/mx1ads.c
===================================================================
--- linux-2.6.26-rc1.orig/arch/arm/mach-imx/mx1ads.c
+++ linux-2.6.26-rc1/arch/arm/mach-imx/mx1ads.c
@@ -109,10 +109,31 @@ static struct platform_device imx_uart2_
 	}
 };
 
+static struct resource imx_i2c_resources[] = {
+	[0] = {
+		.start  = 0x00217000,
+		.end    = 0x00217010,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = I2C_INT,
+		.end    = I2C_INT,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device imx_i2c_device = {
+	.name           = "imx-i2c",
+	.id             = 0,
+	.resource       = imx_i2c_resources,
+	.num_resources  = ARRAY_SIZE(imx_i2c_resources),
+};
+
 static struct platform_device *devices[] __initdata = {
 	&cs89x0_device,
 	&imx_uart1_device,
 	&imx_uart2_device,
+	&imx_i2c_device,
 };
 
 #ifdef CONFIG_MMC_IMX
Index: linux-2.6.26-rc1/drivers/i2c/busses/i2c-imx.c
===================================================================
--- /dev/null
+++ linux-2.6.26-rc1/drivers/i2c/busses/i2c-imx.c
@@ -0,0 +1,639 @@
+/*
+ *	Copyright (C) 2002 Motorola GSG-China
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version 2
+ *	of the License, or (at your option) any later version.
+ *
+ *	This program is distributed in the hope that it will be useful,
+ *	but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *	GNU General Public License for more details.
+ *
+ *	You should have received a copy of the GNU General Public License
+ *	along with this program; if not, write to the Free Software
+ *	Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307,
+ *	USA.
+ *
+ * Author:
+ *	Darius Augulis, Teltonika Inc.
+ *
+ * Desc.:
+ *	Implementation of I2C Adapter/Algorithm Driver
+ *	Driver for I2C Bus integrated in i.MXL, i.MX1
+ *
+ *	module parameters:
+ *		- clkfreq:
+ *			Sets the desired clock rate
+ *			The default value is 100000
+ *			Max value is 400000
+ *		- imxslave:
+ *			IMX slave I2C address in decimal format
+ *			The default value is 0xAC in hex
+ *
+ *	Derived from Motorola GSG China I2C example driver
+ *
+ *	Copyright (C) 2005 Torsten Koschorrek <koschorrek at synertronixx.de
+ *	Portions:
+ *	Copyright (C) 2005 Matthias Blaschke <blaschke at synertronixx.de
+ *	Copyright (C) 2007 RightHand Technologies, Inc. <adyeratrighthandtech.com>
+ *	Copyright (C) 2008 Darius Augulis <darius.augulis at teltonika.lt>
+ *
+ */
+
+/** Includes *******************************************************************
+*******************************************************************************/
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <asm/arch/irqs.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/imx-regs.h>
+
+/** Defines ********************************************************************
+*******************************************************************************/
+
+/* This will be the driver name the kernel reports */
+#define DRIVER_NAME "imx-i2c"
+
+/* Default values of module parameters */
+#define IMX_I2C_SLAVE_ADDR	0xAC
+#define IMX_I2C_BIT_RATE	100000	/* 100kHz */
+
+/* Timeouts */
+#define I2C_IMX_TIME_BUSY	2000	/* loop count */
+#define I2C_IMX_TIME_ACK	2000	/* loop count */
+#define I2C_IMX_TIME_TRX	5	/* seconds */
+
+/* Error numbers */
+#define I2C_IMX_ERR_BUSY	1
+#define I2C_IMX_ERR_TX_TIMEOUT	2
+#define I2C_IMX_ERR_RX_TIMEOUT	3
+#define I2C_IMX_ERR_RX_NO_ACK	4
+
+/* IMX I2C registers */
+#define IMX_I2C_IADR	0x00	/* i2c slave address */
+#define IMX_I2C_IFDR	0x04	/* i2c frequency divider */
+#define IMX_I2C_I2CR	0x08	/* i2c control */
+#define IMX_I2C_I2SR	0x0C	/* i2c status */
+#define IMX_I2C_I2DR	0x10	/* i2c transfer data */
+
+/* Bits of IMX I2C registers */
+#define I2SR_RXAK	0x01
+#define I2SR_IIF	0x02
+#define I2SR_SRW	0x04
+#define I2SR_IAL	0x10
+#define I2SR_IBB	0x20
+#define I2SR_IAAS	0x40
+#define I2SR_ICF	0x80
+#define I2CR_RSTA	0x04
+#define I2CR_TXAK	0x08
+#define I2CR_MTX	0x10
+#define I2CR_MSTA	0x20
+#define I2CR_IIEN	0x40
+#define I2CR_IEN	0x80
+
+/** Function prototypes ********************************************************
+*******************************************************************************/
+
+static int i2c_imx_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num);
+static u32 i2c_imx_func(struct i2c_adapter *adapter);
+static int i2c_imx_probe(struct platform_device *pdev);
+static int i2c_imx_remove(struct platform_device *pdev);
+
+/** Variables ******************************************************************
+*******************************************************************************/
+
+static unsigned int clkfreq = IMX_I2C_BIT_RATE;
+static unsigned int imxslave = IMX_I2C_SLAVE_ADDR;
+static unsigned int disable_delay;	/* Dummy delay */
+
+/*
+ * sorted list of clock divider, register value pairs
+ * taken from table 26-5, p.26-9, Freescale i.MX
+ * Integrated Portable System Processor Reference Manual
+ * Document Number: MC9328MXLRM, Rev. 5.1, 06/2007
+ *
+ * Duplicated divider values removed from list
+ */
+
+static u16 __initdata i2c_imx_clk_divider [50] [2] = {
+	{ 22,	0x20 }, { 24,	0x21 }, { 26,	0x22 }, { 28,	0x23 },
+	{ 30,	0x00 },	{ 32,	0x24 }, { 36,	0x25 }, { 40,	0x26 },
+	{ 42,	0x03 }, { 44,	0x27 },	{ 48,	0x28 }, { 52,	0x05 },
+	{ 56,	0x29 }, { 60,	0x06 }, { 64,	0x2A },	{ 72,	0x2B },
+	{ 80,	0x2C }, { 88,	0x09 }, { 96,	0x2D }, { 104,	0x0A },
+	{ 112,	0x2E }, { 128,	0x2F }, { 144,	0x0C }, { 160,	0x30 },
+	{ 192,	0x31 },	{ 224,	0x32 }, { 240,	0x0F }, { 256,	0x33 },
+	{ 288,	0x10 }, { 320,	0x34 },	{ 384,	0x35 }, { 448,	0x36 },
+	{ 480,	0x13 }, { 512,	0x37 }, { 576,	0x14 },	{ 640,	0x38 },
+	{ 768,	0x39 }, { 896,	0x3A }, { 960,	0x17 }, { 1024,	0x3B },
+	{ 1152,	0x18 }, { 1280,	0x3C }, { 1536,	0x3D }, { 1792,	0x3E },
+	{ 1920,	0x1B },	{ 2048,	0x3F }, { 2304,	0x1C }, { 2560,	0x1D },
+	{ 3072,	0x1E }, { 3840,	0x1F }
+};
+
+static struct platform_driver i2c_imx_driver = {
+	.probe	= i2c_imx_probe,
+	.remove	= i2c_imx_remove,
+	.driver	= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	}
+};
+
+static struct i2c_algorithm i2c_imx_algo = {
+	.master_xfer	= i2c_imx_xfer,
+	.functionality	= i2c_imx_func,
+};
+
+struct imx_i2c_struct {
+	struct i2c_adapter	adapter;
+	struct resource		*res;
+	void __iomem		*base;
+	int			irq;
+	wait_queue_head_t	queue;
+	unsigned long		i2csr;
+};
+
+/** Functions for IMX I2C adapter driver ***************************************
+*******************************************************************************/
+
+static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx)
+{
+	unsigned int i = 0;
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
+
+	/* wait for bus not busy */
+	for (i = 0; i < I2C_IMX_TIME_BUSY; i++) {
+		if (!(readb(i2c_imx->base + IMX_I2C_I2SR) & (I2SR_IBB | I2SR_IAL)))
+			return 0;
+		udelay(1);
+	}
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> I2C bus is busy!\n", __func__);
+	return -I2C_IMX_ERR_BUSY;
+}
+
+static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)
+{
+	int result;
+
+	result = wait_event_interruptible_timeout(i2c_imx->queue,
+		(i2c_imx->i2csr & I2SR_IIF), I2C_IMX_TIME_TRX * HZ);
+
+	if (unlikely(result < 0)) {
+		dev_dbg(&i2c_imx->adapter.dev, "<%s> result < 0!\n", __func__);
+		return result;
+	} else if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
+		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout!\n", __func__);
+		return -I2C_IMX_ERR_TX_TIMEOUT;
+	}
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> TRX complete!\n", __func__);
+	i2c_imx->i2csr = 0;
+	return 0;
+}
+
+static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
+{
+	unsigned int i = 0;
+
+	for (i = 0; i < I2C_IMX_TIME_ACK; i++) {
+		if (!(readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_RXAK)) {
+			dev_dbg(&i2c_imx->adapter.dev,
+				"<%s> ACK received\n", __func__);
+			return 0;
+		}
+		udelay(1);
+	}
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK!\n", __func__);
+	return -I2C_IMX_ERR_RX_NO_ACK;   /* No ACK */
+}
+
+static void i2c_imx_enable(struct imx_i2c_struct *i2c_imx)
+{
+	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
+	writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
+}
+
+static void i2c_imx_disable(struct imx_i2c_struct *i2c_imx)
+{
+	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
+
+	/* setup chip registers to defaults */
+	writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
+	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
+	/*
+	 * This delay caused by an i.MXL hardware bug.
+	 * If no (or too short) delay, no "STOP" bit will be generated.
+	 */
+	udelay(disable_delay);
+	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
+}
+
+static void i2c_imx_start(struct imx_i2c_struct *i2c_imx)
+{
+	unsigned int temp = 0;
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
+	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+	temp |= I2CR_MSTA;
+	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+	temp |= (I2CR_IIEN | I2CR_MTX | I2CR_TXAK);
+	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+}
+
+static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
+{
+	unsigned int temp = 0;
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
+	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+	temp &= ~I2CR_MSTA;
+	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+}
+
+static int __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx, unsigned int rate)
+{
+	unsigned int hclk;
+#ifdef CONFIG_I2C_DEBUG_BUS
+	unsigned int sysclk;
+#endif
+	unsigned int desired_div;
+	int i;
+
+	/* Divider value calculation */
+	hclk = imx_get_hclk();
+	desired_div = (hclk + rate - 1) / rate;
+	if (desired_div < i2c_imx_clk_divider[0][0])
+		i = 0;
+	else if (desired_div > i2c_imx_clk_divider[ARRAY_SIZE(i2c_imx_clk_divider)-1][0])
+		i = ARRAY_SIZE(i2c_imx_clk_divider) - 1;
+	else
+		for (i = 0; i2c_imx_clk_divider[i][0] < desired_div; i++);
+
+	/* Write divider value to register */
+	writeb(i2c_imx_clk_divider[i][1], i2c_imx->base + IMX_I2C_IFDR);
+
+	/*
+	 * There dummy delay is calculated.
+	 * It should be about one I2C clock period long.
+	 * This delay is used in I2C bus disable function
+	 * to fix chip hardware bug.
+	 */
+	disable_delay = (500000U * i2c_imx_clk_divider[i][0]
+		+ (hclk / 2) - 1) / (hclk / 2);
+
+	/* dev_dbg() can't be used, because adapter is not yet registered */
+#ifdef CONFIG_I2C_DEBUG_BUS
+	sysclk = imx_get_system_clk();
+	printk(KERN_DEBUG "I2C: <%s> SYSCLK=%d, HCLK=%d, REQ DIV=%d\n",
+		__func__, sysclk, hclk, desired_div);
+	printk(KERN_DEBUG "I2C: <%s> IFDR[IC]=0x%x, REAL DIV=%d\n", __func__,
+		i2c_imx_clk_divider[i][1], i2c_imx_clk_divider[i][0]);
+#endif
+	return 0;
+}
+
+static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
+{
+	struct imx_i2c_struct *i2c_imx = dev_id;
+	unsigned int temp;
+
+#ifdef CONFIG_I2C_DEBUG_BUS
+	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> CONTROL: IEN=%d, IIEN=%d, "
+		"MSTA=%d, MTX=%d, TXAK=%d, RSTA=%d\n", __func__,
+		(temp&I2CR_IEN ? 1 : 0), (temp&I2CR_IIEN ? 1 : 0),
+		(temp&I2CR_MSTA ? 1 : 0), (temp&I2CR_MTX ? 1 : 0),
+		(temp&I2CR_TXAK ? 1 : 0), (temp&I2CR_RSTA ? 1 : 0));
+	temp = readb(i2c_imx->base + IMX_I2C_I2SR);
+	dev_dbg(&i2c_imx->adapter.dev,
+		"<%s> STATUS: ICF=%d, IAAS=%d, IBB=%d, "
+		"IAL=%d, SRW=%d, IIF=%d, RXAK=%d\n", __func__,
+		(temp&I2SR_ICF ? 1 : 0), (temp&I2SR_IAAS ? 1 : 0),
+		(temp&I2SR_IBB ? 1 : 0), (temp&I2SR_IAL ? 1 : 0),
+		(temp&I2SR_SRW ? 1 : 0), (temp&I2SR_IIF ? 1 : 0),
+		(temp&I2SR_RXAK ? 1 : 0));
+#else
+	temp = readb(i2c_imx->base + IMX_I2C_I2SR);
+#endif
+	if (temp & I2SR_IIF) {
+		/* save status register */
+		i2c_imx->i2csr = temp;
+		temp &= ~I2SR_IIF;
+		writeb(temp, i2c_imx->base + IMX_I2C_I2SR);
+		wake_up_interruptible(&i2c_imx->queue);
+	}
+	return IRQ_HANDLED;
+}
+
+static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
+{
+	int i;
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> write slave address: addr=0x%x\n",
+		__func__, (msgs->addr));
+
+	/* write slave address */
+	writeb((msgs->addr), i2c_imx->base + IMX_I2C_I2DR);
+	if (i2c_imx_trx_complete(i2c_imx))
+		return -I2C_IMX_ERR_TX_TIMEOUT;
+	if (i2c_imx_acked(i2c_imx))
+		return -I2C_IMX_ERR_RX_NO_ACK;
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> write data\n", __func__);
+
+	/* write data */
+	for (i = 0; i < msgs->len; i++) {
+		dev_dbg(&i2c_imx->adapter.dev,
+			"<%s> write byte: B%d=0x%X\n", __func__,
+			i, msgs->buf[i]);
+		writeb(msgs->buf[i], i2c_imx->base + IMX_I2C_I2DR);
+		if (i2c_imx_trx_complete(i2c_imx))
+			return -I2C_IMX_ERR_TX_TIMEOUT;
+		if (i2c_imx_acked(i2c_imx))
+			return -I2C_IMX_ERR_RX_NO_ACK;
+	}
+	return 0;
+}
+
+static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
+{
+	int i;
+	unsigned int temp;
+
+	dev_dbg(&i2c_imx->adapter.dev,
+		"<%s> write slave address: addr=0x%x\n", __func__,
+		((msgs->addr)|0x01));
+
+	/* write slave address */
+	writeb(((msgs->addr)|0x01), i2c_imx->base + IMX_I2C_I2DR);
+	if (i2c_imx_trx_complete(i2c_imx))
+		return -I2C_IMX_ERR_TX_TIMEOUT;
+	if (i2c_imx_acked(i2c_imx))
+		return -I2C_IMX_ERR_RX_NO_ACK;
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> setup bus\n", __func__);
+
+	/* setup bus to read data */
+	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+	temp &= ~I2CR_MTX;
+	if (msgs->len-1)
+		temp &= ~I2CR_TXAK;
+	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+	readb(i2c_imx->base + IMX_I2C_I2DR); /* dummy read */
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> read data\n", __func__);
+
+	/* read data */
+	for (i = 0; i < msgs->len; i++) {
+		if (i2c_imx_trx_complete(i2c_imx))
+			return -I2C_IMX_ERR_RX_TIMEOUT;
+		if (i == (msgs->len-1)) {
+			dev_dbg(&i2c_imx->adapter.dev,
+				"<%s> clear MSTA\n", __func__);
+			temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+			temp &= ~I2CR_MSTA;
+			writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+		} else if (i == (msgs->len-2)) {
+			dev_dbg(&i2c_imx->adapter.dev,
+				"<%s> set TXAK\n", __func__);
+			temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+			temp |= I2CR_TXAK;
+			writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+		}
+		msgs->buf[i] = readb(i2c_imx->base + IMX_I2C_I2DR);
+		dev_dbg(&i2c_imx->adapter.dev,
+			"<%s> read byte: B%d=0x%X\n", __func__,
+			i, msgs->buf[i]);
+	}
+	return 0;
+}
+
+static int i2c_imx_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
+{
+	int i, temp;
+	int err = 0;
+	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
+
+	/* Check or i2c bus is not busy */
+	err = i2c_imx_bus_busy(i2c_imx);
+	if (err)
+		goto fail0;
+
+	/* Enable i2c */
+	i2c_imx_enable(i2c_imx);
+
+	/* Start I2C transfer */
+	i2c_imx_start(i2c_imx);
+
+	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+
+	/* read/write data */
+	for (i = 0; i < num; i++) {
+		if (i) {
+			dev_dbg(&i2c_imx->adapter.dev,
+				"<%s> repeated start\n", __func__);
+			temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+			temp |= I2CR_RSTA;
+			writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+		}
+		dev_dbg(&i2c_imx->adapter.dev,
+			"<%s> transfer message: %d\n", __func__, i);
+		/* write/read data */
+		if (!(msgs[i].flags & I2C_M_RD))
+			err = i2c_imx_write(i2c_imx, &msgs[i]);
+		else
+			err = i2c_imx_read(i2c_imx, &msgs[i]);
+	}
+
+fail0:
+	/* Stop bus */
+	i2c_imx_stop(i2c_imx);
+	/* disable i2c bus */
+	i2c_imx_disable(i2c_imx);
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> exit with: %s: %d\n", __func__,
+		(err < 0) ? "error" : "success msg", (err < 0) ? err : num);
+	return (err < 0) ? err : num;
+}
+
+static u32 i2c_imx_func(struct i2c_adapter *adapter)
+{
+	return (I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL);
+}
+
+static int __init i2c_imx_probe(struct platform_device *pdev)
+{
+	struct imx_i2c_struct *i2c_imx;
+	struct resource *res;
+	void __iomem *base;
+	int irq;
+	int res_size;
+	int ret;
+
+	dev_dbg(&pdev->dev, "<%s>\n", __func__);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "can't get device resources!\n");
+		return -ENODEV;
+	}
+	if (irq < 0) {
+		dev_err(&pdev->dev, "can't get irq number!\n");
+		return -ENODEV;
+	}
+	res_size = (res->end) - (res->start) + 1;
+	if (!request_mem_region(res->start, res_size, res->name)) {
+		dev_err(&pdev->dev, "can't allocate %d bytes at %d address!\n",
+			res_size, res->start);
+		return -ENOMEM;
+	}
+	base = ioremap(res->start, res_size);
+	if (!base) {
+		dev_err(&pdev->dev, "ioremap failed!\n");
+		ret = -EIO;
+		goto fail0;
+	}
+	i2c_imx = kzalloc(sizeof(struct imx_i2c_struct), GFP_KERNEL);
+	if (!i2c_imx) {
+		dev_err(&pdev->dev, "can't allocate interface!\n");
+		ret = -ENOMEM;
+		goto fail1;
+	}
+
+	/* Setup i2c_imx driver structure */
+	strcpy(i2c_imx->adapter.name, pdev->name);
+	i2c_imx->adapter.owner		= THIS_MODULE;
+	i2c_imx->adapter.algo		= &i2c_imx_algo;
+	i2c_imx->adapter.dev.parent	= &pdev->dev;
+	i2c_imx->adapter.class 		= I2C_CLASS_HWMON;
+	i2c_imx->adapter.nr 		= pdev->id;
+	i2c_imx->irq			= irq;
+	i2c_imx->base			= base;
+	i2c_imx->res			= res;
+
+	init_waitqueue_head(&i2c_imx->queue);
+
+	/* Set up platform driver data */
+	platform_set_drvdata(pdev, i2c_imx);
+
+	ret = request_irq(i2c_imx->irq, i2c_imx_isr,
+		IRQF_DISABLED, pdev->name, i2c_imx);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot claim irq %d !\n", i2c_imx->irq);
+		goto fail2;
+	}
+
+	/* Set up adapter data */
+	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
+
+	/* Set up clock divider */
+	i2c_imx_set_clk(i2c_imx, clkfreq);
+
+	/* Set up IMX I2C slave address */
+	writeb(imxslave, i2c_imx->base + IMX_I2C_IADR);
+
+	/* Set up I/O pins for I2C*/
+	imx_gpio_mode(PA15_PF_I2C_SDA);
+	imx_gpio_mode(PA16_PF_I2C_SCL);
+
+	/* Set up chip registers to defaults */
+	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
+	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
+
+
+	/* Add I2C adapter */
+	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "registration failed\n");
+		goto fail3;
+	}
+
+	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", i2c_imx->irq);
+	dev_dbg(&i2c_imx->adapter.dev, "device resources from 0x%x to 0x%x\n",
+		i2c_imx->res->start, i2c_imx->res->end);
+	dev_dbg(&i2c_imx->adapter.dev, "allocated %d bytes at 0x%x \n",
+		res_size, i2c_imx->res->start);
+	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
+		i2c_imx->adapter.name);
+	dev_dbg(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
+	dev_dbg(&i2c_imx->adapter.dev,
+		"adapter \"%s\" associated with driver \"%s\"\n",
+		i2c_imx->adapter.dev.bus_id, i2c_imx_driver.driver.name);
+	return 0;   /* Return OK */
+
+fail3:
+	free_irq(i2c_imx->irq, i2c_imx);
+fail2:
+	platform_set_drvdata(pdev, NULL);
+	kfree(i2c_imx);
+fail1:
+	iounmap(i2c_imx->base);
+fail0:
+	release_mem_region(res->start, res_size);
+	return ret; /* Return error number */
+}
+
+static int i2c_imx_remove(struct platform_device *pdev)
+{
+	struct imx_i2c_struct *i2c_imx = platform_get_drvdata(pdev);
+
+	/* remove adapter */
+	dev_dbg(&i2c_imx->adapter.dev, "adapter removed\n");
+	i2c_del_adapter(&i2c_imx->adapter);
+	platform_set_drvdata(pdev, NULL);
+
+	/* free interrupt */
+	free_irq(i2c_imx->irq, i2c_imx);
+
+	/* setup chip registers to defaults */
+	writeb(0, i2c_imx->base + IMX_I2C_IADR);
+	writeb(0, i2c_imx->base + IMX_I2C_IFDR);
+	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
+	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
+
+	/* release memory */
+	release_mem_region(i2c_imx->res->start,
+		(i2c_imx->res->end - i2c_imx->res->start) + 1);
+	iounmap(i2c_imx->base);
+	kfree(i2c_imx);
+	return 0;
+}
+
+static int __init i2c_adap_imx_init(void)
+{
+	return platform_driver_register(&i2c_imx_driver);
+}
+
+static void __exit i2c_adap_imx_exit(void)
+{
+	platform_driver_unregister(&i2c_imx_driver);
+	return;
+}
+
+module_init(i2c_adap_imx_init);
+module_exit(i2c_adap_imx_exit);
+
+module_param(clkfreq, uint, S_IRUGO);
+MODULE_PARM_DESC(clkfreq, "desired IMX I2C Clock Rate in Hz");
+
+module_param(imxslave, uint, S_IRUGO);
+MODULE_PARM_DESC(imxslave, "desired IMX I2C slave address");
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Darius Augulis");
+MODULE_DESCRIPTION("I2C adapter driver for IMX I2C bus");
+MODULE_ALIAS("platform:" DRIVER_NAME);
Index: linux-2.6.26-rc1/drivers/i2c/busses/Kconfig
===================================================================
--- linux-2.6.26-rc1.orig/drivers/i2c/busses/Kconfig
+++ linux-2.6.26-rc1/drivers/i2c/busses/Kconfig
@@ -257,6 +257,16 @@ config I2C_IBM_IIC
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-ibm_iic.
 
+config I2C_IMX
+	tristate "IMX I2C interface"
+	depends on ARCH_IMX
+	help
+	  Say Y here if you want to use the IIC bus controller on
+	  the Freescale i.MXL and i.MX1 processors.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-imx.
+
 config I2C_IOP3XX
 	tristate "Intel IOPx3xx and IXP4xx on-chip I2C interface"
 	depends on ARCH_IOP32X || ARCH_IOP33X || ARCH_IXP4XX || ARCH_IOP13XX
Index: linux-2.6.26-rc1/drivers/i2c/busses/Makefile
===================================================================
--- linux-2.6.26-rc1.orig/drivers/i2c/busses/Makefile
+++ linux-2.6.26-rc1/drivers/i2c/busses/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
 obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
 obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
+obj-$(CONFIG_I2C_IMX)		+= i2c-imx.o
 obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
 obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
 obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o

--------------030006080801020108060301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--------------030006080801020108060301--
