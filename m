From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH 0/9] Unify i2c_mux_add_adapter error reporting
Date: Tue, 11 Apr 2017 10:08:21 +0200
Message-ID: <5f70e59b-f832-f123-6901-ab89b45e7d70@axentia.se>
References: <1491208718-32068-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491208718-32068-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2017-04-03 10:38, Peter Rosin wrote:
> Hi!
> 
> Many users of the i2c_mux_add_adapter interface log a message
> on failure, but the function already logs such a message. One
> or two of those users actually add more information than already
> provided by the central failure message.
> 
> So, first fix the central error reporting to provide as much
> information as any current user, and then remove the surplus
> error reporting at the call sites.

I have now pushed patches 1-7 to i2c-mux/for-next.
Jonathan grabbed patch 8 and it's going through the iio tree.
Still waiting on patch 9 and the media maintainers.

Cheers,
Peter

> 
> Cheers,
> peda
> 
> Peter Rosin (9):
>   i2c: mux: provide more info on failure in i2c_mux_add_adapter
>   i2c: arb: gpio-challenge: stop double error reporting
>   i2c: mux: gpio: stop double error reporting
>   i2c: mux: pca9541: stop double error reporting
>   i2c: mux: pca954x: stop double error reporting
>   i2c: mux: pinctrl: stop double error reporting
>   i2c: mux: reg: stop double error reporting
>   iio: gyro: mpu3050: stop double error reporting
>   [media] cx231xx: stop double error reporting
> 
>  drivers/i2c/i2c-mux.c                      |  9 ++++++---
>  drivers/i2c/muxes/i2c-arb-gpio-challenge.c |  4 +---
>  drivers/i2c/muxes/i2c-mux-gpio.c           |  4 +---
>  drivers/i2c/muxes/i2c-mux-pca9541.c        |  4 +---
>  drivers/i2c/muxes/i2c-mux-pca954x.c        |  7 +------
>  drivers/i2c/muxes/i2c-mux-pinctrl.c        |  4 +---
>  drivers/i2c/muxes/i2c-mux-reg.c            |  4 +---
>  drivers/iio/gyro/mpu3050-i2c.c             |  5 ++---
>  drivers/media/usb/cx231xx/cx231xx-i2c.c    | 15 ++++-----------
>  9 files changed, 18 insertions(+), 38 deletions(-)
> 
