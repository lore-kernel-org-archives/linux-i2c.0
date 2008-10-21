From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c driver for Maxim max9485 audio
	clock	generator chip
Date: Tue, 21 Oct 2008 09:45:16 +0100
Message-ID: <20081021084516.GA764@fluff.org.uk>
References: <20081021030205.2494.55081.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20081021030205.2494.55081.stgit@terra>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 20, 2008 at 11:02:05PM -0400, Jon Smirl wrote:
> Signed-off-by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/chips/Kconfig   |    9 ++++
>  drivers/i2c/chips/Makefile  |    1 
>  drivers/i2c/chips/max9485.c |  106 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/max9485.h |   38 +++++++++++++++
>  4 files changed, 154 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/chips/max9485.c
>  create mode 100644 include/linux/i2c/max9485.h
> 
> diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
> index 1735682..bc2a6d3 100644
> --- a/drivers/i2c/chips/Kconfig
> +++ b/drivers/i2c/chips/Kconfig
> @@ -40,6 +40,15 @@ config AT24
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called at24.
>  
> +config MAX9485
> +	tristate "Maxim MAX9485 Programmable Audio Clock Generator"
> +	help
> +	  If you say yes here you get support for Maxim MAX9485 
> +	  Programmable Audio Clock Generator.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called max9485.
> +
>  config SENSORS_EEPROM
>  	tristate "EEPROM reader"
>  	depends on EXPERIMENTAL
> diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
> index ca520fa..1560baf 100644
> --- a/drivers/i2c/chips/Makefile
> +++ b/drivers/i2c/chips/Makefile
> @@ -11,6 +11,7 @@
>  
>  obj-$(CONFIG_DS1682)		+= ds1682.o
>  obj-$(CONFIG_AT24)		+= at24.o
> +obj-$(CONFIG_MAX9485)		+= max9485.o
>  obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
>  obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
>  obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
> diff --git a/drivers/i2c/chips/max9485.c b/drivers/i2c/chips/max9485.c
> new file mode 100644
> index 0000000..65058b4
> --- /dev/null
> +++ b/drivers/i2c/chips/max9485.c
> @@ -0,0 +1,106 @@
> +/*
> + * Maxim max9485 Programmable Audio Clock Generator driver
> + *
> + * Written by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + *
> + * Copyright (C) Digispeaker.com

you need a date at which you are claiming the copyright. I'd also
check that (C) in a big symbol is a legally recognised substitute
for an small c in an circle.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
