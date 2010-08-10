From: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH] [ARM] tegra: Add i2c support
Date: Tue, 10 Aug 2010 17:57:45 +0300
Message-ID: <4C6168E9.1070405@compulab.co.il>
References: <1280450180-25016-1-git-send-email-ccross@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1280450180-25016-1-git-send-email-ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Colin,
Two more comments.

Colin Cross wrote:
> From: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> 
> CC: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig     |    7 +
>  drivers/i2c/busses/Makefile    |    1 +
>  drivers/i2c/busses/i2c-tegra.c |  665 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c-tegra.h      |   25 ++

This should probably go to arch/arm/mach-tegra/include/mach/ to minimize the 
pollution in include/linux

>  4 files changed, 698 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-tegra.c
>  create mode 100644 include/linux/i2c-tegra.h
> 

[ snip ]

> +
> +static int __init tegra_i2c_init_driver(void)
> +{
> +	return platform_driver_register(&tegra_i2c_driver);
> +}
> +module_init(tegra_i2c_init_driver);

subsys_initcall would be better here.

> +
> +static void __exit tegra_i2c_exit_driver(void)
> +{
> +	platform_driver_unregister(&tegra_i2c_driver);
> +}
> +module_exit(tegra_i2c_exit_driver);
> diff --git a/include/linux/i2c-tegra.h b/include/linux/i2c-tegra.h
> new file mode 100644
> index 0000000..9c85da4
> --- /dev/null
> +++ b/include/linux/i2c-tegra.h
> @@ -0,0 +1,25 @@
> +/*
> + * drivers/i2c/busses/i2c-tegra.c
> + *
> + * Copyright (C) 2010 Google, Inc.
> + * Author: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef _LINUX_I2C_TEGRA_H
> +#define _LINUX_I2C_TEGRA_H
> +
> +struct tegra_i2c_platform_data {
> +	unsigned long bus_clk_rate;
> +};
> +
> +#endif /* _LINUX_I2C_TEGRA_H */


-- 
Sincerely yours,
Mike.
