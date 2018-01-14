From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 2/4] i2c-acpi : exclude ARA address for smbus device
Date: Sun, 14 Jan 2018 11:28:29 +0000
Message-ID: <20180114112829.2c12f705@archlinux>
References: <20180113133705.25044-1-m.capdeville@no-log.org>
        <20180113133705.25044-2-m.capdeville@no-log.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180113133705.25044-2-m.capdeville-n+LsquliYkMdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc CAPDEVILLE <m.capdeville-n+LsquliYkMdnm+yROfE0A@public.gmane.org>
Cc: Kevin Tsai <ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 13 Jan 2018 14:37:03 +0100
Marc CAPDEVILLE <m.capdeville-n+LsquliYkMdnm+yROfE0A@public.gmane.org> wrote:

> Somme ACPI enumerated devices are known to support smbus alert protocol.
> Theses devices may be miss-enumerated with the reserved smbus ARA address.
> 
> This is the case on Asus T100 tablet where cm3218 ambiant light sensor
> expose two i2c serial bus connections, with the first one being the alert
> response address.
> 
> This patch make a match on known ACPI ids for which devices are smbus ARA
> capable, then skip the connection if it has the reserved 0x0c address and
> mark it with I2C_CLIENT_ALERT flag. So device is enumerated with the
> correct address.

I wonder if we are safe to always skip 0x0c address whether or not
we know the device supports ARA.  The exception may be for devices
that do support ARA but are rolling their own support the hard way...

I suppose it's possible there are i2c devices (not smbus where the
spec says you must not use 0x0c for normal address IIRC) that use
this address.  Does anyone know of any?

Jonathan

> 
> Signed-off-by: Marc CAPDEVILLE <m.capdeville-n+LsquliYkMdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/i2c-core-acpi.c | 23 +++++++++++++++++++++--
>  include/linux/i2c.h         |  1 +
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index a9126b3cda61..5a8886f14329 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -59,8 +59,14 @@ static int i2c_acpi_fill_info(struct acpi_resource *ares, void *data)
>  	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
>  		return 1;
>  
> -	if (lookup->index != -1 && lookup->n++ != lookup->index)
> -		return 1;
> +	if (lookup->index != -1) {
> +		if (lookup->n++ != lookup->index)
> +			return 1;
> +	} else {
> +		if (lookup->info->flags & I2C_CLIENT_ALERT &&
> +		    sb->slave_address == 0x0c)
> +			return 1;
> +	}
>  
>  	status = acpi_get_handle(lookup->device_handle,
>  				 sb->resource_source.string_ptr,
> @@ -85,6 +91,15 @@ static const struct acpi_device_id i2c_acpi_ignored_device_ids[] = {
>  	{}
>  };
>  
> +static const struct acpi_device_id i2c_acpi_alert_device_ids[] = {
> +	/*
> +	 * Smbus alert capable device which may have the reserved ARA address
> +	 * in their serial bus resources list.
> +	 */
> +	{ "CPLM3218", 0 },
> +	{}
> +};
> +
>  static int i2c_acpi_do_lookup(struct acpi_device *adev,
>  			      struct i2c_acpi_lookup *lookup)
>  {
> @@ -100,6 +115,10 @@ static int i2c_acpi_do_lookup(struct acpi_device *adev,
>  		return -ENODEV;
>  
>  	memset(info, 0, sizeof(*info));
> +
> +	if (acpi_match_device_ids(adev, i2c_acpi_alert_device_ids) == 0)
> +		info->flags |= I2C_CLIENT_ALERT;
> +
>  	lookup->device_handle = acpi_device_handle(adev);
>  
>  	/* Look up for I2cSerialBus resource */
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 7592dce12923..b0d6f1333442 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -743,6 +743,7 @@ i2c_unlock_adapter(struct i2c_adapter *adapter)
>  #define I2C_CLIENT_SLAVE	0x20	/* we are the slave */
>  #define I2C_CLIENT_HOST_NOTIFY	0x40	/* We want to use I2C host notify */
>  #define I2C_CLIENT_WAKE		0x80	/* for board_info; true iff can wake */
> +#define I2C_CLIENT_ALERT	0x100	/* Client use SMBUS alert protocol */
>  #define I2C_CLIENT_SCCB		0x9000	/* Use Omnivision SCCB protocol */
>  					/* Must match I2C_M_STOP|IGNORE_NAK */
>  
