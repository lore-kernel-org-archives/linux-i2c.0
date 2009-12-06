From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
	clocking
Date: Sun, 6 Dec 2009 09:47:31 +0100
Message-ID: <20091206084731.GE2766@ucw.cz>
References: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com> <20091126090252.GB12179@pengutronix.de> <083DF309106F364B939360100EC290F804F5659CFF@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <083DF309106F364B939360100EC290F804F5659CFF-SIPbe8o7cfX8DdpCu65jn8FrZmdRls4ZQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Cc: Uwe Kleine-K?nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi!

> > Subject: Re: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
> > clocking
> > 
> > Hello,
> > 
> > can you please add something like "i2c-pnx: " to the subject?
> > (Actually it's a great strategy *not* to put it into the Subject.  This
> > way it attracts far more attention :-)
> > 
> 
> Good point!
> 
> > > Remove suspend/resume functionality, I2C driver gates clock on
> > > only when an I2C transaction is in progress
> > What happens when the machine suspends while a transfer is in progress?
> > (This might be a problem that already existed before.)  If this is
> > really a problem the easiest "fix" is to let the suspend callback return
> > -EBUSY in this case.
> 
> The suspend callback is now removed. It's actually not needed with this
> change. The I2C clocks will turn on prior to a transaction and then turn
> off at the completion.

Are you sure its unneeded? What if someone attempts to suspend the
system when a transaction is running?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
