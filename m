From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 6/6] Add Advantech iManager Watchdog driver
Date: Mon, 18 Jan 2016 07:38:05 +0000
Message-ID: <20160118073805.GG28745@x1>
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
 <1452468675-5827-7-git-send-email-richard.dorsch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1452468675-5827-7-git-send-email-richard.dorsch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: richard.dorsch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, jo.sunga-ELdSlb/RfAS1Z/+hSey0Gg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 10 Jan 2016, richard.dorsch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> From: Richard Vidal-Dorsch <richard.dorsch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Some more information required about the device here.

> Signed-off-by: Richard Vidal-Dorsch <richard.dorsch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/watchdog/Kconfig           |  12 ++
>  drivers/watchdog/Makefile          |   2 +
>  drivers/watchdog/imanager-ec-wdt.c | 170 +++++++++++++++++++
>  drivers/watchdog/imanager-wdt.c    | 333 +++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/imanager/wdt.h   |  37 +++++

Please relocate this to include/linux/watchdog.

>  5 files changed, 554 insertions(+)
>  create mode 100644 drivers/watchdog/imanager-ec-wdt.c
>  create mode 100644 drivers/watchdog/imanager-wdt.c
>  create mode 100644 include/linux/mfd/imanager/wdt.h

[...]

> diff --git a/include/linux/mfd/imanager/wdt.h b/include/linux/mfd/ima=
nager/wdt.h
> new file mode 100644
> index 0000000..eb709b7
> --- /dev/null
> +++ b/include/linux/mfd/imanager/wdt.h
> @@ -0,0 +1,37 @@
> +/*
> + * Advantech iManager Watchdog core
> + *
> + * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
> + * Author: Richard Vidal-Dorsch <richard.dorsch-ELdSlb/RfAS1Z/+hSey0Gg@public.gmane.org>
> + *
> + * This program is free software; you can redistribute  it and/or mo=
dify it
> + * under  the terms of  the GNU General  Public License as published=
 by the
> + * Free Software Foundation;  either version 2 of the  License, or (=
at your
> + * option) any later version.
> + */
> +
> +#ifndef __WDT_H__
> +#define __WDT_H__

These need to be less generic.

> +#include <linux/types.h>
> +
> +enum wdt_event {
> +	DELAY,
> +	PWRBTN,
> +	NMI,
> +	RESET,
> +	WDPIN,
> +	SCI,
> +};

Unless shared between other source files, this should probably move
into the driver.

> +int wdt_core_init(void);
> +
> +int wdt_core_set_timeout(enum wdt_event type, u32 timeout);
> +
> +int wdt_core_disable_all(void);
> +int wdt_core_start_timer(void);
> +int wdt_core_stop_timer(void);
> +int wdt_core_reset_timer(void);
> +int wdt_core_stop_boot_timer(void);

What's the point of these?

> +#endif
> --=20
> 2.7.0
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
