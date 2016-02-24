From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: riic, sh_mobile, rcar: Use ARCH_RENESAS
Date: Wed, 24 Feb 2016 11:21:06 +0100
Message-ID: <20160224102106.GC1391@katana>
References: <1456103719-10818-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456103719-10818-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2016 at 10:15:19AM +0900, Simon Horman wrote:
> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
>=20
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a mo=
re
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied to for-next, thanks!


--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWzYQSAAoJEBQN5MwUoCm2/ZwP/RhP7usRQjvtQRJqRGaChq3d
mZicFaFBVrVdGFjgjn+CD8nCR/qYhBBl26KFcUc9uqzO0+9zWj7zrxtn3gsyoCdA
zvUAbq1oe04jN2MvepZElUMCCYLcy46UMyo26A11ISzwo2FdAz38t+9dlPnfs/FD
KHrb6P9SosqzHL38LYMFdBgUsxb5IbX7LTYRCfElFSiil/6akeXeY1maTKtrP+tf
vLWmZYQVA9cUZ8Ewd+7Gxbgb8B919w21oSFD5blLAGjZe53VQqA4SOaLxFWIZYF3
kb5vogxII0YvMOhAvUq3G+U50T2EfgAyYiEkZHmOu8YGFUB8/KnvJQjUTcponlF3
oM17iMCAl5GuvDCLTt+0Gy2utGN7IdfBJt/EkGYE/BRStUSzMQ91PNSXgX6SdqWr
bPdMAKGwFmAc0n8qYo7gV1H4vWPPROTkHmEfaMtYv6CuanfqqsNY9z4RDgtXDobK
bIg10/4Itn8UyEhwVmA/4aAxJ4z/2jGCOZ8SXE4gzSEUeMvnudNvdGECgc8EBe9D
swyAQf6+j155QaK+iJxjzhUnTBuAjWUW1+qxKN36JELxE5ebca0lpfnPK1YiCQnC
JUwY05p6EBNIRet31cJZhUGnQrW6ZNK9pvLjRIB33nKFImdyOOQBjlVuKX5tf63s
XXG2ykOP7sqnCi0A4RlZ
=Tb6k
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
