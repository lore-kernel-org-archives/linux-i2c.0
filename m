From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Tue, 24 Jul 2018 16:03:38 +0200
Message-ID: <CAK8P3a14_6uf9VLYU0YnmFp0Q=DZBKc0cAesBh0opanGDZMFRA@mail.gmail.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se> <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <20180720151751.242d4809@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720151751.242d4809@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 20, 2018 at 3:17 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Fri, 20 Jul 2018 13:28:10 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Fri, Jul 20, 2018 at 1:13 PM, Peter Rosin <peda@axentia.se> wrote:
>> > On 2018-07-20 12:57, Arnd Bergmann wrote:
>> >> * What I understand from reading i2c-demux-pinctrl.c, a slave device
>> >>   will only ever be observable from one master at a time, when you
>> >>   switch over, all children get removed on one master and added to
>> >>   the other one, to be probed again by their respective drivers.
>> >>   I can see this as a useful feature on i3c as well, in particular to
>> >>   deal with the situation where we have i2c slaves connected to a
>> >>   pinmux that can switch them between an i3c master and an
>> >>   i2c-only master (possibly a gpio based one). That particular use
>> >>   case however doesn't seem to fix well in the current code, which
>> >>   is structure around i3c buses.
>> >
>> > It's pretty easy to come up with examples where this reprobing is
>> > not desirable at all. E.g. if one of the involved I2C devices is
>> > a HDMI encoder (I have a TDA19988 here) sitting in the middle of the
>> > graphics pipeline. Blink-blink on the screen because some *other*
>> > unrelated device needed to be accessed by an alternative master. Not
>> > pretty.
>>
>> Agreed, we definitely don't want to reprobe all devices during normal
>> operation for i3c master handover.
>>
>
> Re-probing would not happen, no matter the solution we choose. It's
> that, in one case, you would have X virtual/linux devices representing
> the same physical device and in the other case, you would just have
> one, and everytime a transfer is requested by the driver, the core
> would pick the appropriate master to do it (most likely the one in
> control of the bus at that time)

I think this is one of the cases I'd want to avoid: controlling multiple
masters that are active at the same time without going through
the handover.

If we have an actual pinmux between two masters and only one
of them can even see the bus, I think we should go through a
complete remove/probe cycle the way that the i2c-demux-pinctrl
does today. If OTOH we a primary/secondary master pair with
handover capability, I would prefer to not see one slave on
both devices at the same time, or (ideally) only use one of the
two masters and disable the other one completely.

>> If we find a case in which it is needed, we could still deal with it
>> like this:
>> - enumerate all slaves connected to the bus for each of the
>>   two masters
>
> That's what will happen if you don't share the same bus representation.

To clarify: I meant list them in the DT representation, not enumerate
them in Linux during boot. Sorry for using a misleading description here.

>> - mark each slave as status="enabled" in at most one of the
>>   buses, and as disabled everywhere else
>
> We shouldn't need to do that. We can just let the driver check whether
> the master provides the necessary capabilities to efficiently
> communicate with the device, and if it does not just return -ENOTSUPP
> in the ->probe() function. This way you'll have a device, but not
> driver controlling it on one bus, and on the other bus, you'll have
> another device (which points to the same physical device) this time
> with a driver attached to it.

I'd still hope that we can completely avoid that case and never
have the case where one physical device has two live
representations in the kernel. It /could/ still be done of course,
but would not always do the right thing, depending on the
type of device (a temperature sensor could just be probed
twice without problems, a network device probably cannot)

      Arnd
