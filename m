From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH RFC] misc/at24: distinguish between eeprom and fram chips
Date: Mon, 28 Jan 2013 11:40:15 +0100
Message-ID: <201301281140.15289.poeschel@lemonage.de>
References: <201212041758.38600.poeschel@lemonage.de> <201212071114.29034.poeschel@lemonage.de> <20130124072701.GG8364@nekote.pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130124072701.GG8364@nekote.pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 24 January 2013 at 08:27:01, Wolfram Sang wrote:
> > > > > > I wanted to use a fm24c04 i2c fram chip with linux. I grepped
> > > > > > the source and found nothing. I later found that my chip can be
> > > > > > handled by at24 eeprom driver. It creates a sysfs file called
> > > > > > eeprom to read from and write to the chip. Userspace has no
> > > > > > chance to distinguish if it is writing an eeprom or a fram
> > > > > > chip.
> > > > > 
> > > > > Why should it?
> > > > 
> > > > Because writes are much faster and it doesn't have to take care on
> > > > erase cycles. It could use other write strategies on such devices
> > > > and update informations that have to survive power downs more
> > > > often.
> > > 
> > > I agree. I think that a seperate attribute named e.g. 'page_size'
> > > would be more helpful than renaming the binary file to fram?
> > 
> > Yes, this is a much better solution! Adding a seperate sysfs file
> > page_size and a file for the type of device which would read eeprom,
> > fram, etc then. If you also think this is the way to go, I would spent
> > one of my next free timeslots to this.
> 
> Oops, this mail seems to have dropped off :(

Luckily I did not have a free timeslot to invest yet. ;)

> I am all for the 'page_size' attribute, but still not convinced what
> gain the 'type' attribute would allow. For FRAM, the page size will be
> large. Isn't this enough information?

Yes, this would be enough information and I think this is the way we should 
go.
I set this on my todo list. Although the change will be quite simple, I think 
I will not find the time to hit the upcoming merge window.

Lars
