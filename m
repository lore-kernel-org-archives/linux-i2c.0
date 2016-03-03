From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rcar: don't open code of_device_get_match_data()
Date: Thu, 3 Mar 2016 22:26:36 +0100
Message-ID: <20160303212636.GD1501@katana>
References: <1456850216-8197-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456850216-8197-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2016 at 05:36:43PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> This change will also make Coverity happy by avoiding a theoretical NULL
> pointer dereference; yet another reason is to use the above helper functi=
on
> to tighten the code and make it more readable.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW2KwMAAoJEBQN5MwUoCm2tusP/34G52KWfgn+V+DGK1Ox4BwJ
/7NA4NeppzENnHnP9Pu89rsKVOoaEOWb1mQjjPn0fozNlbNQ8fiWEeoWxLNIsBVt
WPRmP3WZnlvn9vOKZsIVd2ZNNeeSduFbysX28/2VBGZ6TIOYUDoCShx2dDhsd4g9
UjXRTesaS8HMtusH5Pjiza3rKC19P7cAFQ8yXFD3UkOiroN4XH01dizVxmI2VOxh
Arn6aeX1yrv4nfP42BZWGSMWnO/lah0ScTyQaCEcDk8lvXPpeECiL6wB3ZE/PdLO
PpXTCZRLKmIqFM8Gf2pCgzdZgY21fHSZepH5QX/PNt9CP7wciObf74tB9OhThQ5Q
27AZrK2z/l5TMoXyYwzrLwOOSWSZS8OgoaXeu5hjI+u6PQtSleaI5v74aagPgypO
ZeO8XE/GPbUOtxZh/3v4HCA3o4C8yUqXxmKCRk0JdF+ltr3OQ5+Dbq7BhB++Jp79
I7smK2faKGlkPKuyHfWJnU3nc0M3j9B6QvK7PllTTe+9/7n50m/BCK4nSsPukmhV
enR7qX//1tdwNQJBfQBDsppcVGm0xLU7QCv6xGnsb6O9SURt0x3j/3h872r4WKiW
/CBMedhWWwcUdmRoovN08kqGoYsmoyO7rNrmrsJX7PUELDb+f8PRLHKUHLQ1OFfV
ZSaYkbfuLijg7lOTQ5MC
=8EUP
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
