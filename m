From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: PCA9665 support added to i2c-algo-pca and i2c-pca-isa.c
Date: Wed, 1 Oct 2008 19:39:09 +0200
Message-ID: <20081001173909.GG17953@pengutronix.de>
References: <48D3B5B7.1060402@gamic.com> <20080919145500.GH4307@pengutronix.de>
	<48D3C74E.1050801@gamic.com>
	<20080920072131.GB12497@pengutronix.de>
	<c76dcaf00809200409r7e0420c9rcb83a654d40e217a@mail.gmail.com>
	<c76dcaf00809200510k7e6b4648v630dc33bf6401cca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2164862613532693029=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <c76dcaf00809200510k7e6b4648v630dc33bf6401cca-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Marco Aurelio da Costa <costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============2164862613532693029==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2E/hm+v6kSLEYT3h"
Content-Disposition: inline


--2E/hm+v6kSLEYT3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marco,

finally I came around to setup my board with the PCA9564. Here are my
results: The algo detected the PCA9564 and moaned about the old style of
supplying the frequency. I could easily change it to newstyle. In every
case, I could still correctly read out the eeprom. So, everything worked
flawlessly with a PCA9564. So, if the PCA9665 works for you and you just
apply these minor suggestions below, I think the patch is ready for
submission. For that, you should follow the canocical patch format
(Documentation/SubmittingPatches, Chapter 15) when you post that
version.

Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

On Sat, Sep 20, 2008 at 09:10:12AM -0300, Marco Aurelio da Costa wrote:
> Hi Wolfram.
>=20
> On Sat, Sep 20, 2008 at 8:09 AM, Marco Aurelio da Costa <costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>=
 wrote:
> > I will send you the corrected patch after your comment on the
> > auto-detection issue.
> >
> Actually, I changed my mind and implemented the auto-detection code.
> Here is the new patch.
>=20
> Regards,
>=20
> Marco

