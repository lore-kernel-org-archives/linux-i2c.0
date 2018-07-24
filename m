From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Tue, 24 Jul 2018 18:07:29 +0200
Message-ID: <20180724180729.4aed4a7a@bbrezillon>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
        <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
        <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
        <20180720101206.tv7nsoanwo5ftnia@ninjato>
        <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
        <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se>
        <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
        <a74a7472-e900-d031-d10b-b12f03ea9ff1@axentia.se>
        <20180720154132.2fwmwpiwtxa73ljf@ninjato>
        <CAK8P3a0+8a9LCyW2WX6gO2Pi3GJa_ofznC07LMHjWmxZ4HaX7Q@mail.gmail.com>
        <20180724155717.aodl6xehacparo7b@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724155717.aodl6xehacparo7b@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian
List-Id: linux-i2c@vger.kernel.org

On Tue, 24 Jul 2018 17:57:17 +0200
Wolfram Sang <wsa@the-dreams.de> wrote:

> > I think an SoC design we will likely see is an i3c master multiplexed with
> > an i2c master to access one bus. The i2c master can then use clock
> > stretching and other things that may not work in the i3c master, and it
> > may be used in the absence of proper i3c drivers in the OS.  
> 
> Multiplexed? Well, as soon you want to use I3C features like IBI, this
> is not going to work, right? It will not even work with Linux being an
> I2C slave itself. Or do you mean running the I3C and I2C controller
> simultaneously using the same wires?

I think we should switch to an I3C mindset. It seems the use cases
we're discussing so far are I2C use cases. Keep in mind that I3C bus
management is completely different from I2C one (event if I3C is
backward compatible with I2C, it's just a feature, not the foundation
of the I3C protocol).
