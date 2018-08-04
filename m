From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 01/12] i2c: quirks: add zero length checks
Date: Sat, 4 Aug 2018 23:26:52 +0200
Message-ID: <20180804212652.xe6q2brc74pijvi6@ninjato>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ss5syh2dz7ow7lq7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--ss5syh2dz7ow7lq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:05PM +0200, Wolfram Sang wrote:
> Some adapters do not support a message length of 0. Add this as a quirk
> so drivers don't have to open code it.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--ss5syh2dz7ow7lq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltmGhwACgkQFA3kzBSg
KbYCuBAAqO909trDreplqkNEXwXpF+CJDdy0zwZ3jjlIrlCnnZ7xr5aYlOdS9uA2
gyB7pL+rlbNHoQePk9suNfIkSAGiM0hm71ZoyoPVVU/o8jHRlT26UPVPXoB49LaK
kOhgK5GdhaHWULjTczhwZzs97rrQnXXpfS/f4wl6RuwKUVX235zfPhgn/avJcC2M
Y/GrPicQBenoRrmuZPPqmvlDL/T0LN0HhSF/ZvBYOQZnCMiY1DdmLiy9gwiiWBiy
MgiHGiHDHbJ2GfvLfVrELXnId4gIQaPmCQ6ZZZep85xqS5rPxmvNtzzKZMb1NTK2
lX6tBfG5ji9sx2u435Ha6CJh0KKVNLt6d5KAkRiEtQepCKb8WGw8skgx4jwOIhIs
kYLRhRdba63NxM7ke2pi+TtBzq4pw7hmjJWbJO3402f67ulP4qttykTYEY/joB/E
+8IroXAHek2A3c7mcPKGNTv3uYu1Rt9pRUN5i99fDGEGQ2r8/ixZKdSA+7sJicXJ
A2dd5vV+KcNtp9HiKzdGBa8PTU8etUu5hWKeOdstu2RT9PTrmNKm1yz5oKp8dxna
DVe4x+b2fHDr+cxD0xvxLzvtFOQ6D/8halYL+0mCt4r5LRWJD8mMks8WlwPBiq0V
qL25AHd8XNPh2uEcDbGIghh7D5qBRaHTdnI6bJN9qdttz686MMw=
=KS6K
-----END PGP SIGNATURE-----

--ss5syh2dz7ow7lq7--
