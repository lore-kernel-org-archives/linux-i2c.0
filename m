From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: eg20t: include slab.h for memory allocations
Date: Sun, 20 Feb 2011 23:49:28 +0000
Message-ID: <20110220234928.GO15795@trinity.fluff.org>
References: <1296672461-22822-1-git-send-email-w.sang@pengutronix.de> <20110202222422.GX15795@trinity.fluff.org> <20110216122929.GA6210@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110216122929.GA6210-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 16, 2011 at 01:29:29PM +0100, Wolfram Sang wrote:
> On Wed, Feb 02, 2011 at 10:24:22PM +0000, Ben Dooks wrote:
> > On Wed, Feb 02, 2011 at 07:47:41PM +0100, Wolfram Sang wrote:
> > > Fixes (with v2.6.38-rc3/parisc/parisc-allmodconfig):
> > >   src/drivers/i2c/busses/i2c-eg20t.c:720: error: implicit declaration of function 'kzalloc'
> > >   src/drivers/i2c/busses/i2c-eg20t.c:790: error: implicit declaration of function 'kfree'
> > > 
> > > Reported-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> > > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > Cc: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
> > 
> > ok, will pick this one up.
> 
> Please don't forget.

I'll try and issue a new git tree tomorrow, had problems with old laptop
and 'fun' moving to the new one.

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
