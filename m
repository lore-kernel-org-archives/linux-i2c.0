From: =?ISO-8859-1?Q?H=E5vard_Skinnemoen?= <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-gpio performance issue w/MPC8xx @ 50 MHz
Date: Sun, 1 May 2011 15:04:21 -0700
Message-ID: <BANLkTik_mBMHJt-MzcSQfdnAhseBM5KwFg@mail.gmail.com>
References: <BANLkTikaS8yOTcO+OChvutB0syWdVBsh8g@mail.gmail.com>
	<20110501102603.7993da58@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110501102603.7993da58-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Eran,

On Sun, May 1, 2011 at 1:26 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Eran,
>
> On Tue, 19 Apr 2011 23:53:11 +0300, Eran Duchan wrote:
>> Hey list
>>
>> I needed to bit bang I2C on an ancient MPC875 running at a blazing 50
>> MHz. I started by initializing the generic i2c-gpio bus but quickly
>> found it could not bit bang @ 100 kHz. The most I was able to get it
>> was ~50 kHz by setting udelay to 0 and patching around i2c-gpio.c to
>> make sure it doesn't modify this value.

Hmm. i2c-gpio overrides the udelay specified by the platform? That
shouldn't happen. It does try to come up with some reasonable defaults
if the platform doesn't specify any though.

>> I then implemented a bus driver of my own, based on i2c-gpio. The only
>> difference was that it simply implemented set/get sda/scl by directly
>> writing to hardware. Using this I was able to reach around 150 kHz.
>>
>> 1) Any comments on the above? Could I have done something differently?
>
> Apparently the gpio layer is adding a delay somehow. You should ask
> Grant Likely (gpio subsystem maintainer) and Haavard Skinnemoen (author
> and maintainer of the i2c-gpio driver) about it. I Cc'd both. They
> should know where in i2c-gpio or the gpio layer an extra delay may be
> introduced.

I haven't investigated this in depth, but I'd say it's probably caused
by the extra indirection added by gpiolib, assuming the gpio framework
on your platform uses it. I guess it's one of the downsides of greatly
reducing the amount of platform-specific code.

>> 2) I thought perhaps a thin adapter could be implemented that exported
>> a platform data structure holding callbacks: set sda/scl dir/val, get
>> sda/scl. By registering such a bus driver and supplying these
>> callbacks in the platform module, one could avoid having to
>> re-implement a bus driver like I did. Comments?
>
> What you are proposing is turning i2c-algo-bit into a platform driver
> instead of the basic library it is at the moment. When the code was
> written, the platform "bus" didn't even exist so it wasn't an option.
> While I don't expect all users of i2c-algo-bit to be converted to such
> a platform driver, it may indeed be useful in some cases, so I have no
> objection.

You can probably create a minimal i2c-platform driver which just
passes the platform-specific callbacks to i2c-algo-bit. I think it
should be a new bus driver though...passing those callbacks to
i2c-gpio would basically eliminate the very small amount of
functionality this driver provides while making it more complex.

i2c-gpio currently has 225 lines of code. I think it should be
possible to write a i2c-platform driver in less than 100 lines.
Probably worthwhile for 3x performance, although probably not if the
GPIO hardware has concurrency issues.

> That being said, if you use GPIOs, it would certainly be better to find
> out whether the extra delay you've been observing could be removed.
> Properly requesting the GPIOs you need is definitely cleaner than
> accessing the I/O port (or whatever) directly. Direct access can be
> unreliable if other code is using GPIOs nearby.

If your hardware allows you to control individual pins without
affecting others, it's probably ok to bypass the GPIO layer (although
you should probably still request the pins to prevent others from
using them). If not, you should expect a lot of trouble.

Havard
