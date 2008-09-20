From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: PCA9665 support added to i2c-algo-pca and i2c-pca-isa.c
Date: Sat, 20 Sep 2008 09:21:31 +0200
Message-ID: <20080920072131.GB12497@pengutronix.de>
References: <48D3B5B7.1060402@gamic.com> <20080919145500.GH4307@pengutronix.de>
	<48D3C74E.1050801@gamic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8421965185165653595=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48D3C74E.1050801-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
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


--===============8421965185165653595==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marco,

> I did the fixes you pointed out and run the script.
> This is the result.

Thanks. This patch is somehow missing the i2c-algo-pca.h changes.

> +	adap->algo =3D &pca_algo;
> +
> +	if (pca_data->i2c_chip_type > I2C_PCA_CHIP_9665) {

I wonder if something like I2C_PCA_CHIP_MAXVAL could be useful here.
Then, if another chip will be added, you just need changes in the .h
file.

> +		printk(KERN_WARNING "%s: Invalid chip selected."
> +				"Assuming PCA9564.\n", adap->name);
> +		pca_data->i2c_chip_type =3D I2C_PCA_CHIP_9564;
>  	}
> =20
> -	adap->algo =3D &pca_algo;
> +	if (pca_data->i2c_chip_type =3D=3D I2C_PCA_CHIP_9564) {
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
> +					"Trying default.\n", adap->name);

Please mention what the default is.

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
> +		int tlow, thigh;
> +		int min_tlow, min_thigh;
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
> +		clock =3D pca_clock(pca_data)/100; /* Hz*100 */

CodingStyle (no spaces around operators)
The comment is also a bit misleading as it is the opposite from the
code. Please be a bit more detailed here.

> =20
> -	pca_reset(pca_data);
> =20
> -	clock =3D pca_clock(pca_data);
> -	DEB1(KERN_INFO "%s: Clock frequency is %dkHz\n", adap->name, freqs[cloc=
k]);
> +		if (pca_data->i2c_clock > 10000) {
> +			mode =3D I2C_PCA_MODE_TURBO;
> +			min_tlow =3D 14;
> +			min_thigh  =3D 5;
> +			raise_fall_time =3D 22; /* Raise 11e-8s, Fall 11e-8s */
> +		} else if (pca_data->i2c_clock > 4000) {
> +			mode =3D I2C_PCA_MODE_FASTP;
> +			min_tlow =3D 17;
> +			min_thigh  =3D 9;
> +			raise_fall_time =3D 22; /* Raise 11e-8s, Fall 11e-8s */
> +		} else if (pca_data->i2c_clock > 1000) {
> +			mode =3D I2C_PCA_MODE_FAST;
> +			min_tlow =3D 44;
> +			min_thigh  =3D 20;
> +			raise_fall_time =3D 58; /* Raise 29e-8s, Fall 29e-8s */
> +		} else {
> +			mode =3D I2C_PCA_MODE_STD;
> +			min_tlow =3D 157;
> +			min_thigh  =3D 134;
> +			raise_fall_time =3D 127; /* Raise 29e-8s, Fall 98e-8s */
> +		}
> +
> +		if (clock < 648) {
> +			tlow =3D 255;
> +			thigh =3D (1000000-clock*raise_fall_time)/(3*clock)-tlow;

CodingStyle (no spaces around operators)
The values look a bit magic. I could find min_t*-values in the spec,
still a reference to the section of the spec will be helpful. I think
you could elaborate a bit more on raise_fall_time and clock < 648,
though.

> +		} else {
> +			tlow =3D ((1000000-clock*raise_fall_time)*min_tlow);
> +			tlow /=3D (3*clock*(min_thigh+min_tlow));
> +			thigh =3D tlow*min_thigh/min_tlow;
> +		}

CodingStyle (no spaces around operators)

> +
> +		pca_reset(pca_data);
> =20
> -	pca_set_con(pca_data, I2C_PCA_CON_ENSIO | clock);
> +		DEB1(KERN_INFO
> +		     "%s: Clock frequency is %dHz\n", adap->name, clock*100);

CodingStyle (no spaces around operators)

