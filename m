From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH v6 4/4] i2c, i2c_imc: Add DIMM bus code
Date: Wed, 19 Feb 2014 19:26:46 +0000
Message-ID: <20140219192646.1a62521d@alan.etchedpixels.co.uk>
References: <cover.1387588711.git.luto@amacapital.net>
	<15eccfa508fd0f55230c4274e3e968f91a123b73.1387588711.git.luto@amacapital.net>
	<20140219151626.GA13973@katana>
	<CALCETrVBPzGqaXbZVgUZMw7D5U5YnUMJOEsw1r=TceLYjJ39JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CALCETrVBPzGqaXbZVgUZMw7D5U5YnUMJOEsw1r=TceLYjJ39JA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> example, lots of graphics drivers provide i2c busses, and those busse=
s
> often contain eeproms, and, in theory, things should know that the
> eeprom is associated with a particular graphics port, for example.
> Unfortunately, the i2c core does not know that, things like
> decode-dimms will try to decode it, sensors-detect will scan graphics
> ports for motherboard sensors, etc.

ACPI does now try to describe what is on an i=C2=B2c bus. We perhaps do=
n't use
that information well but on a modern PC class box at least for onboard
devices most of the info is there for the munching.

> For extra fun, there could be drivers for different types of i2c_port=
=2E
>  One of them could be the "DIMM bus" driver, which would know how to
> probe the i2c adapter associated with a DIMM port.  Another could be
> the graphics port driver, which (maybe with some extra configuration
> hints from the graphics driver) could look for EDID-related things.

Busses are not necessarily that tidily organised. There isn't anything
saying you can't sneak multiple things on the same bus. In the graphics
case its unlikely but I wouldn't rule even that out for a display panel=
=2E
Once you get onto phones and tablets it seems anything goes 8)

> I wonder if this would fit in well with the device tree stuff, too --
> DT has ways to say "this node links to that one", right?

ACPI basically tries to describe the heirarchy of devices on the bus, b=
ut
as you say the "real" device can be a rambling mix of GPIO, I=C2=B2C, S=
PI,
PCI (quite probably fake PCI at that) and other resources.

If there is a legitimate use case for poking around with memory dimm i2=
c
on these boards then really there needs to be a proper defined interfac=
e
for doing so that covers firmware and OS users.

Alan
