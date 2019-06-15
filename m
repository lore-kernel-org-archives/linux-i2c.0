From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: mux-gpio: Use "mux" con_id to find channel GPIOs
Date: Sat, 15 Jun 2019 14:43:09 +0300
Message-ID: <CAHp75VcwP8DzhqfOn=cbcRQtd8WrnuoFPT6GCU754drTZePheg@mail.gmail.com>
References: <20190614214748.2389-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190614214748.2389-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Serge Semin <Sergey.Semin@t-platforms.ru>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 15, 2019 at 12:51 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Recent patch - ("i2c: mux/i801: Switch to use descriptor passing")
> altered the i2c-mux-gpio driver to use the GPIO-descriptor
> based interface to find and request the GPIOs then being utilized
> to select and deselect the channels of GPIO-driven i2c-muxes. Even
> though the proposed modification was correct for the platform_data-based
> systems, it was invalid for the OF-based ones and caused the kernel
> to crash at the driver probe procedure. There were two problems with
> that modification. First of all the gpiod_count() and gpiod_get_index()
> were called with NULL con_id.

I always thought that this means "count me all GPIO's for this device
despite their names" and "get me GPIO by index despite it's name".
What's went wrong?


> Due to this the methods couldn't find
> the "mux-gpios" OF-properties and returned the -ENOENT error. Secondly
> the return value of gpiod_count() wasn't checked for being negative,
> which in case of an error caused the driver to crash. This patch
> is intended to fix the described problems.

-- 
With Best Regards,
Andy Shevchenko
