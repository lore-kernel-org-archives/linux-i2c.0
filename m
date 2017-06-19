From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: at91: Handle return value of clk_prepare_enable
Date: Mon, 19 Jun 2017 16:32:32 +0200
Message-ID: <20170619143232.yfjg7ydk3t3daeee@ninjato>
References: <74b05c5180872e368970562535bc305728da4be8.1496211597.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x2hj5jvbepqzvmnc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <74b05c5180872e368970562535bc305728da4be8.1496211597.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: ludovic.desroches@microchip.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--x2hj5jvbepqzvmnc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 12:27:44PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Shortened the commit message a little (i'd think one example is enough)
and applied to for-next, thanks!


--x2hj5jvbepqzvmnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH4IAACgkQFA3kzBSg
KbY72w//SsFI4N0cSwI5tyNluCOMGRx2n+LLm2gz6wOeZClj1eE/J3QIQM0K/jjS
o6TvpNTVod4rDNAjhML9ZCDQ2N11t6l1UzYAlw/PsqD5SMd1xg/tKzJ5YsiAh8A2
2zfQAHACC/gqeBPTV9vWwt4E2xjN6BoY6JUUIgBYbcn++6SDzA6jVF+JbIuYOwk8
1DxmGxKrxymdTmJn52QmNgOVApzOzhqktgZjecvhywjgCGIOJtw1fscWhh5uE0E3
aaC+d7x1OJmRCJCVvPzHQHAKEXSZt0bPQpaqFiiPHGI7+g3+JtHCMuJ4Bv8qTRBE
aNGihigHYZ+Ez5YZ7ECoWE5ewY4Ks82X7fNfMVNU4z4huTOGLJTD2ZO/iVTYsICm
WRMnSmAdWa1kqVv1sGYxFDYV1hRWPGFzi7uTV9m7vZUE2kcqMTd2b9Ji5e+VinCI
vOf/6j4GyVx1tHnknNWbtjVi531cpZXRYZdfrsK/SAAEDf//pS9xRnASnAFNhtat
xngPW0ZiMYqdvVXIutevUBNsI6bbmXTkURJojwzEQmblJon+1kjH3aRIj4TfOKBM
JMxv59vk71ehk2yK0qSclsqOMruvHza76rqWKSwWAR6htqCC/J7d+Wy8nZycAMxB
cpfH+IuuER3RbwrduEId2D0P5hWyDCxs5DlGMbDF0nGm02ulDY4=
=Eny7
-----END PGP SIGNATURE-----

--x2hj5jvbepqzvmnc--
