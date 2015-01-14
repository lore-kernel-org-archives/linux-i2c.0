From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: imx: silence dma_request_slave_channel errors
 if dma not set up in device tree
Date: Wed, 14 Jan 2015 15:14:07 +0100
Message-ID: <20150114141407.GA1598@katana>
References: <1420555701-24645-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420555701-24645-1-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 03:48:19PM +0100, Philipp Zabel wrote:
> If the i2c device tree nodes don't contain the dmas and dma-names propert=
y, an
> error is displayed for each i2c device:
>=20
>     of_dma_request_slave_channel: dma-names property of node '/soc/aips-b=
us@02100000/i2c@021a0000' missing or empty
>=20
> This patch avoids calling dma_request_slave_channel if the dma-names prop=
erty
> does not exist in the device tree in the first place.
>=20
> Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Aren't you curing the symptoms instead of the cause? Sending a
counterpatch in a second...

> ---
>  drivers/i2c/busses/i2c-imx.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 7f3a9fe..f0d9904 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -288,6 +288,9 @@ static void i2c_imx_dma_request(struct imx_i2c_struct=
 *i2c_imx,
>  	struct device *dev =3D &i2c_imx->adapter.dev;
>  	int ret;
> =20
> +	if (!of_get_property(dev->of_node, "dma-names", NULL))
> +		return;
> +
>  	dma =3D devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
>  	if (!dma)
>  		return;
> --=20
> 2.1.4
>=20

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtnmvAAoJEBQN5MwUoCm2bgIP/3ODaLnGC3X8D0rVfg2kAyDP
HY2m5CKJ2M7ga61l3VnP3sYHI0divOjBs2/0O6peX5KAI6xHEAMr87AP3X3WVEOi
a907cAGmrozfxUSNPv4zUZ5OeXa87rB9JZmjUmqAZ8IIcphWxlM1lusGx0pGqjeW
mxhjWnpvhlEqsXQYgSPpxFQi1f0reFuwUHvROYj8Albf0VZN2yGrB251dOACSplY
xOA8935+vLIEd+azDYDPAmL7oIDvy7b62UhuYcpvDmR4awjMtYsqtMDs7m9wCZl8
4SwfpVeslJ0kD4lpAWw2EVLEcXDghLHFRJR2erC9Hm5QWfTf7gD6Y3rMzqGnPiq0
ux36Kbxw/SqiVEnqjjdEinibKxWTnOEiC931lhC9skyB8UUgdCdycEx6l7pNxOBS
9K6bY5LG0p0ujuiYI40BGVtlO3yja7YZtrTPaILNiWb8BfqSjnytsbP1KUooHQDa
p5/jiQvJV4lqeHwDhK0IZIzQMYGP2fxLYuTG4sgESHbVIVWzz7yj+sOM4YG4OQ8g
xz3ZqioCVkIVT6Mt6IhSP1/q30Z3Z1AQdVPf2YWoJZ3yRMF6wwucIBJRS6WtVCMl
ExklT18vF1uRiXcKZrEUTVHS93svPHHNe9AiO6xHjPQeX8RQqL97crxBoody/6TL
8ZGm6QT1iO+qvhy+gpu9
=Uaeu
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
