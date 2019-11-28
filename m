From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH] i2c: imx: Defer probing if EDMA not available
Date: Thu, 28 Nov 2019 10:06:13 +0000
Message-ID: <20191128100613.GI25745@shell.armlinux.org.uk>
References: <20191127071136.5240-1-peng.ma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191127071136.5240-1-peng.ma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Ma <peng.ma@nxp.com>
Cc: "linux@rempel-privat.de" <linux@rempel-privat.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 27, 2019 at 07:12:09AM +0000, Peng Ma wrote:
> EDMA may be not available or defered due to dependencies on
> other modules, If these scenarios is encountered, we should
> defer probing.

This has been tried before in this form, and it causes regressions.

> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 40111a3..c2b0693 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -369,8 +369,8 @@ static void i2c_imx_reset_regs(struct imx_i2c_struct *i2c_imx)
>  }
>  
>  /* Functions for DMA support */
> -static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
> -						dma_addr_t phy_addr)
> +static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
> +			       dma_addr_t phy_addr)
>  {
>  	struct imx_i2c_dma *dma;
>  	struct dma_slave_config dma_sconfig;
> @@ -379,7 +379,7 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
>  
>  	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
>  	if (!dma)
> -		return;
> +		return -ENOMEM;
>  
>  	dma->chan_tx = dma_request_chan(dev, "tx");
>  	if (IS_ERR(dma->chan_tx)) {
> @@ -424,7 +424,7 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
>  	dev_info(dev, "using %s (tx) and %s (rx) for DMA transfers\n",
>  		dma_chan_name(dma->chan_tx), dma_chan_name(dma->chan_rx));
>  
> -	return;
> +	return 0;
>  
>  fail_rx:
>  	dma_release_channel(dma->chan_rx);
> @@ -432,6 +432,8 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
>  	dma_release_channel(dma->chan_tx);
>  fail_al:
>  	devm_kfree(dev, dma);
> +
> +	return ret;

Some platforms don't have EDMA.  Doesn't this force everyone who wants
I2C to have DMA?  The last attempt at this had:

	/* return successfully if there is no dma support */
	return ret == -ENODEV ? 0 : ret;

here because of exactly this.

>  }
>  
>  static void i2c_imx_dma_callback(void *arg)
> @@ -1605,10 +1607,14 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
>  
>  	/* Init DMA config if supported */
> -	i2c_imx_dma_request(i2c_imx, phy_addr);
> +	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
> +	if (ret == -EPROBE_DEFER)
> +		goto i2c_adapter_remove;

This happens _after_ the adapter has been published to the rest of the
kernel.  Claiming resources after publication is racy - the adapter may
be in use by a request at this point.  Secondly, there's been problems
with this causing regressions when EDMA is built as a module and i2c-imx
is built-in.

See e8c220fac415 ("Revert "i2c: imx: improve the error handling in
i2c_imx_dma_request()"") when exactly what you're proposing was tried
and ended up having to be reverted.

AFAIK nothing has changed since, so merely reinstating the known to be
broken code, thereby reintroducing the same (and more) problems, isn't
going to be acceptable.

Sorry, but this gets a big NAK from me.

>  
>  	return 0;   /* Return OK */
>  
> +i2c_adapter_remove:
> +	i2c_del_adapter(&i2c_imx->adapter);
>  clk_notifier_unregister:
>  	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
>  rpm_disable:
> -- 
> 2.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
