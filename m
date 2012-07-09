From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: stu300: use clk_prepare/unprepare
Date: Mon, 9 Jul 2012 14:20:07 +0200
Message-ID: <20120709122007.GH1296@pengutronix.de>
References: <1339522410-570-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q6STzHxy03qt/hK9"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1339522410-570-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Q6STzHxy03qt/hK9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2012 at 07:33:30PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> Make sure we prepare/unprepare the clock for the ST U300
> I2C driver as is required by the clk API especially if you
> use common clock.
>=20
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to next.

BTW sparse throws this for me, maybe you are interested:

drivers/i2c/busses/i2c-stu300.c:464:55: warning: cast removes address space=
 of expression

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Q6STzHxy03qt/hK9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/6zHcACgkQD27XaX1/VRtWYACfVyGkVgquF71/gAAwzW64osVA
/4AAn0XgjdnQIayaB2/CL+JCzmXNJlym
=VaCG
-----END PGP SIGNATURE-----

--Q6STzHxy03qt/hK9--
