From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] dt-bindings: i2c: Use correct vendor prefix for Atmel
Date: Tue, 11 Dec 2018 20:49:22 +0100
Message-ID: <20181211194922.h2ajgeos5mb2znwc@ninjato>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
 <20181123125138.22489-1-thierry.reding@gmail.com>
 <20181130231915.GC860@kunai>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v7eszim7jahxuojo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181130231915.GC860@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--v7eszim7jahxuojo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 01, 2018 at 12:19:15AM +0100, Wolfram Sang wrote:
> On Fri, Nov 23, 2018 at 01:51:38PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The "at," prefix was never correct for Atmel, so fix the few occurrences
> > that got it wrong. Use "atmel," instead.
> >=20
> > While at it, remove the at,24c08 compatible string from the list of
> > trivial devices because it is already documented in eeprom/at24.txt.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> Applied to for-current, thanks!

Reconsidered (as discussed) and applied to for-next with
'trivial-devices' hunk droppend and Bartosz' patch squashed in.


--v7eszim7jahxuojo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQFMIACgkQFA3kzBSg
KbY66BAAirYq7JrIwgWUKeRfW662jWt3vMcd4Ef10RqrfboExoHcix6zHKJWo5PR
1exoAjs3eXdr0RDbBYGHYbKd/yK3Y34LYIaJy5NdaA1cPwO7I1htqgbM98fYSvU7
CWqAWqVkLAXxcYCABz0A5KKbz14i/rvKPGN1tPlSMl/B2JAKLmrO2xvp25priTv8
FLiXX/pC0YUqSuWAyyeRsJ98gsbI/+KC/GTpYYAqHbo45v9WSIN8y7TrCKuNb87I
JH7EVPmSkJIVeXTOS2OQVW5hJWkCAlK5CtLesB2Jjde8aOwl08oMHiWNQZS9CXRK
766aWrnpLJEPcLcTCqA2BT73Yh1e/IFF03bvwH+F7yMACJvrFSp9jbqeGrUjten9
VZnPbDYi7PQqiPgzIJ0DXHSrPAbEFpO+L6m5zNb7K1Vt47zFepfDa/zUi7ep87o0
YnkADYWo+zV6aeYzRzX++Vf4+rrPQEPBPXBQ3JPD+T1LtSP2RYZb0zRePaQEP0mI
+jw2HbuGrfZkBJ6VrO+4+LQavOo22FOD6UY4GEAXuV1DL7UbW4or9b7Cshjzk1Yn
eyYo2gIZ64YulvuMfnCV94mCBwS1OmTnVW92vDkuVE1XqlYyM8QDW21ThCd9kBD2
fVPOIcpxy94PxPon5WdD13lgjTfvVkEmHaSaFO9i/j/uOt1nh8M=
=2bIe
-----END PGP SIGNATURE-----

--v7eszim7jahxuojo--
