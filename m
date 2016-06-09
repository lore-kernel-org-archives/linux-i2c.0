From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i801: Drop needless bit-wise OR
Date: Thu, 9 Jun 2016 22:28:43 +0200
Message-ID: <20160609202843.GI23522@katana>
References: <20160525093702.64d7309c@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cf0hFtnykp6aONGL"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34925 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbcFIU2t (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 16:28:49 -0400
Content-Disposition: inline
In-Reply-To: <20160525093702.64d7309c@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Daniel Kurtz <djkurtz@chromium.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--cf0hFtnykp6aONGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 25, 2016 at 09:37:02AM +0200, Jean Delvare wrote:
> The interrupt handling code makes it look like several status values
> may be merged together before being processed, while this will never
> happen. Change from bit-wise OR to simple assignment to make it more
> obvious and avoid misunderstanding.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Daniel Kurtz <djkurtz@chromium.org>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--cf0hFtnykp6aONGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWdF7AAoJEBQN5MwUoCm2MXcP/2Cgf+wbQUcdsAU6tSVqIDHh
nfhez0SUYRr2CO/9VYtxr/C37/x2nISJsjVdxiaS1WJoVPjdq8h0w18WAuVY+q+y
BdNV4TyKogM/JBeC2KR2tGx7FhJhobLF4zZTGxqwjIl4RPD5ESo9OJPsB+5qp4lD
9+Q07sEtDtyMK+db6W2ehXlvJXyRAaDRlkrwhp8+/5pmX4+Urk8oLokz6VE7Xb0O
iCk3mdUg7J7wVbGxExh50d+PYKl2kOv2Nph8B91dMTtYy83ab0w5JbXMOICGk06i
bAR61zNLLNRpy6+4REiWNtx83/efD2VIc1ht3p5clxVWEyuqWWW1A23q+6uRKumJ
x4sezUfTM0bykKg1HBW3GxTrI715N4k4CPTq59pOI2pfX0kOIS4LgDplWFTMR2mQ
M0/x6w3p+KvUA4WBFbClOtfyx+0FSrwzx6OQOOPSLX5zOYQ9w4H9nrQdGYOcLDXt
jnlxtW05zpVTvICBfdU/3BdiKybwiegwd0XedFqQQBwz5b32pGkNyDofFdHQH9pH
zdHS6u9WDwdEeKDxOO8mChJZzW354hFIIAh+79ApAtSSidjTs1nQUtdZ9Tow02+0
JXjUpJ6jS7cCTUHiEGVjs4VC8Mpz7WX6O2Pt6J9AMfDs1ObnIMmSbh4C1KgIWc56
6IMwkB/AdHJP8ZtTGEMr
=AIm4
-----END PGP SIGNATURE-----

--cf0hFtnykp6aONGL--
