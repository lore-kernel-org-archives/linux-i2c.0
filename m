From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH, v2] Let PCA9564 recover from unacked data byte (state
	0x30)
Date: Tue, 14 Apr 2009 19:01:07 +0200
Message-ID: <20090414170107.GA4260@pengutronix.de>
References: <20090407103847.GA13586@ngeserver2.localdomain> <20090409093855.GB539@ngeserver2.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090409093855.GB539-wEgbaqU1+uOv+36yZLenwA0JkcsJGQge@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enrik Berkhan <Enrik.Berkhan-JJi787mZWgc@public.gmane.org>
Cc: Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enrik,

one minor nit. If that is sorted out, you can add

Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Thanks for the patch,

   Wolfram

On Thu, Apr 09, 2009 at 11:38:55AM +0200, Enrik Berkhan wrote:
> Currently, the i2c-algo-pca driver does nothing if the chip enters state
> 0x30 (Data byte in I2CDAT has been transmitted; NOT ACK has been
> received).  Thus, the i2c bus connected to the controller gets stuck
> afterwards.
>=20
> I have seen this kind of error on a custom board in certain load
> situations most probably caused by interference or noise.
>=20
> A possible reaction is to let the controller generate a STOP condition.
> This is documented in the controller data sheet and the same is done for
> other NACK states as well.
>=20
> Further, state 0x38 isn't handled completely, either. Try to do another
> START in this case like the manual says. As this couldn't be tested,
> I've added a comment to try to reset the chip if the START doesn't help
> as suggested by Wolfram Sang.
>=20
> Signed-off-by: Enrik Berkhan <Enrik.Berkhan-JJi787mZWgc@public.gmane.org>
> ---
>  drivers/i2c/algos/i2c-algo-pca.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> Index: drivers/i2c/algos/i2c-algo-pca.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drivers/i2c/algos/i2c-algo-pca.c.orig	2009-04-07 11:23:08.000000000 +=
0200
> +++ drivers/i2c/algos/i2c-algo-pca.c	2009-04-09 11:10:11.000000000 +0200
> @@ -270,10 +270,17 @@ static int pca_xfer(struct i2c_adapter *
> =20
>  		case 0x30: /* Data byte in I2CDAT has been transmitted; NOT ACK has be=
en received */
>  			DEB2("NOT ACK received after data byte\n");
> +			pca_stop(adap);
>  			goto out;
> =20
>  		case 0x38: /* Arbitration lost during SLA+W, SLA+R or data bytes */
>  			DEB2("Arbitration lost\n");
> +			/*
> +			 * The manual says to send another start
> +			 * condition in this case. If this won't be

A pointer, where the manual says it, is always helpful (revision, chapter, =
page
number or such).

> +			 * sufficient, try pca_reset() instead.
> +			 */
> +			pca_start(adap);
>  			goto out;
> =20
>  		case 0x58: /* Data byte has been received; NOT ACK has been returned */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknkwVMACgkQD27XaX1/VRub0QCgnbhbt5LbXzR4heWFHUQ/IJTF
BEsAnRnebrw0Op4DHnKB9snHwNEAnJ6h
=3n8s
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
