From: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [Resend, PATCH v2] i2c: core: Allow empty id_table in ACPI case
 as well
Date: Wed, 19 Jul 2017 23:32:57 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A59725DCCFC@FMSMSX114.amr.corp.intel.com>
References: <20170717141328.52286-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170717141328.52286-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

Thanks for the patch.

I have verified this patch on 4.13-rc1 kernel for on my TPS68470 PMIC v4 patch.

Feel free to add

Tested-by: Rajmohan Mani <rajmohan.mani@intel.com>

Raj

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Andy Shevchenko
> Sent: Monday, July 17, 2017 7:13 AM
> To: Wolfram Sang <wsa@the-dreams.de>; linux-i2c@vger.kernel.org; Mika
> Westerberg <mika.westerberg@linux.intel.com>; Hans de Goede
> <hdegoede@redhat.com>; Rafael J . Wysocki <rjw@rjwysocki.net>; linux-
> acpi@vger.kernel.org
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Subject: [Resend, PATCH v2] i2c: core: Allow empty id_table in ACPI case as
> well
> 
> For now empty ID table is not allowed with ACPI and prevents driver to be
> probed.
> 
> Add a check to allow empty ID table.
> 
> This introduces a helper i2c_acpi_match_device().
> 
> Note, we rename some static function in i2c-core-acpi.c to distinguish with
> public API.
> 
> Fixes: da10c06a044b ("i2c: Make I2C ID tables non-mandatory for DT'ed
> devices")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> - twice linux-i2c@ instead of i2c and acpi MLs, thus, resent  drivers/i2c/i2c-
> core-acpi.c | 19 +++++++++++++++----  drivers/i2c/i2c-core-base.c |  1 +
>  drivers/i2c/i2c-core.h      |  9 +++++++++
>  3 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c index
> 4842ec3a5451..a9126b3cda61 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -230,6 +230,16 @@ void i2c_acpi_register_devices(struct i2c_adapter
> *adap)
>  		dev_warn(&adap->dev, "failed to enumerate I2C slaves\n");
> }
> 
> +const struct acpi_device_id *
> +i2c_acpi_match_device(const struct acpi_device_id *matches,
> +		      struct i2c_client *client)
> +{
> +	if (!(client && matches))
> +		return NULL;
> +
> +	return acpi_match_device(matches, &client->dev); }
> +
>  static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
>  					   void *data, void **return_value)  {
> @@ -289,7 +299,7 @@ u32 i2c_acpi_find_bus_speed(struct device *dev)  }
> EXPORT_SYMBOL_GPL(i2c_acpi_find_bus_speed);
> 
> -static int i2c_acpi_match_adapter(struct device *dev, void *data)
> +static int i2c_acpi_find_match_adapter(struct device *dev, void *data)
>  {
>  	struct i2c_adapter *adapter = i2c_verify_adapter(dev);
> 
> @@ -299,7 +309,7 @@ static int i2c_acpi_match_adapter(struct device *dev,
> void *data)
>  	return ACPI_HANDLE(dev) == (acpi_handle)data;  }
> 
> -static int i2c_acpi_match_device(struct device *dev, void *data)
> +static int i2c_acpi_find_match_device(struct device *dev, void *data)
>  {
>  	return ACPI_COMPANION(dev) == data;
>  }
> @@ -309,7 +319,7 @@ static struct i2c_adapter
> *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
>  	struct device *dev;
> 
>  	dev = bus_find_device(&i2c_bus_type, NULL, handle,
> -			      i2c_acpi_match_adapter);
> +			      i2c_acpi_find_match_adapter);
>  	return dev ? i2c_verify_adapter(dev) : NULL;  }
> 
> @@ -317,7 +327,8 @@ static struct i2c_client
> *i2c_acpi_find_client_by_adev(struct acpi_device *adev)  {
>  	struct device *dev;
> 
> -	dev = bus_find_device(&i2c_bus_type, NULL, adev,
> i2c_acpi_match_device);
> +	dev = bus_find_device(&i2c_bus_type, NULL, adev,
> +			      i2c_acpi_find_match_device);
>  	return dev ? i2c_verify_client(dev) : NULL;  }
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c index
> c89dac7fd2e7..12822a4b8f8f 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -357,6 +357,7 @@ static int i2c_device_probe(struct device *dev)
>  	 * Tree match table entry is supplied for the probing device.
>  	 */
>  	if (!driver->id_table &&
> +	    !i2c_acpi_match_device(dev->driver->acpi_match_table, client) &&
>  	    !i2c_of_match_device(dev->driver->of_match_table, client))
>  		return -ENODEV;
> 
> diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h index
> 3b63f5e5b89c..3d3d9bf02101 100644
> --- a/drivers/i2c/i2c-core.h
> +++ b/drivers/i2c/i2c-core.h
> @@ -31,9 +31,18 @@ int i2c_check_addr_validity(unsigned addr, unsigned
> short flags);  int i2c_check_7bit_addr_validity_strict(unsigned short addr);
> 
>  #ifdef CONFIG_ACPI
> +const struct acpi_device_id *
> +i2c_acpi_match_device(const struct acpi_device_id *matches,
> +		      struct i2c_client *client);
>  void i2c_acpi_register_devices(struct i2c_adapter *adap);  #else /*
> CONFIG_ACPI */  static inline void i2c_acpi_register_devices(struct
> i2c_adapter *adap) { }
> +static inline const struct acpi_device_id * i2c_acpi_match_device(const
> +struct acpi_device_id *matches,
> +		      struct i2c_client *client)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_ACPI */
>  extern struct notifier_block i2c_acpi_notifier;
> 
> --
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
