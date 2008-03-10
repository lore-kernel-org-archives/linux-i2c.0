From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv2 3/3] Add platform driver on top of the
	new	pca-algorithm
Date: Mon, 10 Mar 2008 12:26:40 +0100
Message-ID: <20080310112640.GB12128@pengutronix.de>
References: <20080206202056.364404622@pengutronix.de>
	<20080206203037.228001815@pengutronix.de>
	<20080212225306.4cf2bd74@hyperion.delvare>
	<fqrob6$3e6$1@ger.gmane.org>
	<20080308111337.440a7c83@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4965524421170786991=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080308111337.440a7c83-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============4965524421170786991==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Sat, Mar 08, 2008 at 11:13:37AM +0100, Jean Delvare wrote:

> Hi Wolfgang,
"Wolfram" please... :)

> Waiting for an updated patch, then I'll push it to -mm. Patches 1/3 and
> 2/3 are already there.
Attached. It works on Blackfin and builds on x86 and x86-64. Hopefully
everything is caught now...

All the best,

   Wolfram

=3D=3D=3D

Subject: Add platform driver on top of the new pca-algorithm
=46rom: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Changes since last revision:
 - check against CONFIG_GENERIC_GPIO (was GENERIC_GPIO :( )
 - don't use platform data anymore, copy all over to own struct
 - give info about mem & irq when booting (and switch to printk
   as device is not yet registered)
 - added comment about problems with polling
 - added proper __devinit and __devexit
 - added owner to module
 - removed whitespace alignment in code
 - driver now named "i2c-pca-platform" (as the module)
 - fixed typos in Kconfig

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
=3D=3D=3D

Tested on a blackfin.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

---
 drivers/i2c/busses/Kconfig            |   15 +
 drivers/i2c/busses/Makefile           |    1=20
 drivers/i2c/busses/i2c-pca-platform.c |  297 +++++++++++++++++++++++++++++=
+++++
 include/linux/i2c-pca-platform.h      |   12 +
 4 files changed, 323 insertions(+), 2 deletions(-)

Index: linux-playground/drivers/i2c/busses/i2c-pca-platform.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-playground/drivers/i2c/busses/i2c-pca-platform.c	2008-03-10 12:00=
:22.000000000 +0100
@@ -0,0 +1,297 @@
+/*
+ *  i2c_pca_platform.c
+ *
+ *  Platform driver for the PCA9564 I2C controller.
+ *
+ *  Copyright (C) 2008 Pengutronix
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/i2c-algo-pca.h>
+#include <linux/i2c-pca-platform.h>
+
+#include <asm/irq.h>
+#include <asm/io.h>
+
+#ifdef CONFIG_GENERIC_GPIO
+#include <asm/gpio.h>
+#endif
+
+#define res_len(r)		((r)->end - (r)->start + 1)
+
+struct i2c_pca_pf_data {
+	void __iomem			*reg_base;
+	int				irq;	/* if 0, use polling */
+#ifdef CONFIG_GENERIC_GPIO
+	int				gpio;
+#endif
+	wait_queue_head_t		wait;
+	struct i2c_adapter		adap;
+	struct i2c_algo_pca_data	algo_data;
+	unsigned long			io_base;
+	unsigned long			io_size;
+};
+
+/* Read/Write functions for different register alignments */
+
+static int i2c_pca_pf_readbyte8(void *pd, int reg)
+{
+	struct i2c_pca_pf_data *i2c =3D pd;
+	return ioread8(i2c->reg_base + reg);
+}
+
+static int i2c_pca_pf_readbyte16(void *pd, int reg)
+{
+	struct i2c_pca_pf_data *i2c =3D pd;
+	return ioread8(i2c->reg_base + reg * 2);
+}
+
+static int i2c_pca_pf_readbyte32(void *pd, int reg)
+{
+	struct i2c_pca_pf_data *i2c =3D pd;
+	return ioread8(i2c->reg_base + reg * 4);
+}
+
+static void i2c_pca_pf_writebyte8(void *pd, int reg, int val)
+{
+	struct i2c_pca_pf_data *i2c =3D pd;
+	iowrite8(val, i2c->reg_base + reg);
+}
+
+static void i2c_pca_pf_writebyte16(void *pd, int reg, int val)
+{
+	struct i2c_pca_pf_data *i2c =3D pd;
+	iowrite8(val, i2c->reg_base + reg * 2);
+}
+
+static void i2c_pca_pf_writebyte32(void *pd, int reg, int val)
+{
+	struct i2c_pca_pf_data *i2c =3D pd;
+	iowrite8(val, i2c->reg_base + reg * 4);
+}
+
+
+static int i2c_pca_pf_waitforcompletion(void *pd)
+{
+	struct i2c_pca_pf_data *i2c =3D pd;
+	int ret =3D 0;
+
+	if (i2c->irq) {
+		ret =3D wait_event_interruptible(i2c->wait,
+			i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
+			& I2C_PCA_CON_SI);
+	} else {
+		/*
+		 * Do polling...
+		 * XXX: Could get stuck in extreme cases!
+		 *      Maybe add timeout, but using irqs is preferred anyhow.
+		 */
+		while ((i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
+				& I2C_PCA_CON_SI) =3D=3D 0)
+			udelay(100);
+	}
+
+	return ret;
+}
+
+static void i2c_pca_pf_dummyreset(void *pd)
+{
+	struct i2c_pca_pf_data *i2c =3D pd;
+	printk(KERN_WARNING "%s: No reset-pin found. Chip may get stuck!\n",
+		i2c->adap.name);
+}
+
+#ifdef CONFIG_GENERIC_GPIO
+static void i2c_pca_pf_resetchip(void *pd)
+{
+	struct i2c_pca_pf_data *i2c =3D pd;
+
+	gpio_set_value(i2c->gpio, 0);
+	ndelay(100);
+	gpio_set_value(i2c->gpio, 1);
+}
+#endif
+
+static irqreturn_t i2c_pca_pf_handler(int this_irq, void *dev_id)
+{
+	struct i2c_pca_pf_data *i2c =3D dev_id;
+
+	if ((i2c->algo_data.read_byte(i2c, I2C_PCA_CON) & I2C_PCA_CON_SI) =3D=3D =
0)
+		return IRQ_NONE;
+
+	wake_up_interruptible(&i2c->wait);
+
+	return IRQ_HANDLED;
+}
+
+
+static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
+{
+	struct i2c_pca_pf_data *i2c;
+	struct resource *res;
+	struct i2c_pca9564_pf_platform_data *platform_data =3D
+				pdev->dev.platform_data;
+	int ret;
+	int irq;
+
+	printk(KERN_INFO "Registering PCA9564 ");
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq =3D platform_get_irq(pdev, 0);
+	/* If irq is 0, we do polling. */
+
+	if (res =3D=3D NULL) {
+		ret =3D -ENODEV;
+		goto e_print;
+	}
+
+	if (!request_mem_region(res->start, res_len(res), res->name)) {
+		ret =3D -ENOMEM;
+		goto e_print;
+	}
+
+	i2c =3D kzalloc(sizeof(struct i2c_pca_pf_data), GFP_KERNEL);
+	if (!i2c) {
+		ret =3D -ENOMEM;
+		goto e_alloc;
+	}
+
+	init_waitqueue_head(&i2c->wait);
+
+	i2c->reg_base =3D ioremap(res->start, res_len(res));
+	if (!i2c->reg_base) {
+		ret =3D -EIO;
+		goto e_remap;
+	}
+	i2c->io_base =3D res->start;
+	i2c->io_size =3D res_len(res);
+	i2c->irq =3D irq;
+
+	printk("at 0x%08x ", res->start);
+
+	i2c->adap.nr =3D pdev->id >=3D 0 ? pdev->id : 0;
+	i2c->adap.owner =3D THIS_MODULE;
+	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "PCA9564 at 0x%08x",
+		res->start);
+	i2c->adap.algo_data =3D &i2c->algo_data;
+	i2c->adap.dev.parent =3D &pdev->dev;
+	i2c->adap.timeout =3D platform_data->timeout;
+
+	i2c->algo_data.i2c_clock =3D platform_data->i2c_clock_speed;
+	i2c->algo_data.data =3D i2c;
+
+	switch (res->flags & IORESOURCE_MEM_TYPE_MASK) {
+	case IORESOURCE_MEM_32BIT:
+		i2c->algo_data.write_byte =3D i2c_pca_pf_writebyte32;
+		i2c->algo_data.read_byte =3D i2c_pca_pf_readbyte32;
+		break;
+	case IORESOURCE_MEM_16BIT:
+		i2c->algo_data.write_byte =3D i2c_pca_pf_writebyte16;
+		i2c->algo_data.read_byte =3D i2c_pca_pf_readbyte16;
+		break;
+	case IORESOURCE_MEM_8BIT:
+	default:
+		i2c->algo_data.write_byte =3D i2c_pca_pf_writebyte8;
+		i2c->algo_data.read_byte =3D i2c_pca_pf_readbyte8;
+		break;
+	}
+
+	i2c->algo_data.wait_for_completion =3D i2c_pca_pf_waitforcompletion;
+
+#ifdef CONFIG_GENERIC_GPIO
+	/* Use NO_GPIO when this macro is in mainline */
+	i2c->gpio =3D platform_data->gpio;
+	if (platform_data->gpio > -1)
+		i2c->algo_data.reset_chip =3D i2c_pca_pf_resetchip;
+	else
+		i2c->algo_data.reset_chip =3D i2c_pca_pf_dummyreset;
+#else
+	i2c->algo_data.reset_chip =3D i2c_pca_pf_dummyreset;
+#endif
+	if (irq) {
+		ret =3D request_irq(irq, i2c_pca_pf_handler,
+			IRQF_TRIGGER_FALLING, i2c->adap.name, i2c);
+		if (ret)
+			goto e_reqirq;
+	}
+
+	printk("using irq %d ", irq);
+
+	if (i2c_pca_add_numbered_bus(&i2c->adap) < 0) {
+		ret =3D -ENODEV;
+		goto e_adapt;
+	}
+
+	platform_set_drvdata(pdev, i2c);
+
+	printk("succeeded.\n");
+	return 0;
+
+e_adapt:
+	if (irq)
+		free_irq(irq, i2c);
+e_reqirq:
+	iounmap(i2c->reg_base);
+e_remap:
+	kfree(i2c);
+e_alloc:
+	release_mem_region(res->start, res_len(res));
+e_print:
+	printk("FAILED! (%d)\n", ret);
+	return ret;
+}
+
+static int __devexit i2c_pca_pf_remove(struct platform_device *pdev)
+{
+	struct i2c_pca_pf_data *i2c =3D platform_get_drvdata(pdev);
+	platform_set_drvdata(pdev, NULL);
+
+	i2c_del_adapter(&i2c->adap);
+
+	if (i2c->irq)
+		free_irq(i2c->irq, i2c);
+
+	iounmap(i2c->reg_base);
+	release_mem_region(i2c->io_base, i2c->io_size);
+	kfree(i2c);
+
+	return 0;
+}
+
+static struct platform_driver i2c_pca_pf_driver =3D {
+	.probe =3D i2c_pca_pf_probe,
+	.remove =3D __devexit_p(i2c_pca_pf_remove),
+	.driver =3D {
+		.name =3D "i2c-pca-platform",
+		.owner =3D THIS_MODULE,
+	},
+};
+
+static int __init i2c_pca_pf_init(void)
+{
+	return platform_driver_register(&i2c_pca_pf_driver);
+}
+
+static void __exit i2c_pca_pf_exit(void)
+{
+	platform_driver_unregister(&i2c_pca_pf_driver);
+}
+
+MODULE_AUTHOR("Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
+MODULE_DESCRIPTION("I2C-PCA9564 platform driver");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_pca_pf_init);
+module_exit(i2c_pca_pf_exit);
+
Index: linux-playground/drivers/i2c/busses/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-playground.orig/drivers/i2c/busses/Kconfig	2008-03-10 11:30:06.00=
0000000 +0100
+++ linux-playground/drivers/i2c/busses/Kconfig	2008-03-10 11:31:57.0000000=
00 +0100
@@ -632,8 +632,8 @@
 	select I2C_ALGOPCA
 	default n
 	help
