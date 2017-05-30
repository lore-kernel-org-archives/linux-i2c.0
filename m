From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH] i2c: rcar: use correct length when unmapping DMA
Date: Tue, 30 May 2017 06:49:49 +0200
Message-ID: <20170530044949.GA7484@bigcity.dyn.berto.se>
References: <20170528075217.1214-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34474 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdE3Etw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 30 May 2017 00:49:52 -0400
Received: by mail-lf0-f44.google.com with SMTP id 99so42570083lfu.1
        for <linux-i2c@vger.kernel.org>; Mon, 29 May 2017 21:49:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170528075217.1214-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On 2017-05-28 09:52:17 +0200, Wolfram Sang wrote:
> Because we need to transfer some bytes with PIO, the msg length is not
> the length of the DMA buffer. Use the correct value which we used when
> doing the mapping.
> 
> Fixes: 73e8b0528346e8 ("i2c: rcar: add DMA support")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/i2c/busses/i2c-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 214bf2835d1f95..8be3e6cb8fe686 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -319,7 +319,7 @@ static void rcar_i2c_dma_unmap(struct rcar_i2c_priv *priv)
>  	rcar_i2c_write(priv, ICFBSCR, TCYC06);
>  
>  	dma_unmap_single(chan->device->dev, sg_dma_address(&priv->sg),
> -			 priv->msg->len, priv->dma_direction);
> +			 sg_dma_len(&priv->sg), priv->dma_direction);
>  
>  	priv->dma_direction = DMA_NONE;
>  }
> -- 
> 2.11.0
> 

-- 
Regards,
Niklas Söderlund
