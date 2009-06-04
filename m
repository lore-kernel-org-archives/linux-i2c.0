From: =?UTF-8?B?UmljaGFyZCBSwprDtmpmb3Jz?=
	<richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Subject: Re: [PATCH] I2C: ocores can add I2C devices to the bus
Date: Thu, 04 Jun 2009 16:24:30 +0200
Message-ID: <4A27D91E.1000306@mocean-labs.com>
References: <4A2566E8.7080404@mocean-labs.com>	<20090602224822.GE18453@fluff.org.uk>	<20090603101533.599d41db@hyperion.delvare>	<87oct53ewh.fsf@macbook.be.48ers.dk>	<4A2639F6.2010505@mocean-labs.com> <20090604150752.6aa7668c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090604150752.6aa7668c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
>>>
>>> Indeed. Isn't it just a matter of using i2c_add_numbered_adapter -
>>> E.G.:
>> Let say there are several PCI boards which have I2C busses, connected in let say
>> a standard PC. The PCI drivers could be MFD:s which exposes some platform
>> devices for the I2C busses.
>
> This doesn't make any sense to me to start with. PCI boards have PCI
> drivers, not platform drivers. If you have an I2C bus on a PCI board,
> the PCI driver simply registers it using i2c_add_adapter(), there is no
> platform driver or device involved.

We have a PCIe device, actually a FPGA with a lot of different IP:s in it.
For instance an UART, I2C, SPI controller, ethernet controller,
radio tuner, video grabber, SDHCI, etc etc. And we only get one single
interrupt from the device.

The PCI driver for this device implements an MFD
(multi function device, check drivers/mfd). The idea of MFD:s is to
register platform devices for all cells. And to multiplex IRQ:s to the
platform devices. And by doing this all existing platform drivers
can be reused.

> If you happen to have a PCI device which implements an I2C adapter
> compatible with i2c-ocores, then what you want is to abstract the I2C
> controller logic to a separate module, and have the current i2c-ocores
> driver (which would become a simple glue module, and may be renamed to
> i2c-ocores-platform) depend on it. Then add your i2c-ocores-pci driver
> for the PCI implementation, also using the abstracted logic module as
> its backend.

Problem here is that our PCI device implements _a lot_ of stuff,
not only I2C.
That's what the MFD is all about, split it into multiple
platform devices. So in my case the MFD driver has to call the algo
directly.

I don't see the bad thing about my idea. I mean the MFD driver knows
that it have an ocores I2C hardware, and that there are a couple of
devices on the I2C bus.
Why not pass a table of devices when registering the I2C platform device?
I think that's nicer than having the MFD register a lot of platform
devices, but when it comes I2C it has to implement it by itself.
This more or less breaks the whole MFD idea :-(


Btw SPI does something like I do, some of the SPI drivers calls
of_register_spi_devices, which registers devices to the newly created
master.

--Richard
