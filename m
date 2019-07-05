From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND][PATCH] i2c: imx: add support for I2C_M_STOP flag
Date: Fri, 5 Jul 2019 20:38:48 +0200
Message-ID: <20190705183848.GH4717@kunai>
References: <20190703164732.27973-1-mans@mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VbfcI4OLZ4XW0yH2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190703164732.27973-1-mans@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-i2c@vger.kernel.org


--VbfcI4OLZ4XW0yH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2019 at 05:47:32PM +0100, Mans Rullgard wrote:
> Add support for the I2C_M_STOP flag to the i2c-imx driver.  This allows
> devices requiring a stop between messages to work with this controller.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>

The problem with this driver is that it is unmaintained, sadly :( I'll
cc some people who might be interested...

> ---
>  drivers/i2c/busses/i2c-imx.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 7bd409eaf0ac..a7f801bb5dc9 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -908,10 +908,17 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
> =20
>  	/* read/write data */
>  	for (i =3D 0; i < num; i++) {
> -		if (i =3D=3D num - 1)
> -			is_lastmsg =3D true;
> +		if (is_lastmsg) {
> +			/* previous message had I2C_M_STOP flag set */
> +			temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +			temp |=3D I2CR_MSTA;
> +			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +			result =3D i2c_imx_bus_busy(i2c_imx, 1);
> +			if (result)
> +				goto fail0;
> +		}
> =20
> -		if (i) {
> +		if (i && !is_lastmsg) {
>  			dev_dbg(&i2c_imx->adapter.dev,
>  				"<%s> repeated start\n", __func__);
>  			temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> @@ -921,6 +928,10 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
>  			if (result)
>  				goto fail0;
>  		}
> +
> +		if (i =3D=3D num - 1 || (msgs[i].flags & I2C_M_STOP))
> +			is_lastmsg =3D true;
> +
>  		dev_dbg(&i2c_imx->adapter.dev,
>  			"<%s> transfer message: %d\n", __func__, i);
>  		/* write/read data */
> @@ -948,6 +959,13 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
>  				result =3D i2c_imx_dma_write(i2c_imx, &msgs[i]);
>  			else
>  				result =3D i2c_imx_write(i2c_imx, &msgs[i]);
> +
> +			if (msgs[i].flags & I2C_M_STOP) {
> +				temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +				temp &=3D ~I2CR_MSTA;
> +				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +				i2c_imx_bus_busy(i2c_imx, 0);
> +			}
>  		}
>  		if (result)
>  			goto fail0;
> @@ -1034,7 +1052,7 @@ static int i2c_imx_init_recovery_info(struct imx_i2=
c_struct *i2c_imx,
> =20
>  static u32 i2c_imx_func(struct i2c_adapter *adapter)
>  {
> -	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
> +	return I2C_FUNC_I2C | I2C_FUNC_PROTOCOL_MANGLING | I2C_FUNC_SMBUS_EMUL
>  		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
>  }
> =20
> --=20
> 2.22.0
>=20

--VbfcI4OLZ4XW0yH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0fmTgACgkQFA3kzBSg
KbYFuhAAj9MYxK+S8qvmx1WrRGAWX89jlV0ILVpGjLyNyfkmmDAAm6mWLQ90fw/+
Rc/vc9Af+H7Dh5KFH/ygenR9XmkwSJR2H9bwBeOMPDvFGA4yqCQBh9OathWO1c1m
yvIaE9JuiyUuhibrJaCBROAzVaDA2FdPeXJkC+iadw3A7L28F+45bR9R9Vfu0H5x
JdEMZYp22tJqke8vER+eStnqIZPeNzmFrGfUbMfaIE+CtJ42aYu2+Bk72qTkKlP4
vBKr3WkwkMRYDTCpGdP7Ok1y9RT5Z+AdNK8UZ0+OTtG2AoaheDFt1HWo9igRkTpt
K39PTDG6xWOlR32rwwyxCbM3WYML7nbPLYb/hoCRFPzzn00BvH3KFSFS3SnAqoZ8
qhMn+AGWHQQYllmUjILjaYpeyc0yb+X/4bWBnxV2sInIoLkPrJDSTrdpqTiwndrV
br1hkih2spkX9ijwGmpPTtf9gt9bKEyQ9gVY7dZSkw/79q2n2BTPFjavU5K71nP6
XJxHkEbG2qAUOjBt2cUaCU+3PHmHkojCOKvNPvtnIZooUroek662r2EPexSiuGFX
Z98wCBz9eBVErDgyl5oT4rqJAmxLAtb3hI9/gVZ+daObafKTavIk4UxlqgETrcL3
36/SpelDstpNaVojJcRxUALksKYRqMHc73Q2wQijKnq/5bSQL1E=
=jviJ
-----END PGP SIGNATURE-----

--VbfcI4OLZ4XW0yH2--
