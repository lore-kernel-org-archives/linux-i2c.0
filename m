From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [PATCH] i2c: mux: mlxcpld: fix i2c mux selection caching
Date: Sat, 17 Dec 2016 20:56:38 +0000
Message-ID: <AM5PR0501MB2097346D3C241CE9D1847FFFA29F0@AM5PR0501MB2097.eurprd05.prod.outlook.com>
References: <1482006551-23108-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482006551-23108-1-git-send-email-peda@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Michael Shych <michaelsh@mellanox.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: Peter Rosin [mailto:peda@axentia.se]
> Sent: Saturday, December 17, 2016 10:29 PM
> To: linux-kernel@vger.kernel.org
> Cc: Peter Rosin <peda@axentia.se>; Vadim Pasternak
> <vadimp@mellanox.com>; Michael Shych <michaelsh@mellanox.com>;
> Wolfram Sang <wsa@the-dreams.de>; linux-i2c@vger.kernel.org
> Subject: [PATCH] i2c: mux: mlxcpld: fix i2c mux selection caching
>=20
> smbus functions return -ve on error, 0 on success.  However,
> __i2c_transfer() have a different return signature - -ve on error, or num=
ber
> of buffers transferred (which may be zero or greater.)
>=20
> The upshot of this is that the sense of the text is reversed when using t=
he
> mux on a bus supporting the master_xfer method: we cache the value and
> never retry if we fail to transfer any buffers, but if we succeed, we cle=
ar the
> cached value
>=20
> Fix this by making mlxcpld_mux_reg_write() return a -ve error code for al=
l
> failure cases, just as was done in commit 7f638c1cb0a1 ("i2c: mux:
> pca954x: fix i2c mux selection caching")
>=20
> This also aligns the implementations of these two muxes in this area.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---

Acked-by: Vadim Pasternak <vadimp@mellanox.com>

>=20
> Hi!
>=20
> I audited the other i2c muxes for similar problems after the recent regre=
ssion
> report for the pca954x driver [1], and found only this.
>=20
> I obviously don't have the hardware to test this patch.
>=20
> Anyway, this driver is probably lower profile than the pca954x, but this =
still
> needs fixing in my opinion...
>=20
> Cheers,
> peda
>=20
> [1] http://www.spinics.net/lists/linux-i2c/msg27586.html
>=20
>  drivers/i2c/muxes/i2c-mux-mlxcpld.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-
> mux-mlxcpld.c
> index 3ab654bbfab5..b7ca249ec9c3 100644
> --- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> +++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> @@ -95,6 +95,7 @@ static int mlxcpld_mux_reg_write(struct i2c_adapter
> *adap,
>  				 struct i2c_client *client, u8 val)  {
>  	struct mlxcpld_mux_plat_data *pdata =3D dev_get_platdata(&client-
> >dev);
> +	int ret =3D -ENODEV;
>=20
>  	if (adap->algo->master_xfer) {
>  		struct i2c_msg msg;
> @@ -104,17 +105,21 @@ static int mlxcpld_mux_reg_write(struct
> i2c_adapter *adap,
>  		msg.flags =3D 0;
>  		msg.len =3D 2;
>  		msg.buf =3D msgbuf;
> -		return __i2c_transfer(adap, &msg, 1);
> +		ret =3D __i2c_transfer(adap, &msg, 1);
> +
> +		if (ret >=3D 0 && ret !=3D 1)
> +			ret =3D -EREMOTEIO;
>  	} else if (adap->algo->smbus_xfer) {
>  		union i2c_smbus_data data;
>=20
>  		data.byte =3D val;
> -		return adap->algo->smbus_xfer(adap, client->addr,
> -					      client->flags, I2C_SMBUS_WRITE,
> -					      pdata->sel_reg_addr,
> -					      I2C_SMBUS_BYTE_DATA, &data);
> -	} else
> -		return -ENODEV;
> +		ret =3D adap->algo->smbus_xfer(adap, client->addr,
> +					     client->flags, I2C_SMBUS_WRITE,
> +					     pdata->sel_reg_addr,
> +					     I2C_SMBUS_BYTE_DATA, &data);
> +	}
> +
> +	return ret;
>  }
>=20
>  static int mlxcpld_mux_select_chan(struct i2c_mux_core *muxc, u32 chan)
> @@ -127,10 +132,7 @@ static int mlxcpld_mux_select_chan(struct
> i2c_mux_core *muxc, u32 chan)
>  	/* Only select the channel if its different from the last channel */
>  	if (data->last_chan !=3D regval) {
>  		err =3D mlxcpld_mux_reg_write(muxc->parent, client, regval);
> -		if (err)
> -			data->last_chan =3D 0;
> -		else
> -			data->last_chan =3D regval;
> +		data->last_chan =3D err < 0 ? 0 : regval;
>  	}
>=20
>  	return err;
> --
> 2.1.4
