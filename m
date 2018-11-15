From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Date: Thu, 15 Nov 2018 16:28:26 +0100
Message-ID: <20181115162826.42b54776@bbrezillon>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
        <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
        <20181115135731.25f60990@bbrezillon>
        <20181115150137.GB4169@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115150137.GB4169@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: vitor <vitor.soares@synopsys.com>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellio>
List-Id: linux-i2c@vger.kernel.org

On Thu, 15 Nov 2018 16:01:37 +0100
Wolfram Sang <wsa@the-dreams.de> wrote:

> Hi Boris,
> 
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

I kind of agree with that. Vitor, do you have a use case in mind for
such userspace drivers? I don't think it's worth designing an API for
something we don't need (yet).
