From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-mxs: fix compile warning in mxs_i2c_xfer()
Date: Thu, 24 Nov 2011 09:37:47 +0100
Message-ID: <20111124083747.GE8439@pengutronix.de>
References: <1322121140-5216-1-git-send-email-shawn.guo@linaro.org>
 <20111124082903.GV19986@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111124082903.GV19986-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2011 at 09:29:03AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Shawn,
>=20
> On Thu, Nov 24, 2011 at 03:52:20PM +0800, Shawn Guo wrote:
> >   CC      drivers/i2c/busses/i2c-mxs.o
> > drivers/i2c/busses/i2c-mxs.c: In function =E2=80=98mxs_i2c_xfer=E2=80=
=99:
> > drivers/i2c/busses/i2c-mxs.c:196:6: warning: =E2=80=98data=E2=80=99 may=
 be used uninitialized in this function
> >=20
> > Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-mxs.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> > index 7e78f7c..00f098f 100644
> > --- a/drivers/i2c/busses/i2c-mxs.c
> > +++ b/drivers/i2c/busses/i2c-mxs.c
> > @@ -193,7 +193,7 @@ static int mxs_i2c_wait_for_data(struct mxs_i2c_dev=
 *i2c)
> > =20
> >  static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int l=
en)
> >  {
> > -	u32 data;
> > +	u32 data =3D 0;
> >  	int i;
> > =20
> >  	for (i =3D 0; i < len; i++) {
> Looks like a stupid compiler. Then better use=20
>=20
> 	u32 uninitialized_var(data);

Leave it as it is and fix the compiler? Will do another test later to make
sure.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7OAlsACgkQD27XaX1/VRtE2QCcCAv0h/YnzmZ7HRrOdIYqkFlC
BI0An1dgbfupuq9g2I0KsGRFxluursMq
=sR8B
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
