From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: I2C_FUNC_SMBUS_QUICK on i2c-mxs
Date: Thu, 30 Aug 2012 15:56:12 +0200
Message-ID: <20120830135612.GJ27306@pengutronix.de>
References: <CAOMZO5Dyp-+GXkWZvgsFXbZv15N+4u3iuPjw-sqwLn=5bVGBsw@mail.gmail.com>
 <201208301508.29149.marex@denx.de>
 <20120830131327.GI27306@pengutronix.de>
 <201208301534.27937.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ed/6oDxOLijJh8b0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201208301534.27937.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ed/6oDxOLijJh8b0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2012 at 03:34:27PM +0200, Marek Vasut wrote:
> Dear Wolfram Sang,
>=20
> > > So I'd say that'd rather be flub of the original author of the driver,
> > > being lazy and not testing the corner cases properly? I can't run git
> > > blame to detect who did it now,
> > :
> > :)
>=20
> %^)
>=20
> Hit dogs will holler. Sorry, I'm not on my work machine now. So Wolfram, =
can you=20
> please comment?

I never needed SMBUS_QUICK and left that check from the original
sources. Datasheet doesn't say anything if 0 means nothing or 64K
(because of underrun). Could be worth trying out and instrumenting the
bus with a scope.

PS: Your DMA patches are scheduled for next week (yes, really!)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ed/6oDxOLijJh8b0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlA/cPwACgkQD27XaX1/VRtwAwCgmrkq/swNIkaIVuleNTdO1Q05
CCAAn3Iq88NUflfHTbXg7MSMMDfSBz82
=WUu2
-----END PGP SIGNATURE-----

--ed/6oDxOLijJh8b0--
