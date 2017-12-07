From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/4] i2c: pca-platform: additional improvements
Date: Thu, 7 Dec 2017 11:42:05 +0100
Message-ID: <20171207104205.h5ejivdmtharmdln@ninjato>
References: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
 <20171029172918.2xtz2srh2meq45io@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="thrxabcroshaxx7e"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55574 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbdLGKmH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 7 Dec 2017 05:42:07 -0500
Content-Disposition: inline
In-Reply-To: <20171029172918.2xtz2srh2meq45io@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, Rich Felker <dalias@libc.org>
Cc: ysato@users.sourceforge.jp, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


--thrxabcroshaxx7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2017 at 06:29:18PM +0100, Wolfram Sang wrote:
> On Wed, Jul 05, 2017 at 10:13:54PM +1200, Chris Packham wrote:
> > This series addresses some of the points identified by Andy. The series=
 is
> > based on top of i2c/for-next. 2 of the patches from v1 have already been
> > applied so I've dropped them from this version.
> >=20
> > I have compile tested patch 1/1 but I don't have access to sh hardware
> > to actually test the changes on.
> >=20
> > Chris Packham (4):
> >   sh: sh7785lcr: add GPIO lookup table for i2c controller reset
> >   i2c: pca-platform: unconditionally use devm_gpiod_get_optional
> >   i2c: pca-platform: use device_property_read_u32
> >   i2c: pca-platform: drop gpio from platform data
> >=20
> >  arch/blackfin/mach-bf561/boards/acvilon.c |  1 -
> >  arch/sh/boards/board-sh7785lcr.c          | 11 +++++++++-
> >  drivers/i2c/busses/i2c-pca-platform.c     | 34 +++++++++--------------=
--------
> >  include/linux/i2c-pca-platform.h          |  3 ---
> >  4 files changed, 20 insertions(+), 29 deletions(-)
>=20
> Series looks good to me, too. I'd need ACKs from the SH maintainers,
> though. Technically, from Blackfin maintainers as well. But I haven't
> heard from them in months, so I could go without that.

Adding Rich Felker to CC...


--thrxabcroshaxx7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlopGvkACgkQFA3kzBSg
KbbVxRAAmNqOVKWSEiAx/PJ5TkFxRgrdBiEcSQLBpqitRpFtWgDJR7EJhUbwt4ux
5UqzjTS/2QJtmO9GlHONO3ZbKZc/vT0gRJakCxsX8y3TsrA2Qg157muiZPc7JCuU
q5CzqwU68l+UDgiYJcT3QkGa61T6NOZJ4bF6QOtvdgTOjikGN1PNyQcspnvE0sUV
D4ash+ufb6PJ/Ensv2gSI9gQrqgizYz6hGTkr/Czh9fsIsJNymX7NQg2KkB5xeNi
Fn0Z22t+WR4UpV3CiWz5vCpZCwzhkcnP4+b9afXkv/a5D5GZfqAMe4j8ZudVRmG1
P/+dvnUeA7SVWd5pUHJIH/alsxMdtvCpq+AznrXZecvvP+IKtkYvz2wzsGcSSfMO
JOkxKzO6WXIl5Z8SCkt8jyQR0NpKpwYvEqt7rx/jUj9KBtpzEKCWYXTHuFKZeZYq
kLva0yraQdEF5KYGSUV92tuq27po62k0o4BRWI4x/NK4acXTo8XMYF8SvBmVh1US
EP8ld4xGo+p9iP2BH6GKw24bEZPNT5aM5/alnQ8s1GLXzoVbcJpfoBdS2R8bZ1pI
78Ghv+Usmm+bV4up+uIaBma6xHyxza3nv2MzUBCgbXkgjupEDgYxM9vXEqZVBFUa
CNfAKoxm2l0cYiOBflV7oKEN2HmIy8a4eMd/9YX++rZcuqOwK/Q=
=TFjj
-----END PGP SIGNATURE-----

--thrxabcroshaxx7e--
