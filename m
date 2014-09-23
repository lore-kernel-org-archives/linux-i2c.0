From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: move acpi code back into the core
Date: Tue, 23 Sep 2014 12:14:38 +0300
Message-ID: <20140923091438.GI1786@lahna.fi.intel.com>
References: <1411420006-4713-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411420006-4713-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 22, 2014 at 11:06:46PM +0200, Wolfram Sang wrote:
> Commit 5d98e61d337c ("I2C/ACPI: Add i2c ACPI operation region support") renamed
> the i2c-core module. This may cause regressions for distributions, so put the
> ACPI code back into the core. No code was changed.

Thanks Wolfram for doing this!

I tested this already and it of course works but there are few things
that you are missing so this probably needs an additional iteration.

> Reported-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> ---
> 
> Lan Tianyi, this is a patch I expected to get from you, fully tested. Since we
> are approaching the final release soon, I did it now. Please do test this
> patch. All I can do is build test (it works for me, build robots are still
> running). If nobody tests this, I have to revert the ACPI changes of this
> cycle.
> 
> Jean, can you have a look, too?
> 
> We can think of something better for the next release, but for now, this should be it.
> 
>  MAINTAINERS            |   1 -
>  drivers/i2c/Makefile   |   5 +-
>  drivers/i2c/i2c-acpi.c | 364 -------------------------------------------------
>  drivers/i2c/i2c-core.c | 345 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 346 insertions(+), 369 deletions(-)
>  delete mode 100644 drivers/i2c/i2c-acpi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 809ecd680d88..e3682d0dea1e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4477,7 +4477,6 @@ M:	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>  L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>  L:	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>  S:	Maintained
> -F:	drivers/i2c/i2c-acpi.c

You can remove my name from MAINTANERS as well. I'm not I2C subsystem
maintainer :) Of course I will still assist reviewing ACPI related
changes in i2c-core.c.

>  I2C-TAOS-EVM DRIVER
>  M:	Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>

...

> +/**
> + * acpi_i2c_register_devices - enumerate I2C slave devices behind adapter
> + * @adap: pointer to adapter
> + *
> + * Enumerate all I2C slave devices behind this adapter by walking the ACPI
> + * namespace. When a device is found it will be added to the Linux device
> + * model and bound to the corresponding ACPI handle.
> + */
> +void acpi_i2c_register_devices(struct i2c_adapter *adap)

static

> +{
> +	acpi_handle handle;
> +	acpi_status status;
> +
> +	if (!adap->dev.parent)
> +		return;
> +
> +	handle = ACPI_HANDLE(adap->dev.parent);
> +	if (!handle)
> +		return;
> +
> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +				     acpi_i2c_add_device, NULL,
> +				     adap, NULL);
> +	if (ACPI_FAILURE(status))
> +		dev_warn(&adap->dev, "failed to enumerate I2C slaves\n");
> +}
> +

...

> +int acpi_i2c_install_space_handler(struct i2c_adapter *adapter)

static

> +{
> +	acpi_handle handle = ACPI_HANDLE(adapter->dev.parent);
> +	struct acpi_i2c_handler_data *data;
> +	acpi_status status;
> +
> +	if (!handle)
> +		return -ENODEV;
> +
> +	data = kzalloc(sizeof(struct acpi_i2c_handler_data),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->adapter = adapter;
> +	status = acpi_bus_attach_private_data(handle, (void *)data);
> +	if (ACPI_FAILURE(status)) {
> +		kfree(data);
> +		return -ENOMEM;
> +	}
> +
> +	status = acpi_install_address_space_handler(handle,
> +				ACPI_ADR_SPACE_GSBUS,
> +				&acpi_i2c_space_handler,
> +				NULL,
> +				data);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&adapter->dev, "Error installing i2c space handler\n");
> +		acpi_bus_detach_private_data(handle);
> +		kfree(data);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +void acpi_i2c_remove_space_handler(struct i2c_adapter *adapter)

static

> +{
> +	acpi_handle handle = ACPI_HANDLE(adapter->dev.parent);
> +	struct acpi_i2c_handler_data *data;
> +	acpi_status status;
> +
> +	if (!handle)
> +		return;
> +
> +	acpi_remove_address_space_handler(handle,
> +				ACPI_ADR_SPACE_GSBUS,
> +				&acpi_i2c_space_handler);
> +
> +	status = acpi_bus_get_private_data(handle, (void **)&data);
> +	if (ACPI_SUCCESS(status))
> +		kfree(data);
> +
> +	acpi_bus_detach_private_data(handle);
> +}
> +#endif

I would put there

#endif /* CONFIG_ACPI_I2C_OPREGION */

> +#endif /* CONFIG_ACPI */

Also please remove all ACPI related stuff in include/linux/i2c.h. That
is not needed anymore.
