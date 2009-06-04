From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: ocores can add I2C devices to the bus
Date: Thu, 4 Jun 2009 15:07:52 +0200
Message-ID: <20090604150752.6aa7668c@hyperion.delvare>
References: <4A2566E8.7080404@mocean-labs.com>
	<20090602224822.GE18453@fluff.org.uk>
	<20090603101533.599d41db@hyperion.delvare>
	<87oct53ewh.fsf@macbook.be.48ers.dk>
	<4A2639F6.2010505@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A2639F6.2010505-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Rojfors <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 03 Jun 2009 10:53:10 +0200, Richard R?=F6jfors wrote:
> Peter Korsgaard wrote:
> >>>>>> "Jean" =3D=3D Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:
> >=20
> > Hi,
> >=20
> >  Jean> I don't like the idea much either, nor the implementation.
> >=20
> >  Jean> Firstly, I don't understand why this would be needed. I can =
understand
> >  Jean> that in some cases you don't know the I2C bus number in adva=
nce, but
> >  Jean> then some code must still instantiate the I2C bus, and the s=
ame code
> >  Jean> should be able to call i2c_new_device() directly to instanti=
ate the
> >  Jean> devices on that bus. Richard, did you try to just do this? I=
f it
> >  Jean> doesn't work, please explain why.
> >=20
> > Indeed. Isn't it just a matter of using i2c_add_numbered_adapter -
> > E.G.:
>=20
> Let say there are several PCI boards which have I2C busses, connected=
 in let say
> a standard PC. The PCI drivers could be MFD:s which exposes some plat=
form
> devices for the I2C busses.

This doesn't make any sense to me to start with. PCI boards have PCI
drivers, not platform drivers. If you have an I2C bus on a PCI board,
the PCI driver simply registers it using i2c_add_adapter(), there is no
platform driver or device involved.

If you happen to have a PCI device which implements an I2C adapter
compatible with i2c-ocores, then what you want is to abstract the I2C
controller logic to a separate module, and have the current i2c-ocores
driver (which would become a simple glue module, and may be renamed to
i2c-ocores-platform) depend on it. Then add your i2c-ocores-pci driver
for the PCI implementation, also using the abstracted logic module as
its backend.

It might make sense to consider ocores an "I2C algorithm" and have
i2c-algo-ocores for the abstracted implementation.

> How should those drivers know which bus numbers that are free?
> Let say there are 2 boards of one type and two of an other.
>=20
> The MFD:s might register there platform devices before there are I2C =
bus drivers available.
> So a call to i2c_get_adapter, won't return any adapter, so AFAIK ther=
e is no
> way to check if a bus number is "free" for use(?) Should those driver=
s talk to each other
> and try to coordinate the bus number usage?
>
> But even if it was possible to figure out bus numbers to use, the bus=
 drivers might
> not be available when the MFD registers the platform device, so when =
should it call
> i2c_new_device? Start a timer and call i2c_get_adapter until it retur=
ns something?

I don't think you need to answer these questions any longer with the
model I proposed above.

--=20
Jean Delvare
