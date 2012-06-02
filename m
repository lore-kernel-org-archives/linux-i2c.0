From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V4] i2c: Add generic I2C multiplexer using pinctrl API
Date: Sat, 2 Jun 2012 11:24:09 +0200
Message-ID: <20120602092409.GA13673@pengutronix.de>
References: <1337354974-22307-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1337354974-22307-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2012 at 09:29:34AM -0600, Stephen Warren wrote:
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
> Acked-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> ---
> Wolfram, when you apply this for 3.6, could you please put just this
> patch into a stable topic branch - that way, I can merge this into a
> Tegra branch too so that I can use the new driver in 3.6.

Thanks, looks good to me. I think I'll wait for rc1 and try to convince
Linus to apply the new driver rule, so we can have it in 3.5 already.

Regards,

  Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/J27kACgkQD27XaX1/VRvqPgCgp8CdnuQ0flYh5sZK9kc0J5v3
s3cAnAiPOA6HEjzxVukw8Xu8tY9xDhEo
=t5NK
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
