From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: sirf: tune the divider to make i2c bus freq more
 accurate
Date: Fri, 23 Oct 2015 22:30:52 +0200
Message-ID: <20151023203052.GI1520@katana>
References: <1441794632-4074-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WR+jf/RUebEcofwt"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36802 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbbJWUaz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 16:30:55 -0400
Content-Disposition: inline
In-Reply-To: <1441794632-4074-1-git-send-email-21cnbao@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-i2c@vger.kernel.org, workgroup.linux@csr.com, Guoying Zhang <Guoying.Zhang@csr.com>, Barry Song <Baohua.Song@csr.com>


--WR+jf/RUebEcofwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2015 at 10:30:32AM +0000, Barry Song wrote:
> From: Guoying Zhang <Guoying.Zhang@csr.com>
>=20
> In prima2 and atlas7, due to some hardware design issue. we
> need to adjust the divider ratio a little according to i2c
> bus frequency ranges.
> Since i2c is open drain interface that allows the slave to
> stall the transaction by holding the SCL line at '0', the RTL
> implementation is waiting for SCL feedback from the pin after
> setting it to High-Z ('1'). This wait adds to the high-time
> interval counter few cycles of the input synchronization
> (depending on the SCL_FILTER_REG field), and also the time it
> takes for the board pull-up resistor to rise the SCL line.
> For slow SCL settings these additions are negligible, but they
> start to affect the speed when clock is set to faster frequencies.
> This patch is based on the actual tests, and it makes SCL more
> accurate.
>=20
> Signed-off-by: Guoying Zhang <Guoying.Zhang@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Applied to for-next, thanks!


--WR+jf/RUebEcofwt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKpj7AAoJEBQN5MwUoCm2CCIQAJCwevqUxCn2KCyy9MNh3zSQ
4jHgJVd2DWaQQiUKcgXVcNqUQCgUhCpPKbq1i40uDFqsHID2x4ee/GqGBe92t8zA
hG0N+QU7U6LpPRdt69PbWf0es8i3WavbF7Y7w7BB9/Zw9s3h/7kdhUjIH6F93BrI
E8YprCum6m79e8f1IsmsrEIBvxGb4FSoZfYrkvRQ6uUre3uuDvQv5ucA/F2tA3GO
dPTmIG/bELVSeRJ9IlsC4bEU1sP2fURV13ENGr+faOy2AJ/2q+jkL0aUrGoylbpH
8OXQMj1jI2oosperdR2onCORzFtLCZJAJJ5XmpfLJs89oy2MM7bg+u93kpvHGvSY
xvRdS1Nt4Np62EjQNBn2AkR+sEWM0DFkunBcCkFAZnEXYFgrGfqqwN6l0ZjeuyFu
473iR69/0UcNBtCE02pnLZ3HiMxjcBlPS4+rjC3Z2+7te3Njvaikj0RcdjUbz0L6
0kFcJWj6/q9N89zudal6/N3MMqVsQ29S4Vbc4h2N2yuoSqlYa9XoSi8k/cSZZJDG
EnvD9v7ZlkmhyXV2SdDv0EL53YftvfCO6GhtYPzPCTus4HFFf9ig37zEva97Y/TZ
JzLjRAxkPxN57eS7Tk9NumqUyCfrx9i+IhvoRIunAt8xh4rV0rr36uvjhT2+D2pb
DgDsUZbrRrRX32y9Yv9Z
=PwbR
-----END PGP SIGNATURE-----

--WR+jf/RUebEcofwt--
