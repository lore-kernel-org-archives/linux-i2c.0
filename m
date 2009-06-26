From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] hwmon: add GP2A002 proximity/ambient sensor
Date: Fri, 26 Jun 2009 11:30:59 +0200
Message-ID: <20090626113059.4c0c2fb3@hyperion.delvare>
References: <4A448926.1030701@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A448926.1030701-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, suchang.woo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 26 Jun 2009 17:39:02 +0900, Minkyu Kang wrote:
> The GP2A002 is a I2C interfaced Sensor for Proximity/Ambient
> This patch adds support the GP2A002 sensor
> 
> Signed-off-by: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Suchang Woo <suchang.woo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/hwmon/Kconfig    |    7 +
>  drivers/hwmon/Makefile   |    1 +
>  drivers/hwmon/gp2ap002.c |  471 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/gp2ap002.h |   21 ++
>  4 files changed, 500 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/gp2ap002.c
>  create mode 100644 include/linux/gp2ap002.h
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2d50166..cc4e200 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1017,6 +1017,13 @@ config SENSORS_APPLESMC
>  	  Say Y here if you have an applicable laptop and want to experience
>  	  the awesome power of applesmc.
>  
> +config SENSORS_GP2AP002
> +	tristate "GP2AP002 series Proximity/Ambient Sensor"
> +	depends on HWMON && I2C
> +	help
> +	  This driver provides support for Proximity/Ambient Sensor.
> +

This doesn't have anything to do with hardware monitoring, so this
doesn't belong to drivers/hwmon.

-- 
Jean Delvare
