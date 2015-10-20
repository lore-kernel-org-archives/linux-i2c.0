From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mv64xxx: really allow I2C offloading
Date: Tue, 20 Oct 2015 18:22:23 +0200
Message-ID: <20151020162223.GQ5379@katana>
References: <1445351544-26062-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3wfpuDtTLg8/Vq6g"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445351544-26062-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, Hezi <hezi@marvell.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--3wfpuDtTLg8/Vq6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2015 at 04:32:24PM +0200, Thomas Petazzoni wrote:
> From: Hezi <hezi@marvell.com>

Is "Hezi" the full name?

>=20
> Commit 00d8689b85a7 ("i2c: mv64xxx: rework offload support to fix
> several problems") completely reworked the offload support, but
> stupidly left a debugging-related "return false" at the beginning of
> the mv64xxx_i2c_can_offload() function. This has the unfortunate
> consequence that offloading is in fact never used, which wasn't really
> the intention.
>=20
> This commit fixes that problem by removing the stupid "return false".
>=20
> Fixes: 00d8689b85a7 ("i2c: mv64xxx: rework offload support to fix several=
 problems")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Hezi <hezi@marvell.com>
> [Thomas: reworked commit log and title.]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Note: the original fix is from Hezi, but I rewrote the commit log,
> which is why I authorized myself to treat my own work as being
> "stupid". Which it really was.

:)

> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv=
64xxx.c
> index 30059c1..5801227 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -669,8 +669,6 @@ mv64xxx_i2c_can_offload(struct mv64xxx_i2c_data *drv_=
data)
>  	struct i2c_msg *msgs =3D drv_data->msgs;
>  	int num =3D drv_data->num_msgs;
> =20
> -	return false;
> -
>  	if (!drv_data->offload_enabled)
>  		return false;
> =20
> --=20
> 2.6.2
>=20

--3wfpuDtTLg8/Vq6g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJmo/AAoJEBQN5MwUoCm2oFkQAIHMxVA+jB+iCxJIpftMiycM
6WLx08/wqp5N94JgH72BSiZHi9I+BdZT61ptfDBrfQarKVW5xkyyDVjeIAapoQe6
ouWZkNxd7oV+BXmQpeHEZwayvt+s0Yratip4uRgrQfJoa48z3BsDBSFBDi0uewnf
AZNkofN7khYlHhRMqXwOl5o2hNtqnKX7tHCdomQjpTiypCeRb/jHzr/OeiR1Px1G
6yPgw01z9qxIEZ+VubAS9ZwkJQUPxLH0N3UebdwlKltYwgVdW65r2om5SpBqIpce
LCE0sPmGVDhC5Qs6fJfID/FzedsVCwmxusHT0mGBzPRIPt2whN39wDLXOtU8HSYT
QBKvsZPKue6nDQ2ySwnKVZYJ1IhsqDGKiZVrRGhZO6kPUJtImyUtmUBEqQdcCY4M
K9ow9iG8swH9tZ2Q8Dt0jWkQvRYExooNzfsR3gtsgqJ4yePh91JLRREEUTv6ES72
beZcDdpyASvRVCDlenL+k+TyPOHjbES4URuIxsYuO1nezzLNzIo6TzB2QPxvHfHN
RL+kUx+NgWaJMloELew+/wf4WnaOzwGSGy1MqxviCa9rcffALuAFnZr6T6CRmQHp
k2Nq9vJo6w/LJKTG9/a3C/RYFs7J5KbEgY5VJgoGOGDazF/0/VidGz7EPqo9iTAC
WDf/JeOtN3OUNwMOZgCC
=VVRa
-----END PGP SIGNATURE-----

--3wfpuDtTLg8/Vq6g--
