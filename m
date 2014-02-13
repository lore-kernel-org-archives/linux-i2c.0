From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mv64xxx: Fix locked bus when offload is selected
 but not used on a message
Date: Thu, 13 Feb 2014 10:41:17 +0100
Message-ID: <20140213094117.GA3934@katana>
References: <1391770588-1344-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1391770588-1344-1-git-send-email-gregory.clement@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -461,8 +461,15 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_d=
ata)
>  	case MV64XXX_I2C_ACTION_OFFLOAD_SEND_START:
>  		if (!mv64xxx_i2c_offload_msg(drv_data))
>  			break;
> -		else
> +		else {

Here you break the coding style...

>  			drv_data->action =3D MV64XXX_I2C_ACTION_SEND_START;
> +			/*
> +			 * Switch to the standard path, so we finally need to
> +			 * prepare the io that have not been done in
> +			 * mv64xxx_i2c_execute_msg
> +			 */
> +			mv64xxx_i2c_prepare_for_io(drv_data, drv_data->msgs);
> +		}

=2E.. but more importantly, NACK. The code is already hard to follow which
is the cause for this bug. This snipplet makes the code even harder to
read, so it needs some simplification IMO. I'll fire up a counterpatch
in a minute to explain what I mean.

>  		/* FALLTHRU */
>  	case MV64XXX_I2C_ACTION_SEND_START:
>  		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_START,
> --=20
> 1.8.1.2
>=20

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS/JM9AAoJEBQN5MwUoCm2rX8P+QFaiQrWhJsv8RG7Bkhz/4LB
j6wR34ZbAzKiCZWI8/NwotWpv8rUGyuEbZ8w4B5rABbj05l75ngqfjzLGw6VFJb8
l1uxOtevNZkZ6j+ahqpjhICTPrrGOR+PlAIPC4UoewJjku4h9GwlMlpvCkrCbV8M
Nh8SvHFIgMXP/sOWhkMlYUJob0cxSE+xerqjJzVW/aSVRkRlYOI2cfKHqTC1MTVt
h3day+PLBS74OpN21Wgyopmf0oCANJX+LgySb0eID+Tgnjy7p+rh0f/HjkzMSXjh
kQqWCUUgVqDFWEtqk7AwHZPJwVLljEXFXQ7teLeDGhAjEJ4Ral+apzeS11cNqZdz
U2RPiz2ODXSGwnn61n5bqtYLq3c71b3IrpAGZ9U7u18G/xCZTQOxVzboD1ex+HDb
q1pHwzZZ3T7VeG2HEziURsiqjqS43m1BKI/bv90ghZuaKfSsq5T+oRXENvdHjrLg
q06rn3a+wVuvU5iDSDje3Ioym1lukvp3MfbI4B1m3OKJPtcCKmqjMbmFyNJ9Fy8B
A6U9TF1dpl5aSPYFM6G01OvECXIWLBx9JlhMDGlFwJ8nVGNvULgSUzLoHoDc8f0B
j/co2gSJktyCrMvmcwydAkub7fc4RFWV72VRlCNPaT+nD4Bxn8yYyWy9xrKXgeYg
4vcjqliWP6qzJu/P1REN
=Bjvz
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
