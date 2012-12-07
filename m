From: Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH RFC] misc/at24: distinguish between eeprom and fram chips
Date: Fri, 7 Dec 2012 11:14:28 +0100
Message-ID: <201212071114.29034.poeschel@lemonage.de>
References: <201212041758.38600.poeschel@lemonage.de> <201212051043.07460.poeschel@lemonage.de> <20121205164153.GA5011@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121205164153.GA5011-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> > > > I wanted to use a fm24c04 i2c fram chip with linux. I grepped the
> > > > source and found nothing. I later found that my chip can be handled
> > > > by at24 eeprom driver. It creates a sysfs file called eeprom to
> > > > read from and write to the chip. Userspace has no chance to
> > > > distinguish if it is writing an eeprom or a fram chip.
> > > 
> > > Why should it?
> > 
> > Because writes are much faster and it doesn't have to take care on erase
> > cycles. It could use other write strategies on such devices and update
> > informations that have to survive power downs more often.
> 
> I agree. I think that a seperate attribute named e.g. 'page_size' would
> be more helpful than renaming the binary file to fram?

Yes, this is a much better solution! Adding a seperate sysfs file page_size 
and a file for the type of device which would read eeprom, fram, etc then.
If you also think this is the way to go, I would spent one of my next free 
timeslots to this.

> > > The method of accessing EEPROMs is used by way more chips than FRAMs.
> > > So, I'd prefer to have the text updated more generic like "EEPROMs and
> > > similar devices like RAMs, ROMs, etc...". Describing setting .flags in
> > > Kconfig is overkill.
> > 
> > A patch updating Kconfig is below.
> 
> Looks good from a glimpse, will apply it later.

Thank you!

Lars
