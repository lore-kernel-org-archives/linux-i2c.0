From: Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH] i2c: imx: defer probe if bus recovery GPIOs are not ready
Date: Tue, 27 Sep 2016 18:31:14 +0000
Message-ID: <AM2PR04MB0770E6FB2035B855F216FE108FCC0@AM2PR04MB0770.eurprd04.prod.outlook.com>
References: <20160927001858.11601-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0049.outbound.protection.outlook.com ([104.47.2.49]:42209
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751002AbcI1FF1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Sep 2016 01:05:27 -0400
In-Reply-To: <20160927001858.11601-1-stefan@agner.ch>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>, "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: Stefan Agner [mailto:stefan@agner.ch]
> Sent: Monday, September 26, 2016 7:19 PM
> To: wsa@the-dreams.de
> Cc: Leo Li <leoyang.li@nxp.com>; linux-i2c@vger.kernel.org; u.kleine-
> koenig@pengutronix.de; linux-kernel@vger.kernel.org; Stefan Agner
> <stefan@agner.ch>
> Subject: [PATCH] i2c: imx: defer probe if bus recovery GPIOs are not read=
y
>=20
> Some SoC might load the GPIO driver after the I2C driver and
> using the I2C bus recovery mechanism via GPIOs. In this case
> it is crucial to defer probing if the GPIO request functions
> do so, otherwise the I2C driver gets loaded without recovery
> mechanisms enabled.
>=20
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
> This is an actual issue on NXP Vybrid devices on which the GPIO
> driver gets loaded rather later.
>=20
> --
> Stefan
>=20
>  drivers/i2c/busses/i2c-imx.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 592a8f2..47fc1f1 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1009,10 +1009,13 @@ static int i2c_imx_init_recovery_info(struct
> imx_i2c_struct *i2c_imx,
>  	rinfo->sda_gpio =3D of_get_named_gpio(pdev->dev.of_node, "sda-gpios",
> 0);
>  	rinfo->scl_gpio =3D of_get_named_gpio(pdev->dev.of_node, "scl-gpios",
> 0);
>=20
> -	if (!gpio_is_valid(rinfo->sda_gpio) ||
> -	    !gpio_is_valid(rinfo->scl_gpio) ||
> -	    IS_ERR(i2c_imx->pinctrl_pins_default) ||
> -	    IS_ERR(i2c_imx->pinctrl_pins_gpio)) {
> +	if (rinfo->sda_gpio =3D=3D -EPROBE_DEFER ||
> +	    rinfo->scl_gpio =3D=3D -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (!gpio_is_valid(rinfo->sda_gpio) ||
> +		   !gpio_is_valid(rinfo->scl_gpio) ||
> +		   IS_ERR(i2c_imx->pinctrl_pins_default) ||
> +		   IS_ERR(i2c_imx->pinctrl_pins_gpio)) {
>  		dev_dbg(&pdev->dev, "recovery information incomplete\n");
>  		return 0;
>  	}
> --
> 2.10.0
