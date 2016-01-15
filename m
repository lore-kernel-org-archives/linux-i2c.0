From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3] i2c: imx: make bus recovery through pinctrl optional
Date: Fri, 15 Jan 2016 08:53:56 +0100
Message-ID: <20160115075356.GI24441@pengutronix.de>
References: <1452842844-16256-1-git-send-email-leoyang.li@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40744 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751105AbcAOHyA (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 15 Jan 2016 02:54:00 -0500
Content-Disposition: inline
In-Reply-To: <1452842844-16256-1-git-send-email-leoyang.li@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Li Yang <leoyang.li@nxp.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Gao Pan <pandy.gao@nxp.com>

Hello,

On Fri, Jan 15, 2016 at 01:27:24AM -0600, Li Yang wrote:
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-im=
x.c
> index a2b132c..1239bfa 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1081,8 +1081,11 @@ static int i2c_imx_probe(struct platform_devic=
e *pdev)
>  		return ret;
>  	}
> =20
> +	/* optional bus recovery feature through pinctrl */
>  	i2c_imx->pinctrl =3D devm_pinctrl_get(&pdev->dev);
> -	if (IS_ERR(i2c_imx->pinctrl)) {
> +	/* bailout on -ENOMEM or -EPROBE_DEFER, continue for other errors *=
/
> +	if (PTR_ERR(i2c_imx->pinctrl) =3D=3D -ENOMEM ||
> +			PTR_ERR(i2c_imx->pinctrl) =3D=3D -EPROBE_DEFER) {
>  		ret =3D PTR_ERR(i2c_imx->pinctrl);
>  		goto clk_disable;
>  	}
> @@ -1125,7 +1128,10 @@ static int i2c_imx_probe(struct platform_devic=
e *pdev)
>  			i2c_imx, IMX_I2C_I2CR);
>  	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2=
C_I2SR);
> =20
> -	i2c_imx_init_recovery_info(i2c_imx, pdev);
> +	if (IS_ERR_OR_NULL(i2c_imx->pinctrl))

I'd prefer to set i2c_imx->pinctrl to NULL if it's not used and then us=
e

	if (!i2c_imx->pinctrl)

here. (Or maybe make i2c_imx_init_recovery_info aware of this situation
to keep the caller simple?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
