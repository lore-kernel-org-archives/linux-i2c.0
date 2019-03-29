From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: imx: don't leak the i2c adapter on error
Date: Fri, 29 Mar 2019 22:08:51 +0100
Message-ID: <20190329210851.gi57f5jamxio3mxr@pengutronix.de>
References: <20190329124817.6717-1-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190329124817.6717-1-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: laurentiu.tudor@nxp.com
Cc: linux-i2c@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-kernel@vger.kernel.org, leoyang.li@nxp.com, linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Oleksij Rempel <o.rempel@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 29, 2019 at 02:48:17PM +0200, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Make sure to free the i2c adapter on the error exit path.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

>  drivers/i2c/busses/i2c-imx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 42fed40198a0..2dfd33f48cd8 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1169,11 +1169,13 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	/* Init DMA config if supported */
>  	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
>  	if (ret < 0)
> -		goto clk_notifier_unregister;
> +		goto del_adapter;
>  
>  	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
>  	return 0;   /* Return OK */
>  
> +del_adapter:
> +	 i2c_del_adapter(&i2c_imx->adapter);

Indention problem here, please remove the superflous space here.

Other than that:

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Fixes: e1ab9a468e3b ("i2c: imx: improve the error handling in i2c_imx_dma_request()")

Thanks
Uwe

>  clk_notifier_unregister:
>  	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
>  rpm_disable:
> -- 
> 2.17.1
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
