From: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 1/1] power supply: add driver for TI BQ20Z75 gas gauge	IC
Date: Wed, 1 Sep 2010 10:53:29 -0700
Message-ID: <E88A1D35AF5437468E5B14C7C4BA61C702CF4B6201@HQMAIL01.nvidia.com>
References: <1282949443-8052-1-git-send-email-rklein@nvidia.com>
 <20100831131323.GA16671@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100831131323.GA16671-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: "cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Andrew Chew <AChew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Thanks for the review, fixed up what you suggested. Will repost soon.

-----Original Message-----
From: Mark Brown [mailto:broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org] 
Sent: Tuesday, August 31, 2010 6:13 AM
To: Rhyland Klein
Cc: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org; Andrew Chew
Subject: Re: [PATCH 1/1] power supply: add driver for TI BQ20Z75 gas gauge IC

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

-Done

> +		if (bq20z75_get_battery_property(count, psp, val))
> +			return -EINVAL;
> +			break;

Indentation is messed up here.

-Done

> +	printk(KERN_INFO "%s: property = %d, value = %d\n", __func__,
> +		psp, val->intval);

Remove unconditional logging like this, make it dev_dbg() if you want to
keep it in so it's only visible when explicitly requested.

-Done

> +	bq20z75_device = kzalloc(sizeof(*bq20z75_device), GFP_KERNEL);
> +	if (!bq20z75_device)
> +		return -ENOMEM;
> +
> +memset(bq20z75_device, 0, sizeof(*bq20z75_device));

Indentation again.

-Done

> +/* any smbus transaction will wake up bq20z75 */
> +static int bq20z75_resume(struct i2c_client *client)
> +{
> +	return 0;
> +}

No need for null functions like this.

-Done

> +#if defined CONFIG_PM
> +	.suspend	= bq20z75_suspend,
> +	.resume		= bq20z75_resume,
> +#endif

The standard way to do this is with the suspend/resume functions -
#define them to NULL which turns their assignments into noops.

-Done

> +MODULE_AUTHOR("NVIDIA Graphics Pvt Ltd");

This only makes sense if it's an actual person (or other contact
address); there's already copyright statements on the file, the author
information is more there to help find someone who might know something
about the driver.

-Done
