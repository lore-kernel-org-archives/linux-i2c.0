From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: pca954x needs gpiolib
Date: Thu, 05 Jun 2014 13:36:12 +0200
Message-ID: <3104966.JoqjcbmMru@avalon>
References: <17059569.EZXzqhtzTf@wuerfel> <6840846.92XabYdCA4@avalon> <4499715.bEb4MNR8Tt@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4499715.bEb4MNR8Tt@wuerfel>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Arnd,

On Thursday 05 June 2014 13:24:16 Arnd Bergmann wrote:
> On Thursday 05 June 2014 12:56:08 Laurent Pinchart wrote:
> > On Thursday 05 June 2014 12:44:47 Arnd Bergmann wrote:
> > > commit 4807e8459bce ("i2c: mux: pca954x: Use the descriptor-based GPIO
> > > API") moved this driver over to the gpio descriptor API, which means
> > > we now have a dependency on GPIOLIB and get this build error when
> > > it is disabled:
> > > 
> > > i2c/muxes/i2c-mux-pca954x.c: In function 'pca954x_probe':
> > > i2c/muxes/i2c-mux-pca954x.c:204:2: error: implicit declaration of
> > > function
> > > 'devm_gpiod_get' [-Werror=implicit-function-declaration] gpio =
> > > devm_gpiod_get(&client->dev, "reset");
> > >   ^
> > > 
> > > i2c/muxes/i2c-mux-pca954x.c:204:7: warning: assignment makes pointer
> > > from
> > > integer without a cast [enabled by default] gpio =
> > > devm_gpiod_get(&client->dev, "reset");
> > >        ^
> > > 
> > > i2c/muxes/i2c-mux-pca954x.c:206:3: error: implicit declaration of
> > > function
> > > 'gpiod_direction_output' [-Werror=implicit-function-declaration]
> > > gpiod_direction_output(gpio, 0);
> > >    ^
> > > 
> > > This adds the dependency in Kconfig as we do for other similar drivers.
> > 
> > I've sent "i2c: pca954x: Fix compilation without CONFIG_GPIOLIB"
> > yesterday, which fixes the compilation issue by including
> > <linux/gpio/consumer.h>. When CONFIG_GPIOLIB isn't set the header defines
> > stub functions, keeping the driver usable without GPIOLIB support.
> 
> Ok, makes sense. Should we remove the 'depends on GPIOLIB' from other
> drivers doing the same, too?

When the GPIO is optional I think so.

-- 
Regards,

Laurent Pinchart
