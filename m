From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Fri, 20 Jul 2018 10:52:27 +0200
Message-ID: <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719152930.3715-1-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.or>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 19, 2018 at 5:29 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:

> - the bus element is a separate object and is not implicitly described
>   by the master (as done in I2C). The reason is that I want to be able
>   to handle multiple master connected to the same bus and visible to
>   Linux.
>   In this situation, we should only have one instance of the device and
>   not one per master, and sharing the bus object would be part of the
>   solution to gracefully handle this case.
>   I'm not sure if we will ever need to deal with multiple masters
>   controlling the same bus and exposed under Linux, but separating the
>   bus and master concept is pretty easy, hence the decision to do it
>   now, just in case we need it some day.
>   The other benefit of separating the bus and master concepts is that
>   master devices appear under the bus directory in sysfs.
>
>   Discussion around the bus/master/dev representation is still ongoing,
>   with Arnd opting for a simple approach where
>   * the bus is implicitly represented by the master device
>   * the master is not represented as a device under the I3C bus
>   * only remote I3C devices are exposed and possibly duplicated if
>     several masters controlling the same bus are exposed to the same
>     Linux instance
>   and Peter preferring the representation where the bus is a separate
>   object. IIRC, Wolfram was in favor of the "bus is a separate object"
>   too.
>
>   If possible, I'd like to close this discussion soon, no matter which
>   solution is chosen.
...
> Missing features in this preliminary version:
...
> - no support for multi-master and the associated concepts (mastership
>   handover, support for secondary masters, ...)

Let's try to come to a conclusion to this discussion, this is the main
show-stopper for inclusion that I see, as changing the fundamental
design would be hard to do once we do it one way or the other,
and the structure is exposed to user space.

Peter and Wolfram, could you explain what scenario you can see that
would require handing over ownership of a device from one i3c master
to another i3c master when both are controlled by the same Linux
instance?

To me this seems like a rather odd scenario, and supporting it
properly requires significant complexity once we try to support the
dynamic handover of the bus between two of our own masters.

It seems more likely to me that we could deal with this case by
requiring either that each bus is controlled by at most one master
device in Linux, or at least that when we have two masters on
the same bus that they each control a non-overlapping set of
slave devices. Either way we'd be able to represent the structure
as a normal tree in the firmware (DT or ACPI) as well as in
sysfs.

       Arnd
