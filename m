From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: remove deprecated attach_adapter callback
Date: Fri, 24 Aug 2018 14:47:49 +0200
Message-ID: <20180824124749.4vgufcqbrc5oarqh@ninjato>
References: <20180821150240.19964-1-wsa@the-dreams.de>
 <20180821150240.19964-3-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="phvp76g7usouniqu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180821150240.19964-3-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--phvp76g7usouniqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 05:02:40PM +0200, Wolfram Sang wrote:
> There aren't any users left. Remove this callback from the 2.4 times.
> Phew, finally, that took years to reach...
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--phvp76g7usouniqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt//nUACgkQFA3kzBSg
KbY5MhAAkIydzhA4RGkQclsMYfRc6a2M3pfJYab18eknTzlb2ffROHkpwtXPGdOt
8pRsy5B+uKbe20k5J3/x8O3RHmXc1oRF4E0YmtFTHKoHJr0otC6GXVtk5ZR30ABh
OG499NAhNQ1grFvuZtV1BG1J8di0dTTJFjdAWwoGHcMarCsRDZzg608FUTuJJ892
VWtd+8QDidXQYVWoIWICzvWGlrbhAmBSCRfZAMBdV53f7FjTVwsZJjzY5eQPTIU9
nbcyTJrsOwkJBJfawYPdLqrqwWgnAf5rguyMEHaD9IfjLoT2YpknvwYiRUbaNZyv
WC0pijebOICPSUlzmerUqtmnP4YV+fZ8QtPJkkuz1PPDQsHD/fDh0oDgVXiJYKMA
mCKzAKG3FolDosTq5d2wxbFpTGmjMg8L5ymnoL8eyFI0tR8oZB2DwjSJdIIwyMnU
JLhWHWRWlV82RaJ0bVd75T8A7Cwsdo78ssboFjdRTAxFH881YTsB9LX/obVolPfz
d6ylhNDYPyuwJVPH2OH/ID/6UEHNcUxle2AjOHDqMlmEgkWWWSu3lpZuCf0+PVuY
Q7RRp6pLGVB/y2lNTmNgfduYYjlqx5y5FhZpwu5ITMj09Tgi915MycyB+b5Cy2Ms
V7DkyzyZsw1mpRPgg/uHBxA85Oae3D3PoVZUGOxM+YpHLXJMz8A=
=VOCr
-----END PGP SIGNATURE-----

--phvp76g7usouniqu--
