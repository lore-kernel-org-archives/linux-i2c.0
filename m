From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2] i2c: i2c-mux-gpio: update mux with
 gpiod_set_array_value_cansleep
Date: Thu, 24 Nov 2016 16:45:49 +0100
Message-ID: <46be889f-a558-0174-f638-c685b23c8ed9@axentia.se>
References: <1479908035-18284-1-git-send-email-peda@axentia.se>
 <20161124151420.GF4271@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161124151420.GF4271@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2016-11-24 16:14, Wolfram Sang wrote:
> Hi Peter,
> 
>> +	int values[mux->data.n_gpios];
> 
> Hmm, my code checkers complain about this line:
> 
>   CHECK   drivers/i2c/muxes/i2c-mux-gpio.c
>     SPARSE
> drivers/i2c/muxes/i2c-mux-gpio.c:29:29: warning: Variable length array is used.
>     SMATCH
> drivers/i2c/muxes/i2c-mux-gpio.c:29:29: warning: Variable length array is used.
> 
> Worth to fix it?

Yes, especially since I spotted an unrelated bug in my patch.
Regarding this though, I just thought (smallish) variable length
arrays were ok. But I guess smallish isn't very exact...

> BTW (unrelated to your patch), the compiler complains about:
> 
> In file included from drivers/i2c/muxes/i2c-mux-gpio.c:18:0:
> drivers/i2c/muxes/../../gpio/gpiolib.h:88:27: warning: ‘gpio_suffixes’ defined but not used [-Wunused-const-variable=]
>  static const char * const gpio_suffixes[] = { "gpios", "gpio" };
> 
> which pointed out this line to me:
> 
>  18 #include "../../gpio/gpiolib.h"
> 
> which is probably worth fixing, too?

Yes, I never liked that include, but I don't know how to get
from struct gpio_desc * to the relevant struct device *
without it...

It's this line that needs it:

	gpio_dev = &gpio_dec->gdev->dev;

If you can replace it with something neater, go for it!

Cheers,
Peter
