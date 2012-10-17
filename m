From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] i2c: at91: add dma support
Date: Wed, 17 Oct 2012 09:38:29 +0100
Message-ID: <20121017083828.GJ21164@n2100.arm.linux.org.uk>
References: <1349876587-31182-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1349876587-31182-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 10, 2012 at 03:43:07PM +0200, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
> +	txdesc = chan_tx->device->device_prep_slave_sg(chan_tx, &dma->sg,
> +		1, DMA_TO_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK, NULL);

No, a while back the DMA engine API changed.  It no longer takes
DMA_TO_DEVICE/DMA_FROM_DEVICE but DMA_MEM_TO_DEV and DMA_DEV_TO_MEM.

> +	/* Keep in mind that we won't use dma to read the last two bytes */
> +	at91_twi_irq_save(dev);
> +	dma_addr = dma_map_single(dev->dev, dev->buf, dev->buf_len - 2,
> +				  DMA_FROM_DEVICE);

Ditto.

> +	dma->xfer_in_progress = true;
> +	cookie = rxdesc->tx_submit(rxdesc);
> +	if (dma_submit_error(cookie)) {

tx_submit never errors (anymore.)

> +	slave_config.direction = DMA_TO_DEVICE;

Same comment as for the other directions.  Note that DMA engine drivers
really should ignore this parameter now, and DMA engine users should phase
it out.

> +	if (dmaengine_slave_config(dma->chan_tx, &slave_config)) {
> +		dev_err(dev->dev, "failed to configure tx channel\n");
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	slave_config.direction = DMA_FROM_DEVICE;

Ditto.
