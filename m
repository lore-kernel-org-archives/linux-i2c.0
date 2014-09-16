From: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-ismt: use correct length when copy buffer
Date: Tue, 16 Sep 2014 06:18:59 -0400
Message-ID: <20140916101859.GC3792@hmsreliant.think-freely.org>
References: <1410859264-7118-1-git-send-email-fan.du@intel.com>
 <1410859264-7118-3-git-send-email-fan.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410859264-7118-3-git-send-email-fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fan Du <fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, fengyuleidian0615-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 16, 2014 at 05:21:04PM +0800, Fan Du wrote:
> In block write mode, when encapsulating dma_buffer, first element is
> 'command', the rest is data buffer, so only copy actual data buffer
> starting from block[1] with the size indicating by block[0].
> 
> Signed-off-by: Fan Du <fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-ismt.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
> index 8a0275c..3f6ecbf 100644
> --- a/drivers/i2c/busses/i2c-ismt.c
> +++ b/drivers/i2c/busses/i2c-ismt.c
> @@ -497,7 +497,7 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
>  			desc->wr_len_cmd = dma_size;
>  			desc->control |= ISMT_DESC_BLK;
>  			priv->dma_buffer[0] = command;
> -			memcpy(&priv->dma_buffer[1], &data->block[1], dma_size);
> +			memcpy(&priv->dma_buffer[1], &data->block[1], dma_size - 1);
>  		} else {
>  			/* Block Read */
>  			dev_dbg(dev, "I2C_SMBUS_BLOCK_DATA:  READ\n");
> @@ -525,7 +525,7 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
>  			desc->wr_len_cmd = dma_size;
>  			desc->control |= ISMT_DESC_I2C;
>  			priv->dma_buffer[0] = command;
> -			memcpy(&priv->dma_buffer[1], &data->block[1], dma_size);
> +			memcpy(&priv->dma_buffer[1], &data->block[1], dma_size - 1);
>  		} else {
>  			/* i2c Block Read */
>  			dev_dbg(dev, "I2C_SMBUS_I2C_BLOCK_DATA:  READ\n");
> -- 
> 1.7.9.5
> 
> 

Acked-by: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
