From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa.c: timeouts off by 1
Date: Wed, 29 Apr 2009 22:06:58 +0200
Message-ID: <20090429200658.GA12251@pengutronix.de>
References: <49A524E4.5050108@gmail.com> <20090423143654.7fc2327e@hyperion.delvare> <49F07ADB.1030300@gmail.com> <20090423170218.66dda625@hyperion.delvare> <20090423163507.9588a73d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090423163507.9588a73d.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2009 at 04:35:07PM -0700, Andrew Morton wrote:
> On Thu, 23 Apr 2009 17:02:18 +0200
> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>=20
> > On Thu, 23 Apr 2009 16:27:39 +0200, Roel Kluin wrote:
> > > Ok, here's for drivers/i2c/busses/i2c-pxa.c. Note that I found anothe=
r,
> > > the last hunk.
> > > --------------------------->8-------------8<-------------------------=
-----
> > > With `while (timeout--)' timeout reaches -1 after the loop, so the te=
sts
> > > below are off by one.
> > >=20
> > > Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > ---
> >=20
> > Ben, Wolfram, I'll let you handle this one as it's an arm driver.
> >=20
>=20
> The patch looks OK,=20

Yup.

Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

>=20
> : static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
> : {
> : 	int timeout =3D DEF_TIMEOUT;
> :=20
> : 	while (timeout-- && readl(_ISR(i2c)) & (ISR_IBB | ISR_UB)) {
> : 		if ((readl(_ISR(i2c)) & ISR_SAD) !=3D 0)
> : 			timeout +=3D 4;
> :=20
> : 		msleep(2);
> : 		show_state(i2c);
> : 	}
> :=20
> : 	if (timeout < 0)
> : 		show_state(i2c);
> :=20
> : 	return timeout < 0 ? I2C_RETRY : 0;
> : }
>=20
> The timeout+=3D4 inside the loop makes my brain hurt.  It makes the loop
> potentially almost-infinite.  By effectively doing timeout+=3D3 each time
> we'll break out of the loop after we've wrapped through 0x100000000
> three times.  Or something.  Help!

Well, it only adds 4 if there was its own I2C-slave address detected. Witho=
ut
knowing the details, I assume there is a reason; I wouldn't dare changing i=
t.

> Also, i2c_pxa_pio_set_master() does
>=20
> 	long timeout =3D 2 * DEF_TIMEOUT;
>=20
> whereas i2c_pxa_wait_bus_not_bus() does
>=20
> 	int timeout =3D DEF_TIMEOUT;
>=20
>=20
> `int' seems an appropriate choice.

This driver seems to have quite some more potential for cleaning up :)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkn4s2IACgkQD27XaX1/VRt2QgCgutgT4jlamJvweGgdZhb6Hncp
KiQAoMNGe8LOhpzNB5rxP4f/T7KJK7EK
=DQ/g
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
