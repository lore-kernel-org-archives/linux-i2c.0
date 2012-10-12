From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: omap: Do not enable the irq always
Date: Fri, 12 Oct 2012 07:26:02 -0700
Message-ID: <87txtz7on9.fsf@deeprootsystems.com>
References: <1349687116-14463-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349687116-14463-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Mon, 8 Oct 2012 14:35:14 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, huzefank-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

+Kalle, Grygorii, Huzefa

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> Enable the irq in the transfer and disable it after the
> transfer is done.
>
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

When using runtime PM with auto-suspend timeouts, why would you disable
the IRQ before the runtime suspend handlers have run?   

If you really want to do this, you probably should have these in the
runtime PM callbacks.  But I'll wait until you add a more descriptive
changelog before I can really tell why this is being done.  Based on the
discussion in the patch from Kalle, I'm assuming this is to prevent
interrups when I2C is being used by co-processors.  If so, plese
describe in the changelog.

That being said, doesn't the runtime suspend callback already disable
IRQs at the device level instead of the INTC level?

Kevin

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
