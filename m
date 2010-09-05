From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] power supply: add driver for TI BQ20Z75 gas gauge IC
Date: Sun, 5 Sep 2010 16:15:44 +0200
Message-ID: <20100905161544.3a9d9e03@hyperion.delvare>
References: <1283448586-14613-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283448586-14613-1-git-send-email-rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Rhyland,

On Thu,  2 Sep 2010 10:29:46 -0700, rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org wrote:
> From: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> this driver depends on I2C and uses SMBUS for communication with the host.
> 
> Addressed comments from reviews by Mark Brown and Jean Delvare.
>   * Cleaned up whitespace and alignment issues
>   * changed return codes to more appropriate values
>   * change Kconfig option name to be consistent with existing devices
>   * removed global struct and moved to device specific data
>   * changed printk to dev_dbg

Looks much better. A few details could be ironed out:

> 
> Signed-off-by: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/power/Kconfig   |    7 +
>  drivers/power/Makefile  |    1 +
>  drivers/power/bq20z75.c |  387 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 395 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/power/bq20z75.c
> 
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 8e9ba17..53d9cbf 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -142,4 +142,11 @@ config CHARGER_PCF50633
>  	help
>  	 Say Y to include support for NXP PCF50633 Main Battery Charger.
>  
> +config BATTERY_BQ20Z75
> +        tristate "TI BQ20z75 gas gauge"
> +        depends on I2C
> +        help
> +         Say Y to include support for TI bq20z75 SBS-compliant

Please leave the BQ in capitals for consistency.

> +         gas gauge and protection IC.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index 0005080..cdc403d 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -34,3 +34,4 @@ obj-$(CONFIG_BATTERY_DA9030)	+= da9030_battery.o
>  obj-$(CONFIG_BATTERY_MAX17040)	+= max17040_battery.o
>  obj-$(CONFIG_BATTERY_Z2)	+= z2_battery.o
>  obj-$(CONFIG_CHARGER_PCF50633)	+= pcf50633-charger.o
> +obj-$(CONFIG_BATTERY_BQ20Z75)	+= bq20z75.o

Would be nice to move this entry right before CONFIG_BATTERY_BQ27x00.
Same for Kconfig, BTW.

> diff --git a/drivers/power/bq20z75.c b/drivers/power/bq20z75.c
> new file mode 100644
> index 0000000..a7eeedf
> --- /dev/null
> +++ b/drivers/power/bq20z75.c
> (...)
> +static int bq20z75_get_property(struct power_supply *psy,
> +	enum power_supply_property psp, union power_supply_propval *val);

You no longer need this forward declaration.

Once these small details are fixed, feel free to add:

Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare
