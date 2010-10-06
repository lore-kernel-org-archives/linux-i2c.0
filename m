From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: Please pull bjdooks' i2c-fixes
Date: Wed, 6 Oct 2010 23:14:30 +0100
Message-ID: <20101006221430.GW21564@trinity.fluff.org>
References: <E1P1SAZ-0001tp-ON@ben-laptop> <20101001080951.GA27870@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101001080951.GA27870-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 01, 2010 at 10:09:51AM +0200, Wolfram Sang wrote:
> Ben,
> 
> On Fri, Oct 01, 2010 at 12:04:07AM +0100, Ben Dooks wrote:
> > The following changes since commit 4193d9163582b05e33aca3392e46649e5c3da8d1:
> >   Linus Torvalds (1):
> >         Merge branch 'for-linus' of git://oss.sgi.com/xfs/xfs
> > 
> > are available in the git repository at:
> > 
> >   git://git.fluff.org/bjdooks/linux.git for-linus/i2c/2636-rc5
> > 
> > Bernhard Walle (1):
> >       i2c-octeon: Return -ETIMEDOUT in octeon_i2c_wait() on timeout
> > 
> > Jon Povey (1):
> >       i2c-davinci: Fix race when setting up for TX
> > 
> > MyungJoo Ham (1):
> >       i2c-s3c2410: fix calculation of SDA line delay
> > 
> >  drivers/i2c/busses/i2c-davinci.c |    6 +++---
> >  drivers/i2c/busses/i2c-octeon.c  |    2 +-
> >  drivers/i2c/busses/i2c-s3c2410.c |    4 ++--
> >  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> Is there a specific reason this patch was not picked up/commented (again)?
> 
> http://thread.gmane.org/gmane.linux.drivers.i2c/6222/focus=6265
> 
> It prevents getting a stalled bus, and we have done similar things for MPC and
> other platforms.

It got tagged onto the end of the previous thread, which was ages ago.

In future, it would be helpful to send each major revision of a patch
as a new thread, maybe with a reference to the previous one.

I'll try and add it before the next pull window, or in it.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
