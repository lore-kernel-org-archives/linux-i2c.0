From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
 clocking
Date: Mon, 7 Dec 2009 20:21:42 +0100
Message-ID: <083DF309106F364B939360100EC290F804F57A69FA@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com>
 <20091126090252.GB12179@pengutronix.de>
 <083DF309106F364B939360100EC290F804F5659CFF@eu1rdcrdc1wx030.exi.nxp.com>
 <20091206084731.GE2766@ucw.cz> <20091206210225.GA20887@pengutronix.de>
 <20091206210739.GE10184@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091206210739.GE10184-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> > Hi,
> >
> > On Sun, Dec 06, 2009 at 09:47:31AM +0100, Pavel Machek wrote:
> > > Hi!
> > >
> > > > > Subject: Re: [PATCH 1/1] Remove suspend/resume functionality, add
> dynamic
> > > > > clocking
> > > > >
> > > > > Hello,
> > > > >
> > > > > can you please add something like "i2c-pnx: " to the subject?
> > > > > (Actually it's a great strategy *not* to put it into the Subject.
> This
> > > > > way it attracts far more attention :-)
> > > > >
> > > >
> > > > Good point!
> > > >
> > > > > > Remove suspend/resume functionality, I2C driver gates clock on
> > > > > > only when an I2C transaction is in progress
> > > > > What happens when the machine suspends while a transfer is in
> progress?
> > > > > (This might be a problem that already existed before.)  If this is
> > > > > really a problem the easiest "fix" is to let the suspend callback
> return
> > > > > -EBUSY in this case.
> > > >
> > > > The suspend callback is now removed. It's actually not needed with
> this
> > > > change. The I2C clocks will turn on prior to a transaction and then
> turn
> > > > off at the completion.
> > >
> > > Are you sure its unneeded? What if someone attempts to suspend the
> > > system when a transaction is running?
> > That's exactly my question.  I think the machine will suspend and the
> > transaction fail.  So no suspend callback isn't optimal, but maybe OK?!
> 
> Having failures just because suspend happened at wrong time is
> bad. .suspend() should just wait for end of transaction.

I'm not sure what situation could actually occur that would suspend the
system in the middle of an I2C transaction. If an I2C transaction was
started and the CPU was suspended, this would appear to be a problem
outside the I2C driver itself. Would other I2C drivers have this similar
problem?

Other drivers that may use the I2C driver during their own suspend
sequence, the USB transceiver shutdown via I2C on this board is a good
example, will pend their own suspend return sequence until the I2C
transactions via I2C are complete. All the I2C driver does now is enable
the clock for the transaction and disable it at completion. This seemed
like the more logical way to go, it saves power when the I2C bus isn't
in use. Since all the suspend/resume functions do for the i2c-pnx
driver is disable and enable clocks, I didn't think the callbacks were
really needed anymore.

The few drivers that I've checked that use I2C in the suspend sequence
all wait for I2C completion prior to returning from suspend. I suppose
it's possible that applications that use i2c-dev may keep chugging away
on I2C as the system is being suspended(?). Maybe.

Would it make sense to add a flag that blocks I2C transcations if the
suspend callback is called (and unblocks them when resume is called)?
It wouldn't fix the root issue, but would prevent the driver from
starting transactions once it's suspend callback is handled just
returning an error status until resume is called?

> 
> 										Pavel
> 
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
