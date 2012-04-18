From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: designware: Add support for 16bit register access
Date: Wed, 18 Apr 2012 13:24:26 +0200
Message-ID: <20120418112426.GD21955@pengutronix.de>
References: <1334734399-1003-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1334734399-1003-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2012 at 09:33:19AM +0200, Stefan Roese wrote:
> The STM SPEAr platform can only access the i2c controller register
> via 16bit read/write functions. This patch adds support to
> automatically detect this 16bit access mode.
>=20
> Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>

Thanks for the update, looks mostly good.

> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
> ---
> v2:
> - Removed parenthesis for single-statement block
> - Moved "swab" and "access_16bit" into "accessor_flags"
>=20
>  drivers/i2c/busses/i2c-designware-core.c |   27 ++++++++++++++++++++++--=
---
>  drivers/i2c/busses/i2c-designware-core.h |    5 ++++-
>  2 files changed, 26 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busse=
s/i2c-designware-core.c
> index df87992..b3c5cfa 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -164,9 +164,15 @@ static char *abort_sources[] =3D {
> =20
>  u32 dw_readl(struct dw_i2c_dev *dev, int offset)
>  {
> -	u32 value =3D readl(dev->base + offset);
> +	u32 value;
> =20
> -	if (dev->swab)
> +	if (dev->accessor_flags & ACCESS_16BIT)
> +		value =3D readw(dev->base + offset) |
> +			(readw(dev->base + offset + 2) << 16);
> +	else
> +		value =3D readl(dev->base + offset);
> +
> +	if (dev->accessor_flags & ACCESS_SWAP)
>  		return swab32(value);
>  	else
>  		return value;
> @@ -174,10 +180,15 @@ u32 dw_readl(struct dw_i2c_dev *dev, int offset)
> =20
>  void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
>  {
> -	if (dev->swab)
> +	if (dev->accessor_flags & ACCESS_SWAP)
>  		b =3D swab32(b);
> =20
> -	writel(b, dev->base + offset);
> +	if (dev->accessor_flags & ACCESS_16BIT) {
> +		writew((u16)b, dev->base + offset);
> +		writew((u16)(b >> 16), dev->base + offset + 2);
> +	} else {
> +		writel(b, dev->base + offset);
> +	}
>  }
> =20
>  static u32
> @@ -254,7 +265,13 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  	/* Configure register endianess access */
>  	reg =3D dw_readl(dev, DW_IC_COMP_TYPE);
>  	if (reg =3D=3D ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
> -		dev->swab =3D 1;
> +		dev->accessor_flags |=3D ACCESS_SWAP;
> +		reg =3D DW_IC_COMP_TYPE_VALUE;

May I ask you to use proper if/elseif/else blocks instead of overwriting
reg? I know you didn't come up with the mechanism, yet it looks too
fragile to be extended IMO.

> +	}
> +
> +	/* Configure register access mode 16bit */
> +	if (reg =3D=3D (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {

Does it make sense to check reg + 2 for the upper part of the signature?

> +		dev->accessor_flags |=3D ACCESS_16BIT;
>  		reg =3D DW_IC_COMP_TYPE_VALUE;
>  	}
> =20
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busse=
s/i2c-designware-core.h
> index 02d1a2d..9c1840e 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -82,7 +82,7 @@ struct dw_i2c_dev {
>  	unsigned int		status;
>  	u32			abort_source;
>  	int			irq;
> -	int			swab;
> +	u32			accessor_flags;
>  	struct i2c_adapter	adapter;
>  	u32			functionality;
>  	u32			master_cfg;
> @@ -90,6 +90,9 @@ struct dw_i2c_dev {
>  	unsigned int		rx_fifo_depth;
>  };
> =20
> +#define ACCESS_SWAP		0x00000001
> +#define ACCESS_16BIT		0x00000002
> +
>  extern u32 dw_readl(struct dw_i2c_dev *dev, int offset);
>  extern void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset);
>  extern int i2c_dw_init(struct dw_i2c_dev *dev);
> --=20
> 1.7.10
>=20

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+OpGoACgkQD27XaX1/VRsy7QCfcNWCPZ6GPKKso4tIjyaN8NdS
jaAAn3LG9K0dqdm1CaMh1WQR8yi2mNQK
=ULCb
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
