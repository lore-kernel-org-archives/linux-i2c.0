From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Fix for Dell P57G touchpad found, need advice on patch
Date: Wed, 16 Sep 2015 11:40:39 +0300
Message-ID: <20150916084039.GC1536@lahna.fi.intel.com>
References: <CAN_72e1BBk_s1BRBHJYuA7+2nbfYf1bCoD9fqatmTxRM_w=myg@mail.gmail.com>
 <20150915164214.GD1525@katana>
 <20150915171151.GF1525@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150915171151.GF1525@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Pavel Roskin <plroskin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Adding Jarkko as well.

On Tue, Sep 15, 2015 at 07:11:51PM +0200, Wolfram Sang wrote:
> On Tue, Sep 15, 2015 at 06:42:14PM +0200, Wolfram Sang wrote:
> > Hi Pavel,
> > 
> > On Thu, Sep 10, 2015 at 11:11:41PM -0700, Pavel Roskin wrote:
> > > Hi!
> > 
> > Thanks for this detailed info. Adding Mika to CC who is an expert of
> > this driver. Mika, maybe we should add you to MAINTAINERS, too?
> > 
> 
> And forgot to add Mika :)
> 
> > > I'm using Dell Inspiron 13, model P57G. It has a problem with the
> > > touchpad under Linux. Approximately half of the time, the touchpad is
> > > not working at all - the mouse cursor is not moving. In this case,
> > > there are error messages written to the kernel log every second:
> > > 
> > > [   53.127339] i2c_designware INT3433:00: controller timed out
> > > [   54.219336] i2c_designware INT3433:00: controller timed out
> > > [   55.311346] i2c_designware INT3433:00: controller timed out
> > > [   56.403326] i2c_designware INT3433:00: controller timed out
> > > 
> > > There is a simple fix - blacklist the driver
> > > (i2c_designware_platform). In this case, the touchpad words as a mouse
> > > and used IRQ 12. Googling for "blackist i2c_designware_platform" shows
> > > that I'm not the one using that approach.
> > > 
> > > I started looking at the driver in git. A patch by Romain Baeriswyl
> > > applied on 2014-08-20 adds support for the "standard" mode with the
> > > 100kHz clock, as opposed to the 400kHz "fast" mode. Unfortunately,
> > > that patch only affects OpenFirmware systems, and I have ACPI. As soon
> > > as I set the clock to 100kHz, the touchpad started working every time.
> > > 
> > > One fix would be to have a module parameter to force slower clock. It
> > > would still require users to deal with modprobe, so it's not optimal.
> > > 
> > > I noticed that dev->get_clk_rate_khz(dev) returns 100000, but that
> > > would be 100000kHz = 100MHz. Not sure is somebody confused the units
> > > or it's the correct clock.
> > > 
> > > Considering that I have no other systems to test, what would be the
> > > best approach? Set the clock to 100kHz for INT3433? Recognize Dell
> > > P57G system specifically? How? Preserve the original clock by reading
> > > the DW_IC_CON register and keeping some bits?
> > 
> > Note: The driver has been using 400kHz from its beginning. However,
> > 100kHz is usually a better default for I2C busses. I wonder if we should
> > take the risk of a performance regression in favour of a sane and
> > working default?

Pavel,

Can you send me acpidump of that machine (or contents of
/sys/firmware/acpi/tables/DSDT)? It may be that the ACPI I2cSerialBus
connector actually has 100kHz there - we just don't use it currently.
