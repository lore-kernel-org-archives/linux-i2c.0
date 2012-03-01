From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: avoid I2C abnormal after resuming from deep
	sleep
Date: Thu, 1 Mar 2012 11:27:24 +0000
Message-ID: <20120301112724.GE8441@trinity.fluff.org>
References: <1330511961-22498-1-git-send-email-chenhui.zhao@freescale.com> <20120229183436.GA30545@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120229183436.GA30545-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Zhao Chenhui <chenhui.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Li Yang <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 29, 2012 at 07:45:23PM +0100, Wolfram Sang wrote:
> Hi,
> 
> On Wed, Feb 29, 2012 at 06:39:21PM +0800, Zhao Chenhui wrote:
> > When entering deep sleep, the value in the registers I2CFDR and
> > I2CDFSRR are lost. This causes I2C access to fail after resuming.
> > 
> > Add suspend/resume routines to save/restore the registers
> > I2CFDR and I2CDFSRR.
> > 
> > Signed-off-by: Zhao Chenhui <chenhui.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Signed-off-by: Li Yang <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-mpc.c |   34 +++++++++++++++++++++++++++++++++-
> >  1 files changed, 33 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> > index a8ebb84..f95a647 100644
> > --- a/drivers/i2c/busses/i2c-mpc.c
> > +++ b/drivers/i2c/busses/i2c-mpc.c
> > @@ -1,7 +1,9 @@
> >  /*
> >   * (C) Copyright 2003-2004
> >   * Humboldt Solutions Ltd, adrian-nKrwMtk+6WksDtB2XHyCLA@public.gmane.org
> > -
> > + *
> > + * Copyright 2012 Freescale Semiconductor, Inc.
> > + *
> 
> I'd think the change is too trivial to claim copyright on the file.

I agree with that.

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
