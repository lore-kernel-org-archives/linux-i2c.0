From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Date: Thu, 15 Nov 2018 07:11:09 -0800
Message-ID: <CAK8P3a2aem0pFKwRgMq9CUsogJ=MU9d6VHzE0o0+WU0v1UWR4A@mail.gmail.com>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com> <20181115135731.25f60990@bbrezillon>
 <20181115150137.GB4169@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115150137.GB4169@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Vitor Soares <vitor.soares@synopsys.com>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 15, 2018 at 7:01 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > What we could do though, is expose I3C devices that do not have a
> > driver in kernel space, like spidev does.
>
> ...
>
> > Mark, Wolfram, Arnd, Greg, any opinion?
>
> Is there a benefit for having drivers in userspace? My gut feeling is to
> encourage people to write kernel drivers. If this is, for some reason,
> not possible for some driver, then we have a use case at hand to test
> the then-to-be-developed userspace interface against. Until then, I
> personally wouldn't waste effort on designing it without a user in
> sight.
>
> Dunno if you have that, but a debug interface (exchanging data with
> clients) on the other hand would be super useful most probably. Maybe
> you can start having that in debugfs and already learn from it if you
> ever want to move some interface outside of debugfs?

I think it may depend a little bit on the complexity we require
for a user interface. If it's basically just pread/pwrite, then the
debugfs would not look any different from a stable interface,
and there is little risk of getting it wrong. The more complex
the interface turns out to be, the more cautious we may want
to be about declaring it stable.

Other than that, I agree we should encourage users to write kernel
drivers, but given the precedent of uio, libusb, spidev, i2c-dev,
and vfio, it does seem extremely likely that users will have
requirements for it, and I think it's a good idea to start the design
discussion before users start building their own interfaces to do the
same thing badly.

        Arnd
