From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: stu300: use devm managed resources
Date: Mon, 16 Jul 2012 12:03:36 +0200
Message-ID: <20120716100336.GA17435@pengutronix.de>
References: <1342300993-23843-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1342300993-23843-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 14, 2012 at 11:23:13PM +0200, Linus Walleij wrote:
> Allocate memory for device state using devm_kzalloc(), get the
> clock using devm_clk_get(), get the IRQ using devm_request_irq(),
> request and remap memory using devm_request_and_ioremap().
> All to simplify accounting and letting the kernel do the
> garbage-collection.
>=20
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> ChangeLog v2->v3:
> - Also delete the cached physical base and size from the state
>   holder struct.
> ChangeLog v1->v2:
> - Use more devm* stuff, at Wolfram's request.
> - Note: based on a clean v3.5-rc6, may need some patch -p1 < patch
>   to apply on the i2c tree, if you want me to rebase it, just tell
>   me where to find the baseline.

I can't apply this on top of your clk_prepare/unprepare patch. I tried
to fix it but was unsure how to handle the clk_unprepare in the error
path of probe. Could you fix it? (BTW as mentioned before, my next
branch is here: git://git.pengutronix.de/git/wsa/linux.git
i2c-embedded/for-next)

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAD5vgACgkQD27XaX1/VRtH3QCgsuLpiKFZUT7T8tM8aVZ5663Y
1HEAn32AKlF8SuyZNP0//uZNTjDiWSHn
=qTL6
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
