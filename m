From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH, RFC] Earlier I2C initialization
Date: Thu, 12 Jun 2008 13:21:03 -0700
Message-ID: <200806121321.03429.david-b@pacbell.net>
References: <200806091541.43899.u.luckas@road.de> <20080611225416.169574a0@hyperion.delvare> <Pine.LNX.4.55.0806112226060.14077@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759563AbYFLUVT@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0806112226060.14077@cliff.in.clinika.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, Ryan Mallon <ryan@bluewatersys.com>, Uli Luckas <u.luckas@road.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 11 June 2008, Maciej W. Rozycki wrote:
> > That being said, I'm not sure if the comparison with the PCI subsys=
tem
> > holds... I am under the impression that PCI bus handling doesn't
> > require dedicated drivers? At least I can't see any under drivers/p=
ci.
>=20
> =A0Of course it does require them. =A0It is just due to their very na=
ture they
> tend to be placed under arch/,

PCI root hubs, yes.  The drivers/pci/hotplug bridges are slightly
more generic, ditto drivers/pci/pcie and the CardBus bridges in
drivers/pcmcia.  At one point, lack of a generic (non-hotplug) PCI
bridge driver was viewed as a weakness of that driver stack.

Also, drivers/acpi/pci_root.c binds the root at subsys_initcall.
That's done *after* some earlier PCI magic; I never bothered
to sort through that little maze.


> although there are some cases where the=20
> same system controller can be used for a range of processors (e.g. so=
me
> Marvell chips can be used either with MIPS or PowerPC CPUs) and they =
might
> be arguably put in a place more suitable for sharing between
> architectures. =A0See arch/mips/pci/ for an example of a generous bun=
ch of
> PCI host drivers.

Which, for the record, get very early initialization using two
different mechanisms:

  - many use arch_initcall()

  - the "arch" subtree is linked before the "drivers" subtree

I don't think I2C needs to worry about arch_initcall just now,
but if necessary it could initialize earlier than subsys_initcall.

- Dave
