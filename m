From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCHv2,resend] i2c: add generic I2C multiplexer using gpio api
Date: Mon, 29 Nov 2010 16:58:19 +0100
Message-ID: <87mxosxgtg.fsf@macbook.be.48ers.dk>
References: <1288797243-8074-1-git-send-email-jacmet@sunsite.dk>
	<20101122175048.235062c1@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101122175048.235062c1-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org> (Jean Delvare's
	message of "Mon, 22 Nov 2010 17:50:48 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "Jean" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:

 Jean> Hi Peter,
 Jean> Sorry and the late answer.

Thanks for the feedback, see below for a few comments.

 >> +++ b/Documentation/i2c/busses/i2c-gpiomux
 >> @@ -0,0 +1,65 @@
 >> +Kernel driver i2c-gpiomux
 >> +
 >> +Author: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
 >> +
 >> +Description
 >> +-----------
 >> +
 >> +i2c-gpiomux is an i2c bus driver providing virtual I2C busses from a

 Jean> It is an i2c mux driver now.

Fixed.

 >> +Usage
 >> +-----
 >> +
 >> +i2c-gpiomux uses the platform bus, so you need to provide a struct
 >> +platform_device with the platform_data pointing to a struct
 >> +gpiomux_i2c_platform_data with the I2C adapter number of the master

 Jean> The structure should be named i2c_gpiomux_platform_data, so that the
 Jean> prefix matches the driver name (but see below).

Fixed - It's now gpio_i2cmux_platform_data.


 >> +bus, the number of virtual busses to create and the GPIO pins used
 >> +to control it. See include/linux/i2c-gpiomux.h for details.
 >> +
 >> +E.G. something like this for a MUX providing 4 virtual busses
 >> +controlled through 3 GPIO pins:
 >> +
 >> +#include <linux/i2c-gpiomux.h>
 >> +#include <linux/platform_device.h>
 >> +
 >> +static unsigned myboard_gpiomux_pins[] = {
 >> +	AT91_PIN_PC26, AT91_PIN_PC25, AT91_PIN_PC24
 >> +};
 >> +
 >> +static unsigned myboard_gpiomux_values[] = {
 >> +	0, 1, 2, 3
 >> +};
 >> +
 >> +static struct gpiomux_i2c_platform_data myboard_i2cmux_data = {
 >> +	.parent		= 1,
 >> +	.base_nr	= 2,

 Jean> There might be no need to specify the numbers of the child I2C segments.
 Jean> Your driver should handle the case where base_nr isn't set, and not ask
 Jean> for specific i2c_adpater numbers then.

Base_nr is now optional.


 >> +	.busses		= ARRAY_SIZE(myboard_gpiomux_values),
 >> +	.gpios		= ARRAY_SIZE(myboard_gpiomux_pins),
 >> +	.gpio		= myboard_gpiomux_pins,
 >> +	.values		= myboard_gpiomux_values,

 Jean> I find your naming convention (or lack thereof) confusing. What about:

 Jean> 	.values		= myboard_gpiomux_values,
 Jean> 	.n_values	= ARRAY_SIZE(myboard_gpiomux_values),
 Jean> 	.pins		= myboard_gpiomux_pins,
 Jean> 	.n_pins		= ARRAY_SIZE(myboard_gpiomux_pins),

 Jean> This would be more consistent and obvious.

Ok, renamed. I'm using gpios/n_gpios instead though, as that is what
they are.

 >> +	.idle		= 4,

 Jean> This should be optional. Not all hardware setup can actually disable
 Jean> all children.

I've made idle == (unsigned)-1 signal no idle support (cannot use 0, as
that's a fairly common idle value).


 >> +};
 >> +
 >> +static struct platform_device myboard_i2cmux = {
 >> +	.name		= "i2c-gpiomux",
 >> +	.id		= 0,
 >> +	.dev		= {
 >> +		.platform_data	= &myboard_i2cmux_data,
 >> +	},
 >> +};

 Jean> All these structures can presumably be marked const.

Platform_device and the main myboard_i2cmux_data cannot as the API
specifies non const, so you get compiler warnings, but the lowe level
values and gpio arrays can (and I've done so).

 >> + config I2C_GPIOMUX
 >> +	tristate "GPIO-based I2C multiplexer"
 >> +	depends on GENERIC_GPIO
 >> +	help
 >> +	  If you say yes to this option, support will be included for a
 >> +	  GPIO based I2C multiplexer. This driver provides virtual I2C
 >> +	  busses from a master bus through a MUX controlled through

 Jean> There is nothing virtual about these bus segments. They are very real.

Reworded.

 >> obj-$(CONFIG_I2C_MUX_PCA9541)	+= pca9541.o
 >> obj-$(CONFIG_I2C_MUX_PCA954x)	+= pca954x.o
 >> +obj-$(CONFIG_I2C_GPIOMUX)	+= i2c-gpiomux.o

 Jean> It should be obvious from the above that your config option should be
 Jean> named CONFIG_I2C_MUX_GPIO.

Renamed.


 Jean> Not sure about the driver name. i2c-gpiomux makes it look like an i2c core or
 Jean> i2c bus driver, which it is not. Maybe gpio-i2cmux would be better? I
 Jean> see we already have drivers named gpio-fan for fans controlled over
 Jean> GPIOs, as well as gpio_mouse and gpio_keys.

Renamed to gpio-i2cmux.

 >> +static void gpiomux_set(struct gpiomux_i2c *i2c, unsigned val)

 Jean> i2c could be a const pointer.

Done.


 >> +{
 >> +	int i;
 >> +
 >> +	for (i = 0;  i < i2c->data.gpios; i++)

 Jean> Double space after the first ";".

 >> +		gpio_set_value(i2c->data.gpio[i], val & (1<<i));

 Jean> Although checkpatch.pl surprisingly doesn't complain, the usual style
 Jean> is to have spaces around "<<".

 >> +static struct platform_driver gpiomux_driver = {
 >> +	.probe  = gpiomux_probe,
 >> +	.remove = __devexit_p(gpiomux_remove),
 >> +	.driver = {

 Jean> Please use tabs to align on "=".

 >> +		.owner = THIS_MODULE,
 >> +		.name = "i2c-gpiomux",

 Jean> And please do the same here, for consistency.

Fixed (all 4).

Thanks for the comments - I'll send a v3 with these fixes shortly.

-- 
Bye, Peter Korsgaard
