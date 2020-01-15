From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 00/12] i2c: convert subsystem to use
 i2c_new_client_device()
Date: Wed, 15 Jan 2020 20:57:05 +0100
Message-ID: <20200115195704.GC23789@ninjato>
References: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-i2c@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 06:47:34PM +0100, Wolfram Sang wrote:
> This patch series converts the I2C subsystem to use the new API. Drivers
> have been build tested. There is one user left in the SMBus part of the
> core which will need a seperate series because all users of this
> function need to be checked/converted, too.
>=20
> Except for documentation patches, the conversion has been done with a
> coccinelle script and further simplification have been applied when
> proofreading the patches.
>=20
> A branch is here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/n=
ew_client_device
>=20
> Looking forward to comments...

Thanks for all the quick reviews and tests \o/

Series applied to for-next, thanks!


--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4fbpAACgkQFA3kzBSg
KbZsuxAAlGN3Qw/NoGCVgmD5F27FU32w32SIt3btqM+Smwb8h/YywvrdIxuaElC4
U0FVB9Nt21/V6whDPbpRqNwtf3Wld5jgpFt3GinATmO0LBrYZM0qsrAWaf9Mnnaw
KgDuO5MOsyLhxxgsT7ak2ASe6o+QzDUOxtGJJLgjEUxAcdF7MEVinFLPA1qOgGlu
qTPNb+z3htcdaoLIVBvUBzS6xIt8HyD2XB71db4C1TqBfdoWI/kRIWn5Fd0Bjiv4
EmUag6Gy7G0CTw0lzmYne+gSB/U8ugzpNDTWEyns4bxTVUGgyuAdWcPomJ9Duieq
zA2yUvTbIX/L/smIXiJcXUOwgWiozVsY+oFpDp0lpg7ZaULiuCZbmcdbil6GRfqB
qVfn8F94w1GRCQ5lNzMTuUbTIo/4w5HFMKQY23lJ8BMI26nVQ4+6YyUoZstLLyMA
Np0s2EAUUGGO9IdMigfaJrVW7m0ukj1Je4S9a8OAE4eVuV89o1UjNdx0O7kV4BPI
K0YpHnEvGaEiQB3MonKIE0jUL6WA1eXUUxsgQCBoXyPx9nmz5QzANoenIPmN8PBw
sf8NAgK8ppLrkWjmbydI2GWMFFhp4gXdGFzvrjLahMNXZsHGLyK/ad9XS6+E54RD
GynwEX6zU+0Znoa+3I2Po2bbPBRvuHSZqES3obLnS7x/VQ8Xz1w=
=uUCI
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
