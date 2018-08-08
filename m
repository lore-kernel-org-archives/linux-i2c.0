From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-amd8111: Mark expected switch fall-through
Date: Wed, 8 Aug 2018 22:10:19 +0200
Message-ID: <20180808201019.v6wbbixglpqvzsou@ninjato>
References: <20180703190751.GA29770@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fn3nrerbdujaohn2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180703190751.GA29770@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--fn3nrerbdujaohn2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 02:07:51PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to for-next, thanks!


--fn3nrerbdujaohn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltrTicACgkQFA3kzBSg
KbacCw//Vgx6WVx2Tt0R+jFSW2lba92Z1cptBvAItIaDKLevwAMfyOpgV+a7vaqh
YkTNKGCbUjy14bCiJkXVng93NiUU6IV6OvWBlx9omrhqVynTZFTOtl3Gc97mCXK6
U8zab/fSEXj6KDoVr+LppMKbZNtCrEqDzy5jxdZapTt/iqECNWL+9HhIiDapaWat
mvHOdtudhFCthW/hYf/MKBsaE1fCjIwnoqk4rEqmPBuu/EaEv4MJpOMfgbdKq2Pd
pDNUTb1t+j5Oa26dX6H88DQ4fsE5/D7qgKDmY2gmOIbkT1rLFISXHuhEAtMaWCFc
bGqbbFmDmd55Org//sdoKFqheoXxUqlV/inqVKvtIH+pY8fuYkIp3JLmbVQWTGdL
TOhhY7AuKCgZc018u79/lgoUqwWdFG+uJwQ4F9wPx+bWMiPslOo2tSIQJraNmH9g
8xZDYLpOeD0Se8OGctg5JuPxIMUuZR7eofhCvmFhwZajYztALXJBVzqpK/S+b5AS
ejL4GqQJeH7bXxFR1uHF4J/P6+XJmbxx8phGHMiVp9BWrfeWXRcCm9qeuD3BPI4K
hnhKgQOvg3763aZZ3kMGLJQzjUEXhjE0RnZJOPkl12AEtzzdgYX1t9WI6ttjm5XL
pQkO6LJvsamI8W8NPenfSlcnnGv2uA2fxsme55vP1oJbJVFszJs=
=fy5D
-----END PGP SIGNATURE-----

--fn3nrerbdujaohn2--
