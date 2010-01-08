From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: status of i2c-cpm and ds2482
Date: Fri, 8 Jan 2010 13:52:22 +0100
Message-ID: <20100108135222.49d7b834@hyperion.delvare>
References: <20100108020253.GJ3388@radix50.net>
	<4B471647.8050806@scram.de>
	<20100108121723.GD4004@radix50.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100108121723.GD4004-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baurzhan Ismagulov <ibr-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Cc: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 8 Jan 2010 13:17:23 +0100, Baurzhan Ismagulov wrote:
> Hello Jochen,
> 
> On Fri, Jan 08, 2010 at 12:25:59PM +0100, Jochen Friedrich wrote:
> >> There are boot messages about both. Creating /dev/i2c-0 and reading from
> >> it result in appropriate debug messages. However,
> >> /sys/devices/w1_bus_master1 is not created; the path described in
> >> http://marc.info/?l=linux-i2c&m=125365009130579&w=2 does not exist. What
> >> is the fastest way to get the application running on 2.6.27.25?
> >
> > What does your dts look like? Is the ds2482 present in the dts?
> 
> Oh, that's an interesting point. No, it isn't present, only i2c. How did
> it work in 2.6.25.7? I'd also appreciate pointers about that, if there
> are any.

You probably want to take a look at these 2 patches of mine which were
applied to the ds2482 driver:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=61c91f7ded640bb2b340cc89d9ca3a3ca0229c74
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=0314b020c49c1d6cd182d2b89775bfa6686660db

The first one went in 2.6.27, the second in 2.6.32.

> Currently I'm trying to understand why the new i2c infrastructure
> doesn't call ds2482_probe, which creates the w1_bus_master1 directory.
> Other ideas also welcome.

Before 2.6.27, the ds2482 driver was a so-called "legacy i2c driver"
probing buses randomly in search of supported chips. Since 2.6.27 is is
a so-called "new-style i2c driver" which only attaches to the devices
when told to. So what you observe is the expected behavior. It is much
safer that way.

For an overview of how an I2C device can be declared, see:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/i2c/instantiating-devices

One method not described in this document is listing the device in a
dts. It should probably be added, unfortunately I don't know enough
about this myself to do it. Any volunteer?

-- 
Jean Delvare
