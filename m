From: vitor <vitor.soares@synopsys.com>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Date: Fri, 16 Nov 2018 12:31:42 +0000
Message-ID: <5f946406-a205-3802-aefd-ebd8b5a72b0b@synopsys.com>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
 <20181115135731.25f60990@bbrezillon> <20181115150137.GB4169@kunai>
 <20181115162826.42b54776@bbrezillon>
 <1d64f21a-ad24-94e0-2c17-25729ef59a31@synopsys.com>
 <20181115200058.1869afdb@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115200058.1869afdb@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, vitor <vitor.soares@synopsys.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetr>
List-Id: linux-i2c@vger.kernel.org

Hi Boris,


On 15/11/18 19:00, Boris Brezillon wrote:
> On Thu, 15 Nov 2018 18:03:47 +0000
> vitor <vitor.soares@synopsys.com> wrote:
>
>> Hi Boris,
>>
>>
>> On 15/11/18 15:28, Boris Brezillon wrote:
>>> On Thu, 15 Nov 2018 16:01:37 +0100
>>> Wolfram Sang <wsa@the-dreams.de> wrote:
>>>   
>>>> Hi Boris,
>>>>   
>>>>> What we could do though, is expose I3C devices that do not have a
>>>>> driver in kernel space, like spidev does.
>>>> ...
>>>>   
>>>>> Mark, Wolfram, Arnd, Greg, any opinion?
>>>> Is there a benefit for having drivers in userspace? My gut feeling is to
>>>> encourage people to write kernel drivers. If this is, for some reason,
>>>> not possible for some driver, then we have a use case at hand to test
>>>> the then-to-be-developed userspace interface against. Until then, I
>>>> personally wouldn't waste effort on designing it without a user in
>>>> sight.
>>> I kind of agree with that. Vitor, do you have a use case in mind for
>>> such userspace drivers? I don't think it's worth designing an API for
>>> something we don't need (yet).
>> My use case is a tool for tests, lets say like the i2c tools.
> What would you like to test exactly?
>
>> There is
>> other subsystems, some of them mentioned on this thread, that have and
>> ioctl system call or other method to change parameters or send data.
> I don't think they added the /dev interface before having a real use
> case for it.
>
>>
>> I rise this topic because I really think it worth to define now how this
>> should be design (and for me how to do the things right) to avoid future
>> issues.
> Actually it should be done the other way around: you should have a real
> need and the /dev interface should be designed to fulfill this need.
> Based on this real use case we can discuss other potential usage that
> might appear in the future and try to design something more
> future-proof, but clearly, this userspace interface should be driven by
> a real/well-defined use case.
>
> Also, exposing things to userspace is way more risky than adding a new
> in-kernel subsystem/framework, because it then becomes part of the
> stable ABI.
>
> To make things clearer, I'm not against the idea of exposing I3C
> devices (or I3C buses) to userspace, but I'd like to understand what you
> plan to do with that. If this is about testing, what kind of tests
> you'd like to run. If this is about developing drivers in userspace,
> why can't these be done in kernel space (license issues?), and what
> would those drivers be allowed to do?


Basically I need a tool that help me during the development and to avoid 
me to write a dummy driver for each device that I test.

For instances do some read/write, get/set ccc commands, if something 
goes wrong during the bus initialization have a to debug etc...


For me this is a valid use case and I imagine when people start to 
develop in i3c this interface will help everyone.


Best regards,

Vitor Soares
