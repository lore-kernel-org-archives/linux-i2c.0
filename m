From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Fri, 17 Dec 2010 01:09:42 +0100
Message-ID: <201012170109.43137.rjw@sisk.pl>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday, December 16, 2010, Rabin Vincent wrote:
> Hello,
> 
> There seem to be some differences between the generic ops and the i2c
> and platform busses' implementations of the interaction between runtime
> PM and system sleep:
> 
>   (1) The platform bus does not implement the
>       don't-call-pm->suspend()-if pm_runtime_suspended()-returns-true
>       functionality implemented by the generic ops and i2c.
> 
>   (2) Both I2C and platform do not set the device as active when a
>       pm->resume callback exists and it succeeds.
> 
>       This seems to have been done in i2c until recently, but has been
>       removed by 753419f59e ("i2c: Fix for suspend/resume issue").  It
>       seems to me that this removal is incorrect, and instead the real
>       problem with the implementation was that it set the device as
>       active even if no resume callback existed, whereas it should only
>       do so when it exists and returns zero, like the generic ops.
> 
> Are these divergences from the generic ops to be considered as bugs?

I think so.  I'm not sure about (1), because someone may already depend on
that behavior, but (2) looks like a bug to me.

> Atleast (2) will cause devices which use UNIVERSAL_DEV_PM_OPS to have
> incorrect runtime pm state after a resume from system sleep.
> 
> If so, before I send patches to fix them: can it be assumed that only
> drivers using dev_pm_ops (and not the legacy ops of these busses) will
> need the interactions between runtime PM and system sleep as done in the
> generic ops?

Yes, you can make this assumption safely.  The drivers that don't use
dev_pm_ops can't support runtime PM at all.

> This would mean that simple busses could simply use the
> generic ops like below instead of duplicating their behaviour:
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 6b4cc56..46117e0 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -212,7 +212,7 @@ static int i2c_device_pm_resume(struct device *dev)
>  	int ret;
> 
>  	if (pm)
> -		ret = pm->resume ? pm->resume(dev) : 0;
> +		ret = pm_generic_resume(dev);
>  	else
>  		ret = i2c_legacy_resume(dev);

Thanks,
Rafael