-	  This driver supports ISA boards using the Philips PCA 9564
-	  Parallel bus to I2C bus controller
+	  This driver supports ISA boards using the Philips PCA9564
+	  parallel bus to I2C bus controller.
 	 =20
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-pca-isa.
@@ -643,6 +643,17 @@
 	  delays when I2C/SMBus chip drivers are loaded (e.g. at boot
 	  time).  If unsure, say N.
=20
+config I2C_PCA_PLATFORM
+	tristate "PCA9564 as platform device"
+	select I2C_ALGOPCA
+	default n
+	help
+	  This driver supports a memory mapped Philips PCA9564
+	  parallel bus to I2C bus controller.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-pca-platform.
+
 config I2C_MV64XXX
 	tristate "Marvell mv64xxx I2C Controller"
 	depends on (MV64X60 || ARCH_ORION) && EXPERIMENTAL
Index: linux-playground/drivers/i2c/busses/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-playground.orig/drivers/i2c/busses/Makefile	2008-03-10 11:30:06.0=
00000000 +0100
+++ linux-playground/drivers/i2c/busses/Makefile	2008-03-10 11:31:57.000000=
000 +0100
@@ -30,6 +30,7 @@
 obj-$(CONFIG_I2C_PARPORT_LIGHT)	+=3D i2c-parport-light.o
 obj-$(CONFIG_I2C_PASEMI)	+=3D i2c-pasemi.o
 obj-$(CONFIG_I2C_PCA_ISA)	+=3D i2c-pca-isa.o
