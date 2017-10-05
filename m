From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Don't set SCL timings and speed mode
 when in slave mode
Date: Thu, 5 Oct 2017 13:18:25 +0200
Message-ID: <20171005111825.kbfb4gcvq26wexnq@ninjato>
References: <20170823134612.26117-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j35xczhrgqdj2hrx"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:38995 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751318AbdJELS1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 5 Oct 2017 07:18:27 -0400
Content-Disposition: inline
In-Reply-To: <20170823134612.26117-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--j35xczhrgqdj2hrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 04:46:12PM +0300, Jarkko Nikula wrote:
> According to data sheet SCL timing parameters and DW_IC_CON SPEED mode
> bits are not used when operating in slave mode.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> I've done quick testing with i2c-slave-eeprom and i2cdump over together
> hooked busses without issues. Would like to hear tested by or comment
> from Luis though. Patch is not urgent so can wait after vacation etc.

Luis?

> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 11 -----
>  drivers/i2c/busses/i2c-designware-slave.c   | 64 -----------------------=
------
>  2 files changed, 75 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bu=
sses/i2c-designware-platdrv.c
> index 56a17fdc2270..962c7ab25b93 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -201,17 +201,6 @@ static void i2c_dw_configure_slave(struct dw_i2c_dev=
 *dev)
