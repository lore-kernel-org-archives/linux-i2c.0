From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: sis630: correct format strings
Date: Sat, 9 Mar 2019 10:54:46 +0100
Message-ID: <20190309095446.GE1340@kunai>
References: <20190302141836.24638-1-louis@kragniz.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190302141836.24638-1-louis@kragniz.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Louis Taylor <louis@kragniz.eu>
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, ndesaulniers@google.com, jflat@chromium.org
List-Id: linux-i2c@vger.kernel.org


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 02:18:36PM +0000, Louis Taylor wrote:
> When compiling with -Wformat, clang warns:
>=20
> drivers/i2c/busses/i2c-sis630.c:482:4: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                         smbus_base + SMB_STS,
>                         ^~~~~~~~~~~~~~~~~~~~
>=20
> drivers/i2c/busses/i2c-sis630.c:483:4: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                         smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> drivers/i2c/busses/i2c-sis630.c:531:37: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                  "SMBus SIS630 adapter at %04hx", smbus_base + SMB_STS);
>                                           ~~~~~   ^~~~~~~~~~~~~~~~~~~~
>=20
> This patch fixes the format strings to use the format type for int.
>=20
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>

Changed Jean's SoB to Rev-by and applied to for-current, thanks!


--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyDjWUACgkQFA3kzBSg
Kba4BA//URuSLZFn9QiesoENmp23IEa9uj3gb+Ur18/pJ7muucYLqj+GGrZ9HdD8
NBbhUhqulclF1Cfwm354o/eoTl8JzMKUxwox0IMn93B5PdvIDxmTvmynleNVsSHp
2biWLGIdgk+jKm9ylNUdhGDcc9FDq1p82rK2stWjq9iI+A1nSkabxauzh5res+ZT
NWJEkhHi0GfXC0P/Xoec1D+m0EpV7ll16QrNkHeFADntZ00y7Z3wEx9Gw7zuIwGb
h0vvWp/M+Pmx5d09dOYQT/+PjR0M5q0Dq7vCVx1bqb3/G8I/jt8QX2hkjLY3IFu2
mzTMJC6hU9Wvm9zLLjXjC7osFS1QaAzx+dgGA4nTudOWlmiNsxYmGHzsr6BHCkbQ
SlfnI+5WHqgKcxbgEofqHsXioawowMOJAV17YS7v2tAlarMLYRpHif5wu/nbmZxR
i547iTLGtow8hgYJiYPmrd6LulJiYMKq+JLO4EQFV62LsPZGqXnvQwdr3dnOMmto
14sLgYYsbf+m4tHoo6OaidBD//MHVDHOJ6yvEZYrEHWfo03Zp8CVPH4aBMaJL7hq
wKdkIc+I0a+J/39NuOhgjYeRXjzt0bl3bYlyKD5ldiQ+eNML1DhXZU6eQ/TvT2vu
dGZKwJdGEYGbcweoMoT6NZjPaO7v9J+qGXZ6/qhdykGYTMteprk=
=5puZ
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--
