From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Fri, 20 Jul 2018 11:57:56 +0200
Message-ID: <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.or>
List-Id: linux-i2c@vger.kernel.org

On 2018-07-20 10:52, Arnd Bergmann wrote:
> On Thu, Jul 19, 2018 at 5:29 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> 
>> - the bus element is a separate object and is not implicitly described
>>   by the master (as done in I2C). The reason is that I want to be able
>>   to handle multiple master connected to the same bus and visible to
>>   Linux.
>>   In this situation, we should only have one instance of the device and
>>   not one per master, and sharing the bus object would be part of the
>>   solution to gracefully handle this case.
>>   I'm not sure if we will ever need to deal with multiple masters
>>   controlling the same bus and exposed under Linux, but separating the
>>   bus and master concept is pretty easy, hence the decision to do it
>>   now, just in case we need it some day.
>>   The other benefit of separating the bus and master concepts is that
>>   master devices appear under the bus directory in sysfs.
>>
>>   Discussion around the bus/master/dev representation is still ongoing,
>>   with Arnd opting for a simple approach where
>>   * the bus is implicitly represented by the master device
>>   * the master is not represented as a device under the I3C bus
>>   * only remote I3C devices are exposed and possibly duplicated if
>>     several masters controlling the same bus are exposed to the same
>>     Linux instance
>>   and Peter preferring the representation where the bus is a separate
>>   object. IIRC, Wolfram was in favor of the "bus is a separate object"
>>   too.
>>
>>   If possible, I'd like to close this discussion soon, no matter which
>>   solution is chosen.
> ...
>> Missing features in this preliminary version:
> ...
>> - no support for multi-master and the associated concepts (mastership
>>   handover, support for secondary masters, ...)
> 
> Let's try to come to a conclusion to this discussion, this is the main
> show-stopper for inclusion that I see, as changing the fundamental
> design would be hard to do once we do it one way or the other,
> and the structure is exposed to user space.
> 
> Peter and Wolfram, could you explain what scenario you can see that
> would require handing over ownership of a device from one i3c master
> to another i3c master when both are controlled by the same Linux
> instance?
> 
> To me this seems like a rather odd scenario, and supporting it
> properly requires significant complexity once we try to support the
> dynamic handover of the bus between two of our own masters.
> 
> It seems more likely to me that we could deal with this case by
> requiring either that each bus is controlled by at most one master
> device in Linux, or at least that when we have two masters on
> the same bus that they each control a non-overlapping set of
> slave devices. Either way we'd be able to represent the structure
> as a normal tree in the firmware (DT or ACPI) as well as in
> sysfs.

I have not read much of the I3C spec. I'm just coming from the
current situation with I2C and the i2c-demux-pinctrl driver which
tries to retrofit this into the I2C world and is not doing a grand
job. And how could it?

If you can acknowledge that i2c-demux-pinctrl is needed for I2C
but for some reason is not needed for I3C because of something
that differs between I2C and I3C, then fine, by all means ditch
the explicit bus object.

But in my mind splitting up the devices on the same bus between
several of our own masters and then not have a single object for
the bus is going to cause headaches down the line. Be it address
clashes or trouble with master ping-pong or whatever.

I think the reason for i2c-demux-pinctrl is that some (most?) I2C
hardware suffers from quirks and one way to work around it is to
make selected accesses from a different master. I expect I3C HW
to also suffer from quirks...

Maybe a bit-bang I3C master isn't feasible for some fundamental
reason? But if it is, then I'd say that it's just a matter of time
until someone finds a situation where such a thing could be used to
work around some I3C quirk. And then it might be too expensive to
always use the bit-bang master for the affected device.

But what do I know? Don't let me hold this series back...

Cheers,
Peter
