From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: Using the gpio i2c multiplexer driver
Date: Wed, 16 Feb 2011 15:50:15 -0800
Message-ID: <20110216235015.GA16412@ericsson.com>
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
> If you do register the platform data in the correct order, things SHOULD
> work correctly as busses are listed in drivers/i2c/Makefile before
> muxes, but alternatively you could play with the init order (E.G. use
> subsys_initcall instead of module_init in the bus driver, see
> b8680784875 for an example).
> 
Turns out
	 bus_register_notifier(&i2c_bus_type, &my_bus_notifier);
is my friend here.

Wait for the i2c adapter to be registered, which results in a notifier call.
Then register the mux driver from the notifier function.

Guenter
