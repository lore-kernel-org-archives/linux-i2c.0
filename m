From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Let PCA9564 recover from unacked data byte (state 0x30)
Date: Tue, 7 Apr 2009 23:04:09 +0200
Message-ID: <20090407210409.GA21933@pengutronix.de>
References: <20090407103847.GA13586@ngeserver2.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090407103847.GA13586-wEgbaqU1+uOv+36yZLenwA0JkcsJGQge@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enrik Berkhan <Enrik.Berkhan-JJi787mZWgc@public.gmane.org>
Cc: Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enrik,

On Tue, Apr 07, 2009 at 12:38:56PM +0200, Enrik Berkhan wrote:
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
> Signed-off-by: Enrik Berkhan <Enrik.Berkhan-JJi787mZWgc@public.gmane.org>
> ---
>  drivers/i2c/algos/i2c-algo-pca.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> Index: drivers/i2c/algos/i2c-algo-pca.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drivers/i2c/algos/i2c-algo-pca.c.orig	2009-04-07 11:23:08.000000000 +=
0200
> +++ drivers/i2c/algos/i2c-algo-pca.c	2009-04-07 11:24:56.000000000 +0200
> @@ -270,10 +270,12 @@ static int pca_xfer(struct i2c_adapter *
> =20
>  		case 0x30: /* Data byte in I2CDAT has been transmitted; NOT ACK has be=
en received */
>  			DEB2("NOT ACK received after data byte\n");
> +			pca_stop(adap);

This looks okay.

>  			goto out;
> =20
>  		case 0x38: /* Arbitration lost during SLA+W, SLA+R or data bytes */
>  			DEB2("Arbitration lost\n");
> +			// XXX pca_start()? pca_reset()?

(No // comments, see CodingStyle)

I think we should do something here, too. The manual says something about d=
oing
another start. What about doing this and adding a comment that possibly a r=
eset
is another thing to try in case of problems?

>  			goto out;
> =20
>  		case 0x58: /* Data byte has been received; NOT ACK has been returned */

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknbv8kACgkQD27XaX1/VRubLgCgwmOgsTO9QEtfjvJug3HSe3bF
Lr4AoJQHBVBiiym2qRAyICd7XOexie97
=/9F2
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
