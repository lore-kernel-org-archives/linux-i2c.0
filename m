From: Biwen Li <biwen.li@nxp.com>
Subject: RE: [v5,2/3] i2c: mux: pca954x: support property idle-state
Date: Fri, 15 Nov 2019 10:21:22 +0000
Message-ID: <DB7PR04MB4490B0121FEED3C74A682C248F700@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20191022041152.3663-1-biwen.li@nxp.com>
 <20191022041152.3663-2-biwen.li@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191022041152.3663-2-biwen.li@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Biwen Li <biwen.li@nxp.com>, "peda@axentia.se" <peda@axentia.se>, Leo Li <leoyang.li@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

Any comments?
If no comments, could you give me a reviewed-by?

Best Regards,
Biwen Li
> This supports property idle-state,if present, overrides i2c-mux-idle-disc=
onnect.
>=20
> My use cases:
> 	- Use the property idle-state to fix
> 	  an errata on LS2085ARDB and LS2088ARDB.
> 	- Errata id: E-00013(board LS2085ARDB and
> 	  LS2088ARDB revision on Rev.B, Rev.C and Rev.D).
> 	- About E-00013:
> 	  - Description: I2C1 and I2C3 buses
> 	    are missing pull-up.
> 	  - Impact: When the PCA954x device is tri-stated, the I2C bus
> 	    will float. This makes the I2C bus and its associated
> 	    downstream devices inaccessible.
> 	  - Hardware fix: Populate resistors R189 and R190 for I2C1
> 	    and resistors R228 and R229 for I2C3.
> 	  - Software fix: Remove the tri-state option from the PCA954x
> 	    driver(PCA954x always on enable status, specify a
> 	    channel zero in dts to fix the errata E-00013).
>=20
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v5:
> 	- add extra precaution for pca954x_init
>=20
> Change in v4:
> 	- rename function
> 	  pca954x_calculate_chan -> pca954x_regval
>=20
> Change in v3:
> 	- update subject and description
> 	- add a helper function pca954x_calculate_chan()
>=20
> Change in v2:
> 	- update subject and description
> 	- add property idle-state
>=20
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 67 +++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c
> b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index 923aa3a5a3dc..218ba1a5ed7e 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -86,7 +86,7 @@ struct pca954x {
>=20
>  	u8 last_chan;		/* last register value */
>  	/* MUX_IDLE_AS_IS, MUX_IDLE_DISCONNECT or >=3D 0 for channel */
> -	s8 idle_state;
> +	s32 idle_state;
>=20
>  	struct i2c_client *client;
>=20
> @@ -229,20 +229,23 @@ static int pca954x_reg_write(struct i2c_adapter
> *adap,
>  				I2C_SMBUS_BYTE, &dummy);
>  }
>=20
> +static u8 pca954x_regval(struct pca954x *data, u8 chan) {
> +	/* We make switches look like muxes, not sure how to be smarter. */
> +	if (data->chip->muxtype =3D=3D pca954x_ismux)
> +		return chan | data->chip->enable;
> +	else
> +		return 1 << chan;
> +}
> +
>  static int pca954x_select_chan(struct i2c_mux_core *muxc, u32 chan)  {
>  	struct pca954x *data =3D i2c_mux_priv(muxc);
>  	struct i2c_client *client =3D data->client;
> -	const struct chip_desc *chip =3D data->chip;
>  	u8 regval;
>  	int ret =3D 0;
>=20
> -	/* we make switches look like muxes, not sure how to be smarter */
> -	if (chip->muxtype =3D=3D pca954x_ismux)
> -		regval =3D chan | chip->enable;
> -	else
> -		regval =3D 1 << chan;
> -
> +	regval =3D pca954x_regval(data, chan);
>  	/* Only select the channel if its different from the last channel */
>  	if (data->last_chan !=3D regval) {
>  		ret =3D pca954x_reg_write(muxc->parent, client, regval); @@ -256,7
> +259,7 @@ static int pca954x_deselect_mux(struct i2c_mux_core *muxc, u32
> chan)  {
>  	struct pca954x *data =3D i2c_mux_priv(muxc);
>  	struct i2c_client *client =3D data->client;
> -	s8 idle_state;
> +	s32 idle_state;
>=20
>  	idle_state =3D READ_ONCE(data->idle_state);
>  	if (idle_state >=3D 0)
> @@ -402,6 +405,25 @@ static void pca954x_cleanup(struct i2c_mux_core
> *muxc)
>  	i2c_mux_del_adapters(muxc);
>  }
>=20
> +static int pca954x_init(struct i2c_client *client, struct pca954x
> +*data) {
> +	int ret;
> +	if (data->idle_state >=3D 0) {
> +		data->last_chan =3D pca954x_regval(data, data->idle_state);
> +	} else {
> +		/* Disconnect multiplexer */
> +		data->last_chan =3D 0;
> +	}
> +	ret =3D i2c_smbus_write_byte(client, data->last_chan);
> +	if (ret < 0) {
> +		data->last_chan =3D 0;
> +		dev_err(&client->dev, "failed to verify the mux, \
> +			the mux maybe not present in fact\n");
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * I2C init/probing/exit functions
>   */
> @@ -411,7 +433,6 @@ static int pca954x_probe(struct i2c_client *client,
>  	struct i2c_adapter *adap =3D client->adapter;
>  	struct device *dev =3D &client->dev;
>  	struct device_node *np =3D dev->of_node;
> -	bool idle_disconnect_dt;
>  	struct gpio_desc *gpio;
>  	struct i2c_mux_core *muxc;
>  	struct pca954x *data;
> @@ -462,23 +483,24 @@ static int pca954x_probe(struct i2c_client *client,
>  		}
>  	}
>=20
> -	/* Write the mux register at addr to verify
> +	data->idle_state =3D MUX_IDLE_AS_IS;
> +	if (of_property_read_u32(np, "idle-state", &data->idle_state)) {
> +		if (np && of_property_read_bool(np, "i2c-mux-idle-disconnect"))
> +			data->idle_state =3D MUX_IDLE_DISCONNECT;
> +	}
> +
> +	/*
> +	 * Write the mux register at addr to verify
>  	 * that the mux is in fact present. This also
> -	 * initializes the mux to disconnected state.
> +	 * initializes the mux to a channel
> +	 * or disconnected state.
>  	 */
> -	if (i2c_smbus_write_byte(client, 0) < 0) {
> +	ret =3D pca954x_init(client, data);
> +	if (ret < 0) {
>  		dev_warn(dev, "probe failed\n");
>  		return -ENODEV;
>  	}
>=20
> -	data->last_chan =3D 0;		   /* force the first selection */
> -	data->idle_state =3D MUX_IDLE_AS_IS;
> -
> -	idle_disconnect_dt =3D np &&
> -		of_property_read_bool(np, "i2c-mux-idle-disconnect");
> -	if (idle_disconnect_dt)
> -		data->idle_state =3D MUX_IDLE_DISCONNECT;
> -
>  	ret =3D pca954x_irq_setup(muxc);
>  	if (ret)
>  		goto fail_cleanup;
> @@ -531,8 +553,7 @@ static int pca954x_resume(struct device *dev)
>  	struct i2c_mux_core *muxc =3D i2c_get_clientdata(client);
>  	struct pca954x *data =3D i2c_mux_priv(muxc);
>=20
> -	data->last_chan =3D 0;
> -	return i2c_smbus_write_byte(client, 0);
> +	return pca954x_init(client, data);
>  }
>  #endif
>=20
> --
> 2.17.1
