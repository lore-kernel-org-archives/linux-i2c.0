From: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: pca954x: Fix reset GPIO property name
Date: Tue, 3 Jun 2014 10:38:53 +0900
Message-ID: <538D272D.5050406@nvidia.com>
References: <1401754973-13274-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401754973-13274-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 06/03/2014 09:22 AM, Laurent Pinchart wrote:
> The DT bindings for the pca954x document that the reset GPIO is
> specified through the "reset-gpios" property. However, the driver
> erroneously uses a property name of "reset-gpio".
>
> The GPIO DT bindings documentation mentions that
>
> "GPIO properties should be named "[<name>-]gpios". The exact meaning of
> each gpios property must be documented in the device tree binding for
> each device."
>
> The correct reset GPIO property name is thus "reset-gpios". Fix the
> driver accordingly.

The plural form should be preferred indeed.

>
> Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>   drivers/i2c/muxes/i2c-mux-pca954x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> While commit dd34c37aa3e81715a1ed8da61fa438072428e188
>
> Author: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Date:   Wed Apr 23 17:28:09 2014 +0200
>
>      gpio: of: Allow -gpio suffix for property names
>
>      Many bindings use the -gpio suffix in property names. Support this in
>      addition to the -gpios suffix when requesting GPIOs using the new
>      descriptor-based API.
>
> adds support for the singular form of the property, the GPIO DT bindings
> document the plural form only. I've thus decided to fix the driver instead of
> the bindings, even though it could be argued that the singular form makes more
> sense in this case. I've CC'ed the people involved with the above commit for
> comments on that, and have no issue fixing the bindings instead of the driver
> if the singular form is preferred.
>
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index 550bd36..73491ca 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -205,7 +205,7 @@ static int pca954x_probe(struct i2c_client *client,
>   		int gpio;
>
>   		/* Get the mux out of reset if a reset GPIO is specified. */
> -		gpio = of_get_named_gpio_flags(np, "reset-gpio", 0, &flags);
> +		gpio = of_get_named_gpio_flags(np, "reset-gpios", 0, &flags);

Won't this break DT compatibility for potential users of this driver? (I 
cannot find any in mainline though)

Considering that this GPIO is only acquired and set once and for all 
during probe (a very simple use-case), how about switching this to the 
gpiod interface instead? That way, you can take advantage of Thierry's 
patch and the plural form will work while also maintaining the singular 
form for backward compatibility.

Alex.
