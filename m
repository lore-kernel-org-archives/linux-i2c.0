From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 2/2] net: phy: sfp: enable i2c-bus detection on
 ACPI based systems
Date: Mon, 6 May 2019 14:55:23 +0200
Message-ID: <20190506125523.GA15291@lunn.ch>
References: <20190505220524.37266-3-ruslan@babayev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190505220524.37266-3-ruslan@babayev.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Babayev <ruslan@babayev.com>
Cc: linux@armlinux.org.uk, f.fainelli@gmail.com, hkallweit1@gmail.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, xe-linux-external@cisco.com
List-Id: linux-i2c@vger.kernel.org

On Sun, May 05, 2019 at 03:05:23PM -0700, Ruslan Babayev wrote:
> Lookup I2C adapter using the "i2c-bus" device property on ACPI based
> systems similar to how it's done with DT.
> 
> An example DSD describing an SFP on an ACPI based system:
> 
> Device (SFP0)
> {
>     Name (_HID, "PRP0001")
>     Name (_DSD, Package ()
>     {
>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>             Package () { "compatible", "sff,sfp" },
>             Package () { "i2c-bus", \_SB.PCI0.RP01.I2C.MUX.CH0 },
>         },
>     })
> }

Hi Ruslan

So this gives you the I2C bus. But what about the 6 GPIOs? And the
maximum power property? You are defining the ACPI interface which from
now on everybody has to follow. So it would be good to make it
complete. ACPI also seems to be poorly documented. There does not
appear to be anything like Documentation/devicetree. So having one
patch, with a good commit message, which implements everything makes
it easier for those that follow.

This appears to be enough to get a very minimal SFP instantiated. But
then what?  How are you using it? How do you instantiate a Phylink
instance for the MAC? How do you link the SFP to the Phylink?

Before accepting this patch, i would like to know more about the
complete solution.

Thanks
	Andrew
