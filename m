From: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] imx/i2c: Make disable_delay a per-device variable
Date: Thu, 02 Apr 2009 14:03:25 +0300
Message-ID: <49D49B7D.6010800@gmail.com>
References: <20090325092625.GA3029@pengutronix.de> <49CA017D.20005@gmail.com> <20090325104357.GB3029@pengutronix.de> <Pine.LNX.4.64.0903282207480.9903@axis700.grange> <d7f267fd0903300048p7caee6e0ne63916b986b132b@mail.gmail.com> <Pine.LNX.4.64.0903301124040.4455@axis700.grange> <20090330095147.GP7861@pengutronix.de> <Pine.LNX.4.64.0903301156060.4455@axis700.grange> <49D08AE4.1090102@gmail.com> <Pine.LNX.4.64.0903301548570.4455@axis700.grange> <20090330145409.GD3058@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-13; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090330145409.GD3058-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <public-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>
Cc: Guennadi Liakhovetski <public-g.liakhovetski-Mmb7MZpHnFY-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>, Sascha Hauer <public-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>, public-linux-i2c-u79uwXL29TY76Z2rM5mHXA-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org, Ben Dooks <public-ben-linux-elnMNo+KYs3YtjvyW6yDsg-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



Wolfram Sang wrote:
> On Mon, Mar 30, 2009 at 03:50:28PM +0200, Guennadi Liakhovetski wrote:
> 
>> Ok, I just was informed, that there is a hardware bug on the board I am 
>> using. So, please ignore my objections. Sorry for the wasted time.
> 
> Well, not completely wasted: We found a bug :) Patch follows, Ben can
> you add it?
> 
> Regards,
> 
>    Wolfram
> 
> ===
> 
> 'disable_delay' was static which is wrong as it is calculated using the per-device
> bus speed. This patch turns 'disable_delay' into a per-device variable.
> 
> Reported-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> ---


Maybe I'm to late, but:
Acked-by: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


>  drivers/i2c/busses/i2c-imx.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> Index: .kernel/drivers/i2c/busses/i2c-imx.c
> ===================================================================
> --- .kernel.orig/drivers/i2c/busses/i2c-imx.c
> +++ .kernel/drivers/i2c/busses/i2c-imx.c
> @@ -86,8 +86,6 @@
>  /** Variables ******************************************************************
>  *******************************************************************************/
>  
> -static unsigned int disable_delay;	/* Dummy delay */
> -
>  /*
>   * sorted list of clock divider, register value pairs
>   * taken from table 26-5, p.26-9, Freescale i.MX
> @@ -121,6 +119,7 @@ struct imx_i2c_struct {
>  	int			irq;
>  	wait_queue_head_t	queue;
>  	unsigned long		i2csr;
> +	unsigned int 		disable_delay;
>  };
>  
>  /** Functions for IMX I2C adapter driver ***************************************
> @@ -212,7 +211,7 @@ static void i2c_imx_stop(struct imx_i2c_
>  	 * This delay caused by an i.MXL hardware bug.
>  	 * If no (or too short) delay, no "STOP" bit will be generated.
>  	 */
> -	udelay(disable_delay);
> +	udelay(i2c_imx->disable_delay);
>  	/* Disable I2C controller */
>  	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
>  }
> @@ -243,7 +242,7 @@ static void __init i2c_imx_set_clk(struc
>  	 * This delay is used in I2C bus disable function
>  	 * to fix chip hardware bug.
>  	 */
> -	disable_delay = (500000U * i2c_clk_div[i][0]
> +	i2c_imx->disable_delay = (500000U * i2c_clk_div[i][0]
>  		+ (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
>  
>  	/* dev_dbg() can't be used, because adapter is not yet registered */
> 
