From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 4/6] Add Advantech iManager I2C driver
Date: Mon, 18 Jan 2016 07:41:46 +0000
Message-ID: <20160118074146.GI28745@x1>
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
 <1452468675-5827-5-git-send-email-richard.dorsch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1452468675-5827-5-git-send-email-richard.dorsch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: richard.dorsch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, jo.sunga-ELdSlb/RfAS1Z/+hSey0Gg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 10 Jan 2016, richard.dorsch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> From: Richard Vidal-Dorsch <richard.dorsch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> Signed-off-by: Richard Vidal-Dorsch <richard.dorsch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/i2c/busses/i2c-imanager |  48 ++++
>  drivers/i2c/busses/Kconfig            |  11 +
>  drivers/i2c/busses/Makefile           |   2 +
>  drivers/i2c/busses/imanager-ec-i2c.c  | 466 ++++++++++++++++++++++++=
++++++++++
>  drivers/i2c/busses/imanager-i2c.c     | 239 +++++++++++++++++
>  include/linux/mfd/imanager/i2c.h      |  55 ++++

Same comments as Watchdog and HWMON.

>  6 files changed, 821 insertions(+)
>  create mode 100644 Documentation/i2c/busses/i2c-imanager
>  create mode 100644 drivers/i2c/busses/imanager-ec-i2c.c
>  create mode 100644 drivers/i2c/busses/imanager-i2c.c
>  create mode 100644 include/linux/mfd/imanager/i2c.h

[...]

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