> +
> +		pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_IMODE);
> +		pca_outw(pca_data, I2C_PCA_IND, mode);
> +		pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_ISCLL);
> +		pca_outw(pca_data, I2C_PCA_IND, tlow);
> +		pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_ISCLH);
> +		pca_outw(pca_data, I2C_PCA_IND, thigh);
> +
> +		pca_set_con(pca_data, I2C_PCA_CON_ENSIO);
> +	}
>  	udelay(500); /* 500 us for oscilator to stabilise */
> =20
>  	return 0;
> @@ -384,7 +508,7 @@
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
> +++ linux-2.6.26.5-new/drivers/i2c/busses/i2c-pca-isa.c	2008-09-19 12:27:=
51.000000000 -0300
> @@ -41,7 +41,8 @@
> =20
>  /* Data sheet recommends 59kHz for 100kHz operation due to variation
>   * in the actual clock rate */
> -static int clock  =3D I2C_PCA_CON_59kHz;
> +static int clock  =3D 59000;
> +static int chip   =3D I2C_PCA_CHIP_9564;
> =20
>  static wait_queue_head_t pca_wait;
> =20
> @@ -103,7 +104,7 @@
>  	.owner          =3D THIS_MODULE,
>  	.id		=3D I2C_HW_A_ISA,
>  	.algo_data	=3D &pca_isa_data,
> -	.name		=3D "PCA9564 ISA Adapter",
> +	.name		=3D "PCA9564/PCA9665 ISA Adapter",
>  	.timeout	=3D 100,
>  };
> =20
> @@ -132,6 +133,7 @@
>  		}
>  	}
> =20
> +	pca_isa_data.i2c_chip_type =3D chip;
>  	pca_isa_data.i2c_clock =3D clock;
>  	if (i2c_pca_add_bus(&pca_isa_ops) < 0) {
>  		dev_err(dev, "Failed to add i2c bus\n");
> @@ -182,7 +184,7 @@
>  }
> =20
>  MODULE_AUTHOR("Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>");
> -MODULE_DESCRIPTION("ISA base PCA9564 driver");
> +MODULE_DESCRIPTION("ISA base PCA9564/PCA9665 driver");
>  MODULE_LICENSE("GPL");
> =20
>  module_param(base, ulong, 0);
> @@ -191,7 +193,15 @@
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
> +module_param(chip, int, 0);
> +MODULE_PARM_DESC(chip, "Chip type: 0 =3D PCA9564; 1 - PCA9665");
> =20
>  module_init(pca_isa_init);
>  module_exit(pca_isa_exit);
> diff -ur linux-2.6.26.5/drivers/i2c/busses/i2c-pca-platform.c linux-2.6.2=
6.5-new/drivers/i2c/busses/i2c-pca-platform.c
> --- linux-2.6.26.5/drivers/i2c/busses/i2c-pca-platform.c	2008-09-08 14:40=
:20.000000000 -0300
> +++ linux-2.6.26.5-new/drivers/i2c/busses/i2c-pca-platform.c	2008-09-19 1=
2:28:36.000000000 -0300
> @@ -172,8 +172,9 @@
> =20
>  	i2c->adap.nr =3D pdev->id >=3D 0 ? pdev->id : 0;
>  	i2c->adap.owner =3D THIS_MODULE;
> -	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "PCA9564 at 0x%08lx",
> -		(unsigned long) res->start);
> +	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
> +		 "PCA9564/PCA9665 at 0x%08lx",

I think we could be precise here as we know the chip-type. I just got
the idea: Do you think it is possible to detect the chip type at
runtime? Perhaps by somehow checking the presence of the indirect
register?

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

> _______________________________________________
> i2c mailing list
> i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c

I haven't really applied the patch yet. Will do on Monday when I have
access to the PCA9564-equipped board.

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjUpHsACgkQD27XaX1/VRtKPgCfYlhmTry6jkQ4ZjTSCh8OLjH9
mlEAoLjkS8pccDRiFhgMWXo3oKKvErgq
=g3Cm
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--


--===============8421965185165653595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============8421965185165653595==--
