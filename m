From: Mark Brown <broonie@kernel.org>
Subject: Re: master build: 2 failures 15 warnings (v4.0-5833-g6c373ca89399)
Date: Wed, 15 Apr 2015 19:08:25 +0100
Message-ID: <20150415180824.GT6023@sirena.org.uk>
References: <E1YiR8T-0003Hq-6F@debutante>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4SRyIMIx602av9xB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1YiR8T-0003Hq-6F@debutante>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: kernel-build-reports@lists.linaro.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--4SRyIMIx602av9xB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2015 at 06:30:01PM +0100, Build bot for Mark Brown wrote:

For the past couple of days -next has been failing to build on both arm
and arm64 with:

> 	arm64-allmodconfig
> ../drivers/i2c/busses/i2c-jz4780.c:181:2: error: implicit declaration of =
function 'readw' [-Werror=3Dimplicit-function-declaration]
> ../drivers/i2c/busses/i2c-jz4780.c:187:2: error: implicit declaration of =
function 'writew' [-Werror=3Dimplicit-function-declaration]
>=20
> 	arm-allmodconfig
> ../drivers/i2c/busses/i2c-jz4780.c:181:2: error: implicit declaration of =
function 'readw' [-Werror=3Dimplicit-function-declaration]
> ../drivers/i2c/busses/i2c-jz4780.c:187:2: error: implicit declaration of =
function 'writew' [-Werror=3Dimplicit-function-declaration]

due to relying on an implicit inclusion of asm/io.h.  This now also
affects Linus' tree.  I've sent a patch.

--4SRyIMIx602av9xB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVLqkYAAoJECTWi3JdVIfQ9tEH/jDf/B/WEdkjg3RnDquFf30Q
FXtZT3x07/VbgC0r4QYaoYoJdPXDA6kwWAu9nKiBwo+RT4uVzfeS2fmjrNSQ96uc
XYS8Be/xsB1GcF0/UuZiNQoDVHILGpn+VcGCyqnjfNUsP+64DV7LHGIDiuGwr//D
Ou/pffkZHrbk1NFUIyqq2SZy6u/7JqDuPXpVICWulcZc40qyoyqBul1rcHLOOgsh
ogZ2cY3nV8LWlAEpxKskIJ0+rqDgh0Vf/Lts+MUr+shHdh24cKVAYRGNjWUi8RIj
oLQHgtb5/6BO2CI1+0McoNvQL1KvpA2LoFPti0wWSzFm5xCkTf5P/UP58r1GGoY=
=FK+B
-----END PGP SIGNATURE-----

--4SRyIMIx602av9xB--
