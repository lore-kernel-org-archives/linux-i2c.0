From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 07/13] i2c: acpi: Introduce
 i2c_acpi_get_i2c_resource() helper
Date: Tue, 27 Nov 2018 11:07:19 +0200
Message-ID: <20181127090719.GM2296@lahna.fi.intel.com>
References: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
 <20181126150858.16901-8-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181126150858.16901-8-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 26, 2018 at 05:08:52PM +0200, Andy Shevchenko wrote:
> Besides current two users one more is coming. Definitely makes sense to
> introduce a helper.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/i2c/i2c-core-acpi.c | 31 +++++++++++++++++++------------
>  include/linux/acpi.h        | 11 +++++++++++
>  2 files changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 287a5e4b3d30..b43f535d264b 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -45,6 +45,23 @@ struct i2c_acpi_lookup {
>  	u32 min_speed;
>  };
>  

Since this is exported, you may want to add kernel-doc here.

> +bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
> +			       struct acpi_resource_i2c_serialbus **i2c)
> +{
> +	struct acpi_resource_i2c_serialbus *sb;
> +
> +	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +		return false;
> +
> +	sb = &ares->data.i2c_serial_bus;
> +	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
> +		return false;
> +
> +	*i2c = sb;
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(i2c_acpi_get_i2c_resource);
> +
>  static int i2c_acpi_fill_info(struct acpi_resource *ares, void *data)
>  {
>  	struct i2c_acpi_lookup *lookup = data;
> @@ -52,11 +69,7 @@ static int i2c_acpi_fill_info(struct acpi_resource *ares, void *data)
>  	struct acpi_resource_i2c_serialbus *sb;
>  	acpi_status status;
>  
> -	if (info->addr || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> -		return 1;
> -
> -	sb = &ares->data.i2c_serial_bus;
> -	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
> +	if (info->addr || !i2c_acpi_get_i2c_resource(ares, &sb))
>  		return 1;
>  
>  	if (lookup->index != -1 && lookup->n++ != lookup->index)
> @@ -528,13 +541,7 @@ i2c_acpi_space_handler(u32 function, acpi_physical_address command,
>  		goto err;
>  	}
>  
> -	if (!value64 || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS) {
> -		ret = AE_BAD_PARAMETER;
> -		goto err;
> -	}
> -
> -	sb = &ares->data.i2c_serial_bus;
> -	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C) {
> +	if (!value64 || !i2c_acpi_get_i2c_resource(ares, &sb)) {
>  		ret = AE_BAD_PARAMETER;
>  		goto err;
>  	}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ed80f147bd50..6afc6e3c4c5c 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1054,6 +1054,17 @@ static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
>  }
>  #endif
>  
> +#if defined(CONFIG_ACPI) && IS_ENABLED(CONFIG_I2C)
> +bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
> +			       struct acpi_resource_i2c_serialbus **i2c);
> +#else
> +static inline bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
> +					     struct acpi_resource_i2c_serialbus **i2c)
> +{
> +	return false;
> +}

I think this belongs to include/linux/i2c.h where we have
i2c_acpi_find_bus_speed() and friends.
