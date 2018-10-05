From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/3] i2c: mux: pca954x: simplify code to reach the
 adapter
Date: Fri, 5 Oct 2018 13:43:36 +0200
Message-ID: <20181005114336.GB5433@kunai>
References: <20181003155024.16024-1-lucaceresoli77@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181003155024.16024-1-lucaceresoli77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Ceresoli <lucaceresoli77@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>, Peter Rosin <peda@axentia.se>, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Michael Hennerich <michael.hennerich@analog.com>
List-Id: linux-i2c@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2018 at 05:50:22PM +0200, Luca Ceresoli wrote:
> From: Luca Ceresoli <luca@lucaceresoli.net>
>=20
> struct i2c_client has a direct pointer to the adapter, no need to dig
> it out of the struct device tree.
>=20
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

I like such cleanups!

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3TmgACgkQFA3kzBSg
KbY/wxAAn7G7Vdc1KEByMKk9/3TAiEhJTn3MfACEsR6i42Jt/y1GspZ45xyn//2T
GZRFv+Ci9qNXh+t08KASjiS9N85/72l3zOhBqSQcmJN5zDtdTtES2rbvsK1HOTAU
ukEygzgofLPd+O0+26L8nBq1QRhmPhe+wYOArw/56/gTH1RUGEr+FY2J9SZBfqoT
G2+RnFszAYhC2A5BubZm8BN01Sim6fHI0CAye6CWYBDypr8q6FoSEfvmmTvjgDTC
u2smf6Q2ZMOHGC9GsZIRMaAahLFW5VkJwTDdA8QY62FaM7XAc6QRzQGmEDbJ46Ig
vWPUekCx703gOXPDNGUb+AAXKRaT9URuY0jbOmV/Y+lTZiUhjdHgDXlv8PfR4yep
twrMDeK3dzbqB9qh3puVugSLqHV5NDKIP5/j0s4/UDLvMFzezJ1klrqJl52szieq
o/SrPKG3OxyHavlTDeIKBHufc5Eo9QgOd0sfw14WCJT/Y16fU3aysStuDWtJ23z+
HLt3ItE3c2rg2FEJRW+23LkoiF8gXD17TArwrhJIeGiSeHfFw3dycAG+9EODz7BQ
DX9Fu6aT2I1Fzo46BiTZ1woQz8kxlslAb25j6Wd3ytzVzlnlXFz3+eiLV5CIv2Iu
fLV/ASCdLkLJrozZzQdZmiNKxWua9fK+qw1SgQIokvE1GdG62Dc=
=UVAc
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
