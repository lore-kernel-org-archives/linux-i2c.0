From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] i2c: i2c-imx: Use correct function to write to register
Date: Thu, 08 Jun 2017 18:43:48 +0200
Message-ID: <1496940228.17240.10.camel@pengutronix.de>
References: <681500CE65202E47A192754B01DAB4671B16747DB9@SDE12.beckipc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47867 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750914AbdFHQnu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 8 Jun 2017 12:43:50 -0400
In-Reply-To: <681500CE65202E47A192754B01DAB4671B16747DB9@SDE12.beckipc.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michail Georgios Etairidis <m.etairidis@beck-ipc.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "darius.augulis@teltonika.lt" <darius.augulis@teltonika.lt>

Hi Michail,

which kernel is this based on? The change doesn't seem to match the
prototype of imx_i2c_read_reg() and imx_i2c_write_reg() of the upstream
kernel.

Also please fix your mailer to send patches in plain text instead of
HTML.

Regards,
Lucas

Am Donnerstag, den 08.06.2017, 18:34 +0200 schrieb Michail Georgios
Etairidis:
> The i2c-imx driver incorrectly uses readb()/writeb() to read and write
> to the appropriate registers when performing a repeated start. The
> appropriate imx_i2c_read_reg()/imx_i2c_write_reg() functions should be
> used instead. Performing a repeated start results to a kernel panic.
> 
>  
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c
> b/drivers/i2c/busses/i2c-imx.c
> 
> index 95ed1718..988bb620 100644
> 
> --- a/drivers/i2c/busses/i2c-imx.c
> 
> +++ b/drivers/i2c/busses/i2c-imx.c
> 
> @@ -734,9 +734,9 @@ static int i2c_imx_dma_read(struct imx_i2c_struct
> *i2c_imx,
> 
>                                 * the first read operation, otherwise
> the first read cost
> 
>                                 * one extra clock cycle.
> 
>                                 */
> 
> -                              temp = readb(i2c_imx->base +
> IMX_I2C_I2CR);
> 
> +                             temp = imx_i2c_read_reg(i2c_imx->base +
> IMX_I2C_I2CR);
> 
>                                temp |= I2CR_MTX;
> 
> -                              writeb(temp, i2c_imx->base +
> IMX_I2C_I2CR);
> 
> +                             imx_i2c_write_reg(temp, i2c_imx->base +
> IMX_I2C_I2CR);
> 
>                }
> 
>                msgs->buf[msgs->len-1] = imx_i2c_read_reg(i2c_imx,
> IMX_I2C_I2DR);
> 
> @@ -857,9 +857,9 @@ static int i2c_imx_read(struct imx_i2c_struct
> *i2c_imx, struct i2c_msg *msgs, bo
> 
>                                                                 * the
> first read operation, otherwise the first read cost
> 
>                                                                 * one
> extra clock cycle.
> 
>                                                                 */
> 
> -                                                              temp =
> readb(i2c_imx->base + IMX_I2C_I2CR);
> 
> +                                                             temp =
> imx_i2c_read_reg(i2c_imx->base + IMX_I2C_I2CR);
> 
>                                                                temp |=
> I2CR_MTX;
> 
> -
> writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> 
> +
> imx_i2c_write_reg(temp, i2c_imx->base + IMX_I2C_I2CR);
> 
>                                                }
> 
>                                } else if (i == (msgs->len - 2)) {
> 
> 
> dev_dbg(&i2c_imx->adapter.dev,
> 
> 
