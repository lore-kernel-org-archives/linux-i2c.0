From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] i2c: imx: Fix reinit_completion() use
Date: Wed, 4 Jul 2018 09:03:42 +0200
Message-ID: <20180704070342.pgnjjffk34nkloob@pengutronix.de>
References: <20180523095623.3347-1-esben.haabendal@gmail.com>
 <20180523095623.3347-2-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180523095623.3347-2-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben.haabendal@gmail.com>
Cc: linux-i2c@vger.kernel.org, Esben Haabendal <eha@deif.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Phil Reid <preid@electromag.com.au>, Philipp Zabel <p.zabel@pengutronix.de>, Lucas Stach <l.stach@pengutronix.de>, Clemens Gruber <clemens.gruber@pqgruber.com>, Michail Georgios Etairidis <m.etairidis@beck-ipc.com>, linux-kernel@vger.kernel.org, Yuan Yao <yao.yuan@freescale.com>, linux-imx@nxp.com
List-Id: linux-i2c@vger.kernel.org

Cc += Yuan Yao who authored DMA support and the NXP team.

On Wed, May 23, 2018 at 11:56:20AM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> Make sure to call reinit_completion() before dma is started to avoid race
> condition where reinit_compleition() is called after complete() and before

s/compleition/completion/

> wait_for_completion_timeout().

Is this a theoretical problem, or did it trigger on your side?
 
> Signed-off-by: Esben Haabendal <eha@deif.com>
Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver")
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

> ---
>  drivers/i2c/busses/i2c-imx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index d7267dd9c7bf..6fca5e64cffb 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -377,6 +377,7 @@ static int i2c_imx_dma_xfer(struct imx_i2c_struct *i2c_imx,
>  		goto err_desc;
>  	}
>  
> +	reinit_completion(&dma->cmd_complete);
>  	txdesc->callback = i2c_imx_dma_callback;
>  	txdesc->callback_param = i2c_imx;
>  	if (dma_submit_error(dmaengine_submit(txdesc))) {
> @@ -631,7 +632,6 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
>  	 * The first byte must be transmitted by the CPU.
>  	 */
>  	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
> -	reinit_completion(&i2c_imx->dma->cmd_complete);
>  	time_left = wait_for_completion_timeout(
>  				&i2c_imx->dma->cmd_complete,
>  				msecs_to_jiffies(DMA_TIMEOUT));
> @@ -690,7 +690,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
>  	if (result)
>  		return result;
>  
> -	reinit_completion(&i2c_imx->dma->cmd_complete);
>  	time_left = wait_for_completion_timeout(
>  				&i2c_imx->dma->cmd_complete,
>  				msecs_to_jiffies(DMA_TIMEOUT));

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
