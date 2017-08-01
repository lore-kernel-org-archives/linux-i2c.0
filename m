From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 11:47:15 -0500
Message-ID: <1538596b-80ed-7800-db97-70e73b90b9e2@ti.com>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
 <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
 <20170731231509.77d1fba4@bbrezillon> <20170731214211.GA11776@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170731214211.GA11776@tetsubishi>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>K
List-Id: linux-i2c@vger.kernel.org

On 07/31/2017 04:42 PM, Wolfram Sang wrote:
> 
>> Actually, that's the first option I considered, but I3C and I2C are
>> really different. I'm not talking about the physical layer here, but
>> the way the bus has to be handled by the software layer. Actually, I
>> thing the I3C bus is philosophically closer to auto-discoverable busses
>> like USB than I2C or SPI.
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> 
>> Of course, I can move all the code in drivers/i2c/, but that won't
>> change the fact that I3C and I2C busses are completely different
>> with little to share between them.
> 
> That wouldn't make sense.
> 
>> To me, the I2C backward compatibility is just a nice feature that was
>> added to help people smoothly transition from mixed I3C busses with
>> both I2C and I3C devices connected to it (I2C devices being here
>> when no (affordable) equivalent exist in the I3C world) to pure I3C
>> busses with only I3C devices connected to it.
> 
> Yeah, and it is still to be seen how good this really works. Devices
> which do clock stretching are out of the question. Probably everything
> which needs an interrupt as well?
> 

I'm surprised they didn't allow for slave clock stretching when
communicating with a legacy i2c device, it will prohibit use of a rather
large class of devices. :(

As for interrupts you are always free to wire up an out-of-band
interrupt like before. :)

>> This being said, I'd be happy if you prove me wrong and propose a
>> solution that allows us to extend the I2C framework to support I3C
>> without to much pain ;-).
> 
> From all I know, I don't see that coming.
> 
