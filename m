From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: Re: [PATCH 1/2] i2c: at91: add DT property for the HOLD field of
 TWIHS_CWGR
Date: Wed, 30 Sep 2015 11:01:02 +0200
Message-ID: <560BA4CE.70606@atmel.com>
References: <1443602831-27069-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:35685 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbbI3JBI (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 30 Sep 2015 05:01:08 -0400
In-Reply-To: <1443602831-27069-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, wsa@the-dreams.de
Cc: devicetree@vger.kernel.org, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi all,

it looks good to me.

Le 30/09/2015 10:47, Ludovic Desroches a =E9crit :
> From: Wenyou Yang <wenyou.yang@atmel.com>
>=20
> Add the HOLD field setting in order to support I2C slave devices whic=
h need
> a longer hold time of the data.
> Since it depends on the slave devices connected to the bus, add a DT
> property "atmel,twd-hold-cycles" to specify this HOLD field.
>=20
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

> ---
>  drivers/i2c/busses/i2c-at91.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-a=
t91.c
> index 1c758cd..06e66ef 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -64,6 +64,7 @@
>  #define	AT91_TWI_IADR		0x000c	/* Internal Address Register */
> =20
>  #define	AT91_TWI_CWGR		0x0010	/* Clock Waveform Generator Reg */
> +#define	AT91_TWI_CWGR_HOLD(x)	(((x) & 0x1f) << 24)
> =20
>  #define	AT91_TWI_SR		0x0020	/* Status Register */
>  #define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
> @@ -185,7 +186,8 @@ static void at91_init_twi_bus(struct at91_twi_dev=
 *dev)
>   * Calculate symmetric clock as stated in datasheet:
>   * twi_clk =3D F_MAIN / (2 * (cdiv * (1 << ckdiv) + offset))
>   */
> -static void at91_calc_twi_clock(struct at91_twi_dev *dev, int twi_cl=
k)
> +static void at91_calc_twi_clock(struct at91_twi_dev *dev,
> +				int twi_clk, u32 twd_hold)
>  {
>  	int ckdiv, cdiv, div;
>  	struct at91_twi_pdata *pdata =3D dev->pdata;
> @@ -204,7 +206,9 @@ static void at91_calc_twi_clock(struct at91_twi_d=
ev *dev, int twi_clk)
>  		cdiv =3D 255;
>  	}
> =20
> -	dev->twi_cwgr_reg =3D (ckdiv << 16) | (cdiv << 8) | cdiv;
> +	dev->twi_cwgr_reg =3D (ckdiv << 16) | (cdiv << 8) | cdiv
> +			    | AT91_TWI_CWGR_HOLD(twd_hold);
> +
>  	dev_dbg(dev->dev, "cdiv %d ckdiv %d\n", cdiv, ckdiv);
>  }
> =20
> @@ -936,6 +940,7 @@ static int at91_twi_probe(struct platform_device =
*pdev)
>  	int rc;
>  	u32 phy_addr;
>  	u32 bus_clk_rate;
> +	u32 twd_hold_cycles;
> =20
>  	dev =3D devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
>  	if (!dev)
> @@ -992,7 +997,12 @@ static int at91_twi_probe(struct platform_device=
 *pdev)
>  	if (rc)
>  		bus_clk_rate =3D DEFAULT_TWI_CLK_HZ;
> =20
> -	at91_calc_twi_clock(dev, bus_clk_rate);
> +	rc =3D of_property_read_u32(dev->dev->of_node,
> +				  "atmel,twd-hold-cycles", &twd_hold_cycles);
> +	if (rc)
> +		twd_hold_cycles =3D 0;
> +
> +	at91_calc_twi_clock(dev, bus_clk_rate, twd_hold_cycles);
>  	at91_init_twi_bus(dev);
> =20
>  	snprintf(dev->adapter.name, sizeof(dev->adapter.name), "AT91");
>=20
