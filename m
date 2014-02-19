From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V3 16/17] i2c: nomadik: Remove busy check for transfers
 at suspend late
Date: Wed, 19 Feb 2014 12:35:50 +0100
Message-ID: <20140219113549.GB4345@katana>
References: <1392650462-14960-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392650462-14960-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2014 at 04:21:02PM +0100, Ulf Hansson wrote:
> We should never be busy performing transfers at suspend late, thus
> there are no reason to check for it.
>=20
> Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>
> Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Adds a warning here:

  CC      drivers/i2c/busses/i2c-nomadik.o
drivers/i2c/busses/i2c-nomadik.c: In function 'nmk_i2c_suspend_late':
drivers/i2c/busses/i2c-nomadik.c:883:22: warning: unused variable 'nmk_i2c'=
 [-Wunused-variable]



--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTBJcVAAoJEBQN5MwUoCm2xZkQALUx2BSS0a7EILW47+gx8tuQ
EBX1i5DExdL75TXFMoGAmtfhgWk8eNMHu0ameuVPGiSypbQSITTZ3m2SRihjne2f
mxy1ngnh1w8or1/jQpQeJNAD8+59pqH2YZDxHmkEW+sk5MCuiWDkPZvj1S03t/Sd
P4jKy0JzCck9mbpO8z5yRfrnA3aEie8eEdecmawhTV7kCEtsATvTHjraLNomHoAc
7eY5HT/KYno1TjxCz6Jd/AlCVvdMdVG/3rXwcrVm2XFuRjZB7Pxdpm3Nz3XxMMBK
ZP2fq3crMHVWozoWletmvB+hGItNw9TZ1DWvWZy3p7ZgiYfbjKxtIg7uTcB4Milj
QFa77MG7e05+IT5zW5X+rZKLvA0cef+j+bpNnLBshUHUg7GqNv42w0Z/XMXamM9e
GHF5/jAmiXNfGHitC0mnuJ6NftJ9PbUpfnpZ4ZpbuLN2XirMU/IixfHO+qcsaIGl
Rd9/F1mMoEo0+20i/80n0VBlMpNvWT6EaflQ7VQ9llBJ4UFpVxac55536VjY8j2u
7DAUVhOZVUUnL8k+q9Qzkh/ZM7kAVkbWDYfveVPWQO1SqQprb+I5A5za1PanWzlo
5pCM9lqEjhBEfPTE/izXPehRHPFueTfx9ktb+mcTlcZOmzce5TOnH7bDUaNOy00A
R4/Ixm2xqPmG2hJxQsHi
=N5BO
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
