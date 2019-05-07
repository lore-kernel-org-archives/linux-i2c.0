From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH RFC v2 net-next 2/2] net: phy: sfp: enable i2c-bus
 detection on ACPI based systems
Date: Tue, 7 May 2019 04:38:12 +0200
Message-ID: <20190507023812.GA12262@lunn.ch>
References: <20190505220524.37266-2-ruslan@babayev.com>
 <20190507003557.40648-3-ruslan@babayev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190507003557.40648-3-ruslan@babayev.com>
Sender: linux-kernel-owner@vger.kernel.org
To: 20190505220524.37266-2-ruslan@babayev.com
Cc: linux@armlinux.org.uk, f.fainelli@gmail.com, hkallweit1@gmail.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, xe-linux-external@cisco.com
List-Id: linux-i2c@vger.kernel.org

On Mon, May 06, 2019 at 05:35:57PM -0700, Ruslan Babayev wrote:
> Lookup I2C adapter using the "i2c-bus" device property on ACPI based
> systems similar to how it's done with DT.
> 
> An example DSD describing an SFP on an ACPI based system:
> 
> Device (SFP0)
> {
>     Name (_HID, "PRP0001")
>     Name (_CRS, ResourceTemplate()
>     {
>         GpioIo(Exclusive, PullDefault, 0, 0, IoRestrictionNone,
>                "\\_SB.PCI0.RP01.GPIO", 0, ResourceConsumer)
>             { 0, 1, 2, 3, 4 }
>     })
>     Name (_DSD, Package ()
>     {
>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>             Package () { "compatible", "sff,sfp" },
>             Package () { "i2c-bus", \_SB.PCI0.RP01.I2C.MUX.CH0 },
>             Package () { "maximum-power-milliwatt", 1000 },
>             Package () { "tx-disable-gpios", Package () { ^SFP0, 0, 0, 1} },
>             Package () { "reset-gpio",       Package () { ^SFP0, 0, 1, 1} },
>             Package () { "mod-def0-gpios",   Package () { ^SFP0, 0, 2, 1} },
>             Package () { "tx-fault-gpios",   Package () { ^SFP0, 0, 3, 0} },
>             Package () { "los-gpios",        Package () { ^SFP0, 0, 4, 1} },
>         },

As i said before, i know ~0 about ACPI. Does devm_gpiod_get() just
work for ACPI?

Thanks
	Andrew
