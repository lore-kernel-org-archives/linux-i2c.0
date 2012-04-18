From: Li Yang-R58472 <r58472-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] i2c-mpc: avoid I2C abnormal after resuming from deep
 sleep
Date: Wed, 18 Apr 2012 10:20:36 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F092D1DC7@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1330511961-22498-1-git-send-email-chenhui.zhao@freescale.com>
 <20120229183436.GA30545@pengutronix.de>
 <20120417142105.GA21802@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120417142105.GA21802-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Zhao Chenhui-B35336 <B35336-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


> On Wed, Feb 29, 2012 at 07:45:23PM +0100, Wolfram Sang wrote:
> > Hi,
> >
> > On Wed, Feb 29, 2012 at 06:39:21PM +0800, Zhao Chenhui wrote:
> > > When entering deep sleep, the value in the registers I2CFDR and
> > > I2CDFSRR are lost. This causes I2C access to fail after resuming.
> > >
> > > Add suspend/resume routines to save/restore the registers I2CFDR and
> > > I2CDFSRR.
> > >
> > > Signed-off-by: Zhao Chenhui <chenhui.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > Signed-off-by: Li Yang <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > ---
> > >  drivers/i2c/busses/i2c-mpc.c |   34
> +++++++++++++++++++++++++++++++++-
> > >  1 files changed, 33 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/drivers/i2c/busses/i2c-mpc.c
> > > b/drivers/i2c/busses/i2c-mpc.c index a8ebb84..f95a647 100644
> > > --- a/drivers/i2c/busses/i2c-mpc.c
> > > +++ b/drivers/i2c/busses/i2c-mpc.c
> > > @@ -1,7 +1,9 @@
> > >  /*
> > >   * (C) Copyright 2003-2004
> > >   * Humboldt Solutions Ltd, adrian-nKrwMtk+6WksDtB2XHyCLA@public.gmane.org
> > > -
> > > + *
> > > + * Copyright 2012 Freescale Semiconductor, Inc.
> > > + *
> >
> > I'd think the change is too trivial to claim copyright on the file.
> 
> Do you want to resend with the comments addressed?

We have a company policy for adding copyright claims.  And this patch has met our criteria that requires adding copyright.

We certainly don't want the policy to be against the common practice of the community.  If it is we can consider changing our policy.  However I can't find a clear message stating the consensus of what the Linux kernel community think of adding copyright claims.  I even found some message that encourage adding copyright to maintain the GPL license.

- Leo
