From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Crash on reading the whole PCI config of PIIX4 SMBus
Date: Wed, 23 Sep 2009 16:15:18 +0200
Message-ID: <20090923161518.5cb29107@hyperion.delvare>
References: <4AB8F142.9090609@nachtwindheim.de>
	<20090922231839.GA20656@pengutronix.de>
	<4ABA1B9C.9070302@nachtwindheim.de>
	<20090923153531.1642b77d@hyperion.delvare>
	<4ABA2CA1.8070806@nachtwindheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4ABA2CA1.8070806-lmEOmhgwvqJeCmjzdEDfrw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Henrik Kretzschmar <henne-lmEOmhgwvqJeCmjzdEDfrw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 23 Sep 2009 16:11:45 +0200, Henrik Kretzschmar wrote:
> Jean Delvare schrieb:
> > You might still want to check if maybe ACPI is interfering with the
> > i2c-piix4 driver. This isn't the kind of result I'd expect, but who
> > knows.
> >   
> This machine doesnt even have ACPI. :) Just APM.
> 
> But reading the config space may be dangerous, refering the manpage of lspci:
> "
>       -xxx   Show  hexadecimal  dump of the whole PCI configuration space. It
>               is available only to root as several PCI devices crash when  you
>               try to read some parts of the config space (this behavior proba-
>               bly doesnt violate the PCI standard, but  its  at  least  very
>               stupid).  However,  such  devices are rare, so you neednt worry
>               much.
> "
> 
> I seem to have stumbled over one of those stupidnesses.
> That is the reason why non-root users are only allowed to
> read the first 64 byte of the config space.

That's right, but it doesn't explain why i2c-piix4 crashes in the first
place, not why merely loading it causes further lspci -xxx to crash
when they did not beforehand. I admit I am totally clueless.

>  
> So its imho generally a good idea to run lspci -xxx on every machine you can
> and save some time searching in the wrong places.


-- 
Jean Delvare
