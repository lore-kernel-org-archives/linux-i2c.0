From: =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Subject: [patch 1/5] i2c: xtensa s6000 i2c driver
Date: Mon, 23 Mar 2009 16:05:14 +0100
Message-ID: <1237820718-30607-1-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oskar Schirmer <os-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>, =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Oskar Schirmer <os-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>

Support for the s6000 on-chip i2c controller.

Signed-off-by: Oskar Schirmer <os-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Daniel Gl=C3=B6ckner <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/Kconfig     |   10 +
 drivers/i2c/busses/Makefile    |    1 +
 drivers/i2c/busses/i2c-s6000.c |  380 ++++++++++++++++++++++++++++++++=
++++++++
 drivers/i2c/busses/i2c-s6000.h |   79 +++++++++
 include/linux/i2c/s6000.h      |   10 +
 5 files changed, 480 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-s6000.c
 create mode 100644 drivers/i2c/busses/i2c-s6000.h
 create mode 100644 include/linux/i2c/s6000.h

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 7f95905..904def4 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -461,6 +461,16 @@ config I2C_S3C2410
 	  Say Y here to include support for I2C controller in the
 	  Samsung S3C2410 based System-on-Chip devices.
=20
+config I2C_S6000
+	tristate "S6000 I2C support"
+	depends on XTENSA_VARIANT_S6000
+	help
+	  This driver supports the on chip I2C device on the
+	  S6000 xtensa processor family.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called i2c-s6000.
+
 config I2C_SH7760
 	tristate "Renesas SH7760 I2C Controller"
 	depends on CPU_SUBTYPE_SH7760
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 0c2c4b2..f7989d1 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_I2C_PASEMI)	+=3D i2c-pasemi.o
 obj-$(CONFIG_I2C_PNX)		+=3D i2c-pnx.o
 obj-$(CONFIG_I2C_PXA)		+=3D i2c-pxa.o
 obj-$(CONFIG_I2C_S3C2410)	+=3D i2c-s3c2410.o
+obj-$(CONFIG_I2C_S6000)		+=3D i2c-s6000.o
 obj-$(CONFIG_I2C_SH7760)	+=3D i2c-sh7760.o
 obj-$(CONFIG_I2C_SH_MOBILE)	+=3D i2c-sh_mobile.o
 obj-$(CONFIG_I2C_SIMTEC)	+=3D i2c-simtec.o
