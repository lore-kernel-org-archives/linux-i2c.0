From: Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-gpio performance issue w/MPC8xx @ 50 MHz
Date: Mon, 2 May 2011 11:48:00 +0300
Message-ID: <BANLkTi=+JxbLfvjrh8A_KQ58CeJJB0wKjw@mail.gmail.com>
References: <BANLkTikaS8yOTcO+OChvutB0syWdVBsh8g@mail.gmail.com>
	<20110501102603.7993da58@endymion.delvare>
	<BANLkTik_mBMHJt-MzcSQfdnAhseBM5KwFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTik_mBMHJt-MzcSQfdnAhseBM5KwFg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?H=E5vard_Skinnemoen?= <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hey guys,

Thanks for taking a look.

> Hmm. i2c-gpio overrides the udelay specified by the platform? That
> shouldn't happen. It does try to come up with some reasonable defaults
> if the platform doesn't specify any though.

Yep, only this scheme explicitly disallows a udelay of 0. It's not too
problematic, I guess, seeing how close 1 is to 0 in terms of timing.

> I haven't investigated this in depth, but I'd say it's probably caused
> by the extra indirection added by gpiolib, assuming the gpio framework
> on your platform uses it. I guess it's one of the downsides of greatly
> reducing the amount of platform-specific code.

Indeed. Tracing the platform gpio code does not show it to be overly
complex at all; simply a matter of mapping the gpio # to a chip (which
is mapped to a port bank), mapping to the specific bit in the bank,
some locking, setting and unlocking. The only problem is that while
this is straightforward, it does introduce unwanted latency. I did not
get to profiling the code, though.

>> While I don't expect all users of i2c-algo-bit to be converted to such
>> a platform driver, it may indeed be useful in some cases, so I have no
>> objection.

Nor would I expect this to be the case. i2c-algo-bit obviously works
well on most platforms when paired to the gpio facility. It just isn't
tight enough for environments low on processing power.

> You can probably create a minimal i2c-platform driver which just
> passes the platform-specific callbacks to i2c-algo-bit. I think it
> should be a new bus driver though...

This is where I kind of lost you. I implemented a bus driver specific
to my platform (compiled in in drivers/i2c/busses) and then
instantiated it in my platform module. I thought about adding a
generic bus driver that would receive callbacks from the platform
module (for example, drivers/i2c/busses/i2c-gpio-direct, or something)
and simply pass these on to i2c-bit-algo. This would allow other
platforms to do the same without having to create a platform specific
bus driver each time like I did. I can submit something generic like
this, if you think this it conforms to the model.

Eran
