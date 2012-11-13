From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: i2c-ocores: Add irq support for sparc
Date: Tue, 13 Nov 2012 12:10:55 +0100
Message-ID: <20121113111055.GF23119@pengutronix.de>
References: <1352739591-1317-1-git-send-email-andreas@gaisler.com>
 <1352739591-1317-2-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OFj+1YLvsEfSXdCH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352739591-1317-2-git-send-email-andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--OFj+1YLvsEfSXdCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 12, 2012 at 05:59:50PM +0100, Andreas Larsson wrote:
> Add sparc support by using platform_get_irq instead of platform_get_resou=
rce.
> There are no platform resources of type IORESOURCE_IRQ for sparc, but
> platform_get_irq works for sparc. In the non-sparc case platform_get_irq
> internally uses platform_get_resource.
>=20
> Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
> ---
> Changes since v1:
>  - platform_get_irq now works for sparc, so that is used for all platforms
>  - Acked by Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
>=20
>  drivers/i2c/busses/i2c-ocores.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-oco=
res.c
> index bffd550..0b71dc6 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -267,7 +267,8 @@ static int __devinit ocores_i2c_probe(struct platform=
_device *pdev)
>  {
>  	struct ocores_i2c *i2c;
>  	struct ocores_i2c_platform_data *pdata;
> -	struct resource *res, *res2;
> +	struct resource *res;
> +	int irq;
>  	int ret;
>  	int i;
> =20
> @@ -275,8 +276,8 @@ static int __devinit ocores_i2c_probe(struct platform=
_device *pdev)
>  	if (!res)
>  		return -ENODEV;
> =20
> -	res2 =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (!res2)
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
>  		return -ENODEV;

Why not pass the error code you got?

> =20
>  	i2c =3D devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
> @@ -313,7 +314,7 @@ static int __devinit ocores_i2c_probe(struct platform=
_device *pdev)
>  	ocores_init(i2c);
> =20
>  	init_waitqueue_head(&i2c->wait);
> -	ret =3D devm_request_irq(&pdev->dev, res2->start, ocores_isr, 0,
> +	ret =3D devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
>  			       pdev->name, i2c);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Cannot claim IRQ\n");

Rest looks good.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--OFj+1YLvsEfSXdCH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCiKr8ACgkQD27XaX1/VRuCjQCgugJ6/nVu4gaduZKIOQFVnpDg
uZgAoJoMOg/cPcvTacY+B5ULQKeLqNVp
=7JKs
-----END PGP SIGNATURE-----

--OFj+1YLvsEfSXdCH--
