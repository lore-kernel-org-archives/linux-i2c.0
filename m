From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 1/3] i2c: imx: Fix race condition in dma read
Date: Thu, 16 Aug 2018 10:27:17 +0200
Message-ID: <20180816082717.tnoslzw4hwuanvxp@pengutronix.de>
References: <20180809123207.9732-1-esben.haabendal@gmail.com>
 <20180809123207.9732-2-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180809123207.9732-2-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben.haabendal@gmail.com>
Cc: linux-i2c@vger.kernel.org, Esben Haabendal <eha@deif.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Peter Rosin <peda@axentia.se>, Wei Jinhua <wei.jinhua1@zte.com.cn>, Phil Reid <preid@electromag.com.au>, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 09, 2018 at 02:32:05PM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> This fixes a race condition, where the DMAEN bit ends up being set after
> I2C slave has transmitted a byte following the dummy read.  When that
> happens, an interrupt is generated instead, and no DMA request is generated
> to kickstart the DMA read, and a timeout happens after DMA_TIMEOUT (1 sec).
> 
> Fixed by setting the DMAEN bit before the dummy read.
> 
> Signed-off-by: Esben Haabendal <eha@deif.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 498c5e891649..f7bd6c21da27 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -668,9 +668,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
>  	struct imx_i2c_dma *dma = i2c_imx->dma;
>  	struct device *dev = &i2c_imx->adapter.dev;
>  
> -	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> -	temp |= I2CR_DMAEN;
> -	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>  
>  	dma->chan_using = dma->chan_rx;
>  	dma->dma_transfer_dir = DMA_DEV_TO_MEM;
> @@ -809,6 +806,8 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
>  	 */
>  	if ((msgs->len - 1) || block_data)
>  		temp &= ~I2CR_TXAK;
> +	if (i2c_imx->dma && msgs->len >= DMA_THRESHOLD && !block_data)
> +		temp |= I2CR_DMAEN;

Instead of duplicating the if condition I'd do:

	int use_dma = i2c_imx->dma && msgs->len >= DMA_THRESHOLD && !block_data;

and then simplify the two conditions to just "use_dma".

With this changed you can add my Ack.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
