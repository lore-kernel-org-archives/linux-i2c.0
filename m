From: Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Subject: Re: [PATCH] i2c/pnx: Really fix start/stop issue
Date: Tue, 20 Apr 2010 01:03:38 +0100
Message-ID: <20100420000338.GI32401@fluff.org.uk>
References: <1271586070-12266-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1271586070-12266-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Apr 18, 2010 at 12:21:10PM +0200, Wolfram Sang wrote:
> The issue was truly solved by the second patch in this thread:
> 
> http://thread.gmane.org/gmane.linux.drivers.i2c/5436

Looks like i've got this in my i2c next.
 
> Accidently, the first one was picked up. So, this patch adds the
> remaining diff (and an additional newline).
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> 
> Jean, can you pick this up, so it will be correct in 2.6.34?
> 
>  drivers/i2c/busses/i2c-pnx.c |    7 ++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> index 2471033..0853ee1 100644
> --- a/drivers/i2c/busses/i2c-pnx.c
> +++ b/drivers/i2c/busses/i2c-pnx.c
> @@ -173,6 +173,10 @@ static int i2c_pnx_master_xmit(struct i2c_pnx_algo_data *alg_data)
>  		/* We still have something to talk about... */
>  		val = *alg_data->mif.buf++;
>  
> +		/* last byte of a message */
> +		if (alg_data->mif.len == 1)
> +			val |= stop_bit;
> +
>  		alg_data->mif.len--;
>  		iowrite32(val, I2C_REG_TX(alg_data));
>  
> @@ -246,6 +250,9 @@ static int i2c_pnx_master_rcv(struct i2c_pnx_algo_data *alg_data)
>  			__func__);
>  
>  		if (alg_data->mif.len == 1) {
> +			/* Last byte, do not acknowledge next rcv. */
> +			val |= stop_bit;
> +
>  			/*
>  			 * Enable interrupt RFDAIE (data in Rx fifo),
>  			 * and disable DRMIE (need data for Tx)
> -- 
> 1.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
