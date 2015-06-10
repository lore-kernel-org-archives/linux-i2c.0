From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: busses: xgene-slimpro: fix incorrect __init
 declation for probe
Date: Wed, 10 Jun 2015 22:18:41 +0900
Message-ID: <20150610131840.GJ1592@katana>
References: <1433288589-10794-1-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433288589-10794-1-git-send-email-fkan-qTEPVZfXA3Y@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2015 at 04:43:09PM -0700, Feng Kan wrote:
> Fix section mismatch error during kernel build for xgene_slimpro_i2c_probe
> function. It was incorrectly defined with __init declaration.
>=20
> Signed-off-by: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>

Applied to for-next, thanks!


--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeDkwAAoJEBQN5MwUoCm2zi4QAJF1FCePvJaOdqUMU5WecfQQ
btcFt3D0Cwdw2LY2kI7jnT4zNLVuMZLdotANLnpR8+0TFcH69menf9E+uC4e4gOX
gcJl0uyV7/QlOEYqmRABaK+t983gYhN9bfrm9aChKNOWs5JMpxk29cSUkklQqynF
0eiVJ1pbDMR8HMHhqk3qbRnrTt4rS/yrWFJkuPj0Be2Cz7YxqE6nxOgzSul/kXGj
yUHHO+pYYR6pbCgh6COtKDBQWqfRPxeqqWinxkHdbzGPu7F3JfptvB1HU5r0nIyX
uelNWwPm30VwVdAq64fA/R4EoXEQv6F8tMaWvGBlgBdyPkkGSSFW/OywCb6CsTin
cIoirkDJrb7OXZetH5XUDGBi7qpa0Q94vNVr0cUg0d1lk0zGdyqkn3N3ak/7ElMH
egW/Y7wR7Kd/QBYyv6Ws1t7nRrir69Jme7b+7Rj4MFoddwMIUHRARRRsvZjKFlp2
rk1M8UeZVPdQPsfCDvTpq3BQiSAb/NxR2OEHFf2edI2lgi/2lfojIx63xFTWTPJI
oSds0F3r/gxpOGd5O7170FJhQxwKLSMe14Mmenf0bT7ZF9Dh/MyO8/IGPJHV3LoU
FlwkF78JpYkQ6RKZg4hB4Ox6Q1QWF9ZnCSoUBwpSJEK54Gq0ijXL9/Uwy34YZDFj
Gwko5oCDnhx8ufinNst2
=oLkx
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
