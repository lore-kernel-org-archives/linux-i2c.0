From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/6] media: radio: si470x: Convert to new i2c device
 probe()
Date: Wed, 31 Jul 2019 21:51:34 +0200
Message-ID: <20190731195134.GD4084@kunai>
References: <20190710215149.9208-1-kieran.bingham+renesas@ideasonboard.com>
 <20190710215149.9208-3-kieran.bingham+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190710215149.9208-3-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>, Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2019 at 10:51:45PM +0100, Kieran Bingham wrote:
> The I2C core framework provides a simplified probe framework from commit
> b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new() call-back type").
>=20
> This driver does not utilise the i2c_device_id table in the probe, so we =
can
> easily convert it to utilise the simplfied i2c driver registration.
>=20
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1B8UYACgkQFA3kzBSg
KbYKjw//X2GF6fIBOwherJk+awtHN+WIYoC8wtW0UnfEEpukj2ERnrBovu+MmvxH
+2Gd+cQ9EIKZxmgVPFot8R/UHaEgfksrz5yQ4pNmsrnpd/9yrIXBSrUtAF8w3cvT
pULKmuNFD91BzODL9BzVQ32M0eScV8/BqROwt4yQBfSN+5UIYI1fqOiu4a6jcmWR
IxpfmHukHEMRTofGInkFtLuvm2ng7FQ2UB1qrzE9gRylObhCfu48IxeCqs9jlklW
IgcGTZldB0PAB3firhMRNVBKQi0jjV/ezDH2jfS5yKaMl8Qz5LtazMZKSDUNGL+G
OXL3wJljTkZqWirHDw2akh7nH+v46x6lgrL8msTMz2Y5oO03nhFODEcJbNUSUqd7
EWXBtWSQFrE0DX1I7U5cKNjIwBIUe1tJwbxJYvORiJtfQJ92SXX+/I+y6/6v1n0B
tmyvcQMUXT1f2cjsvrLGLQEpRDaMhoGB88mxvjBUdTTdIu5VIXUmTSBvluDnQIX1
AaWjLIzHtLJWKUbc74vuboVdXZeSReGRZSO0uIRh/ghKTdkgQ+igsl2Kf+roUUSa
cIiDuZlxq9cgyneeAw+HiPd2/xZQpVXENhai83q64E188BPW9VP+HoGzPyTir3Tl
vd36sdmixpzgblXq72Y+Lb/EvpXlMy2foqjdOcf32vKS0h/0SHY=
=FrgB
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
