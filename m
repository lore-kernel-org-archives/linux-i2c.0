From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: uniphier{-f}: don't print error when adding adapter
 fails
Date: Mon, 15 Aug 2016 00:17:30 +0200
Message-ID: <20160814221730.GB10501@katana>
References: <1470773500-13946-1-git-send-email-wsa-dev@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40070 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752423AbcHNWRg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 14 Aug 2016 18:17:36 -0400
Content-Disposition: inline
In-Reply-To: <1470773500-13946-1-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Guenter Roeck <linux@roeck-us.net>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 09, 2016 at 10:11:40PM +0200, Wolfram Sang wrote:
> The core will do this for us now.
>=20
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>

Applied to for-next, thanks!


--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXsO36AAoJEBQN5MwUoCm2wwgP/iwmihw2IRRNZ2B7o3U/llIV
mEAbb/BgOKBFe0chPEtraVBGiUUUPpGHb+aeRXyaoVfw+Vi5UX8Ia9FCQHAMffi4
axup+Us8PLjpDyxSY2iog/IPYw6VdMGxzMXR4MB/Bss1f9Kjk5dzHPJ3TKflX/A5
BD7NknJ+APv1XlT2jqSBlO1so6vgxaAFjlKew7MZbTrqXshtcPcDIAJ8f9j/LiAz
dkYI12Z3Al0Z0s25LWDFe51WU7Xs6E25/od2l0ZakSn9iYvGdZOZzzDNEXag4EjU
1Il/dmKqI9OQv15jRtu0nkL+NF1Dq8PsRRb2j8ChBqNm2y8uKOCTQ00VFH5tRB5p
0tnxYtJuacsH5+ZBJrhT6TYRnrW/10q/7zXCziqaZ6MFXco92amIi+DnKGAWZHH4
HTafi40hkL3p4aNT6rII5OHI84g7C7qT7kn33Ga9x6EA1Ck/mA4DrBx6JzG4bjyU
v3sL/FHaKNcok5kJrfPoec1NwxSXTw/Cc0Y9F6uwNKdWdQLtJrlZa4wDfDVdHL9H
PdTSmqbC+fiiQWP0f4U2XGqJnyMv+bxmckQfi6QVpw2LHOj5q38HrPd2D20EIgxa
+zS6jJqs//jH0+G1ACCHW7fRHfbbKALC5FoRqbmR6/uflUy3iguXqJ1UA4RBrRH+
28nWkJY0qk+4/vLKqAMQ
=x46h
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
