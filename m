From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: Provide of_match_table to i2c-mux-reg
Date: Thu, 9 Jun 2016 22:39:17 +0200
Message-ID: <20160609203917.GL23522@katana>
References: <20160606135147.GA9810@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQDbd2FCF2Yhw41T"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34997 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbcFIUjX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 16:39:23 -0400
Content-Disposition: inline
In-Reply-To: <20160606135147.GA9810@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lukasz Gemborowski <lukasz.gemborowski@nokia.com>
Cc: peda@axentia.se, linux-i2c@vger.kernel.org, alexander.sverdlin@nokia.com


--yQDbd2FCF2Yhw41T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2016 at 03:51:50PM +0200, Lukasz Gemborowski wrote:
> of_match_table was not filled which prevents device to be
> instantiated from device tree node.
>=20
> Signed-off-by: Lukasz Gemborowski <lukasz.gemborowski@nokia.com>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Applied to for-current, thanks!


--yQDbd2FCF2Yhw41T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWdP1AAoJEBQN5MwUoCm2LLgP/0Cru5Uzog6AM60D4FKGYwjN
s0GNYp/FE4wo3lmbAkR7bmsftp0+ndWPYkec3t8rJgKQkPVWbpID8Gy4JG3LcCJG
X5XpVtfrkT7PW3ZyFcMq+fpgsKmldlg3cuN3/YQu29vY+ZxK/RmzI8FWS7BGhOxP
i5Wu6OCvrOqTKvdy7fimkUu96DbVsx+Qrucqvafht1cmV82lOE9kADHOoxN40J19
jorGpvHgclXSmRMZZgioFdtrbpgR/+TzQBnujAleSzc2JSdvRz/olHNLakKpwsu2
tWoD383emmWAp0DQ3VDe8C2bKbbKkDag2y6r31O8HglsehhLARACyKTFTwrQXMhy
pW/Xx9M9BB88hbkccPsH2G2rvPgp7Luq9yKgz3IXp05z77FYygN1sA6mlSQUoJqW
0MzLFppZ65jk1vmxXA1wGPUTdi23tLpOBQ7L2PBkDyJiQ+6UKz7yldv7Of+KwwRV
yGPOHavgX8d9QUjKNUj+hXIMIf7vuvdpGmilg9ipXAXD9N+UpRM9AuEr3OxnwMm/
p8OifEhk0GaVUSkhT5+euMqomKYQ7HnTpV1tx8g/mOZ7Yymob91gLxvPR6QcouMS
JPAe8eIReHfgF9TGGNdQUZTzgG5zKkoxJ+nO3Uqz9X5MeR3OLu2EzgFkmJWVPLIB
cgtsQmuQt4saikpcrP1f
=vA/5
-----END PGP SIGNATURE-----

--yQDbd2FCF2Yhw41T--