diff --git a/drivers/i2c/busses/i2c-s6000.c b/drivers/i2c/busses/i2c-s6=
000.c
new file mode 100644
index 0000000..88e3fdc
--- /dev/null
+++ b/drivers/i2c/busses/i2c-s6000.c
@@ -0,0 +1,380 @@
+/*
+ * drivers/i2c/busses/i2c-s6000.c
+ *
+ * Description: Driver for S6000 Family I2C Interface
+ *	(c) 2008 emlix GmbH <info-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
+ * Author:	Oskar Schirmer <os-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
+ *
+ * Partially based on i2c-bfin-twi.c driver by <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org=
>
+ * Copyright (c) 2005-2007 Analog Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-13=
01 USA
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/i2c/s6000.h>
+#include <linux/timer.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+#include <asm/io.h>
+#include "i2c-s6000.h"
+
+#define POLL_TIMEOUT	(2 * HZ)
+
+struct s6i2c_if {
+	u8 __iomem		*reg;
+	int			irq;
+	spinlock_t		lock;
+	struct i2c_msg		*msgs;
+	int			msgs_num, msgs_push, msgs_done;
+	unsigned		push, done;
+	int			timeout_count;
+	struct timer_list	timeout_timer;
+	struct i2c_adapter	adap;
+	struct completion	complete;
+	struct clk		*clk;
+	struct resource		*res;
+};
+
+#define I2C_RD16(iface, n) readw(iface->reg + (n))
+#define I2C_WR16(iface, n, v) writew(v, iface->reg + (n))
+#define I2C_RD32(iface, n) readl(iface->reg + (n))
+#define I2C_WR32(iface, n, v) writel(v, iface->reg + (n))
+
+static struct s6i2c_if s6i2c_if;
+
+static void s6i2c_handle_interrupt(struct s6i2c_if *iface)
+{
+	if (I2C_RD16(iface, S6_I2C_INTRSTAT) & (1 << S6_I2C_INTR_TXABRT)) {
+		I2C_RD16(iface, S6_I2C_CLRTXABRT);
+		I2C_WR16(iface, S6_I2C_INTRMASK, 0);
+		complete(&iface->complete);
+		return;
+	}
+	if (iface->msgs_done >=3D iface->msgs_num) {
+		printk(KERN_DEBUG "spurious I2C irq: %x\n",
+		       I2C_RD16(iface, S6_I2C_INTRSTAT));
+		I2C_WR16(iface, S6_I2C_INTRMASK, 0);
+		return;
+	}
+	while ((iface->msgs_push < iface->msgs_num)
+	    && (I2C_RD16(iface, S6_I2C_STATUS) & (1 << S6_I2C_STATUS_TFNF))) =
{
+		struct i2c_msg *m =3D &iface->msgs[iface->msgs_push];
+		if (!(m->flags & I2C_M_RD))
+			I2C_WR16(iface, S6_I2C_DATACMD, m->buf[iface->push]);
+		else
+			I2C_WR16(iface, S6_I2C_DATACMD,
+				 1 << S6_I2C_DATACMD_READ);
+		if (++iface->push >=3D m->len) {
+			iface->push =3D 0;
+			iface->msgs_push +=3D 1;
+		}
+	}
+	do {
+		struct i2c_msg *m =3D &iface->msgs[iface->msgs_done];
+		if (!(m->flags & I2C_M_RD)) {
+			if (iface->msgs_done < iface->msgs_push)
+				iface->msgs_done +=3D 1;
+			else
+				break;
+		} else if (I2C_RD16(iface, S6_I2C_STATUS)
+				& (1 << S6_I2C_STATUS_RFNE)) {
+			m->buf[iface->done] =3D I2C_RD16(iface, S6_I2C_DATACMD);
+			if (++iface->done >=3D m->len) {
+				iface->done =3D 0;
+				iface->msgs_done +=3D 1;
+			}
+		} else{
+			break;
+		}
+	} while (iface->msgs_done < iface->msgs_num);
+	if (iface->msgs_done >=3D iface->msgs_num) {
+		I2C_WR16(iface, S6_I2C_INTRMASK, 1 << S6_I2C_INTR_TXABRT);
+		complete(&iface->complete);
+	} else if (iface->msgs_push >=3D iface->msgs_num) {
+		I2C_WR16(iface, S6_I2C_INTRMASK, (1 << S6_I2C_INTR_TXABRT) |
+						 (1 << S6_I2C_INTR_RXFULL));
+	} else {
+		I2C_WR16(iface, S6_I2C_INTRMASK, (1 << S6_I2C_INTR_TXABRT) |
+						 (1 << S6_I2C_INTR_TXEMPTY) |
+						 (1 << S6_I2C_INTR_RXFULL));
+	}
+}
+
+static irqreturn_t s6i2c_interrupt_entry(int irq, void *dev_id)
+{
+	struct s6i2c_if *iface =3D dev_id;
+	if (!(I2C_RD16(iface, S6_I2C_STATUS) & ((1 << S6_I2C_INTR_RXUNDER)
+					      | (1 << S6_I2C_INTR_RXOVER)
+					      | (1 << S6_I2C_INTR_RXFULL)
+					      | (1 << S6_I2C_INTR_TXOVER)
+					      | (1 << S6_I2C_INTR_TXEMPTY)
+					      | (1 << S6_I2C_INTR_RDREQ)
+					      | (1 << S6_I2C_INTR_TXABRT)
+					      | (1 << S6_I2C_INTR_RXDONE)
+					      | (1 << S6_I2C_INTR_ACTIVITY)
+					      | (1 << S6_I2C_INTR_STOPDET)
+					      | (1 << S6_I2C_INTR_STARTDET)
+					      | (1 << S6_I2C_INTR_GENCALL))))
+		return IRQ_NONE;
+
+	spin_lock(&iface->lock);
+	del_timer(&iface->timeout_timer);
+	s6i2c_handle_interrupt(iface);
+	spin_unlock(&iface->lock);
+	return IRQ_HANDLED;
+}
+
+static void s6i2c_timeout(unsigned long data)
+{
+	struct s6i2c_if *iface =3D (struct s6i2c_if *)data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iface->lock, flags);
+	s6i2c_handle_interrupt(iface);
+	if (--iface->timeout_count > 0) {
+		iface->timeout_timer.expires =3D jiffies + POLL_TIMEOUT;
+		add_timer(&iface->timeout_timer);
+	} else {
+		complete(&iface->complete);
+		I2C_WR16(iface, S6_I2C_INTRMASK, 0);
+	}
+	spin_unlock_irqrestore(&iface->lock, flags);
+}
+
+static int s6i2c_master_xfer(struct i2c_adapter *adap,
+				struct i2c_msg *msgs, int num)
+{
+	struct s6i2c_if *iface =3D adap->algo_data;
+	int i;
+	if (num =3D=3D 0)
+		return 0;
+	if (I2C_RD16(iface, S6_I2C_STATUS) & (1 << S6_I2C_STATUS_ACTIVITY))
+		yield();
+	I2C_WR16(iface, S6_I2C_INTRMASK, 0);
+	I2C_RD16(iface, S6_I2C_CLRINTR);
+	for (i =3D 0; i < num; i++) {
+		if (msgs[i].flags & I2C_M_TEN) {
+			dev_err(&(adap->dev),
+				"s6i2c: 10 bits addr not supported\n");
+			return -EINVAL;
+		}
+		if (msgs[i].len =3D=3D 0) {
+			dev_err(&(adap->dev),
+				"s6i2c: zero length message not supported\n");
+			return -EINVAL;
+		}
+		if (msgs[i].addr !=3D msgs[0].addr) {
+			dev_err(&(adap->dev),
+				"s6i2c: multiple xfer cannot change target\n");
+			return -EINVAL;
+		}
+	}
+	iface->msgs =3D msgs;
+	iface->msgs_num =3D num;
+	iface->msgs_push =3D 0;
+	iface->msgs_done =3D 0;
+	iface->push =3D 0;
+	iface->done =3D 0;
+	iface->timeout_count =3D 10;
+	I2C_WR16(iface, S6_I2C_TAR, msgs[0].addr);
+	I2C_WR16(iface, S6_I2C_ENABLE, 1);
+	I2C_WR16(iface, S6_I2C_INTRMASK, (1 << S6_I2C_INTR_TXEMPTY) |
+					 (1 << S6_I2C_INTR_TXABRT));
+	iface->timeout_timer.expires =3D jiffies + POLL_TIMEOUT;
+	add_timer(&iface->timeout_timer);
+	wait_for_completion(&iface->complete);
+	del_timer_sync(&iface->timeout_timer);
+	while (I2C_RD32(iface, S6_I2C_TXFLR) > 0)
+		schedule();
+	while (I2C_RD16(iface, S6_I2C_STATUS) & (1 << S6_I2C_STATUS_ACTIVITY)=
)
+		schedule();
+	I2C_WR16(iface, S6_I2C_INTRMASK, 0);
+	I2C_WR16(iface, S6_I2C_ENABLE, 0);
+	return iface->msgs_done;
+}
+
+static u32 s6i2c_functionality(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static struct i2c_algorithm s6i2c_algorithm =3D {
+	.master_xfer   =3D s6i2c_master_xfer,
+	.functionality =3D s6i2c_functionality,
+};
+
+static u16 __devinit nanoseconds_on_clk(struct s6i2c_if *iface, u32 ns=
)
+{
+	u64 dividend =3D (u64)ns * clk_get_rate(iface->clk);
+	do_div(dividend, 1000000000);
+	if (dividend > 0xffff)
+		return 0xffff;
+	return dividend;
+}
+
+static int __devinit s6i2c_probe(struct platform_device *dev)
+{
+	struct s6i2c_if *iface =3D &s6i2c_if;
+	struct i2c_adapter *p_adap;
+	const char *clock;
+	int bus_num, rc;
+	spin_lock_init(&(iface->lock));
+	init_completion(&(iface->complete));
+	iface->irq =3D platform_get_irq(dev, 0);
+	if (iface->irq < 0) {
+		rc =3D iface->irq;
+		goto err_out;
+	}
+	iface->res =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!iface->res) {
+		rc =3D -ENXIO;
+		goto err_out;
+	}
+	iface->res =3D request_mem_region(iface->res->start,
+					iface->res->end - iface->res->start + 1,
+					dev->dev.bus_id);
+	if (!iface->res) {
+		rc =3D -EBUSY;
+		goto err_out;
+	}
+	iface->reg =3D ioremap_nocache(iface->res->start,
+				     iface->res->end - iface->res->start + 1);
+	if (!iface->reg) {
+		rc =3D -ENOMEM;
+		goto err_reg;
+	}
+	clock =3D 0;
+	bus_num =3D -1;
+	if (dev->dev.platform_data) {
+		struct s6_i2c_platform_data *pdata =3D dev->dev.platform_data;
+		bus_num =3D pdata->bus_num;
+		clock =3D pdata->clock;
+	}
+	iface->clk =3D clk_get(&dev->dev, clock);
+	if (IS_ERR(iface->clk)) {
+		rc =3D PTR_ERR(iface->clk);
+		goto err_map;
+	}
+	rc =3D clk_enable(iface->clk);
+	if (rc < 0)
+		goto err_clk_put;
+	init_timer(&(iface->timeout_timer));
+	iface->timeout_timer.function =3D s6i2c_timeout;
+	iface->timeout_timer.data =3D (unsigned long)iface;
+	p_adap =3D &iface->adap;
+	strlcpy(p_adap->name, dev->name, sizeof(p_adap->name));
+	p_adap->algo =3D &s6i2c_algorithm;
+	p_adap->algo_data =3D iface;
+	p_adap->nr =3D bus_num;
+	p_adap->class =3D 0;
+	p_adap->dev.parent =3D &dev->dev;
+	I2C_WR16(iface, S6_I2C_INTRMASK, 0);
+	rc =3D request_irq(iface->irq, s6i2c_interrupt_entry,
+			 IRQF_SHARED, dev->name, iface);
+	if (rc) {
+		dev_err(&(p_adap->dev), "s6i2c: cant get IRQ %d\n", iface->irq);
+		goto err_clk_dis;
+	}
+	I2C_WR16(iface, S6_I2C_ENABLE, 0);
+	udelay(1);
+	I2C_WR32(iface, S6_I2C_SRESET, 1 << S6_I2C_SRESET_IC_SRST);
+	I2C_WR16(iface, S6_I2C_CLRTXABRT, 1);
+	I2C_WR16(iface, S6_I2C_CON,
+			(1 << S6_I2C_CON_MASTER) |
+			(S6_I2C_CON_SPEED_NORMAL << S6_I2C_CON_SPEED) |
+			(0 << S6_I2C_CON_10BITSLAVE) |
+			(0 << S6_I2C_CON_10BITMASTER) |
+			(1 << S6_I2C_CON_RESTARTENA) |
+			(1 << S6_I2C_CON_SLAVEDISABLE));
+	I2C_WR16(iface, S6_I2C_SSHCNT, nanoseconds_on_clk(iface, 4000));
+	I2C_WR16(iface, S6_I2C_SSLCNT, nanoseconds_on_clk(iface, 4700));
+	I2C_WR16(iface, S6_I2C_FSHCNT, nanoseconds_on_clk(iface, 600));
+	I2C_WR16(iface, S6_I2C_FSLCNT, nanoseconds_on_clk(iface, 1300));
+	I2C_WR16(iface, S6_I2C_RXTL, 0);
+	I2C_WR16(iface, S6_I2C_TXTL, 0);
+	platform_set_drvdata(dev, iface);
+	if (bus_num < 0)
+		rc =3D i2c_add_adapter(p_adap);
+	else
+		rc =3D i2c_add_numbered_adapter(p_adap);
+	if (rc)
+		goto err_irq_free;
+	return 0;
+
+err_irq_free:
+	free_irq(iface->irq, iface);
+err_clk_dis:
+	clk_disable(iface->clk);
+err_clk_put:
+	clk_put(iface->clk);
+err_map:
+	iounmap(iface->reg);
+err_reg:
+	release_mem_region(iface->res->start,
+			   iface->res->end - iface->res->start + 1);
+err_out:
+	return rc;
+}
+
+static int __devexit s6i2c_remove(struct platform_device *pdev)
+{
+	struct s6i2c_if *iface =3D platform_get_drvdata(pdev);
+	I2C_WR16(iface, S6_I2C_ENABLE, 0);
+	platform_set_drvdata(pdev, NULL);
+	i2c_del_adapter(&(iface->adap));
+	free_irq(iface->irq, iface);
+	clk_disable(iface->clk);
+	clk_put(iface->clk);
+	iounmap(iface->reg);
+	release_mem_region(iface->res->start,
+			   iface->res->end - iface->res->start + 1);
+	return 0;
+}
+
+static struct platform_driver s6i2c_driver =3D {
+	.probe		=3D s6i2c_probe,
+	.remove		=3D __devexit_p(s6i2c_remove),
+	.driver		=3D {
+		.name	=3D "i2c-s6000",
+		.owner	=3D THIS_MODULE,
+	},
+};
+
+static int __init s6i2c_init(void)
+{
+	pr_info("I2C: S6000 I2C driver\n");
+	return platform_driver_register(&s6i2c_driver);
+}
+
+static void __exit s6i2c_exit(void)
+{
+	platform_driver_unregister(&s6i2c_driver);
+}
+
+MODULE_DESCRIPTION("I2C-Bus adapter routines for S6000 I2C");
+MODULE_LICENSE("GPL");
+
+subsys_initcall(s6i2c_init);
+module_exit(s6i2c_exit);
diff --git a/drivers/i2c/busses/i2c-s6000.h b/drivers/i2c/busses/i2c-s6=
000.h
new file mode 100644
index 0000000..ff23b81
--- /dev/null
+++ b/drivers/i2c/busses/i2c-s6000.h
@@ -0,0 +1,79 @@
+/*
+ * drivers/i2c/busses/i2c-s6000.h
+ *
+ * This file is subject to the terms and conditions of the GNU General=
 Public
+ * License.  See the file "COPYING" in the main directory of this arch=
ive
+ * for more details.
+ *
+ * Copyright (C) 2008 Emlix GmbH <info-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
+ * Author:	Oskar Schirmer <os-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
+ */
+
+#ifndef __DRIVERS_I2C_BUSSES_I2C_S6000_H
+#define __DRIVERS_I2C_BUSSES_I2C_S6000_H
+
+#define S6_I2C_CON		0x000
+#define S6_I2C_CON_MASTER		0
+#define S6_I2C_CON_SPEED		1
+#define S6_I2C_CON_SPEED_NORMAL			1
+#define S6_I2C_CON_SPEED_FAST			2
+#define S6_I2C_CON_SPEED_MASK			3
+#define S6_I2C_CON_10BITSLAVE		3
+#define S6_I2C_CON_10BITMASTER		4
+#define S6_I2C_CON_RESTARTENA		5
+#define S6_I2C_CON_SLAVEDISABLE		6
+#define S6_I2C_TAR		0x004
+#define S6_I2C_TAR_GCORSTART		10
+#define S6_I2C_TAR_SPECIAL		11
+#define S6_I2C_SAR		0x008
+#define S6_I2C_HSMADDR		0x00C
+#define S6_I2C_DATACMD		0x010
+#define S6_I2C_DATACMD_READ		8
+#define S6_I2C_SSHCNT		0x014
+#define S6_I2C_SSLCNT		0x018
+#define S6_I2C_FSHCNT		0x01C
+#define S6_I2C_FSLCNT		0x020
+#define S6_I2C_INTRSTAT		0x02C
+#define S6_I2C_INTRMASK		0x030
+#define S6_I2C_RAWINTR		0x034
+#define S6_I2C_INTR_RXUNDER		0
+#define S6_I2C_INTR_RXOVER		1
+#define S6_I2C_INTR_RXFULL		2
+#define S6_I2C_INTR_TXOVER		3
+#define S6_I2C_INTR_TXEMPTY		4
+#define S6_I2C_INTR_RDREQ		5
+#define S6_I2C_INTR_TXABRT		6
+#define S6_I2C_INTR_RXDONE		7
+#define S6_I2C_INTR_ACTIVITY		8
+#define S6_I2C_INTR_STOPDET		9
+#define S6_I2C_INTR_STARTDET		10
+#define S6_I2C_INTR_GENCALL		11
+#define S6_I2C_RXTL		0x038
+#define S6_I2C_TXTL		0x03C
+#define S6_I2C_CLRINTR		0x040
+#define S6_I2C_CLRRXUNDER	0x044
+#define S6_I2C_CLRRXOVER	0x048
+#define S6_I2C_CLRTXOVER	0x04C
+#define S6_I2C_CLRRDREQ		0x050
+#define S6_I2C_CLRTXABRT	0x054
+#define S6_I2C_CLRRXDONE	0x058
+#define S6_I2C_CLRACTIVITY	0x05C
+#define S6_I2C_CLRSTOPDET	0x060
+#define S6_I2C_CLRSTARTDET	0x064
+#define S6_I2C_CLRGENCALL	0x068
+#define S6_I2C_ENABLE		0x06C
+#define S6_I2C_STATUS		0x070
+#define S6_I2C_STATUS_ACTIVITY		0
+#define S6_I2C_STATUS_TFNF		1
+#define S6_I2C_STATUS_TFE		2
+#define S6_I2C_STATUS_RFNE		3
+#define S6_I2C_STATUS_RFF		4
+#define S6_I2C_TXFLR		0x074
+#define S6_I2C_RXFLR		0x078
+#define S6_I2C_SRESET		0x07C
+#define S6_I2C_SRESET_IC_SRST		0
+#define S6_I2C_SRESET_IC_MASTER_SRST	1
+#define S6_I2C_SRESET_IC_SLAVE_SRST	2
+#define S6_I2C_TXABRTSOURCE	0x080
+
+#endif
diff --git a/include/linux/i2c/s6000.h b/include/linux/i2c/s6000.h
new file mode 100644
index 0000000..0b6b0c6
--- /dev/null
+++ b/include/linux/i2c/s6000.h
@@ -0,0 +1,10 @@
+#ifndef __LINUX_I2C_S6000_H
+#define __LINUX_I2C_S6000_H
+
+struct s6_i2c_platform_data {
+	const char *clock;
+	int bus_num;
+};
+
+#endif
+
--=20
1.6.2.107.ge47ee
