From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH, RFC] Earlier I2C initialization
Date: Wed, 11 Jun 2008 22:54:16 +0200
Message-ID: <20080611225416.169574a0@hyperion.delvare>
References: <200806091541.43899.u.luckas@road.de>
	<485031D5.3020606@bluewatersys.com>
	<20080611141852.3ccd89ea@hyperion.delvare>
	<200806111327.09298.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757940AbYFKU4J@vger.kernel.org>
In-Reply-To: <200806111327.09298.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Ryan Mallon <ryan@bluewatersys.com>, Uli Luckas <u.luckas@road.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 11 Jun 2008 13:27:09 -0700, David Brownell wrote:
> On Wednesday 11 June 2008, Jean Delvare wrote:
> > On Thu, 12 Jun 2008 08:13:09 +1200, Ryan Mallon wrote:
> > >                               As David suggested, if i2c is needed early
> > > in enough cases, why not just move it early in the link order? My patch
> > > was just an alternative approach which mimics the current behaviour, but
> > > makes it possible to get any i2c driver early. Why not just mark all of
> > > the drivers/busses that get used on embedded devices as subsys_initcall,
> > > just in case somebody needs them early?
> > 
> > Because this is an abuse of subsys_initcall? I guess that was
> > acceptable when only a couple drivers were doing that, but making it
> > official sounds bad.
> 
> How would it be an abuse?  On those systems, I2C is a "system bus"
> and needs to be initialized early for the same reasons PCI gets set
> up very early on PC hardware.

But the pci subsystem doesn't make use of subsys_initcall(). Instead,
it is simply placed early in the link order.

That being said, I'm not sure if the comparison with the PCI subsystem
holds... I am under the impression that PCI bus handling doesn't
require dedicated drivers? At least I can't see any under drivers/pci.

> There's no rule saying that subsystem initialization may not include
> the essential drivers -- in this case, i2c_adapter drivers.  PCI hubs
> and bridges are certainly initialized very early, before module_init
> code runs...

Care to point me to actual code to backup this "certainly"?

> And in fact it seems a bit odd to think that initializing any bus
> subsystem shouldn't be allowed to include its bus adapters.  It's
> not as if the subsystem has completed initializiation until those
> adapters are usable!!

I think it makes a lot of sense to initialize the core of a subsystem
early, so that all devices and drivers can be registered. This doesn't
imply registering the hardware bus drivers too, even though in some
cases it is also needed. I doubt that whoever designed subsys_initcall
meant it to be used for all bus drivers, otherwise he/she would have
named it, say, busdrv_initcall.

But don't get me wrong: if subsys_initcall is the way to go, that's
alright with me, that's way less work than having to move drivers to
different directories and fixing the link order.

-- 
Jean Delvare
