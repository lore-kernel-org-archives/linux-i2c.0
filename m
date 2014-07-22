From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drivers/i2c/busses: use correct type for
 dma_map/unmap
Date: Tue, 22 Jul 2014 11:13:28 +0200
Message-ID: <20140722091328.GD2349@ldesroches-Latitude-E6320>
References: <1405935725-10457-1-git-send-email-wsa@the-dreams.de>
 <1405935725-10457-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405935725-10457-2-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 21, 2014 at 11:42:03AM +0200, Wolfram Sang wrote:
> dma_{un}map_* uses 'enum dma_data_direction' not 'enum dma_transfer_direction'.
> 
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Acked-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Thanks Wolfram.

> ---
>  drivers/i2c/busses/i2c-at91.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index e95f9ba96790..83c989382be9 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -210,7 +210,7 @@ static void at91_twi_write_data_dma_callback(void *data)
>  	struct at91_twi_dev *dev = (struct at91_twi_dev *)data;
>  
>  	dma_unmap_single(dev->dev, sg_dma_address(&dev->dma.sg),
> -			 dev->buf_len, DMA_MEM_TO_DEV);
> +			 dev->buf_len, DMA_TO_DEVICE);
>  
>  	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
>  }
> @@ -289,7 +289,7 @@ static void at91_twi_read_data_dma_callback(void *data)
>  	struct at91_twi_dev *dev = (struct at91_twi_dev *)data;
>  
>  	dma_unmap_single(dev->dev, sg_dma_address(&dev->dma.sg),
> -			 dev->buf_len, DMA_DEV_TO_MEM);
> +			 dev->buf_len, DMA_FROM_DEVICE);
>  
>  	/* The last two bytes have to be read without using dma */
>  	dev->buf += dev->buf_len - 2;
> -- 
> 2.0.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
