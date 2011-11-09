From: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: RE: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Wed, 9 Nov 2011 17:01:07 +0100
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D087B3C9440@wm021.weinmann.com>
References: <cover.1320753142.git.n.voss@weinmann.de>
 <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
 <4EB9B24A.5040809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4EB9B24A.5040809-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Ryan Mallon' <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org'" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "'khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org'" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "'nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org'" <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "'balbi-l0cyMroinI0@public.gmane.org'" <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ryan,

> > +#include <mach/at91_twi.h>
> 
> 
> This include file looks like it only contains register definitions which
> are used in this file. Would be good to either move them directly into
> this driver or move the header file to this directory and make it a
> local include.

Ok.

> > +
> > +	dev->dev = get_device(&pdev->dev);
> 
> 
> Is this (and the put_device(&pdev->dev) in the exit code) necessary? I
> see that some other i2c drivers do this also, but I'm not familiar with
> using it in other device drivers. Isn't the reference count for
> pdev->dev already incremented by the fact we are probing the device?

It is incremented by the platform_device_register() which does a
device_add(). This seems to be enough, I removed the get-/put_device().


> 
> > +	dev->irq = irq->start;
> > +	platform_set_drvdata(pdev, dev);
> > +
> > +	dev->clk = clk_get(&pdev->dev, "twi_clk");
> 
> 
> This didn't get answered. Can't you just do:
> 
> 	dev->clk = clk_get(&pdev->dev, NULL);
> 
> and clkdev should figure out the correct clock based on the device pointer?

No, this doesn't work on at91 since the clocks have no dev_id property
but only con_id. I cannot see a reason for this, but that's the way it's
done. Multiple hardware interfaces are handled via a lookup table.


> > +	rc = i2c_del_adapter(&dev->adapter);
> 
> 
> Most of the other i2c drivers don't check the return code for
> i2c_del_adapter. If this fails then you will unload the module, but
> potentially leak resources that i2c_del_adapter failed to free up. Not
> sure what the correct answer is here.

I don't really check the value but use it has exit code for the remove()-
function to indicate something went wrong. Just ignoring it wouldn't heal
the resource leakage.

Thanks for reviewing,

Niko
