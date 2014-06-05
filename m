From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] i2c: pca954x: Fix compilation without CONFIG_GPIOLIB
Date: Thu, 05 Jun 2014 10:57:41 +0900
Message-ID: <007001cf8061$89337e30$9b9a7a90$%han@samsung.com>
References: <CA+r1Zhi9Qd4aZ2WJ02K4Gv=zg7QvG+r=t2VpiXRKXcYRc1vt=A@mail.gmail.com>
 <1401900992-16581-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-reply-to: <1401900992-16581-1-git-send-email-laurent.pinchart@ideasonboard.com>
Content-language: ko
Sender: linux-next-owner@vger.kernel.org
To: 'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, wsa@the-dreams.de, khali@linux-fr.org, linus.walleij@linaro.org, paul.gortmaker@windriver.com, 'Stephen Rothwell' <sfr@canb.auug.org.au>, 'Jim Davis' <jim.epost@gmail.com>, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-i2c@vger.kernel.org

On Thursday, June 05, 2014 1:57 AM, Laurent Pinchart write/l
>=20
> The pca954x driver recently switched to the GPIO descriptor API witho=
ut
> including the correct <linux/gpio/consumer.h> header. This breaks
> compilation without CONFIG_GPIOLIB.
>=20
> drivers/i2c/muxes/i2c-mux-pca954x.c: In function =E2=80=98pca954x_pro=
be=E2=80=99:
> drivers/i2c/muxes/i2c-mux-pca954x.c:204:2: error: implicit declaratio=
n
> of function =E2=80=98devm_gpiod_get=E2=80=99 [-Werror=3Dimplicit-func=
tion-declaration]
>   gpio =3D devm_gpiod_get(&client->dev, "reset");
>   ^
> drivers/i2c/muxes/i2c-mux-pca954x.c:204:7: warning: assignment makes
> pointer from integer without a cast [enabled by default]
>   gpio =3D devm_gpiod_get(&client->dev, "reset");
>        ^
> drivers/i2c/muxes/i2c-mux-pca954x.c:206:3: error: implicit declaratio=
n
> of function =E2=80=98gpiod_direction_output=E2=80=99
> [-Werror=3Dimplicit-function-declaration]
>    gpiod_direction_output(gpio, 0);
>    ^
> cc1: some warnings being treated as errors
> make[3]: *** [drivers/i2c/muxes/i2c-mux-pca954x.o] Error 1
>=20
> Fix it by including the right header.
>=20
> Reported-by: Jim Davis <jim.epost@gmail.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/=
i2c-mux-pca954x.c
> index c2c443f..9bd4212 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -36,12 +36,11 @@
>   */
>=20
>  #include <linux/device.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-mux.h>
>  #include <linux/i2c/pca954x.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
>  #include <linux/slab.h>
>=20
>  #define PCA954X_MAX_NCHANS 8
> --
> Regards,
>=20
> Laurent Pinchart
