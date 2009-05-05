From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ST DDC I2C bus driver v1
Date: Tue, 5 May 2009 23:04:10 +0200
Message-ID: <63386a3d0905051404oc7f4688j6b9219b3a9201172@mail.gmail.com>
References: <63386a3d0905050452v5ade99cav7265c38d74699a8c@mail.gmail.com>
	 <20090505134002.GO32548@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090505134002.GO32548-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
Cc: STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

First THANKS for the quick review Ben! I will address the issues swiftly.
Below only the points I need to discuss further (the rest will be fixed).

2009/5/5 Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>:

On Tue, 5 May 2009 14:40:02 +0100, Ben Dooks wrote:
> On Tue, May 05, 2009 at 01:52:22PM +0200, Linus Walleij wrote:
> > --- /dev/null
> > +++ b/drivers/i2c/busses/i2c-stddci2c.c
> > @@ -0,0 +1,973 @@
> > +/*
> > + *
> > + * drivers/i2c/busses/i2c-stddci2c.c
>
> Is it really just for DDC? is there another i2c block in the chip?
> if not, can we just call this sti2c or similar?

Further Jean writes:

> Both names are equally bad. The driver name starts with "i2c-" so there
> is no point in adding "i2c" again. Please use i2c-stddc or i2c-st-u300
> or similar.

The driver is named like this because the actual name of the HW
block *is* "ddci2c" (like my name is "Linus"), I added "st" to make
it more unique. It's going to be used in U300 but it is actually used
in a Nomadik platform for which a linux port exists, so adding
"u300" to the name would be misleading. (Well could be
renamed later, but...)

Then DDC: this block does *both* I2C and DDC1 and DDC2B.
The switch can be made by hardware and software alike.

By setting bit 7 resp bit 4 of I2C_CR it will be switched from
plain I2C to DDC1 or DDC2 respectively.

I didn't add code for it since it cannot be tested on this
reference hardware, but if you like I can try to add that
in anyway. Would be a module parameter to select mode
plain I2C/DDC1/DDC2. Would that be nice?

>> +static int __init
>> +stddci2c_probe(struct platform_device *pdev)
>
> __devinit, iirc.
> (...)
>> +static int __exit
>
> __devexit, iirc.
> (...)
>> +     .remove         = __exit_p(stddci2c_remove),
>
> thought __devexit_p()?

So did I until I tried to merge the RTC driver.
>From http://groups.google.com/group/rtc-linux/web/checklist

* use __devinit/__devexit/__devexit_p for hotpluggable devices
* use __init/__exit/__exit_p otherwise

This is also stated in a comment in include/linux/init.h:

/* Used for HOTPLUG */
#define __devinit        __section(.devinit.text) __cold
#define __devinitdata    __section(.devinit.data)
(etc)

Thinking about it, no platform_device should ever have
__dev{init|exit} in it regarding the definition of a platform
device as something being built in.

I think there are a lot of sinners in the kernel regarding this
though, including a driver fiddled with myself recently :-/

>> +     /* DDC class but actually often used for more generic I2C */
>> +     adap->class = I2C_CLASS_DDC;
>
> I thoguht jdelvare was trying to get rid of this?

Hm, would be good since especially a device like this doesn't
shoehorn very well into that schema doing both plain I2C and
DDC. I would have to assign different values depending on
module parameter if I add explicit DDC support.

Shall I just leave this field unassigned?

Linus Walleij
