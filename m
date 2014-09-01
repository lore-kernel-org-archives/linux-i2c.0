From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c:at91: Fix a race condition during signal handling in
 at91_do_twi_xfer.
Date: Mon, 1 Sep 2014 11:07:16 +0200
Message-ID: <20140901090715.GS4434@ldesroches-Latitude-E6320>
References: <1409080404-19069-1-git-send-email-simon@aqwary.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409080404-19069-1-git-send-email-simon-IfRblWqrl23QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Lindgren <simon-IfRblWqrl23QT0dZR+AlfA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 26, 2014 at 09:13:24PM +0200, Simon Lindgren wrote:
> There is a race condition in at91_do_twi_xfer when signals arrive.
> If a signal is recieved while waiting for a transfer to complete
> wait_for_completion_interruptible_timeout() will return -ERESTARTSYS.
> This is not handled correctly resulting in interrupts still being
> enabled and a transfer being in flight when we return.
> 
> Symptoms include a range of oopses and bus lockups. Oopses can happen
> when the transfer completes because the interrupt handler will corrupt
> the stack. If a new transfer is started before the interrupt fires
> the controller will start a new transfer in the middle of the old one,
> resulting in confused slaves and a locked bus.
> 
> To avoid this, use wait_for_completion_io_timeout instead so that we
> don't have to deal with gracefully shutting down the transfer and
> disabling the interrupts.
> 
> Signed-off-by: Simon Lindgren <simon-IfRblWqrl23QT0dZR+AlfA@public.gmane.org>
Acked-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Thanks for this fix.

> ---
>  drivers/i2c/busses/i2c-at91.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 79a6899..ec299ae 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -421,8 +421,8 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>  		}
>  	}
>  
> -	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
> -							dev->adapter.timeout);
> +	ret = wait_for_completion_io_timeout(&dev->cmd_complete,
> +					     dev->adapter.timeout);
>  	if (ret == 0) {
>  		dev_err(dev->dev, "controller timed out\n");
>  		at91_init_twi_bus(dev);
> -- 
> 1.7.9.5
> 
