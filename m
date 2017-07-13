From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] i2c: move include files out of include/linux/i2c
Date: Thu, 13 Jul 2017 11:46:10 +0200
Message-ID: <20170713094610.noqty3z6sty6mfj5@ninjato>
References: <20170521203743.6514-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="juelcupbh4j3m3xb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48122 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbdGMJqO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 13 Jul 2017 05:46:14 -0400
Content-Disposition: inline
In-Reply-To: <20170521203743.6514-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


--juelcupbh4j3m3xb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi peda,

On Sun, May 21, 2017 at 10:37:41PM +0200, Wolfram Sang wrote:
> It doesn't make sense to use include/linux/i2c for client drivers which m=
ay in
> fact rather be hwmon or input or whatever devices. As a result, I want to
> deprecate include/linux/i2c for good. This series moves the include files=
 to a
> better location, largely include/platform_data because that is what most =
of the
> moved include files contain. Note that some files don't seem to have upst=
ream
> users in board code, so they maybe could even be removed? I didn't check =
for
> that now, but I did it for one i2c master driver recently. So, it may be
> possible.
>=20
> And while i2c muxes might be a corner case, I still want to deprecate
> include/linux/i2c for good ;)
>=20
> No runtime testing because of no HW, but buildbot is happy with this seri=
es at
> least. A branch can be found here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/platform_=
data

Since there were no other i2c-mux patches this merge window and thus no
pull request, do you mind if I pick these two patches for my second pull
request this merge window to have them included in 4.13 already?

Regards,

   Wolfram


--juelcupbh4j3m3xb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllnQV4ACgkQFA3kzBSg
KbbFHw//fJnTITtucNYygzlfdKCczpPsH8w6W8gqCT3vnBIdvjTGQBBAenlSlmPh
TaTp29p1ZImBCaE8HJzG2i1ivwUL6XFvNdv9DVrLtyZMh2fVS0OQ6z1y0DrJDUs/
etS3+H7PMSglSLUbjMIWmTIbPOUdV7YYx2P+6TKLv6+1ycdMzEczZl4zwr2ZDw4X
o6YaIl1eS19SOghLS8wbPau1A8JUWPVZaJ+YxU3goeyyyAjlNrTOmurlu5cvVQtW
XVAPewpeLboFOXMTJd1/4v89AWm4JugScJCRQWr2oOm5V/3Wy+rO5IwgHpaccyCs
UcDiC6Zdwxfr8ZPvTr4HNgArZihfV5TD/8NJ/RKIskfAcN2QMElg6ttxwMJWUNif
7JC1Bi7g5HY42BrJQllQ9X7P70MW5JCTeQfq5zJBbhw6WckAXcf9JvzgM9K/zJ5N
QoFR88y12fZeZYc/vUQ6DBT7LFDjRTNZsisajbWuT9yo3a+tEVjT3Q4iVaZLimzm
jJxZtNjqJhm2h8DqGCIW+vT979vpqrpOr7j22hL5zPeVsatWaOaGDkHSZp+a1i5j
ctSgjuNUsHqIvQwzi5GMYWx0m3xZJfll01kYnAv4MCop2hPSLm7q2qMuhk4pEUHN
0jXGplPMQs1KNbPwgeqzTtYy136FaFOoIMw6YO8Vyv2RJjqPC0U=
=tOI8
-----END PGP SIGNATURE-----

--juelcupbh4j3m3xb--
