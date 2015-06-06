From: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
Subject: Re: [PATCH v2] i2c: busses: i2c-bcm2835: limits cdiv to allowed
 values
Date: Sat, 6 Jun 2015 19:31:25 +0200
Message-ID: <20150606173125.GA1341@debian>
References: <1432895204-19924-1-git-send-email-linux_wi@tinag.ch>
 <5571131D.7060100@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5571131D.7060100-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 04, 2015 at 09:10:21PM -0600, Stephen Warren wrote:
> On 05/29/2015 04:26 AM, Silvan Wicki wrote:
> > Adds: make sure bits 16-31 of DIV register are always 0
> > Adds: assume minimal divider of 2 if divider resulted in 0
> >       (bcm2835 sets divider to 32768 if cdiv is set to 0)
> > 
> > See page 33/34 of BCM2835-ARM-Peripherals.pdf for the DIV register.
> > https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
> 
> > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> 
> > @@ -252,12 +255,22 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
> >  
> >  	divider = DIV_ROUND_UP(clk_get_rate(i2c_dev->clk), bus_clk_rate);
> >  	/*
> > +	 * Divider results in 0 by extremely high bus_clk_rate values
> > +	 * such as bus_clk_rate >= 4044967297 and core_clock = 250MHz.
> > +	 * In such a case assume the minimal possible divider since
> > +	 * bcm2835 chip sets divisor internally to 32768 if cdiv is 0.
> > +	 */
> 
> I would rephrase that as:
> 
> 	/*
> 	 * A divider of0 results in extremely high bus_clk_rate values
> 	 * such as bus_clk_rate >= 4044967297 with core_clock = 250MHz.
> 	 * In such a case assume the minimal possible divider, since
> 	 * bcm2835 chip sets divisor internally to 32768 if cdiv is 0.
> 	 */
> 
> > +	if (divider < BCM2835_I2C_CDIV_MIN)
> > +		divider = BCM2835_I2C_CDIV_MIN;
> 
> This seems reasonable; if the calculated divider is too small, then it
> means we can't run the clock that fas. Running it more slowly loses some
> performance, but should work fine. I might suggest a dev_info() or
> dev_dbg() here.
> 
> > +	/*
> >  	 * Per the datasheet, the register is always interpreted as an even
> >  	 * number, by rounding down. In other words, the LSB is ignored. So,
> >  	 * if the LSB is set, increment the divider to avoid any issue.
> >  	 */
> >  	if (divider & 1)
> >  		divider++;
> > +	if (divider > BCM2835_I2C_CDIV_MAX)
> > +		divider = BCM2835_I2C_CDIV_MAX;
> 
> I think this should be an error. If the calculated divider is too large,
> it means we want to run the clock slower than we can. If we run the
> clock faster than requested, the clock rate might exceed the attached
> I2C devices' capabilities (otherwise, why would we want such a slow
> clock?). As such, I'd suggest a dev_err() here, and to fail the probe()
> by returning an error.
> 
i made an updated patch, v3.

> I'd echo Eric's question: I'm curious whether this patch solves a
> real-world problem, or if you found it by code inspection?

i used i2c on the raspberry pi with an atmega328p. when i was testing
with diffrent i2c speeds it dit not always work as expected. so it was
kind of both, a problem i encountered in real-world that lead to code
inspection. so i analyzed the driver and found some issues.

one thing is this patch with the DIV register.

one thing is that in bcm2835_i2c_isr the S register is read and then
directly written back without ensuring that the reserved bits (10-31)
are cleared. the datasheet mentions: write as 0, read don't care. it
is not guaranteed that the reserved bits will always be 0. but we need
to write a 0. so the proper way i think is to clear the bits with a
bitmask. i think there are more registers which we may need to clear the
reserved bits. bitmask for S register would be 0x03FF.

one thing is that the DEL register is never adjusted. so if cdiv/2 gets
higher than FEDL/REDL the BSC may malfunction. the datasheet mentions:
the delay values should always be set to less than cdiv/2.

and it would be nice to have the ability to manipulate the CLKT->TOUT
value. to change the clock stretching timeout.

i'm new kernel development and find it best to do only one patch at a
time.

cheers
