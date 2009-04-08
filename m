From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [GIT PULL] i2c updates for 2.6.30
Date: Wed, 8 Apr 2009 10:15:22 +0200
Message-ID: <20090408081522.GB3072@pengutronix.de>
References: <20090328213950.1c788471@hyperion.delvare> <10f740e80904071320t2fdd073bs51f3a8abf0f60e36@mail.gmail.com> <20090408101303.71399654@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090408101303.71399654-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2009 at 10:13:03AM +0200, Jean Delvare wrote:
> Hi Geert,
>=20
> On Tue, 7 Apr 2009 22:20:29 +0200, Geert Uytterhoeven wrote:
> > On Sat, Mar 28, 2009 at 22:39, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > > Please pull the i2c subsystem updates for Linux 2.6.30 from:
> >=20
> > > Wolfram Sang (4):
> > > =A0 =A0 =A0i2c-algo-pca: Rework waiting for a free bus
> >=20
> > This one introduced:
> >=20
> > drivers/i2c/algos/i2c-algo-pca.c:197: warning: 'state' is used
> > uninitialized in this function
> >=20
> > Probably
> >=20
> >         while (pca_status(adap) !=3D 0xf8) {
> >=20
> > should become
> >=20
> >         while ((state =3D pca_status(adap)) !=3D 0xf8) {
> >=20
> > again.
>=20
> You're perfectly right, I must have missed it because I didn't build
> any kernel with CONFIG_I2C_DEBUG_ALGO=3Dy for a long time. Here's the fix
> I will push to Linus soon:
>=20
> From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Subject: i2c-algo-pca: Fix use of uninitialized variable in debug message
>=20
> A recent change broke debugging of pca_xfer(), fix it.
>=20
> Reported-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Heh, I was too slow :)

Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

> ---
>  drivers/i2c/algos/i2c-algo-pca.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- linux-2.6.30-rc1.orig/drivers/i2c/algos/i2c-algo-pca.c	2009-04-08 08:=
52:48.000000000 +0200
> +++ linux-2.6.30-rc1/drivers/i2c/algos/i2c-algo-pca.c	2009-04-08 10:06:36=
=2E000000000 +0200
> @@ -190,7 +190,7 @@ static int pca_xfer(struct i2c_adapter *
>  	int completed =3D 1;
>  	unsigned long timeout =3D jiffies + i2c_adap->timeout;
> =20
> -	while (pca_status(adap) !=3D 0xf8) {
> +	while ((state =3D pca_status(adap)) !=3D 0xf8) {
>  		if (time_before(jiffies, timeout)) {
>  			msleep(10);
>  		} else {
>=20
>=20
> --=20
> Jean Delvare
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkncXRoACgkQD27XaX1/VRuHwACgp/KdpGH/4kXitatTZRa/JWDV
88EAoIEeLQnR8CI/uiPM6iBwjv/l78FI
=drOP
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
