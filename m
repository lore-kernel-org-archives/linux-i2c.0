From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCHv3] i2c: add generic I2C multiplexer using gpio api
Date: Tue, 30 Nov 2010 15:02:44 +0100
Message-ID: <87aakqykmz.fsf@macbook.be.48ers.dk>
References: <1291050486-12000-1-git-send-email-peter.korsgaard@barco.com>
	<20101130112958.30b72f39@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101130112958.30b72f39-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org> (Jean Delvare's
	message of "Tue, 30 Nov 2010 11:29:58 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Jean" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:

 Jean> Hi Peter,
 Jean> Thanks for the updated patch.

You're welcome. Thanks for the feedback.


 >> SCL/SDA of the master I2C bus is multiplexed to virtual bus 1..M
 >> according to the settings of the GPIO pins 1..N.

 Jean> Again: these are not virtual buses. These are bus segments behind a
 Jean> mux, and they are as real as the trunk segment in front of the mux.

Ok, I renamed every instance of 'virtual bus' with 'bus segment'.


 Jean> I'm eager to give it a try on my own PC system, where the SMBus
 Jean> is multiplexed using ICH10 GPIO pins. Unfortunately I don't think
 Jean> there is a driver for the Intel ICH GPIO pins, so I'll have to
 Jean> write one. And then I'll have to write some glue code to
 Jean> instantiate the relevant platform device on my system. I'll let
 Jean> you know when I get there.

Nice!


 >> +static struct gpio_i2cmux_platform_data myboard_i2cmux_data = {
 >> +	.parent		= 1,
 >> +	.base_nr	= 2, /* optional */
 >> +	.values		= myboard_gpiomux_values,
 >> +	.n_values	= ARRAY_SIZE(myboard_gpiomux_values),
 >> +	.gpio		= myboard_gpiomux_gpios,

 Jean> .gpios

 >> +	.gpios		= ARRAY_SIZE(myboard_gpiomux_gpios),

 Jean> .n_gpios

Ups, fixed.


 >> +GENERIC GPIO I2C MULTIPLEXER DRIVER
 >> +M:	Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
 >> +L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 >> +S:	Supported
 >> +F:	drivers/i2c/muxes/gpio-i2cmux.c
 >> +F:	include/linux/gpio-i2mux.h

 Jean> Typo: gpio-i2cmux.h. And you're missing:

 Jean> F:	Documentation/i2c/muxes/gpio-i2cmux

Fixed.


 >> + config I2C_MUX_GPIO
 >> +	tristate "GPIO-based I2C multiplexer"
 >> +	depends on GENERIC_GPIO
 >> +	help
 >> +	  If you say yes to this option, support will be included for a
 >> +	  GPIO based I2C multiplexer. This driver provides access to
 >> +	  I2C busses connected through a MUX, which is controlled
 >> +	  through GPIO pins.
 >> +
 >> +	  This driver can also be built as a module.  If so, the module
 >> +	  will be called gpio-i2cmux.
 >> +

 Jean> Alphabetic order -> goes at the beginning of the list.

 >> +obj-$(CONFIG_I2C_MUX_GPIO)	+= gpio-i2cmux.o

 Jean> Alphabetic order -> goes at the beginning of the list.

Fixed.


 >> +	for (i = 0; i < pdata->n_values; i++) {
 >> +		u32 nr = pdata->base_nr ? (pdata->base_nr + i) : 0;
 >> +		bool has_idle = (pdata->idle != (unsigned)-1);

 Jean> has_idle doesn't depend on i, so it would be more efficiently set
 Jean> outside the loop. You could even store a function pointer instead of a
 Jean> boolean value, to be even more efficient.

 Jean> BTW, would it make sense to

 Jean> #define GPIO_I2CMUX_NO_IDLE	((unsigned)-1)

 Jean> to avoid arbitrary cast and constant in the code?

Ok, added define to platform header, and changed the probe code to use
a function pointer instead.


Will send v4 shortly - Thanks for the review.

-- 
Bye, Peter Korsgaard
