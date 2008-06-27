From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH, RFC] Earlier I2C initialization
Date: Fri, 27 Jun 2008 12:41:43 +0200
Message-ID: <20080627124143.23ac7b7b@hyperion.delvare>
References: <200806091541.43899.u.luckas@road.de>
	<485031D5.3020606@bluewatersys.com>
	<20080611141852.3ccd89ea@hyperion.delvare>
	<200806111327.09298.david-b@pacbell.net>
	<20080611225416.169574a0@hyperion.delvare>
	<485042A6.3030705@bluewatersys.com>
	<20080624183945.367c88cf@hyperion.delvare>
	<48640656.9010802@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754590AbYF0Km4@vger.kernel.org>
In-Reply-To: <48640656.9010802@bluewatersys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: David Brownell <david-b@pacbell.net>, Uli Luckas <u.luckas@road.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Ryan,

On Fri, 27 Jun 2008 09:12:54 +1200, Ryan Mallon wrote:
> Jean Delvare wrote:
> > I don't like option 2 at all. drivers/i2c/early could be, but not
> > drivers/i2c-early.
> 
> I don't think its a good idea either. The point was that in order to
> have two sets of i2c drivers with different link order (with regard to
> the rest of the driver subsystems) you would need two top level
> directories in drivers/.

I don't think so. Look at what the input subsystem does (from
drivers/Makefile):

obj-$(CONFIG_SERIO)		+= input/serio/
obj-$(CONFIG_GAMEPORT)		+= input/gameport/
obj-$(CONFIG_INPUT)		+= input/

And there are similar examples with video (video/i810/ and
video/intelfb/ are early in the list). We could do the same with i2c:

obj-$(CONFIG_I2C)		+= i2c/early/

(... lots of things ...)

obj-$(CONFIG_I2C)		+= i2c/

Of course this implies minor edits to drivers/i2c/Makefile. I don't
know if we want to do that, but from a technical point of view it seems
doable.

> The other way of course, is to use one
> directory, or subdirectories under drivers/i2c/ and use subsys_initcall.

> > (...)
> > If we are going to keep using subsys_initcall in bus drivers, then
> > moving the bus drivers using it to a separate directory is not needed.
> > Which doesn't mean we don't want to split the i2c bus drivers into
> > subdirectories for other reasons, but I want to see this as a separate
> > issue. BTW, I started categorizing the different types of i2c bus
> > drivers:
> > http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-group-bus-drivers.patch
> > If you want to help with embedded stuff or SOC or whatever makes sense
> > to group together, please do! For now, everything I am not familiar
> > with is in group "Others".
> 
> I don't know all of the embedded systems, but at a glance the following
> busses from your others section are used on embedded ARM processors:
> 
> i2c-at91
> i2c-davinci
> i2c-ixp2000
> i2c-omap
> i2c-pxa
> i2c-s3c2410
> i2c-versatile

OK, I've moved these to a section titled "Embebbed system I2C host
controller drivers", thanks.

> I'm sure someone else can point out any I missed, and any embedded i2c
> controllers from other architectures. i2c-gpio should probably also go
> under an embedded section as I assume that it is mostly used on embedded
> systems where there is no SoC i2c controller.

OK, I did this too. In theory, i2c-gpio could be used on any system,
but in practice you are most certainly right.

-- 
Jean Delvare
