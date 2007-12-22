From: "Jean Delvare" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.24-rc5-git] add i2c_new_dummy() utility
Date: Sat, 22 Dec 2007 18:31:43 +0100
Message-ID: <kOXVGr9s.1198344701.9162110.khali@gcu-squad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Hi David,

Sorry for the non-threaded reply, I do not have access to the original
post at the moment.

David Brownell wrote:
> This adds a i2c_new_dummy() primitive to help work with devices
> that consume multiple addresses, which include many I2C eeproms
> and at least one RTC.
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
> [ Apologies for the duplicate message some of you may have seen. ]
> 
> Tested with a 24c00 EEPROM ... that's the 16-byte one, which
> ignores a0/a1/a2 and thus consumes 8 addresses.
> 
>  drivers/i2c/i2c-core.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/i2c.h    |    6 ++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> --- a/drivers/i2c/i2c-core.c	2007-12-15 20:57:54.000000000 -0800
> +++ b/drivers/i2c/i2c-core.c	2007-12-15 21:01:22.000000000 -0800
> @@ -276,6 +276,51 @@ void i2c_unregister_device(struct i2c_cl
>  EXPORT_SYMBOL_GPL(i2c_unregister_device);
>  
>  
> +static int dummy_nop(struct i2c_client *client)
> +{
> +	return 0;
> +}
> +
> +static struct i2c_driver dummy_driver = {
> +	.driver.name	= "dummy",
> +	.probe		= dummy_nop,
> +	.remove		= dummy_nop,
> +};
> +
> +
> +/**
> + * i2c_new_dummy - return a new i2c device bound to a dummy driver
> + * @adapter: the adapter managing the device
> + * @address: seven bit address to be used
> + * @type: optional label used for i2c_client.name

Do you have a use case in mind for this feature?

> + * Context: can sleep
> + *
> + * This returns an I2C client bound to the "dummy" driver, intended for use
> + * with devices that consume multiple addresses.  Examples of such chips
> + * include various EEPROMS (like 24c04 and 24c08 models).
> + *
> + * These dummy devices have two main uses.  First, most I2C and SMBus calls
> + * except i2c_transfer() need a client handle; the dummy will be that handle.
> + * And second, this prevents the specified address from being bound to a
> + * different driver.
> + *
> + * This returns the new i2c client, which may be saved for later use with
> + * i2c_unregister_device(); or NULL to indicate an error.

I'd say it _should_ be saved. Calling i2c_unregister_device() is pretty
much mandatory, unless the driver can't be built as a module.

> + */
> +struct i2c_client *
> +i2c_new_dummy(struct i2c_adapter *adapter, unsigned address, const char *type)

The rest of i2c-core uses an unsigned short for addresses, maybe do the
same here for consistency?

> +{
> +	struct i2c_board_info info = {
> +		.driver_name	= "dummy",
> +		.addr		= address,
> +	};
> +
> +	if (type)
> +		strncpy(info.type, type, sizeof info.type);

Please use strlcpy() instead, strncpy() is error-prone.

> +	return i2c_new_device(adapter, &info);
> +}
> +EXPORT_SYMBOL_GPL(i2c_new_dummy);
> +
>  /* ------------------------------------------------------------------------- */
>  
>  /* I2C bus adapters -- one roots each I2C or SMBUS segment */
> @@ -848,11 +893,24 @@ static int __init i2c_init(void)
>  	retval = bus_register(&i2c_bus_type);
>  	if (retval)
>  		return retval;
> -	return class_register(&i2c_adapter_class);
> +	retval = class_register(&i2c_adapter_class);
> +	if (retval)
> +		goto bus_err;
> +	retval = i2c_add_driver(&dummy_driver);
> +	if (retval)
> +		goto class_err;
> +	return 0;
> +
> +class_err:
> +	class_unregister(&i2c_adapter_class);
> +bus_err:
> +	bus_unregister(&i2c_bus_type);
> +	return retval;
>  }

Thanks for fixing a broken error path...

>  
>  static void __exit i2c_exit(void)
>  {
> +	i2c_del_driver(&dummy_driver);
>  	class_unregister(&i2c_adapter_class);
>  	bus_unregister(&i2c_bus_type);
>  }
> --- a/include/linux/i2c.h	2007-12-15 20:57:54.000000000 -0800
> +++ b/include/linux/i2c.h	2007-12-15 21:01:22.000000000 -0800
> @@ -261,6 +261,12 @@ i2c_new_probed_device(struct i2c_adapter
>  		      struct i2c_board_info *info,
>  		      unsigned short const *addr_list);
>  
> +/* For devices that use several addresses, use i2c_new_dummy() to make
> + * client handles for the exta addresses.

Typo: extra.

> + */
> +extern struct i2c_client *
> +i2c_new_dummy(struct i2c_adapter *adap, unsigned address, const char *type);
> +
>  extern void i2c_unregister_device(struct i2c_client *);
>  
>  /* Mainboard arch_initcall() code should register all its I2C devices.
> 

Other than that the patch looks just fine. Please respin it and I'll
apply it.

Thanks,
--
Jean Delvare
