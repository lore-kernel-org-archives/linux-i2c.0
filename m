From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: ocores can add I2C devices to the bus
Date: Thu, 4 Jun 2009 21:02:43 +0200
Message-ID: <20090604210243.078aeb2f@hyperion.delvare>
References: <4A2566E8.7080404@mocean-labs.com>
	<20090602224822.GE18453@fluff.org.uk>
	<20090603101533.599d41db@hyperion.delvare>
	<87oct53ewh.fsf@macbook.be.48ers.dk>
	<4A2639F6.2010505@mocean-labs.com>
	<20090604150752.6aa7668c@hyperion.delvare>
	<4A27D91E.1000306@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A27D91E.1000306-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard =?ISO-8859-15?B?Upr2amZvcnM=?= <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 04 Jun 2009 16:24:30 +0200, Richard R=9A=F6jfors wrote:

Please do all of us a favor and stop using non-ASCII characters in your
e-mail address.

> >> Let say there are several PCI boards which have I2C busses, connec=
ted in let say
> >> a standard PC. The PCI drivers could be MFD:s which exposes some p=
latform
> >> devices for the I2C busses.
> >
> > This doesn't make any sense to me to start with. PCI boards have PC=
I
> > drivers, not platform drivers. If you have an I2C bus on a PCI boar=
d,
> > the PCI driver simply registers it using i2c_add_adapter(), there i=
s no
> > platform driver or device involved.
>=20
> We have a PCIe device, actually a FPGA with a lot of different IP:s i=
n it.
> For instance an UART, I2C, SPI controller, ethernet controller,
> radio tuner, video grabber, SDHCI, etc etc. And we only get one singl=
e
> interrupt from the device.
>=20
> The PCI driver for this device implements an MFD
> (multi function device, check drivers/mfd). The idea of MFD:s is to
> register platform devices for all cells. And to multiplex IRQ:s to th=
e
> platform devices. And by doing this all existing platform drivers
> can be reused.

OK, I understand your design now.

> > If you happen to have a PCI device which implements an I2C adapter
> > compatible with i2c-ocores, then what you want is to abstract the I=
2C
> > controller logic to a separate module, and have the current i2c-oco=
res
> > driver (which would become a simple glue module, and may be renamed=
 to
> > i2c-ocores-platform) depend on it. Then add your i2c-ocores-pci dri=
ver
> > for the PCI implementation, also using the abstracted logic module =
as
> > its backend.
>=20
> Problem here is that our PCI device implements _a lot_ of stuff,
> not only I2C.
> That's what the MFD is all about, split it into multiple
> platform devices. So in my case the MFD driver has to call the algo
> directly.
>=20
> I don't see the bad thing about my idea. I mean the MFD driver knows
> that it have an ocores I2C hardware, and that there are a couple of
> devices on the I2C bus.
> Why not pass a table of devices when registering the I2C platform dev=
ice?
> I think that's nicer than having the MFD register a lot of platform
> devices, but when it comes I2C it has to implement it by itself.
> This more or less breaks the whole MFD idea :-(

I am now convinced your proposed implementation makes sense for your
specific need (which is relatively rare, which is why i2c-core doesn't
handle it.) And contrary to what I first wrote, this doesn't need to be
moved to i2c-core: this is specific enough that I'd rather let the code
live in the bus driver (i2c-ocores) for now, and only if at least two
other bus drivers need the same, consider moving it to i2c-core.

So if you fix the minor objection Ben had about your patch and resend
it, I think we can merge that. Oh, and I also believe your driver
should call i2c_unregister_device() on removal, for symmetry.

> Btw SPI does something like I do, some of the SPI drivers calls
> of_register_spi_devices, which registers devices to the newly created
> master.

We have of_register_i2c_devices() which works exactly the same, but I
can't see the relation between Open Firmware and the problem at hand.

--=20
Jean Delvare
