From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-mxs: fix compile warning in mxs_i2c_xfer()
Date: Thu, 24 Nov 2011 09:00:04 +0100
Message-ID: <20111124080004.GD8439@pengutronix.de>
References: <1322121140-5216-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1322121140-5216-1-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2011 at 03:52:20PM +0800, Shawn Guo wrote:
>   CC      drivers/i2c/busses/i2c-mxs.o
> drivers/i2c/busses/i2c-mxs.c: In function =E2=80=98mxs_i2c_xfer=E2=80=99:
> drivers/i2c/busses/i2c-mxs.c:196:6: warning: =E2=80=98data=E2=80=99 may b=
e used uninitialized in this function
>=20
> Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Which compiler? What flags? I don't see that here.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7N+YQACgkQD27XaX1/VRtL2gCfUxz/cRDKiNGdYG0iACRGdhLz
sscAn3EYHQnjFY+XKb4XkXv9PkapMAHz
=JWLT
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
