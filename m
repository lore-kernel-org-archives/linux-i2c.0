From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: Using the gpio i2c multiplexer driver
Date: Wed, 16 Feb 2011 06:28:06 -0800
Message-ID: <20110216142806.GA13872@ericsson.com>
References: <1297810054.24938.218.camel@groeck-laptop>
 <87ei789z3g.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ei789z3g.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Peter,

On Wed, Feb 16, 2011 at 03:13:07AM -0500, Peter Korsgaard wrote:
> >>>>> "Guenter" == Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org> writes:
> 
>  Guenter> Hi all,
> 
>  Guenter> I am trying to use the new GPIO based I2C
>  Guenter> multiplexer. Unfortunately, I have an initialization problem
>  Guenter> with it.
> 
>  Guenter> Some time after registering the multiplexer as platform driver, its
>  Guenter> probe function is called. Unfortunately, that does not happen in sync
>  Guenter> with I2C adapter initialization. The GPIO mux probe function is called
>  Guenter> before the parent's (ie the multiplexed I2C adapter) probe function is
>  Guenter> called. As a result, the GPIO mux driver does not find its parent i2c
>  Guenter> adapter, and the probe function aborts with an error.
> 
>  Guenter> Any idea how I I can fix the problem, ie how I can ensure that
>  Guenter> the GPIO mux probe function is only called after its parent
>  Guenter> I2C adapter is initialized ?
> 
> What i2c bus controller are you using? Are you registering it's platform
> data very late (E.G. after you register the platform data for gpiomux)?
> 
It is part of an mfd device. The same device also hosts the multiplexer pin.
The bus drivers and the multiplexer driver are instantiated from the mfd core
driver, so I can control the order.

> If you do register the platform data in the correct order, things SHOULD

The I2C bus driver is registered before the GPIO driver.

> work correctly as busses are listed in drivers/i2c/Makefile before
> muxes, but alternatively you could play with the init order (E.G. use
> subsys_initcall instead of module_init in the bus driver, see
> b8680784875 for an example).
> 

I tried that, but it does not help.

Here is a log:

[   16.027528] spanky_i2c spanky_i2c.12: probe 12
[   16.130652] spanky_i2c spanky_i2c.13: probe 13
[   16.131095] spanky-i2cmux spanky-i2cmux.72: Parent adapter (54) not found
		^^^ This is the (renamed) gpio mux driver
[   16.284040] spanky_i2c spanky_i2c.14: probe 14
[   16.292194] spanky_i2c spanky_i2c.15: probe 15
[   16.300029] spanky_i2c spanky_i2c.18: probe 18
[   16.394173] spanky_i2c spanky_i2c.19: probe 19
[   16.537542] spanky_i2c spanky_i2c.20: probe 20
[   16.544743] spanky_i2c spanky_i2c.21: probe 21
[   16.552497] spanky_i2c spanky_i2c.24: probe 24
[   16.657112] spanky_i2c spanky_i2c.25: probe 25
[   16.806678] spanky_i2c spanky_i2c.26: probe 26
[   16.815207] spanky_i2c spanky_i2c.27: probe 27
[   17.396906] spanky_i2c spanky_i2c.30: probe 30
[   17.500035] spanky_i2c spanky_i2c.31: probe 31
[   17.652316] spanky_i2c spanky_i2c.32: probe 32
[   17.659550] spanky_i2c spanky_i2c.33: probe 33
[   18.137137] spanky_i2c spanky_i2c.36: probe 36
[   18.239038] spanky_i2c spanky_i2c.37: probe 37
[   18.390166] spanky_i2c spanky_i2c.38: probe 38
[   18.400315] spanky_i2c spanky_i2c.39: probe 39
[   18.857240] spanky_i2c spanky_i2c.42: probe 42
[   18.961723] spanky_i2c spanky_i2c.43: probe 43
[   19.117111] spanky_i2c spanky_i2c.44: probe 44
[   19.125823] spanky_i2c spanky_i2c.45: probe 45
[   19.746365] spanky_i2c spanky_i2c.54: probe 54
		^^^ this is where the i2c bus driver is registered
[   19.758068] spanky_i2c spanky_i2c.55: probe 55
[   19.768026] spanky_i2c spanky_i2c.55: Registering I2C device pca9541 at 0x74
[   19.768378] spanky_i2c spanky_i2c.55: Registering I2C device pca9541 at 0x75
[   19.768729] spanky_i2c spanky_i2c.56: probe 56
[   19.778987] spanky_i2c spanky_i2c.57: probe 57
[   19.789395] spanky_i2c spanky_i2c.57: Registering I2C device pca9541 at 0x70
[   19.789741] spanky_i2c spanky_i2c.58: probe 58

As you can see, I have a somewhat special situation, with a large number
of I2C bus driver instances. It would work if there was only one instance,
but that does not help me.

I thought about registering the GPIO driver as I2C device as suggested
in the other response, but that would be a bit kludgy and I would prefer 
to avoid it if I can.

Thanks,
Guenter
