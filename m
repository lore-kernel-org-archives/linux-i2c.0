From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/6] i2c: add 'set_sda' to bus_recovery_info
Date: Tue, 5 Dec 2017 09:39:48 +0100
Message-ID: <CACRpkdZzwo9UhT08VDHXg6=eXdK80Pt1omZ4Xda_HFwguyNpaw@mail.gmail.com>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com> <20171204123640.3382-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171204123640.3382-4-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Phil Reid <preid@electromag.com.au>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 4, 2017 at 1:36 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> This will be needed when we want to create STOP conditions, too, later.
> Create the needed fields and populate them for the GPIO case if the GPIO
> is set to output.
>
> Cc: Phil Reid <preid@electromag.com.au>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Claudio Foellmi <claudio.foellmi@ergon.ch>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

(...)
>  #include <linux/errno.h>
> +#include <linux/gpio.h>

Please no.

> +                       if (gpiod_get_direction(bri->sda_gpiod) == GPIOF_DIR_OUT)
> +                               bri->set_sda = set_sda_gpio_value;

Just compare it to zero. if (!gpiod_get_direction())

This flag is only for requesting GPIOs in the old API.
We didn't add a define in the new API, it seemed overengineered.

Yours,
Linus Walleij
