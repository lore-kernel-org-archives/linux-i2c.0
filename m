From: Darius <augulis.darius@gmail.com>
Subject: [PATCH] I2C driver for IMX
Date: Thu, 13 Mar 2008 18:07:45 +0200
Message-ID: <frbjjv$ndk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050505030905010309010403"
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
--------------050505030905010309010403
Content-Type: text/plain; charset=ISO-8859-13; format=flowed
Content-Transfer-Encoding: 7bit

Almost written from scratch - only small piece of code leaved from old 
driver, witch never was originally in vanilla kernel.
SMB is NOT supported currently.
Tested on the MXLADS v2.0 board with i2c client driver (driver for 
NT7651 LCD controller). All works fine, stable.

--------------050505030905010309010403
Content-Type: text/plain;
 name="patch-imx-i2c-2.6.24"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-imx-i2c-2.6.24"

diff -uprN -X linux-2.6.24.3-vanilla/Documentation/dontdiff linux-2.6.24.3-vanilla/drivers/i2c/busses/i2c-imx.c linux-2.6.24.3/drivers/i2c/busses/i2c-imx.c
--- linux-2.6.24.3-vanilla/drivers/i2c/busses/i2c-imx.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6.24.3/drivers/i2c/busses/i2c-imx.c	2008-03-13 17:50:52.000000000 +0200
@@ -0,0 +1,713 @@
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
+ *      USA.
+ *
+ * File Name: imx-i2c.c
+ *
+ * Author:  Torsten Koschorrek, synertronixx GmbH
+ *
+ * Desc.:   Implementation of I2C Adapter/Algorithm Driver
+ *          Driver for I2C Bus integrated in i.MXL, i.MX1
+ *
+ *          compiler options: - I2C_IMX_DEBUG:
+ *                              Enables debug output. If not set, no debug
+ *                              is compiled into the driver.
+ *
+ *          module parameter: - clkdiv:
+ *                              Sets the desired clock rate
+ *                              The default value is 100000
+ *
+ *          Derived from Motorola GSG China I2C example driver
+ *
+ *          Copyright (C) 2002 Motorola GSG-China
+ *          Copyright (C) 2005 Torsten Koschorrek <koschorrek at synertronixx.de
+ *          Portions:
+ *          Copyright (C) 2005 Matthias Blaschke <blaschke at synertronixx.de
+ *          Copyright (C) 2007 RightHand Technologies, Inc. <adyer at righthandtech.com>
+ *          Copyright (C) 2008 Darius Augulis <augulis.darius at gmail.com>
+ *
+ * History: 2002/2/07 use msgs[]
+ *                    Motorola GSG-China
+ *          2004/3/03 port to linux kernel v2.6.x for i.MX
+ *                    adding ioctl (change bus freq)
+ *                    adding cpu- and bus-usage optimization (..slp)
+ *                    T. Koschorrek <koschorrek at synertronixx.de
+ *          2005/2/28 changes in timings
+ *                    M. Blaschke <blaschke at synertronixx.de
+ *          2005/6/01 added module parameters, cleaning up, cpu- and bus-usage
+ *                    modularized (..slave)
+ *                    T. Koschorrek <koschorrek at synertronixx.de
+ *
+ *          2007/07/13 rewrote sections based on comments from Russell King
+ *                     http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2006-April/034215..html
+ *                     Andrew Dyer <adyer at righthandtech.com>
+ *
+ *          2007/09/02 changed to a 'platform' driver
+ *                     Andrew Dyer <adyer at righthandtech.com>
+ *
+ *          2008/03/13 Major changes in driver structure. Works with 2.6.24 kernel.
+ *                     Darius Augulis <augulis.darius at gmail.com>
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
+#include <linux/platform_device.h>
+
+#include <asm/arch/irqs.h>
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
+
+
+/** Defines ********************************************************************
+*******************************************************************************/
+
+/* This will be the driver name the kernel reports */
+#define DRIVER_NAME "imx-i2c"
+
+/* Default values of module parameters */
+#define IMX_I2C_SLAVE_ADDR  0xAC
+#define IMX_I2C_BIT_RATE    100000
+
+/* These defines are missed in imx-regs.h */
+#define IMX_I2C_IADR  	(0x00)	/* i2c slave address */
+#define IMX_I2C_IFDR   	(0x04)	/* i2c frequency divider */
+#define IMX_I2C_I2CR   	(0x08)	/* i2c control */
+#define IMX_I2C_I2SR    (0x0C)	/* i2c status */
+#define IMX_I2C_I2DR    (0x10)	/* i2c transfer data */
+
+/* bits in IMX_I2C_I2SR register */
+#define I2SR_RXAK	0x01
+#define I2SR_IIF	0x02
+#define I2SR_SRW	0x04
+#define I2SR_IAL	0x10
+#define I2SR_IBB	0x20
+#define I2SR_IAAS	0x40
+#define I2SR_ICF	0x80
+
+/* bits in IMX_I2C_I2CR register */
+#define I2CR_RSTA	0x04
+#define I2CR_TXAK	0x08
+#define I2CR_MTX	0x10
+#define I2CR_MSTA	0x20
+#define I2CR_IIEN	0x40
+#define I2CR_IEN	0x80
+
+/* Timeouts */
+#define I2C_IMX_TIME_BUSY   2000
+#define I2C_IMX_TIME_ACK    2000
+
+/* Error numbers */
+#define I2C_IMX_ERR_BUSY        1
+#define I2C_IMX_ERR_TX_TIMEOUT  2
+#define I2C_IMX_ERR_RX_TIMEOUT  3
+#define I2C_IMX_ERR_RX_NO_ACK   4
+
+/** Function prototypes ********************************************************
+*******************************************************************************/
+
+static int          i2c_imx_xfer    (struct i2c_adapter *adapter, struct i2c_msg *msgs, int num);
+static u32          i2c_imx_func    (struct i2c_adapter *adapter);
+static int __init   i2c_imx_probe   (struct platform_device *pdev);
+static int 	    i2c_imx_remove  (struct platform_device *pdev);
+
+/** Variables ******************************************************************
+*******************************************************************************/
+
+static unsigned int clkfreq = IMX_I2C_BIT_RATE;
+static unsigned int imxslave = IMX_I2C_SLAVE_ADDR;;
+
+struct i2c_imx_clk_div_pair {
+	unsigned int divider;
+	unsigned int setting;
+};
+
+static struct i2c_imx_clk_div_pair i2c_imx_clk_div_tbl[64] = { /* FIXME */
+	{22,   0x20}, {24,   0x21}, {26,   0x22}, {28,   0x23},
+	{30,   0x00}, {32,   0x01}, {32,   0x24}, {36,   0x02},
+	{36,   0x25}, {40,   0x26}, {42,   0x03}, {44,   0x27},
+	{48,   0x04}, {48,   0x28}, {52,   0x05}, {56,   0x29},
+	{60,   0x06}, {64,   0x2A}, {72,   0x07}, {72,   0x2B},
+	{80,   0x08}, {80,   0x2C}, {88,   0x09}, {96,   0x2D},
+	{104,  0x0A}, {112,  0x2E}, {128,  0x0B}, {128,  0x2F},
+	{144,  0x0C}, {160,  0x0D}, {160,  0x30}, {192,  0x0E},
+	{192,  0x31}, {224,  0x32}, {240,  0x0F}, {256,  0x33},
+	{288,  0x10}, {320,  0x11}, {320,  0x34}, {384,  0x12},
+	{384,  0x35}, {448,  0x36}, {480,  0x13}, {512,  0x37},
+	{576,  0x14}, {640,  0x15}, {640,  0x38}, {768,  0x16},
+	{768,  0x39}, {896,  0x3A}, {960,  0x17}, {1024, 0x3B},
+	{1152, 0x18}, {1280, 0x19}, {1280, 0x3C}, {1536, 0x1A},
+	{1536, 0x3D}, {1792, 0x3E}, {1920, 0x1B}, {2048, 0x3F},
+	{2304, 0x1C}, {2560, 0x1D}, {3072, 0x1E}, {3840, 0x1F}
+};
+
+static struct platform_driver i2c_imx_driver = {
+	.probe		= i2c_imx_probe,
+	.remove		= i2c_imx_remove,
+	.driver		= {
+		.name	= DRIVER_NAME,
+        .owner	= THIS_MODULE,
+	}
+};
+
+static struct i2c_algorithm i2c_imx_algo = {
+	.master_xfer   =	i2c_imx_xfer,
+	.functionality =	i2c_imx_func,
+};
+
+struct imx_i2c_struct {
+    struct i2c_adapter  adapter;
+	struct resource		*res;
+	void   __iomem		*base;
+    int                 irq;
+    wait_queue_head_t   queue;
+    unsigned long       i2csr;
+};
+
+/** Functions for IMX I2C adapter driver ***************************************
+*******************************************************************************/
+
+static int i2c_imx_bus_busy     (struct imx_i2c_struct *i2c_imx) {
+
+	unsigned int i = 0;
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_bus_busy>\n");
+    #endif
+	/* wait for bus not busy */
+	for (i=0; i<I2C_IMX_TIME_BUSY; i++) {
+		if (!(readb(i2c_imx->base + IMX_I2C_I2SR) & (I2SR_IBB | I2SR_IAL)))
+			return 0;
+		udelay(1);
+	}
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_bus_busy> I2C bus is busy!\n");
+    #endif
+	return -I2C_IMX_ERR_BUSY;
+}
+
+static int i2c_imx_trx_complete (struct imx_i2c_struct *i2c_imx) {
+
+    int result;
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_trx_complete>\n");
+    #endif
+
+    result =    wait_event_interruptible_timeout(i2c_imx->queue,
+                (i2c_imx->i2csr & I2SR_IIF), 5 * HZ);
+
+    if (unlikely(result < 0)) {
+        #ifdef CONFIG_I2C_DEBUG_BUS
+            printk("I2C: <i2c_imx_trx_complete> result < 0!\n");
+        #endif
+        return result;
+    }
+    else if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
+        #ifdef CONFIG_I2C_DEBUG_BUS
+            printk("I2C: <i2c_imx_trx_complete> Timeout!\n");
+        #endif
+        return -I2C_IMX_ERR_TX_TIMEOUT;
+    }
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_trx_complete> TRX complete!\n");
+    #endif
+    i2c_imx->i2csr = 0;
+	return 0;
+}
+
+static int i2c_imx_acked        (struct imx_i2c_struct *i2c_imx) {
+
+    unsigned int i = 0;
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_acked>\n");
+	#endif
+
+    for (i=0; i<I2C_IMX_TIME_ACK; i++) {
+		if (!(readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_RXAK)) {
+            #ifdef CONFIG_I2C_DEBUG_BUS
+                printk("I2C: <i2c_imx_acked> ACK received\n");
+            #endif
+			return 0;
+		}
+		udelay(1);
+	}
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_acked> No ACK!\n");
+    #endif
+    return -I2C_IMX_ERR_RX_NO_ACK;   // No ACK
+
+}
+
+static void i2c_imx_enable      (struct imx_i2c_struct *i2c_imx) {
+
+    unsigned int temp = 0;
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_enable>\n");
+    #endif
+	temp = I2CR_IEN;
+    writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+}
+
+static void i2c_imx_disable     (struct imx_i2c_struct *i2c_imx) {
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_disable>\n");
+    #endif
+
+	/* setup chip registers to defaults */
+    writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
+    writeb(0, i2c_imx->base + IMX_I2C_I2SR);
+
+}
+
+static void i2c_imx_start       (struct imx_i2c_struct *i2c_imx) {
+
+    unsigned int temp = 0;
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_start>\n");
+    #endif
+	temp = readb ( i2c_imx->base + IMX_I2C_I2CR);
+    temp |= I2CR_MSTA;
+    writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+    temp |= (I2CR_IIEN | I2CR_MTX | I2CR_TXAK);
+    writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        temp = readb (i2c_imx->base + IMX_I2C_I2CR);
+        printk("I2C: <i2c_imx_start> CONTROL: IEN=%d, IIEN=%d, MSTA=%d, MTX=%d, TXAK=%d, RSTA=%d\n",
+            (temp&I2CR_IEN?1:0),(temp&I2CR_IIEN?1:0),(temp&I2CR_MSTA?1:0),(temp&I2CR_MTX?1:0),
+            (temp&I2CR_TXAK?1:0),(temp&I2CR_RSTA?1:0));
+        temp = readb (i2c_imx->base + IMX_I2C_I2SR);
+        printk("I2C: <i2c_imx_start> STATUS: ICF=%d, IAAS=%d, IBB=%d, IAL=%d, SRW=%d, IIF=%d, RXAK=%d\n",
+            (temp&I2SR_ICF?1:0),(temp&I2SR_IAAS?1:0),(temp&I2SR_IBB?1:0),(temp&I2SR_IAL?1:0),
+            (temp&I2SR_SRW?1:0),(temp&I2SR_IIF?1:0),(temp&I2SR_RXAK?1:0));
+    #endif
+}
+
+static void i2c_imx_stop        (struct imx_i2c_struct *i2c_imx) {
+
+    unsigned int temp = 0;
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_stop>\n");
+    #endif
+	temp = readb ( i2c_imx->base + IMX_I2C_I2CR);
+    temp &= ~I2CR_MSTA;
+    writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        temp = readb (i2c_imx->base + IMX_I2C_I2CR);
+        printk("I2C: <i2c_imx_stop> CONTROL: IEN=%d, IIEN=%d, MSTA=%d, MTX=%d, TXAK=%d, RSTA=%d\n",
+            (temp&I2CR_IEN?1:0),(temp&I2CR_IIEN?1:0),(temp&I2CR_MSTA?1:0),(temp&I2CR_MTX?1:0),
+            (temp&I2CR_TXAK?1:0),(temp&I2CR_RSTA?1:0));
+        temp = readb (i2c_imx->base + IMX_I2C_I2SR);
+        printk("I2C: <i2c_imx_stop> STATUS: ICF=%d, IAAS=%d, IBB=%d, IAL=%d, SRW=%d, IIF=%d, RXAK=%d\n",
+            (temp&I2SR_ICF?1:0),(temp&I2SR_IAAS?1:0),(temp&I2SR_IBB?1:0),(temp&I2SR_IAL?1:0),
+            (temp&I2SR_SRW?1:0),(temp&I2SR_IIF?1:0),(temp&I2SR_RXAK?1:0));
+    #endif
+}
+
+static int i2c_imx_set_clk      (struct imx_i2c_struct *i2c_imx, unsigned int rate) {
+	unsigned int hclk, sysclk;
+	unsigned int desired_div;
+	int i;
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_set_clk>\n");
+    #endif
+
+	sysclk = imx_get_system_clk ();
+	hclk = imx_get_hclk();
+	desired_div = (hclk << 1) / rate;
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_set_clk> SYSCLK=%d, HCLK=%d, DIV=%d\n", sysclk, hclk, desired_div);
+    #endif
+	if (desired_div & 0x01)
+		desired_div++;
+	desired_div >>= 1;
+	if (desired_div < 22)
+		desired_div = 22;
+	if (desired_div > 3840)
+		return -EINVAL;
+	for (i=0; i<64; i++) {
+		if (i2c_imx_clk_div_tbl[i].divider >= desired_div)
+			break;
+	}
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_set_clk> ICC_FDR[IC]=0x%x, DIV=%d\n", i2c_imx_clk_div_tbl[i].setting, i2c_imx_clk_div_tbl[i].divider);
+    #endif
+	writeb(i2c_imx_clk_div_tbl[i].setting, i2c_imx->base + IMX_I2C_IFDR);
+	return (hclk / i2c_imx_clk_div_tbl[i].divider);
+}
+
+static irqreturn_t i2c_imx_isr  (int irq, void *dev_id) {
+
+	struct imx_i2c_struct *i2c_imx = dev_id;
+	unsigned int temp;
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_isr>\n");
+        temp = readb (i2c_imx->base + IMX_I2C_I2CR);
+        printk("I2C: <i2c_imx_isr> CONTROL: IEN=%d, IIEN=%d, MSTA=%d, MTX=%d, TXAK=%d, RSTA=%d\n",
+            (temp&I2CR_IEN?1:0),(temp&I2CR_IIEN?1:0),(temp&I2CR_MSTA?1:0),(temp&I2CR_MTX?1:0),
+            (temp&I2CR_TXAK?1:0),(temp&I2CR_RSTA?1:0));
+        temp = readb (i2c_imx->base + IMX_I2C_I2SR);
+        printk("I2C: <i2c_imx_isr> STATUS: ICF=%d, IAAS=%d, IBB=%d, IAL=%d, SRW=%d, IIF=%d, RXAK=%d\n",
+            (temp&I2SR_ICF?1:0),(temp&I2SR_IAAS?1:0),(temp&I2SR_IBB?1:0),(temp&I2SR_IAL?1:0),
+            (temp&I2SR_SRW?1:0),(temp&I2SR_IIF?1:0),(temp&I2SR_RXAK?1:0));
+    #endif
+
+    temp = readb(i2c_imx->base + IMX_I2C_I2SR);
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
+static int i2c_imx_write        (struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs) {
+
+	int i;
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_write>\n");
+        printk("I2C: <i2c_imx_write> write slave address: addr=0x%x\n", (msgs->addr<<1));
+	#endif
+	/* write slave address */
+	writeb((msgs->addr<<1), i2c_imx->base + IMX_I2C_I2DR);
+	if (i2c_imx_trx_complete(i2c_imx))
+		return -I2C_IMX_ERR_TX_TIMEOUT;
+    if (i2c_imx_acked(i2c_imx))
+        return -I2C_IMX_ERR_RX_NO_ACK;
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_write> write data\n");
+	#endif
+	/* write data */
+	for (i = 0; i<msgs->len; i++) {
+        #ifdef CONFIG_I2C_DEBUG_BUS
+            printk("I2C: <i2c_imx_write> write byte: %d, b=0x%x\n", i, msgs->buf[i]);
+        #endif
+		writeb(msgs->buf[i], i2c_imx->base + IMX_I2C_I2DR);
+		if (i2c_imx_trx_complete(i2c_imx))
+			return -I2C_IMX_ERR_TX_TIMEOUT;
+        if (i2c_imx_acked(i2c_imx))
+            return -I2C_IMX_ERR_RX_NO_ACK;
+	}
+	return 0;
+}
+
+static int i2c_imx_read         (struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs) {
+
+	int i;
+	unsigned int temp;
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_read>\n");
+        printk("I2C: <i2c_imx_read> write slave address: addr=0x%x\n", (msgs->addr<<1));
+	#endif
+	/* write slave address */
+	writeb((msgs->addr<<1)|0x01, i2c_imx->base + IMX_I2C_I2DR);
+	if (i2c_imx_trx_complete(i2c_imx))
+		return -I2C_IMX_ERR_TX_TIMEOUT;
+    if (i2c_imx_acked(i2c_imx))
+        return -I2C_IMX_ERR_RX_NO_ACK;
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_read> setup bus\n");
+	#endif
+	/* setup bus to read data */
+	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+	temp &= ~I2CR_MTX;
+	if (msgs->len-1)
+        temp &= ~I2CR_TXAK;
+	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_read> dummy read\n");
+	#endif
+	readb(i2c_imx->base + IMX_I2C_I2DR); // dummy read
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_read> read data\n");
+	#endif
+	/* read data */
+	for (i=0; i < msgs->len; i++) {
+
+        if (i2c_imx_trx_complete(i2c_imx))
+			return -I2C_IMX_ERR_RX_TIMEOUT;
+
+        if (i==(msgs->len-1)) {
+            #ifdef CONFIG_I2C_DEBUG_BUS
+                printk("I2C: <i2c_imx_read> clear MSTA\n");
+            #endif
+            temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+            temp &= ~I2CR_MSTA;
+            writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+        }
+        else if (i==(msgs->len-2)) {
+            #ifdef CONFIG_I2C_DEBUG_BUS
+                printk("I2C: <i2c_imx_read> set TXAK\n");
+            #endif
+            temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+            temp |= I2CR_TXAK;
+            writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+        }
+		#ifdef CONFIG_I2C_DEBUG_BUS
+            printk("I2C: <i2c_imx_read> read byte B%d\n", i);
+        #endif
+		msgs->buf[i] = readb(i2c_imx->base + IMX_I2C_I2DR);
+	}
+	return 0;
+}
+
+static int i2c_imx_xfer         (struct i2c_adapter *adapter, struct i2c_msg *msgs, int num) {
+
+	int i, temp;
+	int err = 0;
+	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
+
+	#ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_xfer>\n");
+	#endif
+
+	// chech or i2c bus is not busy
+	err = i2c_imx_bus_busy(i2c_imx);
+	if (err)
+		goto fail0;
+
+    // Enable i2c
+    i2c_imx_enable(i2c_imx);
+
+    /* Start I2C transfer */
+    i2c_imx_start (i2c_imx);
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        temp = readb (i2c_imx->base + IMX_I2C_I2CR);
+        printk("I2C: <i2c_imx_xfer> CONTROL: IEN=%d, IIEN=%d, MSTA=%d, MTX=%d, TXAK=%d, RSTA=%d\n",
+            (temp&I2CR_IEN?1:0),(temp&I2CR_IIEN?1:0),(temp&I2CR_MSTA?1:0),(temp&I2CR_MTX?1:0),
+            (temp&I2CR_TXAK?1:0),(temp&I2CR_RSTA?1:0));
+        temp = readb (i2c_imx->base + IMX_I2C_I2SR);
+        printk("I2C: <i2c_imx_xfer> STATUS: ICF=%d, IAAS=%d, IBB=%d, IAL=%d, SRW=%d, IIF=%d, RXAK=%d\n",
+            (temp&I2SR_ICF?1:0),(temp&I2SR_IAAS?1:0),(temp&I2SR_IBB?1:0),(temp&I2SR_IAL?1:0),
+            (temp&I2SR_SRW?1:0),(temp&I2SR_IIF?1:0),(temp&I2SR_RXAK?1:0));
+    #endif
+
+	// read/write data
+	for (i=0; i<num; i++) {
+
+		if (i) {
+            #ifdef CONFIG_I2C_DEBUG_BUS
+                printk("I2C: <i2c_imx_read> repeated start\n");
+            #endif
+            temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+            temp |= I2CR_RSTA;
+            writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+		}
+		#ifdef CONFIG_I2C_DEBUG_BUS
+            printk("I2C: <i2c_imx_xfer> transfer message: %d\n", i);
+        #endif
+		/* write/read data */
+		if (!(msgs[i].flags & I2C_M_RD))
+			err = i2c_imx_write (i2c_imx, &msgs[i]);
+		else
+            err = i2c_imx_read  (i2c_imx, &msgs[i]);
+	}
+
+fail0:
+	/* Stop bus */
+	i2c_imx_stop (i2c_imx);
+	/* disable i2c bus */
+	i2c_imx_disable (i2c_imx);
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: <i2c_imx_xfer> exit with: %s: %d\n", (err < 0)?"error":"succes msg", (err < 0)?err:num);
+    #endif
+	return (err < 0) ? err : num;
+}
+
+static u32 i2c_imx_func         (struct i2c_adapter *adapter) {
+	return I2C_FUNC_I2C;
+}
+
+static int __init i2c_imx_probe (struct platform_device *pdev) {
+
+    struct imx_i2c_struct *i2c_imx;
+    struct resource *res;
+    void   __iomem	*base;
+    int irq;
+	int res_size;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (!res) {
+        printk("I2C: can't get device resources!\n");
+        return -ENODEV;
+	}
+	if (irq < 0) {
+        printk("I2C: can't get irq number!\n");
+        return -ENODEV;
+	}
+
+	res_size = (res->end) - (res->start) + 1;
+	if (!request_mem_region(res->start, res_size, res->name)) {
+		printk("I2C: can't allocate %d bytes at %d address!\n", res_size, res->start);
+		return -ENOMEM;
+	}
+
+	base = ioremap (res->start, res_size);
+	if (!base) {
+	    printk("I2C: ioremap failed!\n");
+		ret = -EIO;
+		goto fail0;
+	}
+
+	i2c_imx = kzalloc(sizeof(struct imx_i2c_struct), GFP_KERNEL);
+	if (!i2c_imx) {
+		printk("I2C: can't allocate inteface!\n");
+		ret = -ENOMEM;
+		goto fail1;
+	}
+
+    // Setup i2c_imx driver structure
+    i2c_imx->adapter.owner      = THIS_MODULE;
+	i2c_imx->adapter.algo       = &i2c_imx_algo;
+    i2c_imx->adapter.dev.parent = &pdev->dev;
+    strcpy (i2c_imx->adapter.name, pdev->name);
+    i2c_imx->irq    = irq;
+    i2c_imx->base   = base;
+    i2c_imx->res    = res;
+
+    init_waitqueue_head(&i2c_imx->queue);
+
+    /* Set up platform driver data */
+	platform_set_drvdata(pdev, i2c_imx);
+
+	ret = request_irq(i2c_imx->irq, i2c_imx_isr, IRQF_DISABLED, pdev->name, i2c_imx);
+	if (ret) {
+		printk("I2C: %s: cannot claim irq %d !\n", i2c_imx->adapter.dev.bus_id, i2c_imx->irq);
+		goto fail2;
+	}
+
+    /* Set up clock divider */
+    i2c_imx_set_clk(i2c_imx, clkfreq);
+
+    /* Set up IMX I2C slave address */
+    writeb(imxslave, i2c_imx->base + IMX_I2C_IADR);
+
+    /* Set up I/O pins for I2C*/
+	imx_gpio_mode(PA15_PF_I2C_SDA);
+	imx_gpio_mode(PA16_PF_I2C_SCL);
+
+    /* Set up chip registers to defaults */
+    writeb(0, i2c_imx->base + IMX_I2C_I2CR);
+    writeb(0, i2c_imx->base + IMX_I2C_I2SR);
+
+    /* Set up adapter data */
+    i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
+
+    /* Add I2C adapter */
+	ret = i2c_add_adapter(&i2c_imx->adapter);
+	if (ret < 0) {
+		printk("I2C: %s: registration failed\n", i2c_imx->adapter.dev.bus_id);
+		goto fail3;
+	}
+
+    #ifdef CONFIG_I2C_DEBUG_BUS
+        printk("I2C: %s: claimed irq %d\n", i2c_imx->adapter.dev.bus_id, i2c_imx->irq);
+        printk("I2C: %s: device resources from 0x%x to 0x%x\n", i2c_imx->adapter.dev.bus_id, i2c_imx->res->start, i2c_imx->res->end);
+		printk("I2C: %s: allocated %d bytes at 0x%x \n", i2c_imx->adapter.dev.bus_id, res_size, i2c_imx->res->start);
+		printk("I2C: %s: adapter name: \"%s\"\n", i2c_imx->adapter.dev.bus_id, i2c_imx->adapter.name);
+		printk("I2C: adapter \"%s\" associated with driver \"%s\"\n", i2c_imx->adapter.dev.bus_id, i2c_imx_driver.driver.name);
+    #endif
+
+	printk("I2C: %s: IMX I2C adapter registered\n", i2c_imx->adapter.dev.bus_id);
+	return 0;   // Return OK */
+
+fail3:
+	free_irq(i2c_imx->irq, i2c_imx);
+fail2:
+    platform_set_drvdata(pdev, NULL);
+	kfree(i2c_imx);
+fail1:
+	iounmap(i2c_imx->base);
+fail0:
+	release_mem_region(res->start, res_size);
+
+	return ret; // Return error number
+}
+
+static int i2c_imx_remove(struct platform_device *pdev) {
+
+	struct imx_i2c_struct *i2c_imx = platform_get_drvdata(pdev);
+
+	/* remove adapter */
+	printk("I2C: adapter removed\n");
+    i2c_del_adapter(&i2c_imx->adapter);
+	platform_set_drvdata(pdev, NULL);
+
+	/* free interrupt */
+	free_irq(i2c_imx->irq, i2c_imx);
+
+	/* setup chip registers to defaults */
+    writeb(0, i2c_imx->base + IMX_I2C_IADR);
+    writeb(0, i2c_imx->base + IMX_I2C_IFDR);
+    writeb(0, i2c_imx->base + IMX_I2C_I2CR);
+    writeb(0, i2c_imx->base + IMX_I2C_I2SR);
+
+    /* release memory */
+	release_mem_region(i2c_imx->res->start, (i2c_imx->res->end - i2c_imx->res->start) + 1);
+	iounmap(i2c_imx->base);
+	kfree(i2c_imx);
+	return 0;
+}
+
+static int __init i2c_adap_imx_init(void) {
+	return platform_driver_register(&i2c_imx_driver);
+}
+
+static void __exit i2c_adap_imx_exit(void) {
+	platform_driver_unregister(&i2c_imx_driver);
+	return;
+}
+
+module_init(i2c_adap_imx_init);
+module_exit(i2c_adap_imx_exit);
+
+MODULE_AUTHOR("Darius Augulis");
+MODULE_DESCRIPTION("I2C adapter driver for IMX I2C bus");
+MODULE_LICENSE("GPL");
+
+module_param(clkfreq, uint, S_IRUGO);
+MODULE_PARM_DESC(clkfreq, "desired IMX I2C Clock Rate in Hz");
+
+module_param(imxslave, uint, S_IRUGO);
+MODULE_PARM_DESC(imxslave, "desired IMX I2C slave address");
diff -uprN -X linux-2.6.24.3-vanilla/Documentation/dontdiff linux-2.6.24.3-vanilla/drivers/i2c/busses/Kconfig linux-2.6.24.3/drivers/i2c/busses/Kconfig
--- linux-2.6.24.3-vanilla/drivers/i2c/busses/Kconfig	2008-01-25 00:58:37.000000000 +0200
+++ linux-2.6.24.3/drivers/i2c/busses/Kconfig	2008-03-13 17:29:43.000000000 +0200
@@ -249,6 +249,16 @@ config I2C_IBM_IIC
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-ibm_iic.
 
+config I2C_IMX
+	tristate "IMX I2C interface"
+	depends on ARCH_IMX
+	help
+	  Say Y here if you want to use the IIC bus controller on
+	  the Freescale IMX processors.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-imx.
+
 config I2C_IOP3XX
 	tristate "Intel IOPx3xx and IXP4xx on-chip I2C interface"
 	depends on ARCH_IOP32X || ARCH_IOP33X || ARCH_IXP4XX || ARCH_IOP13XX
diff -uprN -X linux-2.6.24.3-vanilla/Documentation/dontdiff linux-2.6.24.3-vanilla/drivers/i2c/busses/Makefile linux-2.6.24.3/drivers/i2c/busses/Makefile
--- linux-2.6.24.3-vanilla/drivers/i2c/busses/Makefile	2008-01-25 00:58:37.000000000 +0200
+++ linux-2.6.24.3/drivers/i2c/busses/Makefile	2008-03-13 17:25:39.000000000 +0200
@@ -18,6 +18,7 @@ obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
 obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
 obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
+obj-$(CONFIG_I2C_IMX)		+= i2c-imx.o
 obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
 obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
 obj-$(CONFIG_I2C_IXP4XX)	+= i2c-ixp4xx.o

--------------050505030905010309010403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--------------050505030905010309010403--
