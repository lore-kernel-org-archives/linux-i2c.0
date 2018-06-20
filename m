From: Michael Shych <michaelsh@mellanox.com>
Subject: RE: [PATCH 2/5] i2c: mux: mlxcpld: make use of __i2c_smbus_xfer
Date: Wed, 20 Jun 2018 09:11:19 +0000
Message-ID: <DB5PR05MB13204C9C94ADA30ABA1575AAD9770@DB5PR05MB1320.eurprd05.prod.outlook.com>
References: <20180620085157.30121-1-peda@axentia.se>
 <20180620085157.30121-3-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620085157.30121-3-peda@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Vadim Pasternak <vadimp@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, Akinobu Mita <akinobu.mita@gmail.com>, Jean Delvare <jdelvare@suse.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: Peter Rosin [mailto:peda@axentia.se]
> Sent: Wednesday, June 20, 2018 11:52 AM
> To: linux-kernel@vger.kernel.org
> Cc: Peter Rosin <peda@axentia.se>; Wolfram Sang <wsa@the-dreams.de>;
> Vadim Pasternak <vadimp@mellanox.com>; Michael Shych
> <michaelsh@mellanox.com>; Guenter Roeck <linux@roeck-us.net>;
> Akinobu Mita <akinobu.mita@gmail.com>; Jean Delvare
> <jdelvare@suse.com>; linux-i2c@vger.kernel.org
> Subject: [PATCH 2/5] i2c: mux: mlxcpld: make use of __i2c_smbus_xfer
>=20
> This simplifies the code, and you get retries for free if the adapter
> does not support ->master_xfer.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Acked-by: Michael Shych <michaelsh@mellanox.com>

> ---
>  drivers/i2c/muxes/i2c-mux-mlxcpld.c | 28 ++++------------------------
>  1 file changed, 4 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-
> mux-mlxcpld.c
> index 12ad8d65faf6..f2bf3e57ed67 100644
> --- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> +++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> @@ -94,31 +94,11 @@ static int mlxcpld_mux_reg_write(struct i2c_adapter
> *adap,
>  				 struct i2c_client *client, u8 val)
>  {
>  	struct mlxcpld_mux_plat_data *pdata =3D dev_get_platdata(&client-
> >dev);
> -	int ret =3D -ENODEV;
> -
> -	if (adap->algo->master_xfer) {
> -		struct i2c_msg msg;
> -		u8 msgbuf[] =3D {pdata->sel_reg_addr, val};
> -
> -		msg.addr =3D client->addr;
> -		msg.flags =3D 0;
> -		msg.len =3D 2;
> -		msg.buf =3D msgbuf;
> -		ret =3D __i2c_transfer(adap, &msg, 1);
> -
> -		if (ret >=3D 0 && ret !=3D 1)
> -			ret =3D -EREMOTEIO;
> -	} else if (adap->algo->smbus_xfer) {
> -		union i2c_smbus_data data;
> -
> -		data.byte =3D val;
> -		ret =3D adap->algo->smbus_xfer(adap, client->addr,
> -					     client->flags, I2C_SMBUS_WRITE,
> -					     pdata->sel_reg_addr,
> -					     I2C_SMBUS_BYTE_DATA, &data);
> -	}
> +	union i2c_smbus_data data =3D { .byte =3D val };
>=20
> -	return ret;
> +	return __i2c_smbus_xfer(adap, client->addr, client->flags,
> +				I2C_SMBUS_WRITE, pdata->sel_reg_addr,
> +				I2C_SMBUS_BYTE_DATA, &data);
>  }
>=20
>  static int mlxcpld_mux_select_chan(struct i2c_mux_core *muxc, u32 chan)
> --
> 2.11.0
