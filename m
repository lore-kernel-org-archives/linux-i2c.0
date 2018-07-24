From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Tue, 24 Jul 2018 16:14:36 +0200
Message-ID: <CAK8P3a0+8a9LCyW2WX6gO2Pi3GJa_ofznC07LMHjWmxZ4HaX7Q@mail.gmail.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se> <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <a74a7472-e900-d031-d10b-b12f03ea9ff1@axentia.se> <20180720154132.2fwmwpiwtxa73ljf@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720154132.2fwmwpiwtxa73ljf@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, Boris Brezillon <boris.brezillon@bootlin.com>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.c>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 20, 2018 at 5:41 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> I don't have an actual example for I2C, maybe Wolfram does? But I can
>> invent a case. E.g. the speedy DMA-enabled master cannot generate
>> RESTART, which is a must for (re-)configuration, but not for passing
>> data to the device.
>
> DMA capable controllers may also not react adequate to the slave doing
> clock stretching (which is forbidden in I3C).
>
> Renesas R-Car Gen2 has two I2C IP cores. One can do DMA and automatic
> transfers to the PMIC, the other has I2C slave functionality. One cannot
> do I2C_SMBUS_QUICK, the other can. And some more kind of quirks.
> Sometimes you can mux the pins to GPIO, so you have a third option.
>
> This setup is the reason the demux driver exists.

Have you run into scenarios where you dynamically switch between
the two masters in order to do different things (on one slave, or
on multiple slaves), or could you always decide on one of them
at boot time with that particular chip?

>> Also consider some future HW that has several I3C blocks, but they
>> are not identical. There's one beefy kind and one slim kind (I'm sure
>> you can find HW with different flavors of I2C blocks). Even if the
>> HW designers intended for one type of block to be superior in every
>> aspect, they might have made a mistake? This HW also has a pinmux, so
>> the SW is free to route different I3C blocks to the actual I3C bus.
>
> So, basically this is what happened with R-Car. Now, I tend to think
> that I3C is much more complex and noone would put two I3C IP cores into
> on SoC. But it was not too long ago that I wouldn't believe someone put
> two different I2C IP cores into a SoC. Then again, it happened when I2C
> was around for 35 years...

I think an SoC design we will likely see is an i3c master multiplexed with
an i2c master to access one bus. The i2c master can then use clock
stretching and other things that may not work in the i3c master, and it
may be used in the absence of proper i3c drivers in the OS.

However, that case cannot be handled with the abstraction in the
proposed i3c framework, which can only deal with multiple i3c
standard compliant masters. I'm also not sure if it can be added
to the i2c-demux-pinctrl driver.

        Arnd
