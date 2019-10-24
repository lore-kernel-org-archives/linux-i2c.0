From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: i2c-stm32f7: remove warning when compiling with
 W=1
Date: Thu, 24 Oct 2019 20:44:37 +0200
Message-ID: <20191024184437.GE1870@kunai>
References: <1571145118-3522-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1571145118-3522-1-git-send-email-alain.volmat@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alain Volmat <alain.volmat@st.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, pierre-yves.mordret@st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com
List-Id: linux-i2c@vger.kernel.org


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2019 at 03:11:58PM +0200, Alain Volmat wrote:
> Remove the following warning:
>=20
> drivers/i2c/busses/i2c-stm32f7.c:315:
> warning: cannot understand function prototype:
> 'struct stm32f7_i2c_spec i2c_specs[] =3D
>=20
> Replace a comment starting with /** by simply /* to avoid having
> it interpreted as a kernel-doc comment.
>=20
> Fixes: aeb068c57214 ("i2c: i2c-stm32f7: add driver")
> Signed-off-by: Alain Volmat <alain.volmat@st.com>

Applied to for-current, thanks!


--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2x8RUACgkQFA3kzBSg
Kbbyqw/8D1GESh2wz7RCGgify6hbIO/FgUOUJigLMBvN7ElqmAgJbf23OvTg1zQx
67AJ5QhuUzw3oXySC2ntHIbBvM5pfiJjCp3knOLIrjWCUVZ2KvBPEprieW5tpBj6
sXy+6ZzojJj8vpA6LqmIu/jX0vMo9NBGLUGkWcnkklz0J0k3U+0VzdAUHGvVpJGd
xWUxHGG8q5vJ5Y4t1RDktRj+vraHaV7SZwp5QL5+tD0LDZ1e00pqupVpHL+vEzIj
GPljclhyWiF/fQzBpY4MZWZ2Gpk4ZCJ5aL2oQtY9HTzy3UmPQJAu2ZjfDzAwM2cy
UfX9vpo9Uzg5k3sphhQz8lL35KYeRNj/HHGn4ricMT05G6AnLZ3PvPN3N6XL7dbk
BFnN1xaDmiF0izsXGQQbkpHvywAL/glYaImGZ2B4cKUN58JXavsmFsW6qM1mlrNl
hAFPFwJWffGJRW91lxC++v4LwjkpuypnRghWwy6sllU28/MgBESKnQwDqW4X3hmA
SsUijLNTRUgUWjgbUJ7s0YQ0zOEP/3U0k/Jv8XY8aLRu38fJ5jCxREQinZF6+Ner
G1DvSW9mfisN2HQqV9lWdADiiM5qfDyqJMT+SkSkXuaYqWqn9FNSFNn9bWjVRqut
aTEeMGUPOljpMtVflUPoV6nPF8LhFNXGhKaZqx5RkGQD9blcWaQ=
=yMm2
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
