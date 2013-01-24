From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v5] i2c: nomadik: adopt pinctrl support
Date: Thu, 24 Jan 2013 11:23:50 +0100
Message-ID: <20130124102350.GB12933@pengutronix.de>
References: <1359017242-13837-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1359017242-13837-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anmar Oueja <anmar.oueja-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2013 at 09:47:22AM +0100, Linus Walleij wrote:
> From: Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>=20
> Amend the I2C nomadik pin controller to optionally take a pin control
> handle and set the state of the pins to:
>=20
> - "default" on boot, resume and before performing an i2c transfer
> - "idle" after initial default, after resume default, and after each
>    i2c xfer
> - "sleep" on suspend()
>=20
> This should make it possible to optimize energy usage for the pins
> both for the suspend/resume cycle, and for runtime cases inbetween
> I2C transfers.
>=20
> Signed-off-by: Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

You forgot one else-branch :(

Do you run checkpatch before sending? '--strict' might be worth
considering then.

Fixed and applied to -next, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlEBC7YACgkQD27XaX1/VRv9mwCfZUv6jptkh6WvUsCro2jgSRv5
G1MAnjyavWgrrDwjOPLZVR6DSN7/1qMF
=jjMm
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
