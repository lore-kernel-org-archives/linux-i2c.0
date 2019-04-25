From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 0/5] i2c-mux-gpio: Split plat- and dt-specific code up
Date: Thu, 25 Apr 2019 17:37:57 +0300
Message-ID: <20190425143755.vmz3l52hrxtqu43z@mobilestation>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
 <93214e50-6f69-0e7a-c725-5e95c1bbdb45@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <93214e50-6f69-0e7a-c725-5e95c1bbdb45@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Peter Korsgaard <peter.korsgaard@barco.com>, Serge Semin <Sergey.Semin@t-platforms.ru>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 24, 2019 at 09:25:24PM +0000, Peter Rosin wrote:

Hello Peter,

> On 2019-04-24 14:34, Serge Semin wrote:
> > The main idea of this patchset was to add the dt-based GPIOs support
> > in i2c-mux-gpio driver. In particular we needed to have the full GPIOs
> > specifier being handled including the dt-flags like GPIO_ACTIVE_HIGH,
> > GPIO_ACTIVE_LOW, etc. Due to using a legacy GPIO interface the former
> > driver implementation didn't provide this ability.
> 
> I'm curious why active low/high is of any importance? That will only affect
> the state numbering, but I fail to see any relevance in that numbering. It's
> just numbers, no?
> 
> If all the pins are inverted (anything else seems very strange), just
> reverse the order. I.e. for a 4-way mux, use 3, 2, 1, 0 instead of
> 0, 1, 2, 3.
> 
> Why not?

I may misunderstood you, but active low/high flag has nothing to do with
pins ordering. It is relevant to an individual pin setting, most likely
related with hardware setup.

Here is a simple example:
i2cmux {
                compatible = "i2c-mux-gpio";
                mux-gpios = <&gpioa 0 GPIO_ACTIVE_LOW
                             &control 2 GPIO_ACTIVE_HIGH
                             &last 5 GPIO_ACTIVE_LOW>;
};

In this setup we've got some i2c-mux with GPIOs-driven channel selector.
First channel is selected by GPIO#0 of controller &gpioa, second one -
by GPIO#2 of controller &control and third - by GPIO#3 of controller
&last. In accordance with the i2c_mux_gpio_set() method of i2c-mux-gpio
driver a GPIO from this set will be driven high in case of a corresponding
mux channel being enabled. But as you can see from the "mux-gpios" property
these GPIOs aren't identical. First of all they belong to different
controller and most importantly they've got different active-attribute.
This attribute actually means the straight or inverted activation policy.
So in case of ACTIVE_HIGH flag you get a straight policy. If you set GPIO'
value the hardware pin will be driven high, and if you clear it GPIO'
value the hardware pin will be pushed to ground. In case ACTIVE_LOW flag
is specified, the GPIO and actual hardware pin values are inverted.
So if you set GPIO to one, the hardware pin will be driven to zero,
and vise-versa. All this logic is implemented in the gpiod subsystem
of the kernel and can be defined in dts scripts, while legacy GPIO
subsystem relied on the drivers to handle this.

Yeah, it might be confusing, but some hardware is designed this way, so
the ordinary GPIO outputs are inverted on the way to the i2c-mux channel
activators. For instance in case if some level-shifter is used as a single
channel i2c-mux and we don't want i2c-bus being always connected to a bus
behind it. Such level-shifters are usually activated by ACTIVE_LOW signals.

In addition there are other than ACTIVE_LOW/ACTIVE_HIGH flags available for
GPIOs in dts, like GPIO_PUSH_PULL, GPIO_OPEN_DRAIN, GPIO_OPEN_SOURCE, which are
also specific not only to the GPIO functionality but to the target port and
hardware design in general. So the support of dt- GPIO-specifiers is very
important to properly describe the hardware setup.

-Sergey

> 
> Cheers,
> Peter
> 
> > On the way of adding the full dt-GPIO flags support a small set of
> > refactorings has been done in order to keep the platform_data-based
> > systems support, make the code more readable and the alterations - clearer.
> > In general the whole changes might be considered as the plat- and dt-
> > specific code split up. In first patch we unpinned the platform-specific
> > method of GPIO-chip probing. The second patch makes the driver to return
> > an error if of-based (last resort path) failed to retrieve the driver
> > private data. The next three patches is the sequence of initial channel
> > info retrieval, platform_data-specific code isolation and finally full
> > dt-based GPIOs request method introduction. The last patch does what
> > we inteded this patchset for in the first place - adds the full dt-GPIO
> > specifiers support.
> > 
> > 
> > Serge Semin (5):
> >   i2c-mux-gpio: Unpin a platform-based device initialization
> >   i2c-mux-gpio: Return an error if no config data found
> >   i2c-mux-gpio: Save initial channel number to the idle data field
> >   i2c-mux-gpio: Unpin the platform-specific GPIOs request code
> >   i2c-mux-gpio: Create of-based GPIOs request method
> > 
> >  drivers/i2c/muxes/i2c-mux-gpio.c | 224 ++++++++++++++++++++-----------
> >  1 file changed, 146 insertions(+), 78 deletions(-)
> > 
> 
