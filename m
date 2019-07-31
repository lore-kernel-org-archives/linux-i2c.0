From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/6] media: i2c: smiapp: Convert to new i2c device probe()
Date: Wed, 31 Jul 2019 21:51:42 +0200
Message-ID: <20190731195142.GE4084@kunai>
References: <20190710215149.9208-1-kieran.bingham+renesas@ideasonboard.com>
 <20190710215149.9208-4-kieran.bingham+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190710215149.9208-4-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>, Mauro Carvalho Chehab <mchehab@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2019 at 10:51:46PM +0100, Kieran Bingham wrote:
> The I2C core framework provides a simplified probe framework from commit
> b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new() call-back type").
>=20
> This driver does not utilise the i2c_device_id table in the probe, so we =
can
> easily convert it to utilise the simplfied i2c driver registration.
>=20
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1B8U4ACgkQFA3kzBSg
KbZ9ng/9FhwSMWXGi73zFKFMcGRI/gXZ+Cej+bHSc3s/aGIyv+D9bDhvPjMb0rOe
tqas1yW5bUHVLJxektvUv2SqWAMYMIaz96sKIZXhMzAj0xPh025ShRTsoZjPV3fL
69iHgRHxvhAk8l7eP0UbaK6EbbDL6G+jPP1tRknG5LO4PXMSyFYO0Jy9ASsh4G8J
yogovbbF6DgHY7SMyG6rSRKBl+FPfCmvIEOaFP3BURzll3IsgRB9qGl2VGum6f5D
dvMh/FG6JMJqKZHGfnDZMzJ75AoV9Ltydzta7E2mZ5miRKlIKPikw+nOM3oAiUjw
tF3nkHHBg28uLEv5n+tMKF11AaIdilxVYHJURoRNBEvxWeA/zYya4xb2asioRWok
NZQLJO/pkRKarUwIUyujC3xGnBD1d81RCwDcKK2ug1WzSTXycUWAdVHTfVkOCxJU
BuhMJbNl+3KWc8IWh8NlDc3mnZM7tqzaaOBsRqjgtDFbAd5E7pv0w6nIxFdiiSZ4
gyJETSlcs3Bg7gLim5Tq6xRNdNl/2kZ2x5X57iyunUgZp2Zfu7nRVjdel2ekBsOV
cojaUSV3W157wJ6PwlHpdgqtgelLgZ/cgIXz4g3IMDqVGQEPU+03PG/ON5LWBFbm
pEJ8mqtdyI2WV+o8CEIDE/gwESJNtSGJ/33IUNbj/WNWE01oL8A=
=gAvi
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
