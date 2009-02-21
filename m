From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c/pca: add PCA9665 support
Date: Sat, 21 Feb 2009 14:03:54 +0100
Message-ID: <20090221130354.GB16774@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This patch adds support for the PCA9665 I2C controller, originally tested a=
nd
posted by Marco Aurelio da Costa. As he did not resubmit the patch after the
final review five months ago, I picked it up, made it apply to latest linus=
-git
and removed the minor coding-style issues.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---

It still works with my PCA9564, so it surely didn't break anything.

Marco, if you are still around, it would be nice to get a signed-off from y=
ou!
(I didn't change any code except adding two "\n" and one " " to debug strin=
gs)

Jean, Ben, do you think we can handle it this way? I'd like to see this
included before the last known working state gets too far off from mainline.

 drivers/i2c/algos/i2c-algo-pca.c      |  180 +++++++++++++++++++++++++++++=
++---
 drivers/i2c/busses/Kconfig            |    8 -
 drivers/i2c/busses/i2c-pca-isa.c      |   14 +-
 drivers/i2c/busses/i2c-pca-platform.c |    9 -
 include/linux/i2c-algo-pca.h          |   33 +++++-
 5 files changed, 216 insertions(+), 28 deletions(-)

Index: drivers/i2c/algos/i2c-algo-pca.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/i2c/algos/i2c-algo-pca.c.orig
+++ drivers/i2c/algos/i2c-algo-pca.c
@@ -46,6 +46,14 @@ static int i2c_debug;
 #define pca_wait(adap) adap->wait_for_completion(adap->data)
 #define pca_reset(adap) adap->reset_chip(adap->data)
=20
+static void pca9665_reset(void *pd)
+{
+	struct i2c_algo_pca_data *adap =3D pd;
+	pca_outw(adap, I2C_PCA_INDPTR, I2C_PCA_IPRESET);
+	pca_outw(adap, I2C_PCA_IND, 0xA5);
+	pca_outw(adap, I2C_PCA_IND, 0x5A);
+}
+
 /*
  * Generate a start condition on the i2c bus.
  *
@@ -333,27 +341,171 @@ static const struct i2c_algorithm pca_al
 	.functionality	=3D pca_func,
 };
=20
-static int pca_init(struct i2c_adapter *adap)
+static unsigned int pca_probe_chip(struct i2c_adapter *adap)
 {
-	static int freqs[] =3D {330,288,217,146,88,59,44,36};
-	int clock;
 	struct i2c_algo_pca_data *pca_data =3D adap->algo_data;
-
-	if (pca_data->i2c_clock > 7) {
-		printk(KERN_WARNING "%s: Invalid I2C clock speed selected. Trying defaul=
t.\n",
-			adap->name);
-		pca_data->i2c_clock =3D I2C_PCA_CON_59kHz;
+	/* The trick here is to check if there is an indirect register
+	 * available. If there is one, we will read the value we first
+	 * wrote on I2C_PCA_IADR. Otherwise, we will read the last value
+	 * we wrote on I2C_PCA_ADR
+	 */
+	pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_IADR);
+	pca_outw(pca_data, I2C_PCA_IND, 0xAA);
+	pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_ITO);
+	pca_outw(pca_data, I2C_PCA_IND, 0x00);
+	pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_IADR);
+	if (pca_inw(pca_data, I2C_PCA_IND) =3D=3D 0xAA) {
+		printk(KERN_INFO "%s: PCA9665 detected.\n", adap->name);
+		return I2C_PCA_CHIP_9665;
+	} else {
+		printk(KERN_INFO "%s: PCA9564 detected.\n", adap->name);
+		return I2C_PCA_CHIP_9564;
 	}
