From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: gpio: add fault injector
Date: Tue, 2 Jan 2018 23:34:04 +0100
Message-ID: <20180102223404.llvuybdtceoln4ks@ninjato>
References: <20170825153918.7544-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f7wrtpgyryjzf6yk"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43833 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750865AbeABWeF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 2 Jan 2018 17:34:05 -0500
Content-Disposition: inline
In-Reply-To: <20170825153918.7544-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--f7wrtpgyryjzf6yk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2017 at 05:39:18PM +0200, Wolfram Sang wrote:
> Add fault injection capabilities to the i2c-gpio driver. When connected to
> another I2C bus, it can create unusual states which the other I2C bus mas=
ter
> driver needs to handle. Only for debugging!
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

To be more precise:

Applied to for-next after fixing checkpatch warnings about parenthesis
in macros, improper 'inline' usage, and octal values for file
permissions.


--f7wrtpgyryjzf6yk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpMCNsACgkQFA3kzBSg
KbZwRw//fIlb1kJwwqCp85nvCjPQHrzY3AueLs3J99xTeAZkTa40AZqkDenqwhwj
CfZIt0AsVwNfV4RnqefpZNgH+tJHPYFkCgIxTKBlZG3RzSTGaHHQ5nX6xmmNLzGH
jhKqUBCesrdVTmrP/tqTk0cTAP1il/R6MVjGH+zNzKT/2gk8w+P9SlHJdUtSLBDI
r8NSQBH9F0nSKGi3ZNgJCfdGivqqUEMYK27kSrURyBgiZCtkn4XkfjRNot7nKATK
Ye0leBhhXDk2J5wn7bIctKXpAgVM/cErCsymHpQg6+MkuIV9LQIiqdSX39pX9iId
JVMfyUvf0olpHfhpUJ5n54bijK7/u6QEYLS1jYUqwyQKbyqezp1UHPhhro4jFqy+
WDItk0Ew2DdaFeKHn0OFjBIdkHq0maZo9rBLJY89LpmqjRqF4PuwuSHYiXrTjmpN
Y9Xe1awaeaLddWs6moMTW0bWdJCCfY4OHq0ovM/CluaT9D6ZsBpKtfoj2Y/kxnnC
pO/u214gp9zhRkvkBQO1RX0e2JpjY58Jo6p2K0neVr8grDECxvgLKGkHK1X5p55C
Je0I1bOmKnBQdxaxfz4VUWZMhZN5gF1n6j/BwPwrqlhAsDwfATKLIi5tt8uVEcyR
ugkWNmn4DZUZb59oiqxcfjn0aiXVfpJXmXFXlbxLYvaI95L07N0=
=pUgP
-----END PGP SIGNATURE-----

--f7wrtpgyryjzf6yk--
