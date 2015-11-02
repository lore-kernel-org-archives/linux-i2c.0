From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [Patch V1] i2c: imx: improve code readability
Date: Mon, 2 Nov 2015 10:29:50 +0100
Message-ID: <20151102092950.GQ4931@pengutronix.de>
References: <1446455130-4704-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37236 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbbKBJ3v (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 2 Nov 2015 04:29:51 -0500
Content-Disposition: inline
In-Reply-To: <1446455130-4704-1-git-send-email-b54642@freescale.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <b54642@freescale.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com

Hello,

On Mon, Nov 02, 2015 at 05:05:30PM +0800, Gao Pan wrote:
> Replace of_get_named_gpio_flags with of_get_named_gpio because
> the latter has less parameters, which improves code readability.
>=20
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> Signed-off-by: Gao Pan <b54642@freescale.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-im=
x.c
> index 1e4d99d..b0fe090 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -996,10 +996,8 @@ static void i2c_imx_init_recovery_info(struct im=
x_i2c_struct *i2c_imx,
>  			PINCTRL_STATE_DEFAULT);
>  	i2c_imx->pinctrl_pins_gpio =3D pinctrl_lookup_state(i2c_imx->pinctr=
l,
>  			"gpio");
> -	rinfo->sda_gpio =3D of_get_named_gpio_flags(pdev->dev.of_node,
> -			"sda-gpios", 0, NULL);
> -	rinfo->scl_gpio =3D of_get_named_gpio_flags(pdev->dev.of_node,
> -			"scl-gpios", 0, NULL);
> +	rinfo->sda_gpio =3D of_get_named_gpio(pdev->dev.of_node, "sda-gpios=
", 0);
> +	rinfo->scl_gpio =3D of_get_named_gpio(pdev->dev.of_node, "scl-gpios=
", 0);

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
