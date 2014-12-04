From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: Remove support for legacy PM
Date: Thu, 4 Dec 2014 19:11:11 +0100
Message-ID: <20141204181111.GD7944@katana>
References: <1417366352-22356-1-git-send-email-lars@metafoo.de>
 <1417366352-22356-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417366352-22356-2-git-send-email-lars@metafoo.de>
Sender: linux-doc-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2014 at 05:52:32PM +0100, Lars-Peter Clausen wrote:
> There haven't been any I2C driver that use the legacy suspend/resume
> callbacks for a while now and new drivers are supposed to use PM ops. So
> remove support for legacy suspend/resume for I2C drivers.
>=20
> Since there aren't any special bus specific things to do during
> suspend/resume and since the PM core will automatically fallback directly=
 to
> using the device's PM ops if no bus PM ops are specified there is no need=
 to
> have any I2C bus PM ops.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

I'll keep this for 3.20, 3.19 is too close now. But thanks, the diffstat
looks great :) Just curious, has buildbot tested this already?


--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgKO/AAoJEBQN5MwUoCm2g/QP+gMlQIh1Xr2529d5c4BCAqyS
26YU4lTNwDE5g6e99XA7sVc1j6+OkR/Z0vsJN5wFXjVyFp0f/SZgGyC288sMB3xj
DPqd0RzAYJ9uyh+aV9y1maoENHAgVs+VzT2soo0oISNrnO+L0eDADp2/RrptA02d
xz4eQQM7k/SP9Xpyv/gwUb5zQSo7XGRU8t197k6k2tFY8//gkmoDGnwNHajYtAgZ
uUxJIHCICCJ634LULmxvvsbRoO1wW0qzfFsLDeo/vN1iiCbQmej8DmaBM5IvSOQK
at+LAISZHExLOpBA1BdyNDH7cMXWePWDpSQEaXlB7XLBcd9fFK6BBczEppcoPZSr
57Pk/YGtOwAPmvjb85RFgE4XGmLGMDIjH74H+8cAgIEo0zkxZ3Q8UIn/zXbHFBSq
Kpjs9Ziw+SFc4B00kZ0v5d8OZjABj8zisdnD6T2RHY2avpgyelM20xCfHN2/OgEo
NUJeUIM/nXQf22ZQzFnMUG7wSLPL0rYsrKxNo+nDORvyVzYW2aqOGTTmIWAVI36s
iShzvfnn47A8xHeBUUNkHJ6mxak+f/QY4718x0sUiy0oMAqjoWC3HliDQE7Rsxy4
gjP4CYy2R5lZgL4+s/0uffwjiKjR8k67BhasRECSjJwUpKUHp11SXhw640BEU05L
fQFO5tqst9YS5kMvLZj5
=r71W
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
