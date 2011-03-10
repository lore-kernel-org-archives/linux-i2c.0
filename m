From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: set controller to pio queue mode after reset
Date: Thu, 10 Mar 2011 08:13:20 +0000
Message-ID: <20110310081320.GE15795@trinity.fluff.org>
References: <1298656491-30686-1-git-send-email-w.sang@pengutronix.de> <20110307004736.GC15795@trinity.fluff.org> <20110307090651.GA3425@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110307090651.GA3425-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 07, 2011 at 10:06:51AM +0100, Wolfram Sang wrote:
> On Mon, Mar 07, 2011 at 12:47:36AM +0000, Ben Dooks wrote:
> > On Fri, Feb 25, 2011 at 06:54:51PM +0100, Wolfram Sang wrote:
> > > From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > 
> > > mxs_reset_block() clears the PIO_QUEUE_MODE bit. So we have
> > > to set it again after a controller reset.
> > 
> > -rc candidate?
> 
> The driver is only in your next branch. I guess you could even squash
> it into the driver if rebasing does not hurt there.

I'll add it to the -next branch ready for merging.

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
