From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] hwmon: Add support for JEDEC JC 42.4 compliant
 temperature sensors
Date: Sun, 11 Jul 2010 08:31:06 -0700
Message-ID: <1278862266.1501.59.camel@Joe-Laptop.home>
References: <1278859984-22593-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278859984-22593-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Paul Goyette <paul-3orOWTcw9wBWk0Htik3J/w@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 2010-07-11 at 07:53 -0700, Guenter Roeck wrote:
> diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
> new file mode 100644
> index 0000000..685057d
> --- /dev/null
> +++ b/drivers/hwmon/jc42.c
[]
> +struct jc42_chips {
> +	u16 manid;
> +	u16 devid;
> +	u16 devid_mask;
> +};
> +
> +static struct jc42_chips jc42_chips[] = {
> +	{ ADT_MANID, ADT7408_DEVID, ADT7408_DEVID_MASK },
> +	{ IDT_MANID, TS3000B3_DEVID, TS3000B3_DEVID_MASK },
> +	{ MAX_MANID, MAX6604_DEVID, MAX6604_DEVID_MASK },
> +	{ MCP_MANID, MCP98242_DEVID, MCP98242_DEVID_MASK },
> +	{ MCP_MANID, MCP98243_DEVID, MCP98243_DEVID_MASK },
> +	{ MCP_MANID, MCP9843_DEVID, MCP9843_DEVID_MASK },
> +	{ NXP_MANID, SE97_DEVID, SE97_DEVID_MASK },
> +	{ ONS_MANID, CAT6095_DEVID, CAT6095_DEVID_MASK },
> +	{ NXP_MANID, SE98_DEVID, SE98_DEVID_MASK },
> +	{ STM_MANID, STTS424_DEVID, STTS424_DEVID_MASK },
> +	{ STM_MANID, STTS424E_DEVID, STTS424E_DEVID_MASK },
> +};
[]
> +	for (i = 0; i < ARRAY_SIZE(jc42_chips); i++) {
> +		if (manid == jc42_chips[i].manid
> +		    && (devid & jc42_chips[i].devid_mask) ==
> +					    jc42_chips[i].devid) {
> +			strlcpy(info->type, "jc42", I2C_NAME_SIZE);
> +			return 0;
> +		}
> +	}

Decidedly trivial:

Kernel style seems to prefer having logical tests at
end of line rather than start of line.

Maybe this bit would be more readable with a temporary:

	for (i = 0; i < ARRAY_SIZE(jc42_chips); i++) {
		struct jc42_chips *chip = &jc42_chips[i];
		if (manid == chip->manid &&
		    (devid & chip->devid_mask) == chip->devid) {
			strlcpy(info->type, "jc42", I2C_NAME_SIZE);
			return 0;
		}
	}
