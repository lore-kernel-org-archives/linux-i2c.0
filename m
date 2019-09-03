From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RESEND 0/3] hwmon: convert remaining drivers to
 i2c_new_dummy_device()
Date: Tue, 3 Sep 2019 20:37:15 +0200
Message-ID: <20190903183715.GO2171@ninjato>
References: <20190903181256.13450-1-wsa+renesas@sang-engineering.com>
 <20190903183340.GA29077@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p/1JFEOz/hVXxMAZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903183340.GA29077@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--p/1JFEOz/hVXxMAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2019 at 11:33:40AM -0700, Guenter Roeck wrote:
> On Tue, Sep 03, 2019 at 08:12:53PM +0200, Wolfram Sang wrote:
> > This series is part of a tree-wide movement to replace the I2C API call
> > 'i2c_new_dummy' which returns NULL with its new counterpart returning an
> > ERRPTR.
> >=20
> > This series fixes the remaining hwmon drivers which could not be
> > converted by my cocci script. So, I did it manually, yet all drivers
> > still follow the same pattern. Build tested by me and by buildbot. No
> > tests on HW have been performed, so testing is appreciated.
> >=20
> I still have the previous version (with RFT) in my queue.
> Question is what to do with it; I have not seen any test feedback.
> I tend to just apply the series and wait for fallout.
> Any objections ?

For the sake of the API conversion, I would appreciate this much. Of
course, I'll be there if there is fallout. Thanks!


--p/1JFEOz/hVXxMAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1ustcACgkQFA3kzBSg
Kba4HQ//ZbhI88LI65pmEOzqI17Im3yRIvfUmrJ1xXcJ6aFLcOWRSKEMY+gcdUCe
OOQZNWypCj5qGnF/gvbPo5ibEJXNVBJLG6SAaAUyLv59fDbMCEnCZM9Sna2iuTvs
hJDmWHqFGT6s9biAKdYaG3TGMIWUdWTg7yJsv0kAdEHYsYkPqdGfeNQIYuebeY/5
uE4EQc7bBz+yWxDwr2D1VNjTYKY3zRLYCgjquHXe4cY5+vGa1sELS7lTqA07l00L
87lVvDW3aVzFmPaPhp8JNDgFXq83inCc9ATpll21omgVspXH++M3s/3Vqr6vq2eJ
HJd7Tp3ifxlPs+L9RoZOmhg1Mv8ZNSVkOb7KXv4jbBdlIeUE+nFdW6VC9oX7ACPZ
MrNDVaKqwTdubAxOFvzLrB3UswT6EL5lDqoeNCbdbEqwN7gUdkp/6LpWvmTuVPHg
tcxMBALOnLGopvtsRqTY+qinXzNEon45xUnYenfzRossTyAiAr4hXnbz+kEM6dfa
BkXyODLEC7EAUst4d+EclC05mU0N1opZJ0fDNzQuwbEYLGxTb3NmaAA5OxSQycA/
GWKdgg3OjcdbPy6siMhlEhoTec84TqfOaP1zs4hn8L6/u4NoaF0VNcKjj1EcgK1f
MXYJfXNm5wQ/JOaVFKivfXzVr+vPql2KWD6eNXhLlc8GHJoBEwM=
=sBPl
-----END PGP SIGNATURE-----

--p/1JFEOz/hVXxMAZ--
