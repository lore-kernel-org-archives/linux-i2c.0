From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/4] i2c: uniphier: add minor sanity checks to
 i2c-uniphier/i2c-uniphier-f
Date: Mon, 14 Dec 2015 11:01:12 +0100
Message-ID: <20151214100112.GE1733@katana>
References: <1448877216-32286-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33940 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbbLNKBQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 14 Dec 2015 05:01:16 -0500
Content-Disposition: inline
In-Reply-To: <1448877216-32286-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 06:53:32PM +0900, Masahiro Yamada wrote:
>=20
>=20
>=20
> Masahiro Yamada (4):
>   i2c: uniphier: error out if clock rate is zero
>   i2c: uniphier: error out if bus speed is zero
>   i2c: uniphier_f: error out if clock rate is zero
>   i2c: uniphier_f: error out if bus speed is zero

Applied to for-next, thanks!


--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWbpNoAAoJEBQN5MwUoCm27CMP/37aJNFSHflkFB8bS3JprPjy
w9+d+RanZouZatUrf1Om7K30vsf4vKzIrfBwFhJ0fz0U6VfIsL8lVKKIAzuZ0NZo
QqrYNc/ZfF+sXbXs0nuMeGtM/9kkQzEmua2u1aqrdpLDGTBou7DTUQBx0UCVpHsq
PE8PiMzOQZD+jH3JMM1KSJ/4OfLHdLh6niUiBR6sN30wVhprbTahPYDTYajLVxQj
7JM2Kaf576TqJ6Rhsyab5+h98lR5aFf5gGwVDd0qycWFkyDGBBICbRw8lXr1HkVM
ene6UDamPWNR6ZRPdPd9UF8J3nklYXZRvrDECaMC71LqZwVhvpJTr1XTwpIRvMFv
7Wxsl6fKFjA55t/4D+Rh7nX3dIJ7NyLJwWLVuCpS+gnV2coFjLljUsRSHy4TB27D
+ltyjWbLOQj0E7czAWPh4B/9sUgVBwLqfMIBTxdnCy5cv8zJxb+h03JMx/aISRLf
f6dBuEFH7c8g9zLZZfn9/qVger9+J9Z5CzLmU5xzBHoFFIuAP3+5ybC+DrvEYCxG
elnM9Zxp5SB3stgasjHEqbyisQslRoZBr/UKg7RY4nw+fUuNW76knbLBu8lMwbG8
/5lovaQl+XGu+lh64Sexc0JIfpwLSuQ44JJGHosqErciZivX9X6IUOAB6+6e282Z
0C3PBRhYtqErk+lIqT91
=eMxp
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--
