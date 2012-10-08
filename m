From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: omap: Do not enable the irq always
Date: Mon, 8 Oct 2012 10:46:31 +0100
Message-ID: <20121008094631.GX4625@n2100.arm.linux.org.uk>
References: <1349687116-14463-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1349687116-14463-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 08, 2012 at 02:35:14PM +0530, Shubhrajyoti D wrote:
> Enable the irq in the transfer and disable it after the
> transfer is done.

This description is missing the most vital bits of information.  In years
to come, someone will wonder "why has this changed" and there's no reason
given in the commit log.

Commit logs which are just mere translations from patch to English are
evil.  Instead, good commit logs briefly state what is being done and
then go on to describe _why_ the change is necessary.

> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index b6c6b95..ce41596 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -625,6 +625,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  	if (IS_ERR_VALUE(r))
>  		goto out;
>  
> +	enable_irq(dev->irq);
>  	r = omap_i2c_wait_for_bb(dev);
>  	if (r < 0)
>  		goto out;
> @@ -654,6 +655,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  
>  	omap_i2c_wait_for_bb(dev);
>  out:
> +	disable_irq(dev->irq);
>  	pm_runtime_mark_last_busy(dev->dev);
>  	pm_runtime_put_autosuspend(dev->dev);
>  	return r;
> @@ -1179,6 +1181,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  		goto err_unuse_clocks;
>  	}
>  
> +	disable_irq(dev->irq);
>  	adap = &dev->adapter;
>  	i2c_set_adapdata(adap, dev);
>  	adap->owner = THIS_MODULE;
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
