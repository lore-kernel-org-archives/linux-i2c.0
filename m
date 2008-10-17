From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 5/6]: i2c: Add bus addressing support.
Date: Fri, 17 Oct 2008 17:24:59 +0200
Message-ID: <20081017172459.550dda6c@hyperion.delvare>
References: <20080821.024330.51639001.davem@davemloft.net>
	<20081015145228.14b1ae77@hyperion.delvare>
	<20081015.143722.260594637.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081015.143722.260594637.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Wed, 15 Oct 2008 14:37:22 -0700 (PDT), David Miller wrote:
> From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Date: Wed, 15 Oct 2008 14:52:28 +0200
> 
> > Hi David,
> > 
> > On Thu, 21 Aug 2008 02:43:30 -0700 (PDT), David Miller wrote:
> > > 
> > > i2c: Add bus addressing support.
> > > 
> > > Some I2C bus controllers support the driving of multiple I2C bus
> > > segments (think PCI domains).
> > > 
> > > For example, the pcf8584 variants on some sparc64 boxes can do this.
> > > They have an auxiliary 8-bit register that specifies the I2C bus each
> > > I2C operation acts upon.  In the openfirmware device tree, the I2C
> > > client devices are described using an 8-bit bus address and a 10-bit
> > > I2C device address.
> > 
> > Can you please point me to the part of the PCF8454 datasheet which
> > explains this? I can't find it. As I read the datasheet, the PCF8454
> > supports a single I2C bus.
> 
> It's a feature Sun added to their PCF chips.  The register address
> is forwarded to an internal MUX they implemented which implements
> the register selecting the I2C bus.

I don't really follow you here. The PCF8584 is a chip manufactured by
Philips. I don't quite see how Sun could have added registers to a chip
after the fact. Or do they produce compatible chips for their own
systems, with extra features?

More likely, they combined the PCF8584 with another chip which is
multiplexing the I2C bus. Philips has many such chips, for example the
PCA9540 series. It probably doesn't really matter for the problem at
hand anyway, but I'm curious.

> > Oh my, holy crap! I can't believe you dared to propose this.
> 
> Propose an alternative solution that actually works and preserves
> compatability, as mine does.

What you need is i2c bus multiplexing support. What you call "bus
addressing" is only the most simple form of multiplexing, i.e. a single
level of multiplexing and no trunk.

A generic form of i2c bus multiplexing is not upstream yet but a number
of people have been working on this in the last few years, in
particular Rodolfo Giometti (Cc'd.) I admit I did not pay too much
attention to the patches myself, due to a lack of time and personal
interest, as well as the feeling that it was preferable to first
cleanup i2c-core from its legacy binding model and redundant lists and
locks before adding something as complex as bus multiplexing support.
Multiplexing will require clever locking and it did not seem sane to
attempt to do that as long as legacy and new-style i2c devices coexist.
But the cleanup phase of i2c-core is hopefully coming to an end so it
will soon be time to look into i2c bus multiplexing support.

In the meantime, it is always possible to write hardware-specific
multiplexing drivers. See for example i2c-amd756-s4882 and
i2c-nforce2-s4985, two drivers that handle the multiplexing of SMBus on
Tyan motherboards. While these drivers aren't exactly elegant and we do
not want such drivers to proliferate, they at least fill the gap until
we have a good generic solution. And these two drivers did not require
any change to i2c-core as I recall, except maybe bug fixes which the
new use case revealed.

> > I don't like this at all. This really looks like a custom hack to solve
> > the problem at hand without paying too much attention to compatibility
> > issues which I am certain will arise. Just to mention the first one
> > that comes to mind: access from user-space through i2c-dev, and
> > specifically i2c-tools.
> 
> I got that working, read the patch my patch works, I was careful
> to keep things working.

How do you access your "addressed buses" through i2c-dev? It will
reject any address larger than 0x3ff. And even if you did update
i2c-dev to no longer check for "wrong" addresses, i2c-tools would not
support them. So you'd also need to update i2c-tools.

Now maybe you don't plan to use i2c-dev and i2c-tools on your I2C
buses, but that's hardly the point. The point is that your proposal
requires changes to other drivers and user-space tools, while the
alternative doesn't require such changes.

Even i2c-core has checks on invalid addresses, in
i2c_new_probed_device(), i2c_detect_address() and i2c_probe_address().
While we don't care much about the latter (it's going away soon) the
former 2 would need to be updated. Then again you may say that you do
not plan to use these functions on your I2C buses, but this illustrates
how your proposal would require more changes to be universally usable.

> > What makes your setup fundamentally different from a motherboard with
> > more than one I2C bus (which is a rather common case)? Why don't you
> > simply register one i2c_adapter for each i2c bus segment?
> 
> It doesn't work like that.  All the bit banging goes through the
> one I2C controller, the bus it is accessing is simply changed behind
> it's back by that special register.

That's the definition of bus multiplexing. You apparently think that
struct i2c_adapter represents one I2C controller (and admittedly that's
what the name suggests for historical reasons) while what it really
represents is an I2C bus segment. In your case you have one controller
for several I2C bus segments. So you simply need as many i2c_adapter
structures registered, and then it's up to your driver to handle the
multiplexing in a way that is transparent for the users.

If you want to see generic i2c bus multiplexing support available soon,
then please help Rodolfo by reviewing and testing his patches, and help
me finish the conversion of all i2c chip drivers to the standard device
driver binding model. 87 drivers have been converted or deleted
already, most by myself, 27 are remaining. An up-to-date list is at:
http://jdelvare.pck.nerim.net/linux/legacy_i2c_driver.list
As you can see, most remaining drivers are in drivers/macintosh and
drivers/media/video. I can probably handle media/video myself with the
help of Hans Verkuil but I have no idea what to do with the macintosh
drivers.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
