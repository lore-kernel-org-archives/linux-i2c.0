From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/6] i2c: sort includes for the core
Date: Wed, 24 Feb 2016 11:27:33 +0100
Message-ID: <20160224102732.GF1391@katana>
References: <1456007931-4595-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46349 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032AbcBXK1f (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 24 Feb 2016 05:27:35 -0500
Received: from p4fe25c03.dip0.t-ipconnect.de ([79.226.92.3]:57166 helo=katana)
	by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <wsa@the-dreams.de>)
	id 1aYWfO-0000po-Hk
	for linux-i2c@vger.kernel.org; Wed, 24 Feb 2016 11:27:34 +0100
Content-Disposition: inline
In-Reply-To: <1456007931-4595-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 20, 2016 at 11:38:45PM +0100, Wolfram Sang wrote:
> If drivers must do it, the core should do it as well: keep the includes s=
orted
> to make it hard to duplicate entries :)
>=20
> Plain sorting, nothing has been added or removed.
>=20
>=20
> Wolfram Sang (6):
>   i2c: i2c-boardinfo: sort includes
>   i2c: i2c-core: sort includes
>   i2c: i2c-dev: sort includes
>   i2c: i2c-mux: sort includes
>   i2c: i2c-smbus: sort includes
>   i2c: i2c-stub: sort includes
>=20

Applied to for-next, thanks!


--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWzYWUAAoJEBQN5MwUoCm2o9IP/R61F4h7d/BBPa8p40IiVpOE
4Jew9r2yThGAKph8PovWT3/KC2M2K1JZxr9gBgf4nKWYQpSXlC9W0lTTtG4Nq0zO
M6hnP1H9d5RdytCQ0t8VkYQf3v0XtMW6dP96JvLgXN6UKZkx57NGL8Cffa+VqkS0
v2uoK4xiytlY0u1jocVcauo/RrR2Pa6KAzTHLXr0e5pkLIM4XGG7abhpFI9wTXHu
SLQKQMdnVBVdC74eC+vrghwT7jS8l6cMeNiw78+tNatvmdq9vtoFZY5ZB9/G0aPJ
evBKK5Y7Vjgs6MyTzrsf7RbtSba/CdEpdvooyurA1OzVQo82EwxwPyDK8GWvMTFS
ccFUOfbDRQgofq30i9Bof3N9mURzFOoJDAlX+LTXlnXgFav0jwC5/uSL5atJDWoq
SApszLWhukFOcIEQqcEpp9g/VjD/k8OBWSKK7ifzUTi8FdO9sF4tQIanvdq+3AHZ
9xJn3g8Qr6e3mzE6P+GFtZg60HWkj+IIAcBTdNgxm552FQmPRGmx1jvbmlIE2gdx
Z5KG/aFczTwbi2f33qqMIYIIsUFdt6Z+3IFX5cVHzqvq3T6ieR19YM+Xo5uWo3yd
UKtBLk2H+ULnYeidaGjWfjNWS+yxurkcwGlzE8ACC1+O5HONMcHwV5DPSXkdxKBB
W3oRFIRfvaXmlMImzy/4
=dv7s
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
