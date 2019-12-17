From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: core: Use DEVICE_ATTR_*() helper macros
Date: Tue, 17 Dec 2019 16:58:01 +0100
Message-ID: <20191217155801.GB14061@ninjato>
References: <20191113152306.13968-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191113152306.13968-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2019 at 04:23:06PM +0100, Geert Uytterhoeven wrote:
> Convert the i2c core sysfs attributes from DEVICE_ATTR() to
> DEVICE_ATTR_*(), to reduce boilerplate.
> This requires renaming some functions.
>=20
> Although no suitable macro exists for the delete_device attribute,
> rename i2c_sysfs_delete_device() to delete_device_store() for
> consistency.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

Applied to for-next, thanks!


--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl34+wkACgkQFA3kzBSg
KbYrXA/9HJCyl76YLAfzC390t2ypvgJ272SNDRIpR0wyM39GFrUZiLtf0M+dNSMT
3P8l+j1gngw1J/b9ZAcK8hdwkTTYSVPa2lKAgaMYQbG0iNemf6Sr4G4ZTa6on75U
xDAU+Q/dV33lig6CciQi0FGJkKFjOsMoe8RbsIodynkkHvzdCVpPMiFYbtqKSmyJ
W4m2Hg7QNSd3loOjIGG58KkZaiuHp5rcAdWhkwom1dVM4om2P3nUd2STNs+R+6GK
NTSWcKfbZM1DRAyqO6IVqykRzVjdgouzWFgk4FgzFbYotUgvPnLhgMsPskomjw8O
D6NKz7saDhItZULIz5qogOkuspTkNDxPdU4govv9UXxXhnV/Qoq1kFSGhx1yB1zV
zqJBKqstV+1pGCC6rVfMj4C6yRhbVJso/LSptiDS3D+qqNse1sb7ytJ46zPqGglu
XL27/UjsPkqv6A4Xr2/exLmEFbIg71vH9tptmKg/VSEj8cuY5EuQ+8FWXP+WTyni
LDxwf2FxHjwc2D4vdek8BfR1sRrzFNV3Z1U4SQdkxPsRD0lJqWD4PC7/Qfh6KmFG
SVsiyl8DsAyKLrU56N2zaLhVtFlbipfW3ZhaADbXfNgYEsRIyKz+oV8z+EIbendC
2B09ar8jythkex+9bDmz2NiUUGbLF/Lt1WFP682uvh7gcEOOllA=
=LmlD
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