+}
+
+static int pca_init(struct i2c_adapter *adap)
+{
+	struct i2c_algo_pca_data *pca_data =3D adap->algo_data;
=20
 	adap->algo =3D &pca_algo;
=20
-	pca_reset(pca_data);
+	if (pca_probe_chip(adap) =3D=3D I2C_PCA_CHIP_9564) {
+		static int freqs[] =3D {330, 288, 217, 146, 88, 59, 44, 36};
+		int clock;
+
+		if (pca_data->i2c_clock > 7) {
+			switch (pca_data->i2c_clock) {
+			case 330000:
+				pca_data->i2c_clock =3D I2C_PCA_CON_330kHz;
+				break;
+			case 288000:
+				pca_data->i2c_clock =3D I2C_PCA_CON_288kHz;
+				break;
+			case 217000:
+				pca_data->i2c_clock =3D I2C_PCA_CON_217kHz;
+				break;
+			case 146000:
+				pca_data->i2c_clock =3D I2C_PCA_CON_146kHz;
+				break;
+			case 88000:
+				pca_data->i2c_clock =3D I2C_PCA_CON_88kHz;
+				break;
+			case 59000:
+				pca_data->i2c_clock =3D I2C_PCA_CON_59kHz;
+				break;
+			case 44000:
+				pca_data->i2c_clock =3D I2C_PCA_CON_44kHz;
+				break;
+			case 36000:
+				pca_data->i2c_clock =3D I2C_PCA_CON_36kHz;
+				break;
+			default:
+				printk(KERN_WARNING
+					"%s: Invalid I2C clock speed selected."
+					" Using default 59kHz.\n", adap->name);
+			pca_data->i2c_clock =3D I2C_PCA_CON_59kHz;
+			}
+		} else {
+			printk(KERN_WARNING "%s: "
+				"Choosing the clock frequency based on "
+				"index is deprecated."
+				" Use the nominal frequency.\n", adap->name);
+		}
+
+		pca_reset(pca_data);
+
+		clock =3D pca_clock(pca_data);
+		printk(KERN_INFO "%s: Clock frequency is %dkHz\n",
+		     adap->name, freqs[clock]);
+
+		pca_set_con(pca_data, I2C_PCA_CON_ENSIO | clock);
+	} else {
+		int clock;
+		int mode;
+		int tlow, thi;
+		/* Values can be found on PCA9665 datasheet section 7.3.2.6 */
+		int min_tlow, min_thi;
+		/* These values are the maximum raise and fall values allowed
+		 * by the I2C operation mode (Standard, Fast or Fast+)
+		 * They are used (added) below to calculate the clock dividers
+		 * of PCA9665. Note that they are slightly different of the
+		 * real maximum, to allow the change on mode exactly on the
+		 * maximum clock rate for each mode
+		 */
+		int raise_fall_time;
+
+		struct i2c_algo_pca_data *pca_data =3D adap->algo_data;
+
+		/* Ignore the reset function from the module,
+		 * we can use the parallel bus reset
+		 */
+		pca_data->reset_chip =3D pca9665_reset;
+
+		if (pca_data->i2c_clock > 1265800) {
+			printk(KERN_WARNING "%s: I2C clock speed too high."
+				" Using 1265.8kHz.\n", adap->name);
+			pca_data->i2c_clock =3D 1265800;
+		}
+
+		if (pca_data->i2c_clock < 60300) {
+			printk(KERN_WARNING "%s: I2C clock speed too low."
+				" Using 60.3kHz.\n", adap->name);
+			pca_data->i2c_clock =3D 60300;
+		}
=20
-	clock =3D pca_clock(pca_data);
-	printk(KERN_INFO "%s: Clock frequency is %dkHz\n", adap->name,
-	       freqs[clock]);
+		/* To avoid integer overflow, use clock/100 for calculations */
+		clock =3D pca_clock(pca_data) / 100;
=20
-	pca_set_con(pca_data, I2C_PCA_CON_ENSIO | clock);
+		if (pca_data->i2c_clock > 10000) {
+			mode =3D I2C_PCA_MODE_TURBO;
+			min_tlow =3D 14;
+			min_thi  =3D 5;
+			raise_fall_time =3D 22; /* Raise 11e-8s, Fall 11e-8s */
+		} else if (pca_data->i2c_clock > 4000) {
+			mode =3D I2C_PCA_MODE_FASTP;
+			min_tlow =3D 17;
+			min_thi  =3D 9;
+			raise_fall_time =3D 22; /* Raise 11e-8s, Fall 11e-8s */
+		} else if (pca_data->i2c_clock > 1000) {
+			mode =3D I2C_PCA_MODE_FAST;
+			min_tlow =3D 44;
+			min_thi  =3D 20;
+			raise_fall_time =3D 58; /* Raise 29e-8s, Fall 29e-8s */
+		} else {
+			mode =3D I2C_PCA_MODE_STD;
+			min_tlow =3D 157;
+			min_thi  =3D 134;
+			raise_fall_time =3D 127; /* Raise 29e-8s, Fall 98e-8s */
+		}
+
+		/* The minimum clock that respects the thi/tlow =3D 134/157 is
+		 * 64800 Hz. Below that, we have to fix the tlow to 255 and
+		 * calculate the thi factor.
+		 */
+		if (clock < 648) {
+			tlow =3D 255;
+			thi =3D 1000000 - clock * raise_fall_time;
+			thi /=3D (I2C_PCA_OSC_PER * clock) - tlow;
+		} else {
+			tlow =3D (1000000 - clock * raise_fall_time) * min_tlow;
+			tlow /=3D I2C_PCA_OSC_PER * clock * (min_thi + min_tlow);
+			thi =3D tlow * min_thi / min_tlow;
+		}
+
+		pca_reset(pca_data);
+
+		printk(KERN_INFO
+		     "%s: Clock frequency is %dHz\n", adap->name, clock * 100);
+
+		pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_IMODE);
+		pca_outw(pca_data, I2C_PCA_IND, mode);
+		pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_ISCLL);
+		pca_outw(pca_data, I2C_PCA_IND, tlow);
+		pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_ISCLH);
+		pca_outw(pca_data, I2C_PCA_IND, thi);
+
+		pca_set_con(pca_data, I2C_PCA_CON_ENSIO);
+	}
 	udelay(500); /* 500 us for oscilator to stabilise */