> diff -ur linux-2.6.26.5/drivers/i2c/algos/i2c-algo-pca.c linux-2.6.26.5-n=
ew/drivers/i2c/algos/i2c-algo-pca.c
> --- linux-2.6.26.5/drivers/i2c/algos/i2c-algo-pca.c	2008-09-08 14:40:20.0=
00000000 -0300
> +++ linux-2.6.26.5-new/drivers/i2c/algos/i2c-algo-pca.c	2008-09-20 09:07:=
35.000000000 -0300
> @@ -43,6 +43,14 @@
>  #define pca_wait(adap) adap->wait_for_completion(adap->data)
>  #define pca_reset(adap) adap->reset_chip(adap->data)
> =20
> +static void pca9665_reset(void *pd)
> +{
> +	struct i2c_algo_pca_data *adap =3D pd;
> +	pca_outw(adap, I2C_PCA_INDPTR, I2C_PCA_IPRESET);
> +	pca_outw(adap, I2C_PCA_IND, 0xA5);
> +	pca_outw(adap, I2C_PCA_IND, 0x5A);
> +}
> +
>  /*
>   * Generate a start condition on the i2c bus.
>   *
> @@ -330,26 +338,176 @@
>  	.functionality	=3D pca_func,
>  };
> =20
> -static int pca_init(struct i2c_adapter *adap)
> +static unsigned int pca_probe_chip(struct i2c_adapter *adap)
>  {
> -	static int freqs[] =3D {330,288,217,146,88,59,44,36};
> -	int clock;
>  	struct i2c_algo_pca_data *pca_data =3D adap->algo_data;
> -
> -	if (pca_data->i2c_clock > 7) {
> -		printk(KERN_WARNING "%s: Invalid I2C clock speed selected. Trying defa=
ult.\n",
> +	/* The trick here is to check if there is an indirect register
> +	 * available. If there is one, we will read the value we first
> +	 * wrote on I2C_PCA_IADR. Otherwise, we will read the last value
> +	 * we wrote on I2C_PCA_ADR
> +	 */
> +	pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_IADR);
> +	pca_outw(pca_data, I2C_PCA_IND, 0xAA);
> +	pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_ITO);
> +	pca_outw(pca_data, I2C_PCA_IND, 0x00);
> +	pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_IADR);
> +	if (pca_inw(pca_data, I2C_PCA_IND) =3D=3D 0xAA) {
> +		printk(KERN_INFO
> +			"%s: PCA9665 detected.",

"\n" is missing. Also, the whole printk should fit into one line.

>  			adap->name);
> -		pca_data->i2c_clock =3D I2C_PCA_CON_59kHz;
> +		 return I2C_PCA_CHIP_9665;
> +	} else {
> +		printk(KERN_INFO
> +			"%s: PCA9564 detected.",

Here, too.

> +			adap->name);
> +		return I2C_PCA_CHIP_9564;
>  	}
> +}
> +
> +static int pca_init(struct i2c_adapter *adap)
> +{
> +	struct i2c_algo_pca_data *pca_data =3D adap->algo_data;
> =20
>  	adap->algo =3D &pca_algo;
> =20
> -	pca_reset(pca_data);
> +	if (pca_probe_chip(adap) =3D=3D I2C_PCA_CHIP_9564) {
> +		static int freqs[] =3D {330, 288, 217, 146, 88, 59, 44, 36};
> +		int clock;
> +
> +		if (pca_data->i2c_clock > 7) {
> +			switch (pca_data->i2c_clock) {
> +			case 330000:
> +				pca_data->i2c_clock =3D I2C_PCA_CON_330kHz;
> +				break;
> +			case 288000:
> +				pca_data->i2c_clock =3D I2C_PCA_CON_288kHz;
> +				break;
> +			case 217000:
> +				pca_data->i2c_clock =3D I2C_PCA_CON_217kHz;
> +				break;
> +			case 146000:
> +				pca_data->i2c_clock =3D I2C_PCA_CON_146kHz;
> +				break;
> +			case 88000:
> +				pca_data->i2c_clock =3D I2C_PCA_CON_88kHz;
> +				break;
> +			case 59000:
> +				pca_data->i2c_clock =3D I2C_PCA_CON_59kHz;
> +				break;
> +			case 44000:
> +				pca_data->i2c_clock =3D I2C_PCA_CON_44kHz;
> +				break;
> +			case 36000:
> +				pca_data->i2c_clock =3D I2C_PCA_CON_36kHz;
> +				break;
> +			default:
> +				printk(KERN_WARNING
> +					"%s: Invalid I2C clock speed selected."
> +					"Using default 59kHz.\n", adap->name);

Space before "Using".

> +			pca_data->i2c_clock =3D I2C_PCA_CON_59kHz;
> +			}
> +		} else {
> +			printk(KERN_WARNING "%s: "
> +				"Choosing the clock frequency based on "
> +				"index is deprecated."
> +				" Use the nominal frequency.\n", adap->name);
> +		}
> +
> +		pca_reset(pca_data);
> +
> +		clock =3D pca_clock(pca_data);
> +		DEB1(KERN_INFO "%s: Clock frequency is %dkHz\n",
> +		     adap->name, freqs[clock]);
> +
> +		pca_set_con(pca_data, I2C_PCA_CON_ENSIO | clock);
> +	} else {
> +		int clock;
> +		int mode;
> +		int tlow, thi;
> +		/* Values can be found on PCA9665 datasheet section 7.3.2.6 */
> +		int min_tlow, min_thi;
> +		/* These values are the maximum raise and fall values allowed
> +		 * by the I2C operation mode (Standard, Fast or Fast+)
> +		 * They are used (added) below to calculate the clock dividers
> +		 * of PCA9665. Note that they are slightly different of the
> +		 * real maximum, to allow the change on mode exactly on the
> +		 * maximum clock rate for each mode
> +		 */
> +		int raise_fall_time;
> +
> +		struct i2c_algo_pca_data *pca_data =3D adap->algo_data;
> +
> +		/* Ignore the reset function from the module,
> +		 * we can use the parallel bus reset
> +		 */
> +		pca_data->reset_chip =3D pca9665_reset;
> +
> +		if (pca_data->i2c_clock > 1265800) {
> +			printk(KERN_WARNING "%s: I2C clock speed too high."
> +				" Using 1265.8kHz.\n", adap->name);
> +			pca_data->i2c_clock =3D 1265800;
> +		}
> +
> +		if (pca_data->i2c_clock < 60300) {
> +			printk(KERN_WARNING "%s: I2C clock speed too low."
> +				" Using 60.3kHz.\n", adap->name);
> +			pca_data->i2c_clock =3D 60300;
> +		}
> +
> +		/* To avoid integer overflow, use clock/100 for calculations */
> +		clock =3D pca_clock(pca_data)/100;

Spaces around operators.

> =20
> -	clock =3D pca_clock(pca_data);
> -	DEB1(KERN_INFO "%s: Clock frequency is %dkHz\n", adap->name, freqs[cloc=
k]);
> =20
> -	pca_set_con(pca_data, I2C_PCA_CON_ENSIO | clock);
> +		if (pca_data->i2c_clock > 10000) {
> +			mode =3D I2C_PCA_MODE_TURBO;
> +			min_tlow =3D 14;
> +			min_thi  =3D 5;
> +			raise_fall_time =3D 22; /* Raise 11e-8s, Fall 11e-8s */
> +		} else if (pca_data->i2c_clock > 4000) {
> +			mode =3D I2C_PCA_MODE_FASTP;
> +			min_tlow =3D 17;
> +			min_thi  =3D 9;
> +			raise_fall_time =3D 22; /* Raise 11e-8s, Fall 11e-8s */
> +		} else if (pca_data->i2c_clock > 1000) {
> +			mode =3D I2C_PCA_MODE_FAST;
> +			min_tlow =3D 44;
> +			min_thi  =3D 20;
> +			raise_fall_time =3D 58; /* Raise 29e-8s, Fall 29e-8s */
> +		} else {
> +			mode =3D I2C_PCA_MODE_STD;
> +			min_tlow =3D 157;
> +			min_thi  =3D 134;
> +			raise_fall_time =3D 127; /* Raise 29e-8s, Fall 98e-8s */
> +		}
> +
> +		/* The minimum clock that respects the thi/tlow =3D 134/157 is
> +		 * 64800 Hz. Below that, we have to fix the tlow to 255 and
> +		 * calculate the thi factor.
> +		 */
> +		if (clock < 648) {
> +			tlow =3D 255;
> +			thi =3D 1000000 - clock * raise_fall_time;
> +			thi /=3D (I2C_PCA_OSC_PER * clock) - tlow;
> +		} else {
> +			tlow =3D (1000000 - clock * raise_fall_time) * min_tlow;
> +			tlow /=3D I2C_PCA_OSC_PER * clock * (min_thi + min_tlow);
> +			thi =3D tlow * min_thi / min_tlow;
> +		}
> +
> +		pca_reset(pca_data);
> +
> +		DEB1(KERN_INFO
> +		     "%s: Clock frequency is %dHz\n", adap->name, clock * 100);
> +
> +		pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_IMODE);
> +		pca_outw(pca_data, I2C_PCA_IND, mode);
> +		pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_ISCLL);
> +		pca_outw(pca_data, I2C_PCA_IND, tlow);
> +		pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_ISCLH);
> +		pca_outw(pca_data, I2C_PCA_IND, thi);
> +
> +		pca_set_con(pca_data, I2C_PCA_CON_ENSIO);
> +	}
>  	udelay(500); /* 500 us for oscilator to stabilise */
> =20
>  	return 0;
> @@ -384,7 +542,7 @@
> =20
>  MODULE_AUTHOR("Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>, "
>  	"Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> -MODULE_DESCRIPTION("I2C-Bus PCA9564 algorithm");
> +MODULE_DESCRIPTION("I2C-Bus PCA9564/PCA9665 algorithm");
>  MODULE_LICENSE("GPL");
> =20
>  module_param(i2c_debug, int, 0);
> diff -ur linux-2.6.26.5/drivers/i2c/busses/i2c-pca-isa.c linux-2.6.26.5-n=
ew/drivers/i2c/busses/i2c-pca-isa.c
> --- linux-2.6.26.5/drivers/i2c/busses/i2c-pca-isa.c	2008-09-08 14:40:20.0=
00000000 -0300
> +++ linux-2.6.26.5-new/drivers/i2c/busses/i2c-pca-isa.c	2008-09-20 08:53:=
59.000000000 -0300
> @@ -41,7 +41,7 @@
> =20
>  /* Data sheet recommends 59kHz for 100kHz operation due to variation
>   * in the actual clock rate */
> -static int clock  =3D I2C_PCA_CON_59kHz;
> +static int clock  =3D 59000;
> =20
>  static wait_queue_head_t pca_wait;
> =20
> @@ -103,7 +103,7 @@
>  	.owner          =3D THIS_MODULE,
>  	.id		=3D I2C_HW_A_ISA,
>  	.algo_data	=3D &pca_isa_data,
> -	.name		=3D "PCA9564 ISA Adapter",
> +	.name		=3D "PCA9564/PCA9665 ISA Adapter",
>  	.timeout	=3D 100,
>  };
> =20
> @@ -182,7 +182,7 @@
>  }
> =20
>  MODULE_AUTHOR("Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>");
> -MODULE_DESCRIPTION("ISA base PCA9564 driver");
> +MODULE_DESCRIPTION("ISA base PCA9564/PCA9665 driver");
>  MODULE_LICENSE("GPL");
> =20
>  module_param(base, ulong, 0);
> @@ -191,7 +191,13 @@
>  module_param(irq, int, 0);
>  MODULE_PARM_DESC(irq, "IRQ");
>  module_param(clock, int, 0);
> -MODULE_PARM_DESC(clock, "Clock rate as described in table 1 of PCA9564 d=
atasheet");
> +MODULE_PARM_DESC(clock, "Clock rate in hertz.\n\t\t"
> +		"For PCA9564: 330000,288000,217000,146000,"
> +		"88000,59000,44000,36000\n"
> +		"\t\tFor PCA9665:\tStandard: 60300 - 100099\n"
> +		"\t\t\t\tFast: 100100 - 400099\n"
> +		"\t\t\t\tFast+: 400100 - 10000099\n"
> +		"\t\t\t\tTurbo: Up to 1265800");
> =20
>  module_init(pca_isa_init);
>  module_exit(pca_isa_exit);
> diff -ur linux-2.6.26.5/drivers/i2c/busses/i2c-pca-platform.c linux-2.6.2=
6.5-new/drivers/i2c/busses/i2c-pca-platform.c
> --- linux-2.6.26.5/drivers/i2c/busses/i2c-pca-platform.c	2008-09-08 14:40=
:20.000000000 -0300
> +++ linux-2.6.26.5-new/drivers/i2c/busses/i2c-pca-platform.c	2008-09-20 0=
8:25:37.000000000 -0300
> @@ -172,8 +172,9 @@
> =20
>  	i2c->adap.nr =3D pdev->id >=3D 0 ? pdev->id : 0;
>  	i2c->adap.owner =3D THIS_MODULE;
> -	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "PCA9564 at 0x%08lx",
> -		(unsigned long) res->start);
> +	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
> +		 "PCA9564/PCA9665 at 0x%08lx",
> +		 (unsigned long) res->start);
>  	i2c->adap.algo_data =3D &i2c->algo_data;
>  	i2c->adap.dev.parent =3D &pdev->dev;
>  	i2c->adap.timeout =3D platform_data->timeout;
> @@ -246,7 +247,7 @@
>  e_alloc:
>  	release_mem_region(res->start, res_len(res));
>  e_print:
> -	printk(KERN_ERR "Registering PCA9564 FAILED! (%d)\n", ret);
> +	printk(KERN_ERR "Registering PCA9564/PCA9665 FAILED! (%d)\n", ret);
>  	return ret;
>  }
> =20
> @@ -290,7 +291,7 @@
>  }
> =20
>  MODULE_AUTHOR("Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> -MODULE_DESCRIPTION("I2C-PCA9564 platform driver");
> +MODULE_DESCRIPTION("I2C-PCA9564/PCA9665 platform driver");
>  MODULE_LICENSE("GPL");
> =20
>  module_init(i2c_pca_pf_init);
> diff -ur linux-2.6.26.5/drivers/i2c/busses/Kconfig linux-2.6.26.5-new/dri=
vers/i2c/busses/Kconfig
> --- linux-2.6.26.5/drivers/i2c/busses/Kconfig	2008-09-08 14:40:20.0000000=
00 -0300
> +++ linux-2.6.26.5-new/drivers/i2c/busses/Kconfig	2008-09-19 10:33:35.000=
000000 -0300
> @@ -630,7 +630,7 @@
>  	  will be called i2c-voodoo3.
> =20
>  config I2C_PCA_ISA
> -	tristate "PCA9564 on an ISA bus"
> +	tristate "PCA9564/PCA9665 on an ISA bus"
>  	depends on ISA
>  	select I2C_ALGOPCA
>  	default n
> @@ -647,7 +647,7 @@
>  	  time).  If unsure, say N.
> =20
>  config I2C_PCA_PLATFORM
> -	tristate "PCA9564 as platform device"
> +	tristate "PCA9564/PCA9665 as platform device"
>  	select I2C_ALGOPCA
>  	default n
>  	help
> diff -ur linux-2.6.26.5/include/linux/i2c-algo-pca.h linux-2.6.26.5-new/i=
nclude/linux/i2c-algo-pca.h
> --- linux-2.6.26.5/include/linux/i2c-algo-pca.h	2008-09-08 14:40:20.00000=
0000 -0300
> +++ linux-2.6.26.5-new/include/linux/i2c-algo-pca.h	2008-09-20 08:56:11.0=
00000000 -0300
> @@ -1,7 +1,14 @@
>  #ifndef _LINUX_I2C_ALGO_PCA_H
>  #define _LINUX_I2C_ALGO_PCA_H
> =20
> -/* Clock speeds for the bus */
> +/* Chips known to the pca algo */
> +#define I2C_PCA_CHIP_9564	0x00
> +#define I2C_PCA_CHIP_9665	0x01
> +
> +/* Internal period for PCA9665 oscilator */
> +#define I2C_PCA_OSC_PER		3 /* e10-8s */
> +
> +/* Clock speeds for the bus for PCA9564*/
>  #define I2C_PCA_CON_330kHz	0x00
>  #define I2C_PCA_CON_288kHz	0x01
>  #define I2C_PCA_CON_217kHz	0x02
> @@ -18,6 +25,26 @@
>  #define I2C_PCA_ADR		0x02 /* OWN ADR Read/Write */
>  #define I2C_PCA_CON		0x03 /* CONTROL Read/Write */
> =20
> +/* PCA9665 registers */
> +#define I2C_PCA_INDPTR          0x00 /* INDIRECT Pointer Write Only */
> +#define I2C_PCA_IND             0x02 /* INDIRECT Read/Write */
> +
> +/* PCA9665 indirect registers */
> +#define I2C_PCA_ICOUNT          0x00 /* Byte Count for buffered mode */
> +#define I2C_PCA_IADR            0x01 /* OWN ADR */
> +#define I2C_PCA_ISCLL           0x02 /* SCL LOW period */
> +#define I2C_PCA_ISCLH           0x03 /* SCL HIGH period */
> +#define I2C_PCA_ITO             0x04 /* TIMEOUT */
> +#define I2C_PCA_IPRESET         0x05 /* Parallel bus reset */
> +#define I2C_PCA_IMODE           0x06 /* I2C Bus mode */
> +
> +/* PCA9665 I2C bus mode */
> +#define I2C_PCA_MODE_STD        0x00 /* Standard mode */
> +#define I2C_PCA_MODE_FAST       0x01 /* Fast mode */
> +#define I2C_PCA_MODE_FASTP      0x02 /* Fast Plus mode */
> +#define I2C_PCA_MODE_TURBO      0x03 /* Turbo mode */
> +
> +
>  #define I2C_PCA_CON_AA		0x80 /* Assert Acknowledge */
>  #define I2C_PCA_CON_ENSIO	0x40 /* Enable */
>  #define I2C_PCA_CON_STA		0x20 /* Start */
> @@ -31,7 +58,9 @@
>  	int  (*read_byte)		(void *data, int reg);
>  	int  (*wait_for_completion)	(void *data);
>  	void (*reset_chip)		(void *data);
> -	/* i2c_clock values are defined in linux/i2c-algo-pca.h */
> +	/* For PCA9964, use one of the predefined frequencies:

Typo: Not 9964, but 9564

> +	 * 330000, 288000, 217000, 146000, 88000, 59000, 44000, 36000
> +	 * For PCA9665, use the frequency you want here. */
>  	unsigned int			i2c_clock;
>  };
> =20

> _______________________________________________
> i2c mailing list
> i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c

All the best and thanks for the patch!

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--2E/hm+v6kSLEYT3h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjjtb0ACgkQD27XaX1/VRuahgCgwlv8cC2p4Q5UaWpvF3mjBiGW
mQcAn130Uz/psnQs/LFNLU+eg6qGnYs0
=T+z/
-----END PGP SIGNATURE-----

--2E/hm+v6kSLEYT3h--


--===============2164862613532693029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============2164862613532693029==--
