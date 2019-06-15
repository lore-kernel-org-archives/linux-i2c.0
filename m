From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH] i2c: mux-gpio: Use "mux" con_id to find channel GPIOs
Date: Sun, 16 Jun 2019 02:24:07 +0300
Message-ID: <20190615232406.ni3ausfjaz5qowib@mobilestation>
References: <20190614214748.2389-1-fancer.lancer@gmail.com>
 <CAHp75VcwP8DzhqfOn=cbcRQtd8WrnuoFPT6GCU754drTZePheg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VcwP8DzhqfOn=cbcRQtd8WrnuoFPT6GCU754drTZePheg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Serge Semin <Sergey.Semin@t-platforms.ru>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 15, 2019 at 02:43:09PM +0300, Andy Shevchenko wrote:
> On Sat, Jun 15, 2019 at 12:51 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Recent patch - ("i2c: mux/i801: Switch to use descriptor passing")
> > altered the i2c-mux-gpio driver to use the GPIO-descriptor
> > based interface to find and request the GPIOs then being utilized
> > to select and deselect the channels of GPIO-driven i2c-muxes. Even
> > though the proposed modification was correct for the platform_data-based
> > systems, it was invalid for the OF-based ones and caused the kernel
> > to crash at the driver probe procedure. There were two problems with
> > that modification. First of all the gpiod_count() and gpiod_get_index()
> > were called with NULL con_id.
> 
> I always thought that this means "count me all GPIO's for this device
> despite their names" and "get me GPIO by index despite it's name".
> What's went wrong?
> 

No. It's wrong as far as I can see for kernels 4.4, 4.9 and the modern
5.2.0-rcX. dt_gpio_count()/of_find_gpio()will always try to count/request
either "<con_id>-gpio(s)" or "gpio(s)" GPIOs in the device of-node. While
platform_gpio_count()/gpiod_find() will take into account GPIOs with matching
<con_id>'s even if it is NULL.

Regards,
-Sergey

> 
> > Due to this the methods couldn't find
> > the "mux-gpios" OF-properties and returned the -ENOENT error. Secondly
> > the return value of gpiod_count() wasn't checked for being negative,
> > which in case of an error caused the driver to crash. This patch
> > is intended to fix the described problems.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
