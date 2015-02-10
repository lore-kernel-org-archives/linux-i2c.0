From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: at91: fixup return type of
 wait_for_completion_timeout
Date: Tue, 10 Feb 2015 17:39:04 +0100
Message-ID: <20150210163904.GG1962@odux.rfo.atmel.com>
References: <1423411927-32686-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423411927-32686-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Feb 08, 2015 at 11:12:07AM -0500, Nicholas Mc Guire wrote:
> Return type of wait_for_completion_timeout is unsigned long not int. This
> patch adds a timeout variable of appropriate type and fixes up the assignment.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Acked-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Thanks

> ---
> 
> Patch was only compile tested with at91_dt_defconfig
> (implies CONFIG_I2C_AT91=y)
> 
> Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)
> 
>  drivers/i2c/busses/i2c-at91.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 636fd2e..79c6404 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -381,6 +381,7 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
>  static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>  {
>  	int ret;
> +	unsigned long timeout;
>  	bool has_unre_flag = dev->pdata->has_unre_flag;
>  
>  	dev_dbg(dev->dev, "transfer: %s %d bytes.\n",
> @@ -436,9 +437,9 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>  		}
>  	}
>  
> -	ret = wait_for_completion_timeout(&dev->cmd_complete,
> -					     dev->adapter.timeout);
> -	if (ret == 0) {
> +	timeout = wait_for_completion_timeout(&dev->cmd_complete,
> +					      dev->adapter.timeout);
> +	if (timeout == 0) {
>  		dev_err(dev->dev, "controller timed out\n");
>  		at91_init_twi_bus(dev);
>  		ret = -ETIMEDOUT;
> -- 
> 1.7.10.4
> 
