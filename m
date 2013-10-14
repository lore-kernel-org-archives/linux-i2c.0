From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/3] ACPI: add module autoloading support for ACPI
 enumerated devices
Date: Mon, 14 Oct 2013 13:14:23 +0300
Message-ID: <20131014101423.GE3521@intel.com>
References: <1381741834-7334-1-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1381741834-7334-1-git-send-email-rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: rjw-KKrjLPT3xs0@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 14, 2013 at 05:10:32PM +0800, Zhang Rui wrote:
> An ACPI enumerated device may have its compatible id strings.
> 
> To support the compatible ACPI ids (acpi_device->pnp.ids),
> we introduced acpi_driver_match_device() to match
> the driver->acpi_match_table and acpi_device->pnp.ids.
> 
> For those drivers, MODULE_DEVICE_TABLE(acpi, xxx) is used to
> exports the driver module alias in the format of
> "acpi:device_compatible_ids".
> But in the mean time, the current code does not export the
> ACPI compatible strings as part of the module_alias for the
> ACPI enumerated devices, which will break the module autoloading.
> 
> Take the following piece of code for example,
> static const struct acpi_device_id xxx_acpi_match[] = {
>         { "INTABCD", 0 },
>         { }
> };
> MODULE_DEVICE_TABLE(acpi, xxx_acpi_match);
> 
> If this piece of code is used in a platform driver for
> an ACPI enumerated platform device, the platform driver module_alias
> is "acpi:INTABCD", but the uevent attribute of its platform device node
> is "platform:INTABCD:00" (PREFIX:pdev->name).
> If this piece of code is used in an i2c driver for an ACPI enumerated
> i2c device, the i2c driver module_alias is "acpi:INTABCD", but
> the uevent of its i2c device node is "i2c:INTABCD:00" (PREFIX:client->name).
> 
> The reason why the module autoloading is not broken for now is that
> the uevent file of the ACPI device node is "acpi:INTABCD".
> Thus it is the ACPI device node creation that loads the platform/i2c driver.
> 
> So this is a problem that will affect us the day when the ACPI bus
> is removed from device model.
> 
> This patch introduces a new function to exporting ACPI ids as the
> module_alias, for the ACPI enumerate devices.
> 
> For any drivers using MODULE_DEVICE_TALBE(acpi, blabla), the uevent file
                                        ^ TABLE?

> of its associated device must be fixed by invoking this function.
> 
> Signed-off-by: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Makes sense. There is one comment below but other than that, you can add
my,

Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

For the three patches.

I wonder if we should do the same for SPI bus as well?

> ---
>  drivers/acpi/scan.c  |   24 ++++++++++++++++++++++++
>  include/linux/acpi.h |    8 ++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 407ad13..db6f879 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -111,6 +111,30 @@ static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
>  	return len;
>  }
>  
> +int acpi_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct acpi_device *acpi_dev;
> +	int result;
> +	int len;
> +
> +	result = acpi_bus_get_device(ACPI_HANDLE(dev), &acpi_dev);
> +	if (result)
> +		return result;
> +
> +	if (list_empty(&acpi_dev->pnp.ids))
> +		return 0;
> +
> +	if (add_uevent_var(env, "MODALIAS="))
> +		return -ENOMEM;
> +	len = create_modalias(acpi_dev, &env->buf[env->buflen - 1],
> +				sizeof(env->buf) - env->buflen);
> +	if (len >= (sizeof(env->buf) - env->buflen))
> +		return -ENOMEM;
> +	env->buflen += len;
> +	return 0;
> +}
> +EXPORT_SYMBOL(acpi_device_uevent_modalias);

_GPL?
