From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/7] OF/ACPI/I2C: Add generic match function for the
 aforementioned systems
Date: Thu, 05 Jun 2014 11:30:09 +0100
Message-ID: <20140605103009.85BE4C40A4D@trevor.secretlab.ca>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
	<1401883796-17841-8-git-send-email-lee.jones@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401883796-17841-8-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed,  4 Jun 2014 13:09:56 +0100, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Currently this is a helper function for the I2C subsystem to aid the
> matching of non-standard compatible strings and devices which use DT
> and/or ACPI, but do not supply any nodes (see: [1] Method 4).  However,
> it has been made more generic as it can be used to only make one call
> for drivers which support any mixture of OF, ACPI and/or I2C matching.
> 
> The initial aim is for of_match_device() to be replaced by this call
> in all I2C device drivers.
> 
> [1] Documentation/i2c/instantiating-devices
> 
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

I don't like this. It drops all type safety on the match entry
and the caller has no idea what it got back.

g.

> ---
>  include/linux/match.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 include/linux/match.h
> 
> diff --git a/include/linux/match.h b/include/linux/match.h
> new file mode 100644
> index 0000000..20a08e2
> --- /dev/null
> +++ b/include/linux/match.h
> @@ -0,0 +1,40 @@
> +#include <linux/of.h>
> +#include <linux/acpi.h>
> +#include <linux/i2c.h>
> +
> +static void *device_match(struct device *dev)
> +{
> +	struct device_driver *driver = dev->driver;
> +
> +	if (!driver)
> +		return NULL;
> +
> +	/* Attempt an OF style match */
> +	if (IS_ENABLED(CONFIG_OF)) {
> +		const struct of_device_id *of_match =
> +			i2c_of_match_device(driver->of_match_table, dev);
> +		if (of_match)
> +			return (void *)of_match;
> +	}
> +
> +	/* Then ACPI style match */
> +	if (IS_ENABLED(CONFIG_ACPI)) {
> +		const struct acpi_device_id *acpi_match	=
> +			acpi_match_device(driver->acpi_match_table, dev);
> +		if (acpi_match)
> +			return (void *)acpi_match;
> +	}
> +
> +	/* Finally an I2C match */
> +	if (IS_ENABLED(CONFIG_I2C)) {
> +		struct i2c_client *client = i2c_verify_client(dev);
> +		struct i2c_driver *i2c_drv = to_i2c_driver(driver);
> +		struct i2c_device_id *i2c_match;
> +
> +		i2c_match = i2c_match_id(i2c_drv->id_table, client);
> +		if (i2c_match)
> +			return (void *)i2c_match;
> +	}
> +
> +	return NULL;
> +}
> -- 
> 1.8.3.2
> 
