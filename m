From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC v2 0/1] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Wed, 30 Sep 2015 16:57:02 +0300
Message-ID: <20150930135702.GJ1551@lahna.fi.intel.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <20150929231912.GA7913@cumulusnetworks.com>
 <20150930094336.GF1551@lahna.fi.intel.com>
 <2521626.jxElES8O1e@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2521626.jxElES8O1e@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dustin Byford <dustin@cumulusnetworks.com>, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 30, 2015 at 02:52:28PM +0200, Rafael J. Wysocki wrote:
> > >     Device (CH00) {
> > >         Name (_ADR, 0x0)
> > > 
> > >         Device (TMP0) {
> > >             Name (_ADR, 0x50)
> > 
> > ... and this are not needed. I2cSerialBus already contains the address.
> > 
> > Also I think you need to have "PRP0001" here as well.
> 
> The idea is to use _ADR kind of instead of "PRP0001" to express the "you
> don't need a driver for this" idea AFAICS.

But I think it needs a driver and it even includes "compatible" string
below :-)

> > >             Name (_CRS, ResourceTemplate()
> > >             {
> > >                 I2cSerialBus (0x60, ControllerInitiated, I2C_SPEED,
> > >                               AddressingMode7Bit, "^CH00", 0x00,
> > >                               ResourceConsumer,,)
> > >             })
> > >             Name (_DSD, Package ()
> > >             {
> > >                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > >                 Package () {
> > >                     Package (2) { "compatible", "national,lm75" },
> > >                 }
> > >             })
> > >         }
> > >     }
> > > }
