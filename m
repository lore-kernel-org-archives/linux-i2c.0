From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: imx: add retries for i2c-0 on Ventana boards
Date: Fri, 8 Jul 2016 08:28:46 +0200
Message-ID: <20160708062846.GI16643@pengutronix.de>
References: <1467900229-5262-1-git-send-email-tharvey@gateworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56401 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751299AbcGHG2u (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Jul 2016 02:28:50 -0400
Content-Disposition: inline
In-Reply-To: <1467900229-5262-1-git-send-email-tharvey@gateworks.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Fabio Estevam <fabio.estevam@freescale.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Tim,

On Thu, Jul 07, 2016 at 07:03:49AM -0700, Tim Harvey wrote:
> Gateworks Ventana IMX6 based boards have a Gateworks System Controlle=
r [1]
> (gsc) device that can NAK i2c transactions when its busy in an ADC lo=
op. As
> this is always on i2c-0 we will add retries for that bus for any Vent=
ana
> board.

The right thing is to fix the drivers IMHO.

> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-im=
x.c
> index 1844bc9..aec71c3 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -460,6 +460,8 @@ static int i2c_imx_acked(struct imx_i2c_struct *i=
2c_imx)
>  {
>  	if (imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR) & I2SR_RXAK) {
>  		dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK\n", __func__);
> +		if (i2c_imx->adapter.retries)
> +			return -EAGAIN;

This is wrong, struct i2c_adapter::retries is for restarting a transfer
on arbitration loss.

>  		return -ENXIO;  /* No ACK */
>  	}
> =20
> @@ -1068,6 +1070,16 @@ static int i2c_imx_probe(struct platform_devic=
e *pdev)
>  	i2c_imx->adapter.dev.of_node	=3D pdev->dev.of_node;
>  	i2c_imx->base			=3D base;
> =20
> +	/*
> +	 * The Gateworks Ventana has an i2c based system controller on i2c-=
0
> +	 * which emulates several standard i2c devices with existing driver=
s.
> +	 * That device can NAK when its in an ADC loop. Add bus retries.
> +	 */
> +	if (of_machine_is_compatible("gw,ventana") && phy_addr =3D=3D 0x021=
a0000) {

Please don't. If you want to do handle a device in a special way, inven=
t
a device tree property, add it to your machine description and add
handling here. Using of_machine_is_compatible + base address of the
device to decide about configuration is a no go.

> +		dev_info(&pdev->dev, "Adding retries for Ventana GSC\n");
> +		i2c_imx->adapter.retries =3D 3;
> +	}
> +

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
