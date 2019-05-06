From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 2/2] net: phy: sfp: enable i2c-bus detection on
 ACPI based systems
Date: Mon, 6 May 2019 21:33:05 +0200
Message-ID: <20190506193305.GA25013@lunn.ch>
References: <20190505220524.37266-3-ruslan@babayev.com>
 <20190506125523.GA15291@lunn.ch>
 <87zhnztnby.fsf@babayev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87zhnztnby.fsf@babayev.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Babayev <ruslan@babayev.com>
Cc: linux@armlinux.org.uk, f.fainelli@gmail.com, hkallweit1@gmail.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, xe-linux-external@cisco.com
List-Id: linux-i2c@vger.kernel.org

> Hi Andrew,
> 
> I had the GPIOs and the "maximum-power" property in my ACPI snippet initially,
> but then decided to take it out thinking it was not relevant for the
> current patch. I can add the missing pieces back in V2.
> This is what it would like:
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
>     })
> }

Hi Ruslan

I know approximately 0 about ACPI. But that at least lists all the
properties we expect. Thanks.

> > Before accepting this patch, i would like to know more about the
> > complete solution.
> 
> I haven't gotten that far yet, but for the Phylink I was thinking something along the
> lines of:
> 
> Device (PHY0)
> {
>     Name (_HID, "PRP0001")
>     Name (_DSD, Package ()
>     {
>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>             Package () { "compatible", "ethernet-phy-ieee802.3-c45" },
>             Package () { "sfp", \_SB.PCI0.RP01.SFP0 },
>         },
>     })
> }

You probably also need managed = "in-band-status" and
phy-mode = "sgmii";

armada-388-clearfog.dtsi is probably the best reference, much of the
development work for Phylink and SFPs was done on that board.

> I don't have a complete solution working yet. With these patches
> I was hoping to get some early feedback.

Please post your patches as "RFC" in the subject line, if you are
wanting early feedback.

Thanks
	Andrew
