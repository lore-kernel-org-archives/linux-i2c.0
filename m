From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: eg20t: include slab.h for memory allocations
Date: Wed, 16 Feb 2011 13:29:29 +0100
Message-ID: <20110216122929.GA6210@pengutronix.de>
References: <1296672461-22822-1-git-send-email-w.sang@pengutronix.de>
 <20110202222422.GX15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110202222422.GX15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 02, 2011 at 10:24:22PM +0000, Ben Dooks wrote:
> On Wed, Feb 02, 2011 at 07:47:41PM +0100, Wolfram Sang wrote:
> > Fixes (with v2.6.38-rc3/parisc/parisc-allmodconfig):
> >   src/drivers/i2c/busses/i2c-eg20t.c:720: error: implicit declaration of function 'kzalloc'
> >   src/drivers/i2c/busses/i2c-eg20t.c:790: error: implicit declaration of function 'kfree'
> > 
> > Reported-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
> 
> ok, will pick this one up.

Please don't forget.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
