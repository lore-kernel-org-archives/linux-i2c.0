From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Moving at24 out of i2c/chips?
Date: Mon, 19 Jan 2009 17:18:05 +0100
Message-ID: <20090119171805.21791f72@hyperion.delvare>
References: <20090114193521.GB15315@pengutronix.de>
	<200901141211.20681.david-b@pacbell.net>
	<20090114214038.3d7fbf57@hyperion.delvare>
	<20090115100322.GA3148@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090115100322.GA3148-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, 15 Jan 2009 11:03:22 +0100, Wolfram Sang wrote:
> On Wed, Jan 14, 2009 at 09:40:38PM +0100, Jean Delvare wrote:
> > On Wed, 14 Jan 2009 12:11:20 -0800, David Brownell wrote:
> > > On Wednesday 14 January 2009, Wolfram Sang wrote:
> > > > as drivers/i2c/chips/ is going to go away, I wondered if Jean would be
> > > > interested in a patch moving it to drivers/misc/ (best location I could
> > > > come up with)? David, are you okay with that?
> > > 
> > > That seems a reasonable place for it, if that directory is going
> > > away.  Might even be worth moving the at25 (SPI eeprom) driver
> > > there to keep it company, and adding an EEPROM section to Kconfig
> > > for that directory.  (There's some 93x6 support too.  Those are a
> > > flavor of SPI eeprom, but that driver doesn't use the SPI stack.)
> > 
> > Yes, makes sense to me. The old eeprom driver could go along as well.
> > Thanks for taking care of this!
> 
> Okay, sounds good. I am just a bit unsure how to proceed. I assume these
> changes have to go via gkh's tree.

I don't think they have to. As far as I know there is no dedicated
maintainer for the drivers/misc directory, so basically anyone can
commit patches touching it. Patches moving drivers from
drivers/i2c/chips to drivers/misc could as well go through my i2c tree.

> Can I just make a patch series which
> moves those drivers, post it to LKML (plus the other needed mailing
> lists) and wait for acked-bys to come in? Or is it better to post the
> series as [RFC] and collect acked-bys beforehand? Or shall I just move
> at24 to the new location and wait for the other eeprom-driver-authors to
> follow on their own?

I don't think we need any kind of acks for the at24 and eeprom drivers.
Their case has already been discussed and apparently we all agree. You
can post your patch moving these to LKML if you want, but that's really
only to let people know what it happening, if they care. Or give them a
chance to complain, but I really don't explain anyone to do that.

So I think the most straightforward thing to do is for you to send a
patch moving eeprom and at24 to drivers/misc to the linux-i2c list,
where I will pick it and push it to Linus through my i2c tree. Probably
too late for 2.6.29... or not, after all driver moves are better done
outside of merge windows.

Alternatively, if there are more eeprom drivers, having a
drivers/misc/eeprom directory for them might make sense, or maybe even
drivers/eeprom. Honestly, I don't really care, as long as
drivers/i2c/chips gets smaller ;)

-- 
Jean Delvare
