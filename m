From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: Add support for deferred probing
Date: Tue, 26 Mar 2013 12:09:08 +0100
Message-ID: <20130326110908.GC8553@the-dreams.de>
References: <20130228120140.127ebb91@endymion.delvare>
 <20130322115621.GB24508@the-dreams.de>
 <20130324114301.4b5efc34@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130324114301.4b5efc34-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


> What do you mean? In <linux/gpio.h> I see:
> 
> struct gpio {
> 	unsigned	gpio;
> (...)
> 
> static inline int gpio_get_value(unsigned int gpio)
> {
> 	return __gpio_get_value(gpio);
> }
> 
> And in <linux/i2c-gpio.h>:
> 
> struct i2c_gpio_platform_data {
> 	unsigned int    sda_pin;
> 	unsigned int    scl_pin;
> (...)

I remembered this paragraph from Documentation/gpio.txt:

===

If you want to initialize a structure with an invalid GPIO number, use
some negative number (perhaps "-EINVAL"); that will never be valid.  To
test if such number from such a structure could reference a GPIO, you
may use this predicate:

        int gpio_is_valid(int number);
...

===

Confusingly, I know found that the chapter starts with

===

GPIOs are identified by unsigned integers in the range 0..MAX_INT.  That
reserves "negative" numbers for other purposes like marking signals as
"not available on this board", or indicating faults.

===

Meh.

> If you still have a concern about the types used, please clarify and
> let me know what change you expect.

Leave it. I think the fragile part is gpio_is_valid() but this is truly
outside the scope of this patch.

> > > +	ret = gpio_request(sda_pin, "sda");
> > > +	if (ret) {
> > > +		if (ret == -EINVAL)
> > > +			ret = -EPROBE_DEFER;	/* Try again later */
> > 
> > Would gpio_request_array() make the code simpler?
> 
> I gave it a try, this indeed makes the code slightly simpler (-4 lines)
> but the resulting binary slightly larger (+40 bytes on x86-64.) I'd say
> it's not worth it?

OK. Then leave it.

> Note that my patch doesn't introduce the gpio_request() calls, they
> were there before, so this decision is actually independent from my
> patch, and even if we decide to switch to using gpio_request_array(),
> I'd rather do it in a separate patch for clarity.

I don't fully get it. Do you want to appl gpio_request() to this patch?
Otherwise, I'd take it as is.

Thanks,

   Wolfram
