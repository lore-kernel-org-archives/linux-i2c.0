From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH net-next 2/2] net: phy: sfp: enable i2c-bus detection on
 ACPI based systems
Date: Tue, 7 May 2019 12:29:46 +0300
Message-ID: <20190507092946.GS2895@lahna.fi.intel.com>
References: <20190505220524.37266-3-ruslan@babayev.com>
 <20190506045951.GB2895@lahna.fi.intel.com>
 <871s1bv4aw.fsf@babayev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871s1bv4aw.fsf@babayev.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Babayev <ruslan@babayev.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com, wsa@the-dreams.de, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, xe-linux-external@cisco.com
List-Id: linux-i2c@vger.kernel.org

On Mon, May 06, 2019 at 11:14:15AM -0700, Ruslan Babayev wrote:
> 
> Mika Westerberg writes:
> 
> > On Sun, May 05, 2019 at 03:05:23PM -0700, Ruslan Babayev wrote:
> >> Lookup I2C adapter using the "i2c-bus" device property on ACPI based
> >> systems similar to how it's done with DT.
> >> 
> >> An example DSD describing an SFP on an ACPI based system:
> >> 
> >> Device (SFP0)
> >> {
> >>     Name (_HID, "PRP0001")
> >>     Name (_DSD, Package ()
> >>     {
> >>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >>         Package () {
> >>             Package () { "compatible", "sff,sfp" },
> >>             Package () { "i2c-bus", \_SB.PCI0.RP01.I2C.MUX.CH0 },
> >
> > Hmm, ACPI has I2cSerialBusV2() resource for this purpose. Why you are not
> > using that?
> 
> I am not an ACPI expert, but my understanding is I2cSerialBusV2() is
> used for slave connections. I am trying to reference an I2C controller
> here.

Ah, the device itself is not sitting on an I2C bus? In that case I
agree, I2CSerialBusV2() is not correct here.
