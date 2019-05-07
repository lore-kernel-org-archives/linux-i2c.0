From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH net-next 2/2] net: phy: sfp: enable i2c-bus detection on
 ACPI based systems
Date: Tue, 7 May 2019 12:34:09 +0300
Message-ID: <20190507093409.GT2895@lahna.fi.intel.com>
References: <20190505220524.37266-3-ruslan@babayev.com>
 <20190506045951.GB2895@lahna.fi.intel.com>
 <20190506194019.GB25013@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190506194019.GB25013@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ruslan Babayev <ruslan@babayev.com>, linux@armlinux.org.uk, f.fainelli@gmail.com, hkallweit1@gmail.com, wsa@the-dreams.de, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, xe-linux-external@cisco.com
List-Id: linux-i2c@vger.kernel.org

On Mon, May 06, 2019 at 09:40:19PM +0200, Andrew Lunn wrote:
> On Mon, May 06, 2019 at 07:59:51AM +0300, Mika Westerberg wrote:
> > On Sun, May 05, 2019 at 03:05:23PM -0700, Ruslan Babayev wrote:
> > > Lookup I2C adapter using the "i2c-bus" device property on ACPI based
> > > systems similar to how it's done with DT.
> > > 
> > > An example DSD describing an SFP on an ACPI based system:
> > > 
> > > Device (SFP0)
> > > {
> > >     Name (_HID, "PRP0001")
> > >     Name (_DSD, Package ()
> > >     {
> > >         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > >         Package () {
> > >             Package () { "compatible", "sff,sfp" },
> > >             Package () { "i2c-bus", \_SB.PCI0.RP01.I2C.MUX.CH0 },
> > 
> > Hmm, ACPI has I2cSerialBusV2() resource for this purpose. Why you are not
> > using that?
> 
> Hi Mika
> 
> Does that reference the bus as a whole, or a device on the bus?

It references a single device on the bus.

> The SFP subsystem needs a reference to the bus as a whole. There can
> be an at24 like EEPROM at addresses 0x50 and 0x51. There can be an
> MDIO bus encapsulated in i2c at addresses 0x40-0x5f, excluding 0x50
> and 0x51. What actually is there depends on the SFP module which is
> plugged into the SFP cage, and it is all hot-plugable.

Yeah, as I replied on the other email I2CSerialBusV2() cannot really be
used here. I did not realize that the device is referencing the whole bus.
