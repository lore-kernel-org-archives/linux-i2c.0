From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Crash on reading the whole PCI config of PIIX4 SMBus
Date: Wed, 23 Sep 2009 15:35:31 +0200
Message-ID: <20090923153531.1642b77d@hyperion.delvare>
References: <4AB8F142.9090609@nachtwindheim.de>
	<20090922231839.GA20656@pengutronix.de>
	<4ABA1B9C.9070302@nachtwindheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4ABA1B9C.9070302@nachtwindheim.de>
Sender: linux-pci-owner@vger.kernel.org
To: Henrik Kretzschmar <henne@nachtwindheim.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>, jbarnes@virtousgeek.org, linux-pci@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 23 Sep 2009 14:59:08 +0200, Henrik Kretzschmar wrote:
> Wolfram Sang schrieb:
> > On Tue, Sep 22, 2009 at 05:46:10PM +0200, Henrik Kretzschmar wrote:
> >
> >   
> >> at boot time my system (Wincor/Nixdorf Beetle D1) sometimes crashs while loading the i2c-piix4 driver.
> >>     
> >
> > Have you checked if you have the latest BIOS for this machine? Sometimes
> > PCI-problems got fixed there...
> >
> >   
> Thanks for you fast replies,
> 
> the latest BIOS (05/08) is already installed, so no fixing can be expected that way
> 
> 
> I tested my killer-commands at the other box @home with no crashes.
> 
> The commands _work_ with a coldstarted Linux and i2c-piix not loaded,
> so the only thing I can do is blacklisting it and renounce sensors support,
> having a good a argument for a new hardware aquisition. :)

That's really odd, considering that the i2c-piix4 driver doesn't change
the PCI device configuration, it only reads from it.

If you trigger some transactions (for example by running "sensors -s"
at boot time?) then you also write to the I/O ports. But this hardly
explains how subsequently reading the PCI config space would crash.

You might still want to check if maybe ACPI is interfering with the
i2c-piix4 driver. This isn't the kind of result I'd expect, but who
knows.

> 
> For completness the message with the SMBus revision, which is not the pci-revision, is:
> 
> SMBus Host Controller at 0x1040, revision 0

Revision 0 here as well, I suspect there never was any other revision
of this chip.

> 
> 
> The "?" at the interrupt line of lspci is a little strange:
> 
> >> Interrupt: pin ? routed to IRQ 9
> 
> looking at lspci -x -s 7.3 I can see that PCI_INTERRUPT_PIN == 0 
> 
> I cant see that i2p-piix does any interrupts, refering /proc/irq/9/spurious
> 
> The driver says:
>  
> Using Interrupt SMI# for SMBus

This is only a debug message, saying how the interrupt line is
configured, but you are right that the driver doesn't use interrupts
(much to our shame.)

> 
> I'm not sure, but my box @home has the same lspci output with the "?".
> 
> So long, thanks for help.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
