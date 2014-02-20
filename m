From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: Re: [PATCH v6 4/4] i2c, i2c_imc: Add DIMM bus code
Date: Wed, 19 Feb 2014 17:30:09 -0800
Message-ID: <CALCETrWEexCqH5486Qfyt22i5+MZjpETJEMTyg6FO6xOwXuraQ@mail.gmail.com>
References: <cover.1387588711.git.luto@amacapital.net> <15eccfa508fd0f55230c4274e3e968f91a123b73.1387588711.git.luto@amacapital.net>
 <20140219151626.GA13973@katana> <CALCETrVBPzGqaXbZVgUZMw7D5U5YnUMJOEsw1r=TceLYjJ39JA@mail.gmail.com>
 <20140219192646.1a62521d@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140219192646.1a62521d-mUKnrFFms3BCCTY1wZZT65JpZx93mCW/@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 19, 2014 at 11:26 AM, One Thousand Gnomes
<gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> wrote:
>> example, lots of graphics drivers provide i2c busses, and those buss=
es
>> often contain eeproms, and, in theory, things should know that the
>> eeprom is associated with a particular graphics port, for example.
>> Unfortunately, the i2c core does not know that, things like
>> decode-dimms will try to decode it, sensors-detect will scan graphic=
s
>> ports for motherboard sensors, etc.
>
> ACPI does now try to describe what is on an i=B2c bus. We perhaps don=
't use
> that information well but on a modern PC class box at least for onboa=
rd
> devices most of the info is there for the munching.

I'm discussing the in-kernel representation, not where the information
comes from.  Presumably there should be something in the kernel that
works for ACPI, DT, and directly-enumerated busses (see below).

>
>> For extra fun, there could be drivers for different types of i2c_por=
t.
>>  One of them could be the "DIMM bus" driver, which would know how to
>> probe the i2c adapter associated with a DIMM port.  Another could be
>> the graphics port driver, which (maybe with some extra configuration
>> hints from the graphics driver) could look for EDID-related things.
>
> Busses are not necessarily that tidily organised. There isn't anythin=
g
> saying you can't sneak multiple things on the same bus. In the graphi=
cs
> case its unlikely but I wouldn't rule even that out for a display pan=
el.
> Once you get onto phones and tablets it seems anything goes 8)
>

I'm suggesting identifying a range of addresses on a bus with a "port"
(or whatever it should be called).  Multiple ports could claim
non-overlapping ranges on the same bus.

>> I wonder if this would fit in well with the device tree stuff, too -=
-
>> DT has ways to say "this node links to that one", right?
>
> ACPI basically tries to describe the heirarchy of devices on the bus,=
 but
> as you say the "real" device can be a rambling mix of GPIO, I=B2C, SP=
I,
> PCI (quite probably fake PCI at that) and other resources.
>
> If there is a legitimate use case for poking around with memory dimm =
i2c
> on these boards then really there needs to be a proper defined interf=
ace
> for doing so that covers firmware and OS users.

The legitimate use case is NV-DIMMs.  They have control registers that
are accessed via smbus.  BIOS is likely to poke at those registers
early in boot, but the kernel and/or userspace will need them, too.
It would be nice to know which DIMM slot they map to.

In this particular case (Intel LGA2011 systems), there's only one sane
way to wire up the busses, since the memory controller *is* the smbus
master.  According to the JEDEC spec, each DIMM slot is has three pins
that indicate which slot it is on its channel, and the onboard smbus
hardware uses those pins to select its addresses.  (This maps directly
to three of the seven address bits.)  Each memory controller supports
two RAM channels and two i2c channels, and, if you wire them backwards
(or mix them up between controllers), then I would be amazed if the
system works.  So this particular driver really does know the topology
a priori.

On the other hand, nothing rules out having NV-DIMMs in non-LGA2011
systems where the smbus/i2c topology is less certain.  But I think it
would be silly for an eventual NVDIMM driver to specifically depend on
ACPI, since ACPI isn't needed for existing LGA2011 NVDIMM systems.

(Knowing which physical memory addresses map to which DIMM is a
different story.  I think that the sb-edac driver knows the mapping,
though.)

--Andy
