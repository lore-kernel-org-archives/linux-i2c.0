From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 1/1] power supply: add driver for TI BQ20Z75 gas gauge
	IC
Date: Tue, 31 Aug 2010 14:13:24 +0100
Message-ID: <20100831131323.GA16671@sirena.org.uk>
References: <1282949443-8052-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1282949443-8052-1-git-send-email-rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 27, 2010 at 03:50:43PM -0700, rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org wrote:

> +	case POWER_SUPPLY_PROP_STATUS:
> +	case POWER_SUPPLY_PROP_CYCLE_COUNT:
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +	case POWER_SUPPLY_PROP_TEMP:
> +	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
> +	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
> +	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
> +		for (count = 0; count < REG_MAX; count++) {
> +			if (psp == bq20z75_data[count].psp)
> +				break;
> +		}

Rather than using REG_MAX it'd seem safer to use ARRAY_SIZE() to make
sure you're within the array.

> +		if (bq20z75_get_battery_property(count, psp, val))
> +			return -EINVAL;
> +			break;

Indentation is messed up here.

> +	printk(KERN_INFO "%s: property = %d, value = %d\n", __func__,
> +		psp, val->intval);

Remove unconditional logging like this, make it dev_dbg() if you want to
keep it in so it's only visible when explicitly requested.

> +	bq20z75_device = kzalloc(sizeof(*bq20z75_device), GFP_KERNEL);
> +	if (!bq20z75_device)
> +		return -ENOMEM;
> +
> +memset(bq20z75_device, 0, sizeof(*bq20z75_device));

Indentation again.

> +/* any smbus transaction will wake up bq20z75 */
> +static int bq20z75_resume(struct i2c_client *client)
> +{
> +	return 0;
> +}

No need for null functions like this.

> +#if defined CONFIG_PM
> +	.suspend	= bq20z75_suspend,
> +	.resume		= bq20z75_resume,
> +#endif

The standard way to do this is with the suspend/resume functions -
#define them to NULL which turns their assignments into noops.

> +MODULE_AUTHOR("NVIDIA Graphics Pvt Ltd");

This only makes sense if it's an actual person (or other contact
address); there's already copyright statements on the file, the author
information is more there to help find someone who might know something
about the driver.