+obj-$(CONFIG_I2C_PCA_PLATFORM)	+=3D i2c-pca-platform.o
 obj-$(CONFIG_I2C_PIIX4)		+=3D i2c-piix4.o
 obj-$(CONFIG_I2C_PMCMSP)	+=3D i2c-pmcmsp.o
 obj-$(CONFIG_I2C_PNX)		+=3D i2c-pnx.o
Index: linux-playground/include/linux/i2c-pca-platform.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-playground/include/linux/i2c-pca-platform.h	2008-03-10 11:31:57.0=
00000000 +0100
@@ -0,0 +1,12 @@
+#ifndef I2C_PCA9564_PLATFORM_H
+#define I2C_PCA9564_PLATFORM_H
+
+struct i2c_pca9564_pf_platform_data {
+	int gpio;		/* pin to reset chip. driver will work when
+				 * not supplied (negative value), but it
+				 * cannot exit some error conditions then */
+	int i2c_clock_speed;	/* values are defined in linux/i2c-algo-pca.h */
+	int timeout;		/* timeout =3D this value * 10us */
+};
+
+#endif /* I2C_PCA9564_PLATFORM_H */

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH1RrwD27XaX1/VRsRAvsnAKCJl8eEAzFCZJZhmg1Nx3nJ9XP+XwCcC5h/
eCXG81UgQC5oirFprkHF6hE=
=AWVt
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--


--===============4965524421170786991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============4965524421170786991==--
