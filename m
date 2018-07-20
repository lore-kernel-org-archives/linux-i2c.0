From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Fri, 20 Jul 2018 12:57:07 +0200
Message-ID: <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720101206.tv7nsoanwo5ftnia@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, Boris Brezillon <boris.brezillon@bootlin.com>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.c>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 20, 2018 at 12:12 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> I have not read much of the I3C spec. I'm just coming from the
>> current situation with I2C and the i2c-demux-pinctrl driver which
>> tries to retrofit this into the I2C world and is not doing a grand
>> job. And how could it?
>>
>> If you can acknowledge that i2c-demux-pinctrl is needed for I2C
>> but for some reason is not needed for I3C because of something
>> that differs between I2C and I3C, then fine, by all means ditch
>> the explicit bus object.
>>
>> But in my mind splitting up the devices on the same bus between
>> several of our own masters and then not have a single object for
>> the bus is going to cause headaches down the line. Be it address
>> clashes or trouble with master ping-pong or whatever.
>>
>> I think the reason for i2c-demux-pinctrl is that some (most?) I2C
>> hardware suffers from quirks and one way to work around it is to
>> make selected accesses from a different master. I expect I3C HW
>> to also suffer from quirks...
>>
>> Maybe a bit-bang I3C master isn't feasible for some fundamental
>> reason? But if it is, then I'd say that it's just a matter of time
>> until someone finds a situation where such a thing could be used to
>> work around some I3C quirk. And then it might be too expensive to
>> always use the bit-bang master for the affected device.
>>
>> But what do I know? Don't let me hold this series back...
>
> Thanks, Peter. You nailed it, the I2C use case (and its limits). From
> what I know about I3C, bit-banging doesn't sound very feasible to me, so
> the situation might be a bit different. Still, no one knows about future
> I3C use cases and HW quirks. This is why I encouraged the seperate bus
> object because back then it was said it was easy to do and implement. If
> this now becomes a show-stopper, we can surely re-decide. I am not
> strong on this point, it was just something which would have helped I2C.
> (And for that matter, we (= the Renesas Upstream Kernel Team) was
> discussing something similar to the i2c demuxer for SPI, too. We have
> multiple IP cores which can do SPI on R-Car, all with their pros and
> cons)

I think we need to distinguish between demuxing and i3c master
handover here, they are two separate issues that both need to be solved
and that are not too hard to do, but we get into trouble if we combine
them in arbitrary ways, which is what I'm concerned about:

* What I understand from reading i2c-demux-pinctrl.c, a slave device
  will only ever be observable from one master at a time, when you
  switch over, all children get removed on one master and added to
  the other one, to be probed again by their respective drivers.
  I can see this as a useful feature on i3c as well, in particular to
  deal with the situation where we have i2c slaves connected to a
  pinmux that can switch them between an i3c master and an
  i2c-only master (possibly a gpio based one). That particular use
  case however doesn't seem to fix well in the current code, which
  is structure around i3c buses.

* The other thing we definitely have to support for i3c is to deal with
   handing over control of the bus between the i3c master owned
   by Linux, and other masters that are /not/ owned by the same
   Linux instance. This is the part that the spec discusses in much
   detail, with the intention of temporarily giving up control of the
   bus to let another master do its thing on a shared slave without
   user interaction.

Combining the two quickly gets nasty I think. The current design
seems to imply that a device driver could keep talking to a slave
while it is being reparented from one master to another. I can't
think of a good reason why we would possibly want that, but
it definitely opens up questions in what happens to e.g. the sysfs
representation, lock order, and power management that I'd rather
not have to think about.

       Arnd
