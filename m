From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/9] of/device: Allow I2C devices to OF match without
 supplying an OF node
Date: Sat, 07 Jun 2014 00:28:18 +0100
Message-ID: <20140606232818.8D870C42604@trevor.secretlab.ca>
References: <1402069952-28022-1-git-send-email-lee.jones@linaro.org>
	<1402069952-28022-8-git-send-email-lee.jones@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402069952-28022-8-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri,  6 Jun 2014 16:52:30 +0100, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> The I2C framework supplies a means for devices to be registered without
> the requirement for platform_data, DT or ACPI.  The current solution is
> that every single I2C device in the kernel is forced to supply a
> normally empty/sparse I2C ID table so the I2C subsystem can match to.
> In an effort to rid the kernel of these tables we need to provide some
> temporary work arounds until we can straighten out the blocking factors.
> 
> This change is meant to be temporary and will be stripped out once
> we've converted all I2C device drivers from of_match_device() over
> to the new I2C generic i2c_of_match_device().

This change imposes the i2c workaround onto every single caller of
i2c_of_match_device(), regardless of subsystem, and regardless of the
desired behaviour. It also prevents an i2c driver from getting the
correct behavour when it wants it.

So, no, I'm not okay with hooking into the core code to work around the
subsystem problem. I2C drivers need to call the i2c specific version
directly. I know that adds a line of change to the driver patches, but I
think it is necessary.

g.

> 
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/of/device.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index dafb973..3b1c8f9 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -1,6 +1,7 @@
>  #include <linux/string.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
> +#include <linux/i2c.h>
>  #include <linux/of_device.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> @@ -21,9 +22,25 @@
>  const struct of_device_id *of_match_device(const struct of_device_id *matches,
>  					   const struct device *dev)
>  {
> +	const struct of_device_id *match;
> +
>  	if ((!matches) || (!dev->of_node))
>  		return NULL;
> -	return of_match_node(matches, dev->of_node);
> +
> +	match = of_match_node(matches, dev->of_node);
> +	if (match)
> +		return match;
> +
> +	/*
> +	 * Low impact workaround, until we can convert all I2C compatible
> +	 * strings over to the correctly specified <vendor>,<device> format.
> +	 */
> +	match = i2c_of_match_device_strip_vendor(matches, (struct device *)dev);
> +	if (match)
> +		dev_warn(dev,
> +			 "WARNING: Vendor ID missing from compatible string\n");
> +
> +	return match;
>  }
>  EXPORT_SYMBOL(of_match_device);
>  
> -- 
> 1.8.3.2
> 
