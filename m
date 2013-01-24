From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH RFC] misc/at24: distinguish between eeprom and fram chips
Date: Thu, 24 Jan 2013 08:27:01 +0100
Message-ID: <20130124072701.GG8364@nekote.pengutronix.de>
References: <201212041758.38600.poeschel@lemonage.de>
 <201212051043.07460.poeschel@lemonage.de>
 <20121205164153.GA5011@pengutronix.de>
 <201212071114.29034.poeschel@lemonage.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201212071114.29034.poeschel@lemonage.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars Poeschel <poeschel@lemonage.de>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Dec 07, 2012 at 11:14:28AM +0100, Lars Poeschel wrote:
> > > > > I wanted to use a fm24c04 i2c fram chip with linux. I grepped the
> > > > > source and found nothing. I later found that my chip can be handled
> > > > > by at24 eeprom driver. It creates a sysfs file called eeprom to
> > > > > read from and write to the chip. Userspace has no chance to
> > > > > distinguish if it is writing an eeprom or a fram chip.
> > > > 
> > > > Why should it?
> > > 
> > > Because writes are much faster and it doesn't have to take care on erase
> > > cycles. It could use other write strategies on such devices and update
> > > informations that have to survive power downs more often.
> > 
> > I agree. I think that a seperate attribute named e.g. 'page_size' would
> > be more helpful than renaming the binary file to fram?
> 
> Yes, this is a much better solution! Adding a seperate sysfs file page_size 
> and a file for the type of device which would read eeprom, fram, etc then.
> If you also think this is the way to go, I would spent one of my next free 
> timeslots to this.

Oops, this mail seems to have dropped off :(

I am all for the 'page_size' attribute, but still not convinced what
gain the 'type' attribute would allow. For FRAM, the page size will be
large. Isn't this enough information?

Regards,

   Wolfram
