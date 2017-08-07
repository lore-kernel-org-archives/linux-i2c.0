From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: imx: Remove a useless test in
 'i2c_imx_init_recovery_info()'
Date: Mon, 7 Aug 2017 08:36:17 +0200
Message-ID: <20170807063617.5wr4i7b7k72uyrit@pengutronix.de>
References: <20170806234953.30682-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53255 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751301AbdHGGgT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Aug 2017 02:36:19 -0400
Content-Disposition: inline
In-Reply-To: <20170806234953.30682-1-christophe.jaillet@wanadoo.fr>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On Mon, Aug 07, 2017 at 01:49:53AM +0200, Christophe JAILLET wrote:
> 'devm_pinctrl_get()' never returns NULL, so this test can be simplified.

That's wrong. If CONFIG_PINCTRL is disabled devm_pinctrl_get returns
NULL. But I think this shouldn't be considered an error, so your change
is right, just the commit log is not.

> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 54a47b40546f..7e84662fe1c0 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -997,7 +997,7 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
>  	struct i2c_bus_recovery_info *rinfo = &i2c_imx->rinfo;
>  
>  	i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
> -	if (!i2c_imx->pinctrl || IS_ERR(i2c_imx->pinctrl)) {
> +	if (IS_ERR(i2c_imx->pinctrl)) {
>  		dev_info(&pdev->dev, "can't get pinctrl, bus recovery not supported\n");
>  		return PTR_ERR(i2c_imx->pinctrl);
>  	}

Side note: I'm not sure, this construct is valid. IIRC PTR_ERR should
only be called for values x where IS_ERR(x) is true. Here it is at least
surprising that an message hints to a problem but the return code is 0.

@Julia: I'm sure coccinelle can find more of those?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
