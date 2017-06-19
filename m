From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: i2c-imx: Use correct function to write to register
Date: Mon, 19 Jun 2017 20:54:16 +0200
Message-ID: <20170619185416.owrkfcbvutbhdrmo@pengutronix.de>
References: <681500CE65202E47A192754B01DAB4671B16747E36@SDE12.beckipc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37343 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751012AbdFSSyT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 19 Jun 2017 14:54:19 -0400
Content-Disposition: inline
In-Reply-To: <681500CE65202E47A192754B01DAB4671B16747E36@SDE12.beckipc.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michail Georgios Etairidis <m.etairidis@beck-ipc.com>
Cc: lst@pengutronix.de, linux-i2c@vger.kernel.org, kernel@pengutronix.de, Fugang Duan <B38611@freescale.com>, Yuan Yao <yao.yuan@freescale.com>

On Fri, Jun 09, 2017 at 03:28:12PM +0200, Michail Georgios Etairidis wrote:
> The i2c-imx driver incorrectly uses readb()/writeb() to read and write to the appropriate registers when performing a repeated start. The appropriate imx_i2c_read_reg()/imx_i2c_write_reg() functions should be used instead. Performing a repeated start results in a kernel panic.

please limit lines in the commit to 76 chars.

> I am resubmitting this patch as the previous one was erroneous. This patch is based on the current upstream kernel code.
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 95ed171..54a47b4 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -734,9 +734,9 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
>  		 * the first read operation, otherwise the first read cost
>  		 * one extra clock cycle.
>  		 */
> -		temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> +		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>  		temp |= I2CR_MTX;
> -		writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> +		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);

These were introduced by commit ce1a78840ff7a authored by Yao Yuan.

>  	}
>  	msgs->buf[msgs->len-1] = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
>  
> @@ -857,9 +857,9 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
>  				 * the first read operation, otherwise the first read cost
>  				 * one extra clock cycle.
>  				 */
> -				temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> +				temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>  				temp |= I2CR_MTX;
> -				writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> +				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);

These were introduced by commit 054b62d9f25c9 authored by Fugang Duan.

I added these two people to Cc:, maybe they are still at Freescale/NXP
and can comment.

	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);

results in

	readb(i2c_imx->base + (reg << i2c_imx->hwdata->regshift));

where .regshift is 2 for imx and 0 for vf610. So the patch makes a
difference on the former platforms only.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
