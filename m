From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v4 1/2] i2c: add DMA support for freescale i2c driver
Date: Fri, 4 Apr 2014 16:28:55 +0200
Message-ID: <201404041628.55471.marex@denx.de>
References: <1396579272-19542-1-git-send-email-yao.yuan@freescale.com> <1396579272-19542-2-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1396579272-19542-2-git-send-email-yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday, April 04, 2014 at 04:41:11 AM, Yuan Yao wrote:
> Add dma support for i2c. This function depend on DMA driver.
> You can turn on it by write both the dmas and dma-name properties in dts
> node.
> 
> Signed-off-by: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

[...]

Since you will be fixing that superfluous return 0; (I actually wonder, did you 
really test the driver at all before submitting it?) ...

> +static int i2c_imx_dma_xfer(struct imx_i2c_struct *i2c_imx,
> +					struct i2c_msg *msgs)
> +{
> +	struct imx_i2c_dma *dma = i2c_imx->dma;
> +	struct dma_async_tx_descriptor *txdesc;
> +	struct device *dev = &i2c_imx->adapter.dev;
> +
> +	dma->dma_buf = dma_map_single(dma->chan_using->device->dev, msgs->buf,

Please fix this "noodle" here too, the chain of pointers is quite long, you can 
just define a variable for that.

> +					dma->dma_len, dma->dma_data_dir);
> +	if (dma_mapping_error(dma->chan_using->device->dev, dma->dma_buf)) {
> +		dev_err(dev, "DMA mapping failed\n");
> +		return -EINVAL;
> +	}
> +
> +	txdesc = dmaengine_prep_slave_single(dma->chan_using, dma->dma_buf,
> +					dma->dma_len, dma->dma_transfer_dir,
> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!txdesc) {
> +		dev_err(dev, "Not able to get desc for DMA xfer\n");
> +		dma_unmap_single(dma->chan_using->device->dev, dma->dma_buf,
> +					dma->dma_len, dma->dma_data_dir);
> +		return -EINVAL;
> +	}
> +
> +	txdesc->callback = i2c_imx_dma_callback;
> +	txdesc->callback_param = i2c_imx;
> +	dmaengine_submit(txdesc);
> +	dma_async_issue_pending(dma->chan_using);
> +
> +	return 0;
> +}
[...]

Other than those two things,

Reviewed-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
