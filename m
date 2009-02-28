From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: [PATCH 1/3] Added empty directories for hardware sensors
Date: Sat, 28 Feb 2009 13:40:48 +0100
Message-ID: <20090228124048.GB18336@buzzloop.caiaq.de>
References: <20090226095718.GA24575@buzzloop.caiaq.de> <1235654648-3450-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1235654648-3450-1-git-send-email-daniel-rDUAYElUppE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 26, 2009 at 02:24:06PM +0100, Daniel Mack wrote:
> This adds empty directories and the neccessary entries to Makefiles and
> Kconfigs in order to provide a place for hardware sensors which are not
> meant to be based in drivers/hwmon.
> 
> Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
> ---
>  How about this approach? Take it as RFC ...

Any oppinion on this, anyone? I'm currently writing a driver for an
accelerometer and will have the same uncertainty of where to put it in
the end.

Daniel



> 
>  arch/arm/Kconfig         |    2 ++
>  drivers/Kconfig          |    2 ++
>  drivers/Makefile         |    1 +
>  drivers/sensors/Kconfig  |   20 ++++++++++++++++++++
>  drivers/sensors/Makefile |    4 ++++
>  5 files changed, 29 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/sensors/Kconfig
>  create mode 100644 drivers/sensors/Makefile
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index dbfdf87..91a6c55 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1283,6 +1283,8 @@ source "drivers/power/Kconfig"
>  
>  source "drivers/hwmon/Kconfig"
>  
> +source "drivers/sensors/Kconfig"
> +
>  source "drivers/thermal/Kconfig"
>  
>  source "drivers/watchdog/Kconfig"
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 00cf955..57a9578 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -60,6 +60,8 @@ source "drivers/power/Kconfig"
>  
>  source "drivers/hwmon/Kconfig"
>  
> +source "drivers/sensors/Kconfig"
> +
>  source "drivers/thermal/Kconfig"
>  
>  source "drivers/watchdog/Kconfig"
> diff --git a/drivers/Makefile b/drivers/Makefile
> index c1bf417..207a0d5 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -74,6 +74,7 @@ obj-y				+= i2c/
>  obj-$(CONFIG_W1)		+= w1/
>  obj-$(CONFIG_POWER_SUPPLY)	+= power/
>  obj-$(CONFIG_HWMON)		+= hwmon/
> +obj-$(CONFIG_SENSORS)		+= sensors/
>  obj-$(CONFIG_THERMAL)		+= thermal/
>  obj-$(CONFIG_WATCHDOG)		+= watchdog/
>  obj-$(CONFIG_PHONE)		+= telephony/
> diff --git a/drivers/sensors/Kconfig b/drivers/sensors/Kconfig
> new file mode 100644
> index 0000000..bc85c90
> --- /dev/null
> +++ b/drivers/sensors/Kconfig
> @@ -0,0 +1,20 @@
> +#
> +# Sensor drivers
> +#
> +
> +menuconfig SENSORS
> +	tristate "Sensor drivers"
> +	depends on HAS_IOMEM
> +	default n
> +	help
> +	  Sensor drivers are for special purpose devices that can monitor
> +	  ambient light, motion, temperature and the like.
> +
> +	  Check file:Documentation/sensors to see which devices are
> +	  currently supported.
> +
> +
> +if SENSORS
> +
> +endif # SENSORS
> +
> diff --git a/drivers/sensors/Makefile b/drivers/sensors/Makefile
> new file mode 100644
> index 0000000..4c629c2
> --- /dev/null
> +++ b/drivers/sensors/Makefile
> @@ -0,0 +1,4 @@
> +#
> +# Makefile for sensor chip drivers.
> +#
> +
> -- 
> 1.6.1.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
