From: vitor <vitor.soares@synopsys.com>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Date: Thu, 15 Nov 2018 18:03:47 +0000
Message-ID: <1d64f21a-ad24-94e0-2c17-25729ef59a31@synopsys.com>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
 <20181115135731.25f60990@bbrezillon> <20181115150137.GB4169@kunai>
 <20181115162826.42b54776@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115162826.42b54776@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: vitor <vitor.soares@synopsys.com>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicet>
List-Id: linux-i2c@vger.kernel.org

Hi Boris,


On 15/11/18 15:28, Boris Brezillon wrote:
> On Thu, 15 Nov 2018 16:01:37 +0100
> Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Hi Boris,
>>
>>> What we could do though, is expose I3C devices that do not have a
>>> driver in kernel space, like spidev does.
>> ...
>>
>>> Mark, Wolfram, Arnd, Greg, any opinion?
>> Is there a benefit for having drivers in userspace? My gut feeling is to
>> encourage people to write kernel drivers. If this is, for some reason,
>> not possible for some driver, then we have a use case at hand to test
>> the then-to-be-developed userspace interface against. Until then, I
>> personally wouldn't waste effort on designing it without a user in
>> sight.
> I kind of agree with that. Vitor, do you have a use case in mind for
> such userspace drivers? I don't think it's worth designing an API for
> something we don't need (yet).

My use case is a tool for tests, lets say like the i2c tools. There is 
other subsystems, some of them mentioned on this thread, that have and 
ioctl system call or other method to change parameters or send data.


I rise this topic because I really think it worth to define now how this 
should be design (and for me how to do the things right) to avoid future 
issues.


Best regards,

Vitor Soares
