From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: riic: remove clock and frequency restrictions
Date: Thu, 26 Oct 2017 22:36:22 +0200
Message-ID: <20171026203622.hyala2lxsjpdshnh@ninjato>
References: <20171018140459.104351-1-chris.brandt@renesas.com>
 <20171018163725.ik6ieofpd6ehilbo@ninjato>
 <SG2PR06MB1165C76C6B35511B21CC70668A4D0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v7t3jkswcpvpypwj"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59734 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751228AbdJZUgZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Oct 2017 16:36:25 -0400
Content-Disposition: inline
In-Reply-To: <SG2PR06MB1165C76C6B35511B21CC70668A4D0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>


--v7t3jkswcpvpypwj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I ran checkpatch and fixed everything it found, but it didn't flag that o=
ne.
>=20
>=20
> $ scripts/checkpatch.pl z_patches/riic/S4V1/*
> total: 0 errors, 0 warnings, 169 lines checked

with "--strict" it will find it.


--v7t3jkswcpvpypwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnyR0YACgkQFA3kzBSg
KbY8/g//WDk2MzHV+LkVlr0Sk7wnw5k/9tXRczkGEwqCECLN3b1olxk5GYN48V72
fjti7x9B4Fq2x7yYNPfA/7QCj1qyVHuWqE7Hgov2nFYwUsHGP10smotjH5MA90+3
/ROdCUu5rk3v0YRRBByJPVzxGzNNxhNvJqGD4xAefwmk3y2nMdkJg3XxN3ncfqPy
Wyy8YEI7yJpUbmWrvY9XFq14SI8jdkmOMRyrzgWjzWzFYR6WJlP/7LJPWEifzSCC
4OwPUeh1kco5ePVsFoeve9EoUYahOYJ/uPyeTuAdIXmsdbqLNNMBdiLLqL75zK+P
APbmtHGSwHqA+gkWlhoFoFJoHepjlbbhZo/+MYsYSoXADdshaSbsjE9O3LuFejyP
pCjahaRkjfNopn3HVyCJMUcUSLJw2vB5vReG041PBh/nT7peeOmAg4QR3SDpxbma
piGJj+B39/9kfFhGgSElKul9fge04bCl00QSGpXOEfmqSmXC8pV1WzaXjF+s8yFD
h7CSxNLXHhGBf90ounrBmV/IQ60yDMu7jQj6XHkG4Go/rg56YWKKKjmWnTpydbi8
tlAVoliiuSbnOhU+zKIQ2JiDWqSoanitG7BYXdDKxps3IIOpWa9QZaWDIdNGAYNO
Iz/ms9tK0ILsP32FsN8fESEjal/NgPEiWWLr6QG9IhMw0SKaFvc=
=qUBN
-----END PGP SIGNATURE-----

--v7t3jkswcpvpypwj--
