From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI I2C device-driver matching issue
Date: Mon, 26 Oct 2015 11:29:48 +0200
Message-ID: <20151026092948.GE1526@lahna.fi.intel.com>
References: <CAE7DoPbODXiUcsxMD1qRXCvX_o0evf6KsK2qu65g9uxnw5GNAw@mail.gmail.com>
 <2863037.enS8LjaQhU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2863037.enS8LjaQhU@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ben Gardner <gardner.ben@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Oct 24, 2015 at 05:32:29PM +0200, Rafael J. Wysocki wrote:
> CC: Mika
> 
> On Thursday, October 22, 2015 01:05:42 PM Ben Gardner wrote:
> > Hi all,
> > 
> > I have a custom Baytrail board with a M24C02 EEPROM attached to I2C bus 3.
> > I am using coreboot/SeaBIOS, so I have complete control over the ACPI tables.
> > I am using Linux 4.2.3.
> > 
> > I have defined a EEPROM device on I2C3 using I2cSerialBus() and it
> > shows up as expected.
> > 
> > Scope (\_SB.PCI0.I2C3) {
> >   Device (EEP0) {
> >     Name (_CID, Package() { "24c02" })
> >     Name (_CRS, ResourceTemplate () {
> >       I2cSerialBus (0x0057, ControllerInitiated, 400000,
> >         AddressingMode7Bit, "\\_SB.PCI0.I2C3", 0x00,
> >         ResourceConsumer,,)
> >     })
> >   }
> > }

This is being discussed in another thread:

http://marc.info/?l=linux-acpi&m=144562104914442&w=2
