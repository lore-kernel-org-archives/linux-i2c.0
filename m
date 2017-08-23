From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2] i2c: core: add device-managed version of i2c_new_dummy
Date: Wed, 23 Aug 2017 14:09:56 +0200
Message-ID: <1913702d-9cb0-2874-7760-0e3f83985e61@axentia.se>
References: <8c0a982f-30d5-1124-c871-b040b5bce636@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0102.outbound.protection.outlook.com ([104.47.0.102]:3980
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753955AbdHWMKE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 23 Aug 2017 08:10:04 -0400
In-Reply-To: <8c0a982f-30d5-1124-c871-b040b5bce636@gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On 2017-08-22 07:45, Heiner Kallweit wrote:
> i2c_new_dummy is typically called from the probe function of the
> driver for the primary i2c client. It requires calls to
> i2c_unregister_device in the error path of the probe function and
> in the remove function.
> This can be simplified by introducing a device-managed version.
> 
> Note the changed error case return value type:
> i2c_new_dummy returns NULL whilst devm_new_i2c_dummy returns an ERR_PTR.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Looks good to me, assuming you have some user in the wings...

Reviewed-by: Peter Rosin <peda@axentia.se>

Cheers,
peda

> ---
> v2:
> - added entry to Documentation/driver-model/devres.txt
> - extended documentation of new function
> - changed return value type to an ERR_PTR in case of error
> ---
>  Documentation/driver-model/devres.txt |  3 +++
>  drivers/i2c/i2c-core-base.c           | 39 +++++++++++++++++++++++++++++++++++
>  include/linux/i2c.h                   |  3 +++
>  3 files changed, 45 insertions(+)
> 
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> index 30e04f7a..67d59528 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -258,6 +258,9 @@ GPIO
>    devm_gpio_request_one()
>    devm_gpio_free()
>  
> +I2C
> +  devm_i2c_new_dummy
> +
>  IIO
>    devm_iio_device_alloc()
>    devm_iio_device_free()
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 12822a4b..aac9491c 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -868,6 +868,45 @@ struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
>  }
>  EXPORT_SYMBOL_GPL(i2c_new_dummy);
>  
> +static void devm_i2c_release_dummy(struct device *dev, void *res)
> +{
> +	i2c_unregister_device(*(struct i2c_client **)res);
> +}
> +
> +/**
> + * devm_i2c_new_dummy - return a new i2c device bound to a dummy driver
> + * @dev: device the managed resource is bound to
> + * @adapter: the adapter managing the device
> + * @address: seven bit address to be used
> + * Context: can sleep
> + *
> + * This is the device-managed version of i2c_new_dummy.
> + * Note the changed return value type: It returns the new i2c client
> + * or an ERR_PTR in case of an error.
> + */
> +struct i2c_client *devm_i2c_new_dummy(struct device *dev,
> +				      struct i2c_adapter *adapter,
> +				      u16 address)
> +{
> +	struct i2c_client *ret, **dr;
> +
> +	dr = devres_alloc(devm_i2c_release_dummy, sizeof(*dr), GFP_KERNEL);
> +	if (!dr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = i2c_new_dummy(adapter, address);
> +	if (!ret) {
> +		devres_free(dr);
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	*dr = ret;
> +	devres_add(dev, dr);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_i2c_new_dummy);
> +
>  /**
>   * i2c_new_secondary_device - Helper to get the instantiated secondary address
>   * and create the associated device
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index d501d395..d0c091e6 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -381,6 +381,9 @@ extern int i2c_probe_func_quick_read(struct i2c_adapter *, unsigned short addr);
>  extern struct i2c_client *
>  i2c_new_dummy(struct i2c_adapter *adap, u16 address);
>  
> +extern struct i2c_client *
> +devm_i2c_new_dummy(struct device *dev, struct i2c_adapter *adap, u16 address);
> +
>  extern struct i2c_client *
>  i2c_new_secondary_device(struct i2c_client *client,
>  				const char *name,
> 
