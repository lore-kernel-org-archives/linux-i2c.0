From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/4] i2c: at91: add support for the HOLD field
Date: Thu, 3 Dec 2015 11:30:36 +0100
Message-ID: <566019CC.3060005@atmel.com>
References: <1449136434-27619-1-git-send-email-ludovic.desroches@atmel.com>
 <1449136434-27619-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449136434-27619-2-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Le 03/12/2015 10:53, Ludovic Desroches a =E9crit :
> The hold field allows to configure the data hold time which can be se=
t
> with the help of the generic binding 'i2c-sda-hold-time-ns'. This
> feature has been introduced with SAMA5D4 SoC family.
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>


> ---
>  drivers/i2c/busses/i2c-at91.c | 53 +++++++++++++++++++++++++++++++++=
+++++++---
>  1 file changed, 50 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-a=
t91.c
> index 10835d1..921d32b 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -64,6 +64,8 @@
>  #define	AT91_TWI_IADR		0x000c	/* Internal Address Register */
> =20
>  #define	AT91_TWI_CWGR		0x0010	/* Clock Waveform Generator Reg */
> +#define	AT91_TWI_CWGR_HOLD_MAX	0x1f
> +#define	AT91_TWI_CWGR_HOLD(x)	(((x) & AT91_TWI_CWGR_HOLD_MAX) << 24)
> =20
>  #define	AT91_TWI_SR		0x0020	/* Status Register */
>  #define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
> @@ -110,6 +112,7 @@ struct at91_twi_pdata {
>  	unsigned clk_offset;
>  	bool has_unre_flag;
>  	bool has_alt_cmd;
> +	bool has_hold_field;
>  	struct at_dma_slave dma_slave;
>  };
> =20
> @@ -187,10 +190,11 @@ static void at91_init_twi_bus(struct at91_twi_d=
ev *dev)
>   */
>  static void at91_calc_twi_clock(struct at91_twi_dev *dev, int twi_cl=
k)
>  {
> -	int ckdiv, cdiv, div;
> +	int ckdiv, cdiv, div, hold =3D 0;
>  	struct at91_twi_pdata *pdata =3D dev->pdata;
>  	int offset =3D pdata->clk_offset;
>  	int max_ckdiv =3D pdata->clk_max_div;
> +	u32 twd_hold_time_ns =3D 0;
> =20
>  	div =3D max(0, (int)DIV_ROUND_UP(clk_get_rate(dev->clk),
>  				       2 * twi_clk) - offset);
> @@ -204,8 +208,33 @@ static void at91_calc_twi_clock(struct at91_twi_=
dev *dev, int twi_clk)
>  		cdiv =3D 255;
>  	}
> =20
> -	dev->twi_cwgr_reg =3D (ckdiv << 16) | (cdiv << 8) | cdiv;
> -	dev_dbg(dev->dev, "cdiv %d ckdiv %d\n", cdiv, ckdiv);
> +	if (pdata->has_hold_field) {
> +		of_property_read_u32(dev->dev->of_node, "i2c-sda-hold-time-ns",
> +				     &twd_hold_time_ns);
> +
> +		/*
> +		 * hold time =3D HOLD + 3 x T_peripheral_clock
> +		 * Use clk rate in kHz to prevent overflows when computing
> +		 * hold.
> +		 */
> +		hold =3D DIV_ROUND_UP(twd_hold_time_ns
> +				    * (clk_get_rate(dev->clk) / 1000), 1000000);
> +		hold -=3D 3;
> +		if (hold < 0)
> +			hold =3D 0;
> +		if (hold > AT91_TWI_CWGR_HOLD_MAX) {
> +			dev_warn(dev->dev,
> +				 "HOLD field set to its maximum value (%d instead of %d)\n",
> +				 AT91_TWI_CWGR_HOLD_MAX, hold);
> +			hold =3D AT91_TWI_CWGR_HOLD_MAX;
> +		}
> +	}
> +
> +	dev->twi_cwgr_reg =3D (ckdiv << 16) | (cdiv << 8) | cdiv
> +			    | AT91_TWI_CWGR_HOLD(hold);
> +
> +	dev_dbg(dev->dev, "cdiv %d ckdiv %d hold %d (%d ns)\n",
> +		cdiv, ckdiv, hold, twd_hold_time_ns);
>  }
> =20
>  static void at91_twi_dma_cleanup(struct at91_twi_dev *dev)
> @@ -797,6 +826,7 @@ static struct at91_twi_pdata at91rm9200_config =3D=
 {
>  	.clk_offset =3D 3,
>  	.has_unre_flag =3D true,
>  	.has_alt_cmd =3D false,
> +	.has_hold_field =3D false,
>  };
> =20
>  static struct at91_twi_pdata at91sam9261_config =3D {
> @@ -804,6 +834,7 @@ static struct at91_twi_pdata at91sam9261_config =3D=
 {
>  	.clk_offset =3D 4,
>  	.has_unre_flag =3D false,
>  	.has_alt_cmd =3D false,
> +	.has_hold_field =3D false,
>  };
> =20
>  static struct at91_twi_pdata at91sam9260_config =3D {
> @@ -811,6 +842,7 @@ static struct at91_twi_pdata at91sam9260_config =3D=
 {
>  	.clk_offset =3D 4,
>  	.has_unre_flag =3D false,
>  	.has_alt_cmd =3D false,
> +	.has_hold_field =3D false,
>  };
> =20
>  static struct at91_twi_pdata at91sam9g20_config =3D {
> @@ -818,6 +850,7 @@ static struct at91_twi_pdata at91sam9g20_config =3D=
 {
>  	.clk_offset =3D 4,
>  	.has_unre_flag =3D false,
>  	.has_alt_cmd =3D false,
> +	.has_hold_field =3D false,
>  };
> =20
>  static struct at91_twi_pdata at91sam9g10_config =3D {
> @@ -825,6 +858,7 @@ static struct at91_twi_pdata at91sam9g10_config =3D=
 {
>  	.clk_offset =3D 4,
>  	.has_unre_flag =3D false,
>  	.has_alt_cmd =3D false,
> +	.has_hold_field =3D false,
>  };
> =20
>  static const struct platform_device_id at91_twi_devtypes[] =3D {
> @@ -854,6 +888,15 @@ static struct at91_twi_pdata at91sam9x5_config =3D=
 {
>  	.clk_offset =3D 4,
>  	.has_unre_flag =3D false,
>  	.has_alt_cmd =3D false,
> +	.has_hold_field =3D false,
> +};
> +
> +static struct at91_twi_pdata sama5d4_config =3D {
> +	.clk_max_div =3D 7,
> +	.clk_offset =3D 4,
> +	.has_unre_flag =3D false,
> +	.has_alt_cmd =3D false,
> +	.has_hold_field =3D true,
>  };
> =20
>  static struct at91_twi_pdata sama5d2_config =3D {
> @@ -861,6 +904,7 @@ static struct at91_twi_pdata sama5d2_config =3D {
>  	.clk_offset =3D 4,
>  	.has_unre_flag =3D true,
>  	.has_alt_cmd =3D true,
> +	.has_hold_field =3D true,
>  };
> =20
>  static const struct of_device_id atmel_twi_dt_ids[] =3D {
> @@ -883,6 +927,9 @@ static const struct of_device_id atmel_twi_dt_ids=
[] =3D {
>  		.compatible =3D "atmel,at91sam9x5-i2c",
>  		.data =3D &at91sam9x5_config,
>  	}, {
> +		.compatible =3D "atmel,sama5d4-i2c",
> +		.data =3D &sama5d4_config,
> +	}, {
>  		.compatible =3D "atmel,sama5d2-i2c",
>  		.data =3D &sama5d2_config,
>  	}, {
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
