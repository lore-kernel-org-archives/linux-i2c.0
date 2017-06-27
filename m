From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/5] i2c: pca-platform: switch to struct gpio_desc
Date: Tue, 27 Jun 2017 21:53:50 +0200
Message-ID: <20170627195350.jszt3hzxky6cktg6@ninjato>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-3-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a3luhuozddwyuh6g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170626004434.2757-3-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: robh+dt@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--a3luhuozddwyuh6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 12:44:31PM +1200, Chris Packham wrote:
> Make use of struct gpio_desc which allows us to specify the active state
> of the reset pin.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied to for-next, thanks!


--a3luhuozddwyuh6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllSt84ACgkQFA3kzBSg
KbbmZg/4uvPw3zHRy6BP0OUdf08kEWHT5IFsxBaQb4Ou5bgnwCEVrF7fVU+mgCNS
yn3mFN2NweJ9UrOYbL+2BjYsPGU7NJG8baB+oOPZz5DQn53ahYcy00OPyq4/MtBq
hnpZKTIkx3icITlo6HfPuDkA0alZ0IksWd0xQda7eqkbzrcuhQvyUNrUaolP2LWB
0Ysywgx0zAH814xcnPyddtLgH3X6XWynIoytkpbin2rbJLNyJuVEw4AKwFsleK0R
kDxum7wO7NkT92E10YjjlHZ/KqxkPs7BJVn1naHluwWEp/ctjkwtG/AJ64GvS+HE
+7E2zVjRgkjhwzBFWpNZgMfMIV8I7T9lg7LhKEMo2xF6L2/9YTSjtLhInFWoYsA+
U3yRPeWl8huDG7iPNDT3C9Jgt4J76Jnez05JULlP0lAFfmx2sQ3hTdUPjJVB6zm9
m9eSMHzggt7D4+RrCrp1qBaRaCPEfK/h4fhx1m02Ee1RkYVPbOV8YhedoC+CzJKC
DnPrRPuKCFfK0AzLt9noWP0cO5uVgCTF/Lw4O1fiVnfi4tpaKQPugzPe4G2Deg16
6WZoF9SFD6nEVXnFjgn4bJDDHu7TWtnJidGXk1l6Yx65qsRiG1MsQHztsVVvDSy7
iYBtMlFqnVkZwY7ztbwZqedWZFrfQN1G+PnBItbq6VPqo1DC6A==
=dXSp
-----END PGP SIGNATURE-----

--a3luhuozddwyuh6g--
