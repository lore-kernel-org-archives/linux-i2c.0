From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rcar: fix resume by always initializing registers
 before transfer
Date: Sat, 22 Apr 2017 08:16:25 +0200
Message-ID: <20170422061625.GA9326@katana>
References: <20170418183835.13836-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170418183835.13836-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 08:38:35PM +0200, Wolfram Sang wrote:
> Resume failed because of uninitialized registers. Instead of adding a
> resume callback, we simply initialize registers before every transfer.
> This lightweight change is more robust and will keep us safe if we ever
> need support for power domains or dynamic frequency changes.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY+vU5AAoJEBQN5MwUoCm2aBwQAK4oRw0D0ttIIR7Qq86hZmsB
gtYVey5F0AV+di0TGP/s+E3Irv7d7ex+67+MH1gWFx5yyG5gKDgfCy4S9+3MHRTb
b9JAshtorpUJjk5ZL6S1z2SYp9VppB66RnjE6Di92tlS1AayMpDgotqZ8D71QGEL
eXXZUiobqggsSsAkTu4O3Nm15rnQjKuWUeZqbb4x6FaNezGIdaXfR5tStmoWkxrc
/HypjhYdCDVWNVIuMpC7+ABBUpHYWQGk5IEplke9Mk2iQolU78AvwDTu2xTe1jrk
/k7ozQZRcXXbiXzk+9J3d16GMPEXIl/vCE1v6a857ZIAz6DPASTZWH+IhyIKfkXu
tYjNNeCTilUWvHeGBXeLtghvBI1uUfLxOv+qnp0KBEV0s5AXj6JDieEkE5PH8D4j
fXDZ1M1Iy7koY20r9MTAR7v967thBKWTRx0+0TscB9oqJtdr634XujU0Ot4hu3YA
AMiTIWyU6jd6jMtwCIxktbSoo4PwGX26kN7EWd4jYn9rdbRX7FsYltd/GrOdob+K
uOWdFKwXf9LVkRBV9r2/Mv9x4o3BigcxpTxgpUIfpJQssz+1Ez5EAsJLHD153BV0
Ubzqh+O1Xi7quIz7JzJiJG+eWKW1033jBwmjabJLODgSj3KoOFVdVqtoDWxbnHvo
e5iTMoMu9Ur0pu03WfA8
=aZlI
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
