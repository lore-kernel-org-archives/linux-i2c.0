From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: Using the gpio i2c multiplexer driver
Date: Wed, 16 Feb 2011 09:13:07 +0100
Message-ID: <87ei789z3g.fsf@macbook.be.48ers.dk>
References: <1297810054.24938.218.camel@groeck-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297810054.24938.218.camel@groeck-laptop> (Guenter Roeck's
	message of "Tue, 15 Feb 2011 14:47:34 -0800")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Guenter" == Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org> writes:

 Guenter> Hi all,

 Guenter> I am trying to use the new GPIO based I2C
 Guenter> multiplexer. Unfortunately, I have an initialization problem
 Guenter> with it.

 Guenter> Some time after registering the multiplexer as platform driver, its
 Guenter> probe function is called. Unfortunately, that does not happen in sync
 Guenter> with I2C adapter initialization. The GPIO mux probe function is called
 Guenter> before the parent's (ie the multiplexed I2C adapter) probe function is
 Guenter> called. As a result, the GPIO mux driver does not find its parent i2c
 Guenter> adapter, and the probe function aborts with an error.

 Guenter> Any idea how I I can fix the problem, ie how I can ensure that
 Guenter> the GPIO mux probe function is only called after its parent
 Guenter> I2C adapter is initialized ?

What i2c bus controller are you using? Are you registering it's platform
data very late (E.G. after you register the platform data for gpiomux)?

If you do register the platform data in the correct order, things SHOULD
work correctly as busses are listed in drivers/i2c/Makefile before
muxes, but alternatively you could play with the init order (E.G. use
subsys_initcall instead of module_init in the bus driver, see
b8680784875 for an example).

-- 
Bye, Peter Korsgaard
