From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv2] i2c: i2c-tiny-usb: fix buffer not being DMA capable
Date: Mon, 22 May 2017 10:35:25 +0200
Message-ID: <20170522083525.ubm2cxj3oueefljl@ninjato>
References: <20170505090650.28412-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u45bwgube7ik2vm4"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170505090650.28412-1-sebastian.reichel@collabora.co.uk>
Sender: stable-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Till Harbaum <till@harbaum.org>, Greg KH <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--u45bwgube7ik2vm4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 11:06:50AM +0200, Sebastian Reichel wrote:
> Since v4.9 i2c-tiny-usb generates the below call trace
> and longer works, since it can't communicate with the
> USB device. The reason is, that since v4.9 the USB
> stack checks, that the buffer it should transfer is DMA
> capable. This was a requirement since v2.2 days, but it
> usually worked nevertheless.
>=20

Applied to for-current, thanks!


--u45bwgube7ik2vm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkioskACgkQFA3kzBSg
KbZi4RAAseKhrVqJGsfe8FCnHf7KSBy7sV5Vj+hFWt6cYg/8SDmSf4Kb/BgdYxsA
TfeluOZL3gnvxYM8XRlnTBrE+IdYoLq76oX+7wYPfSRPAYXVOO1XbZ6AGkTQyzBI
wnx/cPJk7creBINjtHYg5Q/0Jvzmt12F3GI8XmBuAXUQyf3brSGayT9TbQ7hVbih
dDq0KPT2JMXYXtyDv8yzFdLjmSwDXHTl2YnqYK6kM3QMNgVLAMuZEZNQNMTtiUez
uBghv7ZhYVGlbKtlb25i+Zn3lhf066RuAe+ummof0lnm5w99zwi0LNXspFNwDgSr
mBOXFiJEM2ftmwmBBLIDBVN4ExDl87E1LiI0eTJqFVstva4QpxkPzpSukPuizfSF
QK0p5XRbloV/XkJ5fbr0lD+/1VgOzTvxZ1g9G+LIUgJB9t+qtwtLpGtFIwHoKIAh
EQqyLmGCZTKF9S14JH/zSbzuuO9yNCwtquLJmNGlQzFnvu+RceYuyPEMR7HwfLch
Vez8ATy0RkuE1mytdZ7oJICXGcBOJjutRiulEnJEdVAXvUi/KFizakTsgfh8cjvc
W84XwHCZUQtcfJGoUXMX4jALozFcuje++IX7k0f6WI30y3pTZmG2/V7XmbH6xCBi
0IHjSZv91wb51lFAu4K13exrPPJr2/x1SDL6xFk2pU0NLtIo4oY=
=+cYa
-----END PGP SIGNATURE-----

--u45bwgube7ik2vm4--
