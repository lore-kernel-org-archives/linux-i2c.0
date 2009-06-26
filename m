From: Jaswinder Singh Rajput <jaswinder-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] hwmon: add GP2A002 proximity/ambient sensor
Date: Fri, 26 Jun 2009 14:46:00 +0530
Message-ID: <1246007760.3067.5.camel@hpdv5.satnam>
References: <4A448926.1030701@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A448926.1030701-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, suchang.woo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2009-06-26 at 17:39 +0900, Minkyu Kang wrote:
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

> diff --git a/include/linux/gp2ap002.h b/include/linux/gp2ap002.h
> new file mode 100644
> index 0000000..b6a950b
> --- /dev/null
> +++ b/include/linux/gp2ap002.h
> @@ -0,0 +1,21 @@
> +/*
> + *  Copyright (C) 2009 Samsung Electronics
> + *  Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __GP2AP002_H_
> +#define __GP2AP002_H_
> +
> +struct gp2ap002_platform_data {
> +	int (*get_adc)(void);
> +	void (*power_enable)(int);
> +	int vo_gpio;
> +	int prox_mode;
> +	int enable;
> +};
> +
> +#endif

I am curious what is the use of include/linux/gp2ap002.h, it only have
gp2ap002_platform_data structure which you can keep in your source file
the only file which is using it.

Thanks,
--
JSR