>  			 DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED;
> =20
>  	dev->mode =3D DW_IC_SLAVE;
> -
> -	switch (dev->clk_freq) {
> -	case 100000:
> -		dev->slave_cfg |=3D DW_IC_CON_SPEED_STD;
> -		break;
> -	case 3400000:
> -		dev->slave_cfg |=3D DW_IC_CON_SPEED_HIGH;
> -		break;
> -	default:
> -		dev->slave_cfg |=3D DW_IC_CON_SPEED_FAST;
> -	}
>  }
> =20
>  static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepar=
e)
> diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/buss=
es/i2c-designware-slave.c
> index ea9578ab19a1..d42558d1b002 100644
> --- a/drivers/i2c/busses/i2c-designware-slave.c
> +++ b/drivers/i2c/busses/i2c-designware-slave.c
> @@ -51,9 +51,7 @@ static void i2c_dw_configure_fifo_slave(struct dw_i2c_d=
ev *dev)
>   */
>  static int i2c_dw_init_slave(struct dw_i2c_dev *dev)
>  {
> -	u32 sda_falling_time, scl_falling_time;
>  	u32 reg, comp_param1;
> -	u32 hcnt, lcnt;
>  	int ret;
> =20
>  	ret =3D i2c_dw_acquire_lock(dev);
> @@ -79,68 +77,6 @@ static int i2c_dw_init_slave(struct dw_i2c_dev *dev)
>  	/* Disable the adapter. */
>  	__i2c_dw_enable_and_wait(dev, false);
> =20
> -	/* Set standard and fast speed deviders for high/low periods. */
> -	sda_falling_time =3D dev->sda_falling_time ?: 300; /* ns */
> -	scl_falling_time =3D dev->scl_falling_time ?: 300; /* ns */
> -
> -	/* Set SCL timing parameters for standard-mode. */
> -	if (dev->ss_hcnt && dev->ss_lcnt) {
> -		hcnt =3D dev->ss_hcnt;
> -		lcnt =3D dev->ss_lcnt;
> -	} else {
> -		hcnt =3D i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
> -				       4000,	/* tHD;STA =3D tHIGH =3D 4.0 us */
> -				       sda_falling_time,
> -				       0,	/* 0: DW default, 1: Ideal */
> -				       0);	/* No offset */
> -		lcnt =3D i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
> -				       4700,	/* tLOW =3D 4.7 us */
> -				       scl_falling_time,
> -				       0);	/* No offset */
> -	}
> -	dw_writel(dev, hcnt, DW_IC_SS_SCL_HCNT);
> -	dw_writel(dev, lcnt, DW_IC_SS_SCL_LCNT);
> -	dev_dbg(dev->dev, "Standard-mode HCNT:LCNT =3D %d:%d\n", hcnt, lcnt);
> -
> -	/* Set SCL timing parameters for fast-mode or fast-mode plus. */
> -	if ((dev->clk_freq =3D=3D 1000000) && dev->fp_hcnt && dev->fp_lcnt) {
> -		hcnt =3D dev->fp_hcnt;
> -		lcnt =3D dev->fp_lcnt;
> -	} else if (dev->fs_hcnt && dev->fs_lcnt) {
> -		hcnt =3D dev->fs_hcnt;
> -		lcnt =3D dev->fs_lcnt;
> -	} else {
> -		hcnt =3D i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
> -				       600,	/* tHD;STA =3D tHIGH =3D 0.6 us */
> -				       sda_falling_time,
> -				       0,	/* 0: DW default, 1: Ideal */
> -				       0);	/* No offset */
> -		lcnt =3D i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
> -				       1300,	/* tLOW =3D 1.3 us */
> -				       scl_falling_time,
> -				       0);	/* No offset */
> -	}
> -	dw_writel(dev, hcnt, DW_IC_FS_SCL_HCNT);
> -	dw_writel(dev, lcnt, DW_IC_FS_SCL_LCNT);
> -	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT =3D %d:%d\n", hcnt, lcnt);
> -
> -	if ((dev->slave_cfg & DW_IC_CON_SPEED_MASK) =3D=3D
> -		DW_IC_CON_SPEED_HIGH) {
> -		if ((comp_param1 & DW_IC_COMP_PARAM_1_SPEED_MODE_MASK)
> -			!=3D DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH) {
> -			dev_err(dev->dev, "High Speed not supported!\n");
> -			dev->slave_cfg &=3D ~DW_IC_CON_SPEED_MASK;
> -			dev->slave_cfg |=3D DW_IC_CON_SPEED_FAST;
> -		} else if (dev->hs_hcnt && dev->hs_lcnt) {
> -			hcnt =3D dev->hs_hcnt;
> -			lcnt =3D dev->hs_lcnt;
> -			dw_writel(dev, hcnt, DW_IC_HS_SCL_HCNT);
> -			dw_writel(dev, lcnt, DW_IC_HS_SCL_LCNT);
> -			dev_dbg(dev->dev, "HighSpeed-mode HCNT:LCNT =3D %d:%d\n",
> -				hcnt, lcnt);
> -		}
> -	}
> -
>  	/* Configure SDA Hold Time if required. */
>  	reg =3D dw_readl(dev, DW_IC_COMP_VERSION);
>  	if (reg >=3D DW_IC_SDA_HOLD_MIN_VERS) {
> --=20
> 2.14.1
>=20

--j35xczhrgqdj2hrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnWFQEACgkQFA3kzBSg
KbYFGw//aJr+uC6wVEIpzzUQ5qZc1LfxhTGNAtZ1hlepKTmnRd6iUbgeCDJaLT+h
HI9Hmh5ZrCl64KNe1c5PRDyvpTr17n5aJzcYzFJPnytR85erYxHkE1VwDGjLy8dU
b7an8rKNIuMWQQHKR+1bqPBp1rFBI5UpDPXxizKN/oKNj8NG9qIMzSa7xvvT2oWF
22p5I6TCSvsOog0Ck0ChF5uKjlieqqwZAyjtx4XVH8Aeu/6CPtd5Frp0biZVeO51
KHjf1c8w75nIZTxdi5ZEpQY7bbP3p4itqNSsuIEIdyA7Wk+Vn2z/Ng4JjFxeY+x5
QMzlmXGXn1svtj5prLLnWgautVjgW5OC9oZtg7qpLGXeDjpDS2Bpo1ZLOCrN5epq
YLaPvJEqvGd4L8DwqI48RRCXlgooH17VO1X+TQfzWCbQ2/cA3OfUfeVCFwpCp7vG
MDdkUcVgaqqAb+J8dppq7j9FzaQwCqnq8OByZVleTmM7GGDj5rEjzQqQ/XpHiVGb
kAjZV08Qqb5SzqhTlGTHht5LUBqTU3ZhP9d3b2e46ENtsL9R4rbfr/Gyetwq7XGj
OnjPS5kzPsl5Kn8De0/ulxy9P6v6IMF+S9zJv14LGGrUqYxshIMdhn7kgBjMdC84
8k5qbPzAYiUHvnJ9dUQ768HZ0d8FApuy4TFfTVQ0qzNwDnhg9MI=
=gGGG
-----END PGP SIGNATURE-----

--j35xczhrgqdj2hrx--
