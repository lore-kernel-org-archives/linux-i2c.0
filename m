From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Getting at gpio- and pinctrl-devices as a consumer
Date: Fri, 25 Nov 2016 00:29:40 +0100
Message-ID: <CACRpkdb0cdvxgnuOBNfdY+idVcTXMwzKRYfCsFpiRx2qaVrt=w@mail.gmail.com>
References: <1479908035-18284-1-git-send-email-peda@axentia.se>
 <20161124151420.GF4271@katana> <46be889f-a558-0174-f638-c685b23c8ed9@axentia.se>
 <20161124195230.GA1666@katana> <b481ed92-c9d2-b4da-b484-6d8bec6038f0@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <b481ed92-c9d2-b4da-b484-6d8bec6038f0@axentia.se>
Sender: linux-gpio-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa-dev@sang-engineering.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 24, 2016 at 10:35 PM, Peter Rosin <peda@axentia.se> wrote:

> The background is that the gpio- and pinctrl-based i2c-mux drivers
> need to know if the device that is used to control the mux of the
> i2c-bus is also sitting on that very same i2c-bus. If it is, the
> locking has to be different and a bit more relaxed. This relaxed
> mode cannot be used always, as that would change the mux behavior
> in an unacceptable way for stuff expecting the (traditional)
> stricter locking. See Documentation/i2c/i2c-topology for more
> details if you need it.
>
> To check this, the i2c mux drivers dig out the device connected to
> each gpio-pin (or pinctrl-state) and walks up the device tree to see
> if the root i2c adapter that is muxed is in the loop.
>
> When I wrote this code, I could not find a clean way to go from a
> struct gpio_desc * to the relevant device, short of doing
>
>         #include "../../gpio/gpiolib.h"
>
>         gpio_dev = &gpio_desc->gdev->dev;
>
> And similarly for pinctrl:
>
>         #include "../../pinctrl/core.h"
>
>         struct pinctrl_setting *setting;
>         pinctrl_dev = setting->pctldev->dev;
>
> I'm not very proud of that, and wonder if there is a better way
> to get at the needed struct device? If not, then perhaps there
> should be?

Surely if I can be convinced that we need helpers for this
in GPIO and/or pin control we can add them.

They just need to be named something reasonable and
be generally useful for other situations of similar nature.

struct device *gpiod_get_backing_device(struct gpio_desc *d);

Is simple but is it really what you want?

Yours,
Linus Walleij
