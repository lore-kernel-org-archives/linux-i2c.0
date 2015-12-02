From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/4] i2c: at91: add upport for the HOLD field
Date: Wed, 2 Dec 2015 12:01:49 +0100
Message-ID: <565ECF9D.30707@atmel.com>
References: <1449052747-20991-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:40751 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbbLBLBc (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 2 Dec 2015 06:01:32 -0500
In-Reply-To: <1449052747-20991-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, wsa@the-dreams.de, alexandre.belloni@free-electrons.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Le 02/12/2015 11:39, Ludovic Desroches a =E9crit :
> The hold field allows to configure the data hold time which can be se=
t
> with the help of the generic binding 'i2c-sda-hold-time-ns'. This
> feature has been introduced with SAMA5D4 SoC family.
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/i2c/busses/i2c-at91.c | 54 +++++++++++++++++++++++++++++++++=
+++++++---
>  1 file changed, 51 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-a=
t91.c
> index 10835d1..09e1690 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -64,6 +64,7 @@
>  #define	AT91_TWI_IADR		0x000c	/* Internal Address Register */
> =20
>  #define	AT91_TWI_CWGR		0x0010	/* Clock Waveform Generator Reg */
> +#define	AT91_TWI_CWGR_HOLD(x)	(((x) & 0x1f) << 24)

I would have defined MAX_HOLD here and used it in the mask above...


> =20
>  #define	AT91_TWI_SR		0x0020	/* Status Register */
>  #define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
> @@ -110,6 +111,7 @@ struct at91_twi_pdata {
>  	unsigned clk_offset;
>  	bool has_unre_flag;
>  	bool has_alt_cmd;
> +	bool has_hold_field;
>  	struct at_dma_slave dma_slave;
>  };
> =20
> @@ -187,10 +189,13 @@ static void at91_init_twi_bus(struct at91_twi_d=
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
> +
> +#define MAX_HOLD 31

Instead of here ^^

> =20
>  	div =3D max(0, (int)DIV_ROUND_UP(clk_get_rate(dev->clk),
>  				       2 * twi_clk) - offset);
> @@ -204,8 +209,33 @@ static void at91_calc_twi_clock(struct at91_twi_=
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
> +		if (hold > MAX_HOLD) {
> +			dev_warn(dev->dev,
> +				 "HOLD field set to its maximum value (%d instead of %d)\n",
> +				 MAX_HOLD, hold);
> +			hold =3D MAX_HOLD;
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
> @@ -797,6 +827,7 @@ static struct at91_twi_pdata at91rm9200_config =3D=
 {
>  	.clk_offset =3D 3,
>  	.has_unre_flag =3D true,
>  	.has_alt_cmd =3D false,
> +	.has_hold_field =3D false,
>  };
> =20
>  static struct at91_twi_pdata at91sam9261_config =3D {
> @@ -804,6 +835,7 @@ static struct at91_twi_pdata at91sam9261_config =3D=
 {
>  	.clk_offset =3D 4,
>  	.has_unre_flag =3D false,
>  	.has_alt_cmd =3D false,
> +	.has_hold_field =3D false,
>  };
> =20
>  static struct at91_twi_pdata at91sam9260_config =3D {
> @@ -811,6 +843,7 @@ static struct at91_twi_pdata at91sam9260_config =3D=
 {
>  	.clk_offset =3D 4,
>  	.has_unre_flag =3D false,
>  	.has_alt_cmd =3D false,
> +	.has_hold_field =3D false,
>  };
> =20
>  static struct at91_twi_pdata at91sam9g20_config =3D {
> @@ -818,6 +851,7 @@ static struct at91_twi_pdata at91sam9g20_config =3D=
 {
>  	.clk_offset =3D 4,
>  	.has_unre_flag =3D false,
>  	.has_alt_cmd =3D false,
> +	.has_hold_field =3D false,
>  };
> =20
>  static struct at91_twi_pdata at91sam9g10_config =3D {
> @@ -825,6 +859,7 @@ static struct at91_twi_pdata at91sam9g10_config =3D=
 {
>  	.clk_offset =3D 4,
>  	.has_unre_flag =3D false,
>  	.has_alt_cmd =3D false,
> +	.has_hold_field =3D false,
>  };
> =20
>  static const struct platform_device_id at91_twi_devtypes[] =3D {
> @@ -854,6 +889,15 @@ static struct at91_twi_pdata at91sam9x5_config =3D=
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
> @@ -861,6 +905,7 @@ static struct at91_twi_pdata sama5d2_config =3D {
>  	.clk_offset =3D 4,
>  	.has_unre_flag =3D true,
>  	.has_alt_cmd =3D true,
> +	.has_hold_field =3D true,
>  };
> =20
>  static const struct of_device_id atmel_twi_dt_ids[] =3D {
> @@ -883,6 +928,9 @@ static const struct of_device_id atmel_twi_dt_ids=
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

Otherwise it's okay for me.

Bye,
--=20
Nicolas Ferre
