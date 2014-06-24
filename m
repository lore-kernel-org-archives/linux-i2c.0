From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] gpio: crystalcove: Fix implicit declaration of function
 'seq_printf' error
Date: Tue, 24 Jun 2014 11:26:43 +0100
Message-ID: <20140624102643.GJ13803@lee--X1>
References: <1403265753-25851-1-git-send-email-lee.jones@linaro.org>
 <1403265753-25851-3-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403265753-25851-3-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hmm... a leftover patch in my 'send' directory I feel!

Please ignore.

> drivers/gpio/gpio-crystalcove.c: In function 'crystalcove_gpio_dbg_sh=
ow':
> drivers/gpio/gpio-crystalcove.c:286:3: error: implicit declaration of=
 function 'seq_printf'
>    seq_printf(s, " gpio-%-2d %s %s %s %s ctlo=3D%2x,%s %s %s\n",
>=20
> Reported-by: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/gpio/gpio-crystalcove.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crys=
talcove.c
> index 5a98499..934462f 100644
> --- a/drivers/gpio/gpio-crystalcove.c
> +++ b/drivers/gpio/gpio-crystalcove.c
> @@ -18,6 +18,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/gpio.h>
> +#include <linux/seq_file.h>
>  #include <linux/bitops.h>
>  #include <linux/regmap.h>
>  #include <linux/mfd/intel_soc_pmic.h>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
