From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V3] i2c: Add generic I2C multiplexer using pinctrl API
Date: Thu, 3 May 2012 14:24:17 +0200
Message-ID: <20120503122417.GH9574@pengutronix.de>
References: <1335893011-24231-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rCwQ2Y43eQY6RBgR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1335893011-24231-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 01, 2012 at 11:23:31AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> This is useful for SoCs whose I2C module's signals can be routed to
> different sets of pins at run-time, using the pinctrl API.
>=20
>                                  +-----+  +-----+
>                                  | dev |  | dev |
>     +------------------------+   +-----+  +-----+
>     | SoC                    |      |        |
>     |                   /----|------+--------+
>     |   +---+   +------+     | child bus A, on first set of pins
>     |   |I2C|---|Pinmux|     |
>     |   +---+   +------+     | child bus B, on second set of pins
>     |                   \----|------+--------+--------+
>     |                        |      |        |        |
>     +------------------------+  +-----+  +-----+  +-----+
>                                 | dev |  | dev |  | dev |
>                                 +-----+  +-----+  +-----+
>=20
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> v3: Renamed pinctrl-i2cmux.c to i2c-mux-pinctrl.c to match recent changes
>     to other I2C mux files.

Thanks for doing the rename already. While I think I could follow your
argument regarding the compatible-binding, I'd still like to have an ack
=66rom one of the device tree maintainers. The bindings are non-trivial
and I am missing the insight to judge them.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rCwQ2Y43eQY6RBgR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+iePEACgkQD27XaX1/VRsAnACggpomVUolsSLM78Htvfr0GK8N
1ncAmgMdj0GCjXoGIoaiUmGMdz5BCRfX
=7eDD
-----END PGP SIGNATURE-----

--rCwQ2Y43eQY6RBgR--
