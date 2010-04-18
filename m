From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/pnx: Really fix start/stop issue
Date: Sun, 18 Apr 2010 13:04:57 +0200
Message-ID: <20100418130457.0341efce@hyperion.delvare>
References: <1271586070-12266-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1271586070-12266-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Sun, 18 Apr 2010 12:21:10 +0200, Wolfram Sang wrote:
> The issue was truly solved by the second patch in this thread:
> 
> http://thread.gmane.org/gmane.linux.drivers.i2c/5436
> 
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

i2c-pnx is for an embedded platform -> this is for Ben.

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


-- 
Jean Delvare