=20
 	return 0;
@@ -388,7 +540,7 @@ EXPORT_SYMBOL(i2c_pca_add_numbered_bus);
=20
 MODULE_AUTHOR("Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>, "
 	"Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
-MODULE_DESCRIPTION("I2C-Bus PCA9564 algorithm");
+MODULE_DESCRIPTION("I2C-Bus PCA9564/PCA9665 algorithm");
 MODULE_LICENSE("GPL");
=20
 module_param(i2c_debug, int, 0);
Index: drivers/i2c/busses/i2c-pca-isa.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/i2c/busses/i2c-pca-isa.c.orig
+++ drivers/i2c/busses/i2c-pca-isa.c
@@ -41,7 +41,7 @@ static int irq =3D -1;
=20
 /* Data sheet recommends 59kHz for 100kHz operation due to variation
  * in the actual clock rate */
-static int clock  =3D I2C_PCA_CON_59kHz;
+static int clock  =3D 59000;
=20
 static wait_queue_head_t pca_wait;
=20
@@ -103,7 +103,7 @@ static struct i2c_adapter pca_isa_ops =3D=20
 	.owner          =3D THIS_MODULE,
 	.id		=3D I2C_HW_A_ISA,
 	.algo_data	=3D &pca_isa_data,
-	.name		=3D "PCA9564 ISA Adapter",
+	.name		=3D "PCA9564/PCA9665 ISA Adapter",
 	.timeout	=3D 100,
 };
=20
@@ -196,7 +196,7 @@ static void __exit pca_isa_exit(void)
 }
=20
 MODULE_AUTHOR("Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>");
-MODULE_DESCRIPTION("ISA base PCA9564 driver");
+MODULE_DESCRIPTION("ISA base PCA9564/PCA9665 driver");
 MODULE_LICENSE("GPL");
=20
 module_param(base, ulong, 0);
@@ -205,7 +205,13 @@ MODULE_PARM_DESC(base, "I/O base address
 module_param(irq, int, 0);
 MODULE_PARM_DESC(irq, "IRQ");
 module_param(clock, int, 0);
-MODULE_PARM_DESC(clock, "Clock rate as described in table 1 of PCA9564 dat=
asheet");
+MODULE_PARM_DESC(clock, "Clock rate in hertz.\n\t\t"
+		"For PCA9564: 330000,288000,217000,146000,"
+		"88000,59000,44000,36000\n"
+		"\t\tFor PCA9665:\tStandard: 60300 - 100099\n"
+		"\t\t\t\tFast: 100100 - 400099\n"
+		"\t\t\t\tFast+: 400100 - 10000099\n"
+		"\t\t\t\tTurbo: Up to 1265800");
=20
 module_init(pca_isa_init);
 module_exit(pca_isa_exit);
Index: drivers/i2c/busses/i2c-pca-platform.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/i2c/busses/i2c-pca-platform.c.orig
+++ drivers/i2c/busses/i2c-pca-platform.c
@@ -172,8 +172,9 @@ static int __devinit i2c_pca_pf_probe(st
=20
 	i2c->adap.nr =3D pdev->id >=3D 0 ? pdev->id : 0;
 	i2c->adap.owner =3D THIS_MODULE;
-	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "PCA9564 at 0x%08lx",
-		(unsigned long) res->start);
+	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
+		 "PCA9564/PCA9665 at 0x%08lx",
+		 (unsigned long) res->start);
 	i2c->adap.algo_data =3D &i2c->algo_data;
 	i2c->adap.dev.parent =3D &pdev->dev;
 	i2c->adap.timeout =3D platform_data->timeout;
@@ -246,7 +247,7 @@ e_remap:
 e_alloc:
 	release_mem_region(res->start, res_len(res));
 e_print:
-	printk(KERN_ERR "Registering PCA9564 FAILED! (%d)\n", ret);
+	printk(KERN_ERR "Registering PCA9564/PCA9665 FAILED! (%d)\n", ret);
 	return ret;
 }
=20
@@ -290,7 +291,7 @@ static void __exit i2c_pca_pf_exit(void)
 }
