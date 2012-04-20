From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-eg20t: add helper function for xfer check
Date: Fri, 20 Apr 2012 22:39:37 +0200
Message-ID: <20120420203937.GB12691@pengutronix.de>
References: <1334817485-7121-1-git-send-email-tomoya.rohm@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1334817485-7121-1-git-send-email-tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 03:38:04PM +0900, Tomoya MORINAGA wrote:
> Currently, there are the same code for xfer complete check processing.
> So, I add helper function pch_i2c_wait_for_check_xfer.
>=20
> Reported-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Both applied to next, thanks for doing this! ~120 lines saved, that's
about 10%. And also way better maintainable, yay.

My checkers found some other issues, for which I will send patches in a
minute. Please have a look and test.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+RyYkACgkQD27XaX1/VRvUvQCfSsmJo6aAYZChOsH+2rGKJl8z
Fz4AnRYC09uIa8jG7LPYyxapi6DUTc/q
=hBsq
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
