From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] i2c: allow specifying separate wakeup interrupt in device tree
Date: Wed, 19 Aug 2015 10:51:17 -0700
Message-ID: <CAKdAkRRCLtRjDVysd9GQ-uJfbqDZ78hEMPkGuZbnXrQ0x+ACHg@mail.gmail.com>
References: <20150730201431.GA5255@dtor-ws>
	<20150809152255.GA2367@katana>
	<20150810055936.GB26735@dtor-ws>
	<20150810061621.GA1573@katana>
	<20150819174347.GA2112@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150819174347.GA2112@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux I2C <linux-i2c@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, Aug 19, 2015 at 10:43 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > > > @@ -659,20 +662,47 @@ static int i2c_device_probe(struct device *dev)
>> > > >         if (!device_can_wakeup(&client->dev))
>> > > >                 device_init_wakeup(&client->dev,
>> > > >                                         client->flags & I2C_CLIENT_WAKE);
>> > >
>> > > I was about to ask if we couldn't combine this and the later if-blocks
>> > > with an if-else combination. But now I stumble over the above block in
>> > > general: If the device cannot cause wake ups, then we might initialize
>> > > it as a wakeup-device depending on client->flags??
>> >
>> > I believe it is done so that we do not try to re-add wakeup source after
>> > unbinding/rebinding the device. With my patch we clearing wakeup flag on
>> > unbind, so it is OK, but there is still error path where we might want
>> > to reset the wakeup flag as well.
>>
>> I was wondering if it wants to achieve that, why does it not
>> unconditionally use 0 instead of the WAKE flag.
>
> When reviewing V2, I wasn't comfortable with just guessing what the old
> code means. So, I did some digging and found:
>
> https://lkml.org/lkml/2008/8/10/204
>
> Quoting the interesting paragraph from David Brownell:
>
> ===
>
> Better would be to preserve any existing settings:
>
>         if (!device_can_wakeup(&client->dev))
>                 device_init_wakeup(...)
> That way the userspace policy setting is preserved unless the
> device itself gets removed ... instead of being clobbered by
> the simple act of (re)probing a driver.
>
>> > +   device_init_wakeup(&client->dev, client->flags &
>> > I2C_CLIENT_WAKE);
>
> ===
>
> I have to admit that I am not familiar with device wakeup handling and
> especially its userspace policies. Can you double check that your V2
> meets the above intention?

No it does not; it explicitly resets the wakeup flag. Note that the
original code was not quite right in that regard either: it would
preserve wakeup flag set by userspace upon driver rebinding; but it
would re-arm the wakeup flag if it was disabled by userspace.

I believe that resetting the flag upon re-binding the driver is proper
behavior as the driver is responsible for setting up and handling
wakeups.

Thanks.

-- 
Dmitry
