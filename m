From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: create builtin_i2c_driver to avoid registration
 boilerplate
Date: Wed, 13 Jan 2016 11:06:42 +0100
Message-ID: <20160113100642.GB1540@katana>
References: <1450038799-27995-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450038799-27995-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 13, 2015 at 03:33:19PM -0500, Paul Gortmaker wrote:
> In commit f309d4443130bf814e991f836e919dca22df37ae ("platform_device:
> better support builtin boilerplate avoidance") we introduced the
> builtin_driver macro.
>=20
> Here we use that support and extend it to I2C driver registration,
> so where a driver is clearly non-modular and builtin-only, we can
> register it in a similar fashion.  And existing code that is clearly
> non-modular can be updated with the simple mapping of
>=20
>      module_i2c_driver(...)  ---> builtin_i2c_driver(...)
>=20
> We've essentially cloned the former to make the latter, and taken
> out the remove/module_exit parts since those never get used in a
> non-modular build of the code.
>=20
> A similar thing was done in commit b4eb6cdbbd13698704863f680c643c569909e1=
c2
> ("PCI: Add builtin_pci_driver() to avoid registration boilerplate").
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied to for-next (i.e. v4.5), thanks!


--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWliGxAAoJEBQN5MwUoCm2vyoP/3RVGltW4OnQ7b0R2esgyrKe
2nXXk0wTAH0Nr6hWplbMrWqe2MbAkRmnGdtupBjeIuBAm8NSA4/MKBfz7UIR2OUW
lMKd/ZK/PfDKDgi6IwD9w+jGmp4zOh7kNXZW6JCcdnPNY1zla0HNH4c7uqDhUbgS
UoQ2XIral7UrXajrSN09fWYNAq+v+jN2OZ24rRUHkXVCj8HXgs8QkOaLFDzaKQbO
So6fHGCUEtiU8idr/7tvHYuQFZz0yQJgqhDync8E366nQkHpvH6OnDoy6hi0BTI1
b8HnKof32sbr1iFDqVYM6BXw+GQQCUOOpSunGjc/+h+gsp2QkfRMvIdeowZCwXVu
jUmWc44jHhlRy01eQZLZUYZ1unnE0K+s/i691K5ujwoNOhbs3MNlpOm2JR28dAQ5
6jRKO3WLs/8AdfA/LVkE7jVq9VzqW9rSoOlMy6PgrR0MoYnlIucjB2nafND0HZ/x
aMeyVPPYkpcwwnwv2rKAOT32UTYezGW/tCNyLR9ElaRKNeDYKTyBNX85b9unx7ig
qx2WPY24DnNG5GnZeYHy6cwTRp1uF/9AWp1Q4zV9+G0ZdEpKsyd8faoVFG+I35ir
WLp+xlPcXaEn/89Q1wEIuSXHFkNoLlApP4HfFLEyq9BwwSroBusaMTFh8/g8a5TB
HFOYR0dEyb0la7zXesdt
=nVhQ
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
