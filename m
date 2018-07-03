From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
Date: Tue, 3 Jul 2018 23:01:00 +0200
Message-ID: <20180703210100.jpxz4xwwwgvjqycv@ninjato>
References: <20180620085157.30121-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="47ontlfpy2nc3et4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180620085157.30121-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, Akinobu Mita <akinobu.mita@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--47ontlfpy2nc3et4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2018 at 10:51:52AM +0200, Peter Rosin wrote:
> Hi!
>=20
> There are a couple of users that could benefit from an unlocked variant
> of i2c_smbus_xfer. In response to [1] I dusted off an old series that I
> have had in a branch for a while that adds such a beast. It also converts
> over some users in the i2c-mux department.
>=20
> There are a couple of remaining candidates in i2c/busses/i2c-amd756-s4882=
=2Ec
> and i2c/busses/i2c-nforce2-s4985.c, but frankly, those are just too nasty.
> Why do they unregister the root adapter and then continue to use it? I
> dare not touch that code...
>=20
> Anyway, this series looks like a nice cleanup to me, and the recent sccb
> patch from Akinobu Mita could also benefit, as indicated by Wolfram [1].

Applied to for-next, thanks!


--47ontlfpy2nc3et4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAls75AgACgkQFA3kzBSg
KbZRuQ/+LBvh7cnUPnZZ6UxMva8N3uNRN/htcgpXw705HPf2FFesGW32Ao/tD4CL
REezY4t9v4CsY4Jjm549HVJyyhmqSre+oF9JZZURvkezGGe1RAiOBgLoQ4gU4EaS
jJ1oz5dT92tEvbGAe87aWb3zrYclr/qYEgEVubrCWACwcymwSuIc0jSkvMO2nK7o
dz3Zfo9o0a4hAj8HUqUNP84IlZDxEBclzNTr7QWLRsxDBPqcT2xH2g1j+6Qd3ifr
1iSWdVGmojFGigNWhESn7z/dugDGgMDRQbfYrsjfsIMgoVQU2TlW4QiBYUTorcI8
V/dJC+6iKReJ4yrRYhumT+lxPAmra6hikqxx+4F+k14QqtrzjhaEtls5wnq8w9r8
z/YL3uvRu2tsrz2YmhhmZ7wvsXIKHeOXuD8S3gMYR8jIIZsDT6qBp+p9vxaPBrNr
+qTnua+yQGnE1miI4g24F/oCyGqBC04k9/PkWz2GbH9hc4hk1iAukAwJMWSBowdz
WIvoQBFgGBStR7Bfchacwoz/LOYUzqBeVu0v+PZEfTk79BdK9mqFMkCswEuwiQ48
HWD9dwDTbNb4Txw4NlEXFIOsRJw0KnpCe8nZwG4MAvlc5yp+/raKbECij/RmFmCC
c6qp3/r2VWHAdnIPemyreLa4O/y4ZSozptRlfDhi0QCQbGIXCSk=
=0qn+
-----END PGP SIGNATURE-----

--47ontlfpy2nc3et4--
