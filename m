From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mv64xxx: really allow I2C offloading
Date: Thu, 22 Oct 2015 14:49:05 +0200
Message-ID: <20151022124905.GC1517@katana>
References: <1445351544-26062-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58416 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755592AbbJVMtK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 22 Oct 2015 08:49:10 -0400
Content-Disposition: inline
In-Reply-To: <1445351544-26062-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, Hezi <hezi@marvell.com>, stable@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2015 at 04:32:24PM +0200, Thomas Petazzoni wrote:
> From: Hezi <hezi@marvell.com>
>=20
> Commit 00d8689b85a7 ("i2c: mv64xxx: rework offload support to fix
> several problems") completely reworked the offload support, but
> stupidly left a debugging-related "return false" at the beginning of
> the mv64xxx_i2c_can_offload() function. This has the unfortunate
> consequence that offloading is in fact never used, which wasn't really
> the intention.
>=20
> This commit fixes that problem by removing the stupid "return false".
>=20
> Fixes: 00d8689b85a7 ("i2c: mv64xxx: rework offload support to fix several=
 problems")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Hezi <hezi@marvell.com>
> [Thomas: reworked commit log and title.]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to for-current, thanks!


--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKNtBAAoJEBQN5MwUoCm2T6IQAIC9HkavmnKZtFzK/6GB1EJl
FY3ZUORDW5mY8Rndsp2INrEDIN2kXkuqKWnbrnQGNJRXAglwz1JOPJxV6LuWaTuA
xx0YU1X43GPrlpANI27XE2BUAU39EXta0rHrL6ax8xpR8Fl1dpJvk3awL9Duroqi
uZGBQhAB0Z/Guse1tnKaEmRjx2HLWcWQ1OEOTqfaKTtqelE6W0XCpBswIwgvCWTY
ZQeJgF9LqW3hLAPxkgebO+sBtPjZ9rnkNiSO+dMHPDvsdTzWVI47YYbfrn3DE5jY
s39P1jodKXBybjBuqx7mSrHvnarD9UFssC9SOB0XvIqTdS/YiMzhmVBpOI0cDmDQ
JgHRYJGImXstdseeNMVfTEy006eZPoDC2mAz2w/1b3RxWIUGA8xWQirGPfnL68Sy
1Q8WX5PX+7So1Qkr2i1WH67Lq4zwiFwZMlddP0X+x/o2rQuFr9muoK83BcYK9USx
ieEbukV/i3DLnuDKbS7HcM0pD2vMxAEqO0POQtntJ5pU5LyCD5uMPVJxz9dQuaLU
oIQlNZKcCSw/Jj1juCH54mWraBMW9xJDPby0xsJuPB7b87ko/dM3xpjCsWjVUx3Q
ogcOFTKSz28ZuRrTRdOApNo5Buuf/PZJ9ZaGN5gFq7EvKjaFOJBS3+Kmbjkjo/zM
O2wXKjd9MWt64piXKCw6
=z4ps
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
