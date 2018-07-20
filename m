From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Fri, 20 Jul 2018 15:16:15 +0200
Message-ID: <a74a7472-e900-d031-d10b-b12f03ea9ff1@axentia.se>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
 <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se>
 <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Boris Brezillon <boris.brezillon@bootlin.com>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@ar>
List-Id: linux-i2c@vger.kernel.org

On 2018-07-20 13:28, Arnd Bergmann wrote:
> On Fri, Jul 20, 2018 at 1:13 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2018-07-20 12:57, Arnd Bergmann wrote:
>>> * What I understand from reading i2c-demux-pinctrl.c, a slave device
>>>   will only ever be observable from one master at a time, when you
>>>   switch over, all children get removed on one master and added to
>>>   the other one, to be probed again by their respective drivers.
>>>   I can see this as a useful feature on i3c as well, in particular to
>>>   deal with the situation where we have i2c slaves connected to a
>>>   pinmux that can switch them between an i3c master and an
>>>   i2c-only master (possibly a gpio based one). That particular use
>>>   case however doesn't seem to fix well in the current code, which
>>>   is structure around i3c buses.
>>
>> It's pretty easy to come up with examples where this reprobing is
>> not desirable at all. E.g. if one of the involved I2C devices is
>> a HDMI encoder (I have a TDA19988 here) sitting in the middle of the
>> graphics pipeline. Blink-blink on the screen because some *other*
>> unrelated device needed to be accessed by an alternative master. Not
>> pretty.
> 
> Agreed, we definitely don't want to reprobe all devices during normal
> operation for i3c master handover.
> 
> What is the least contrived use case that you can think of where we
> would want to use one master to talk to one device on the bus,
> but another master to talk to another device on the same bus?
> I still hope that we can decide that this is not a useful scenario
> at all.
> 
> If we find a case in which it is needed, we could still deal with it
> like this:
> - enumerate all slaves connected to the bus for each of the
>   two masters
> - mark each slave as status="enabled" in at most one of the
>   buses, and as disabled everywhere else
> - Use dynamic handover according to the bus protocol to
>   switch masters without having Linux even know that the
>   two buses are shared.
> 
> That scenario would then fall completely into the "secondary
> master handover" category but require no special handling
> in the i3c layer beyond what we need for secondary masters
> that are managed by something outside of the kernel's
> score (a microcontroller, firmware, ...).

The worst case is not mentioned above, where a single device benefits
from being accessed by two different masters.

That happens e.g. if one master is speedy but triggers a quirk and
one master is slow and reliable, and the device must use the speedy
master for some things (high bandwidth data?) but can't use it for
other things (configuration?) and must fall back to the slow and
reliable master for that.

I don't have an actual example for I2C, maybe Wolfram does? But I can
invent a case. E.g. the speedy DMA-enabled master cannot generate
RESTART, which is a must for (re-)configuration, but not for passing
data to the device.


Also consider some future HW that has several I3C blocks, but they
are not identical. There's one beefy kind and one slim kind (I'm sure
you can find HW with different flavors of I2C blocks). Even if the
HW designers intended for one type of block to be superior in every
aspect, they might have made a mistake? This HW also has a pinmux, so
the SW is free to route different I3C blocks to the actual I3C bus.
Maybe the involved I3C blocks don't see the bus when the pinmux is
in the "wrong" state? Then you can't do a normal handover...


But if you *want* to end up with "that's just too contrived", then
of course that's where you'll end up.

Cheers,
Peter
