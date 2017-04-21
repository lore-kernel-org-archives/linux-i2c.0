From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: thunderx: Enable HWMON class probing
Date: Fri, 21 Apr 2017 18:05:46 +0200
Message-ID: <20170421160546.b626wm6tdq7frjrm@ninjato>
References: <20170421144355.8172-1-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mk2oaijcmf2lh55e"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56901 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1041985AbdDUSew (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 21 Apr 2017 14:34:52 -0400
Content-Disposition: inline
In-Reply-To: <20170421144355.8172-1-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-i2c@vger.kernel.org, David Daney <david.daney@cavium.com>, Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>


--mk2oaijcmf2lh55e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 21, 2017 at 04:43:55PM +0200, Jan Glauber wrote:
> Set I2C_CLASS_HWMON to enable automatic probing of BMC devices
> by the ipmi-ssif driver.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next, thanks!


--mk2oaijcmf2lh55e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlj6LdYACgkQFA3kzBSg
KbaGoQ//WU28gdDvIVZQObd1ENorccxsYXjBF3PgQbdrt74Xy5eedV/8T2ZbhsJ4
qHNzzlQXrUM9ofQ37qYlazgyo+OdBw+QJ3TglWwfaAncAv9LU1MylNrpCiRMSCxS
pCw+8FcC0Wg7Lo1ds+H3hsP7EZeLqOAkGVPzVXFE/02Iva9UwaOcXjeSdBlQiN1s
DAQ6A4CnuA1/xOByKkWAgCFYDD5aIw01sWv2q4xmu9H5cOR+WTaFkabpQvGV9lLV
mMDsWGPpq8f9OFkpYfUy7lw3DXXiPFZPvGa0fLqUW7hVRGuHglN8ic+CjY0QzN/u
8KBSrCN7tvXVDZCpYuf0JD4eRa8IIJuKgHeZwg8mhvqbbeow1HE40t0cOxLvMN/j
+/aEZITZuBOuyIvajNt/Y9ujoSTLUk4gT8ASlbHnBlozQOhNbeadX+izXjEwVOmZ
b+KVCtJFBW5jM5DBH8jDyW6PhprQzUGn7eSlAm83VBRPFaoc2IhqFWaq9IG0GkF3
xPNZk83rpaf+lz61KNHYpqq/T81uqyObHR3WadiNl6WuOmBS7BDc+YJmaeO3N6l7
vVuK144N8N7CcFHZh/s2DWfatrUTvbvCwdXEr3TS2/GNUILWj/SxPgiw83iTClsd
N0yHM0ZSbM9g/vWLwZbLrLmc9Z6kgkUcjij15JNWWVwD4IL/SMk=
=ZX0J
-----END PGP SIGNATURE-----

--mk2oaijcmf2lh55e--