=20
 MODULE_AUTHOR("Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
-MODULE_DESCRIPTION("I2C-PCA9564 platform driver");
+MODULE_DESCRIPTION("I2C-PCA9564/PCA9665 platform driver");
 MODULE_LICENSE("GPL");
=20
 module_init(i2c_pca_pf_init);
Index: drivers/i2c/busses/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/i2c/busses/Kconfig.orig
+++ drivers/i2c/busses/Kconfig
@@ -617,12 +617,12 @@ config I2C_ELEKTOR
 	  will be called i2c-elektor.
=20
 config I2C_PCA_ISA
-	tristate "PCA9564 on an ISA bus"
+	tristate "PCA9564/PCA9665 on an ISA bus"
 	depends on ISA
 	select I2C_ALGOPCA
 	default n
 	help
-	  This driver supports ISA boards using the Philips PCA9564
+	  This driver supports ISA boards using the Philips PCA9564/PCA9665
 	  parallel bus to I2C bus controller.
=20
 	  This driver can also be built as a module.  If so, the module
@@ -634,11 +634,11 @@ config I2C_PCA_ISA
 	  time).  If unsure, say N.
=20
 config I2C_PCA_PLATFORM
-	tristate "PCA9564 as platform device"
+	tristate "PCA9564/PCA9665 as platform device"
 	select I2C_ALGOPCA
 	default n
 	help
-	  This driver supports a memory mapped Philips PCA9564
+	  This driver supports a memory mapped Philips PCA9564/PCA9665
 	  parallel bus to I2C bus controller.
=20
 	  This driver can also be built as a module.  If so, the module
Index: include/linux/i2c-algo-pca.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/i2c-algo-pca.h.orig
+++ include/linux/i2c-algo-pca.h
@@ -1,7 +1,14 @@
 #ifndef _LINUX_I2C_ALGO_PCA_H
 #define _LINUX_I2C_ALGO_PCA_H
=20
-/* Clock speeds for the bus */
+/* Chips known to the pca algo */
+#define I2C_PCA_CHIP_9564	0x00
+#define I2C_PCA_CHIP_9665	0x01
+
+/* Internal period for PCA9665 oscilator */
+#define I2C_PCA_OSC_PER		3 /* e10-8s */
+
+/* Clock speeds for the bus for PCA9564*/
 #define I2C_PCA_CON_330kHz	0x00
 #define I2C_PCA_CON_288kHz	0x01
 #define I2C_PCA_CON_217kHz	0x02
@@ -18,6 +25,26 @@
 #define I2C_PCA_ADR		0x02 /* OWN ADR Read/Write */
 #define I2C_PCA_CON		0x03 /* CONTROL Read/Write */
=20
+/* PCA9665 registers */
+#define I2C_PCA_INDPTR          0x00 /* INDIRECT Pointer Write Only */
+#define I2C_PCA_IND             0x02 /* INDIRECT Read/Write */
+
+/* PCA9665 indirect registers */
+#define I2C_PCA_ICOUNT          0x00 /* Byte Count for buffered mode */
+#define I2C_PCA_IADR            0x01 /* OWN ADR */
+#define I2C_PCA_ISCLL           0x02 /* SCL LOW period */
+#define I2C_PCA_ISCLH           0x03 /* SCL HIGH period */
+#define I2C_PCA_ITO             0x04 /* TIMEOUT */
+#define I2C_PCA_IPRESET         0x05 /* Parallel bus reset */
+#define I2C_PCA_IMODE           0x06 /* I2C Bus mode */
+
+/* PCA9665 I2C bus mode */
+#define I2C_PCA_MODE_STD        0x00 /* Standard mode */
+#define I2C_PCA_MODE_FAST       0x01 /* Fast mode */
+#define I2C_PCA_MODE_FASTP      0x02 /* Fast Plus mode */
+#define I2C_PCA_MODE_TURBO      0x03 /* Turbo mode */
+
+
 #define I2C_PCA_CON_AA		0x80 /* Assert Acknowledge */
 #define I2C_PCA_CON_ENSIO	0x40 /* Enable */
 #define I2C_PCA_CON_STA		0x20 /* Start */
@@ -31,7 +58,9 @@ struct i2c_algo_pca_data {
 	int  (*read_byte)		(void *data, int reg);
 	int  (*wait_for_completion)	(void *data);
 	void (*reset_chip)		(void *data);
-	/* i2c_clock values are defined in linux/i2c-algo-pca.h */
+	/* For PCA9564, use one of the predefined frequencies:
+	 * 330000, 288000, 217000, 146000, 88000, 59000, 44000, 36000
+	 * For PCA9665, use the frequency you want here. */
 	unsigned int			i2c_clock;
 };
=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmf+7oACgkQD27XaX1/VRun4QCcDJqFTExFQlhkWjbtcU9cZwZh
g0oAnihsLMS5A3R5PlTZ/x6m4v2LTF9q
=WCTe
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
