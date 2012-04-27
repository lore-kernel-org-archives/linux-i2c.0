From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 09/11] ARM: imx6q: add ssi1 clk_lookup
Date: Fri, 27 Apr 2012 11:25:29 +0200
Message-ID: <20120427092529.GA20478@pengutronix.de>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-10-git-send-email-richard.zhao@freescale.com>
 <20120427080412.GW17184@pengutronix.de>
 <20120427091055.GP28063@b20223-02.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120427091055.GP28063-iWYTGMXpHj9ITqJhDdzsOjpauB2SiJktrE5yTffgRl4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 27, 2012 at 05:10:56PM +0800, Richard Zhao wrote:
> On Fri, Apr 27, 2012 at 10:04:12AM +0200, Sascha Hauer wrote:
> > On Fri, Apr 27, 2012 at 03:03:03PM +0800, Richard Zhao wrote:
> > > It's used by audio drivers.
> > > 
> > > Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > ---
> > >  arch/arm/mach-imx/clk-imx6q.c |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> > > index f40a35d..9a03dcc 100644
> > > --- a/arch/arm/mach-imx/clk-imx6q.c
> > > +++ b/arch/arm/mach-imx/clk-imx6q.c
> > > @@ -418,6 +418,7 @@ int __init mx6q_clocks_init(void)
> > >  	clk_register_clkdev(clk[sdma], NULL, "20ec000.sdma");
> > >  	clk_register_clkdev(clk[dummy], NULL, "20bc000.wdog");
> > >  	clk_register_clkdev(clk[dummy], NULL, "20c0000.wdog");
> > > +	clk_register_clkdev(clk[ssi1], NULL, "2028000.ssi");
> > 
> > The ssi clock needs a general cleanup on all i.MX just like I cleaned up
> > the other units. The SSI unit has at least a register clock and a baud
> > clock. What the driver requests and enables is the register clock.
> > 
> > The baud clock is currently unused and is needed only for master mode
> > (which is not implemented in the ssi driver)
> Are you sure for that? If I don't enable clk[ssi1], the ssi will not
> work.
> 
> > 
> > So where we want to come to is:
> > 
> > 	clk_register_clkdev(clk[ipg], "ipg", "2028000.ssi");
> ssi don't have ipg gate. We can let it always on for imx6q.

Can you please ask your IC guys for clarification?

For example on i.MX5 we have a ssi ipg clock and a ssi serial clock.
Both can be gated with two individual gate bits.

The i.MX6 datasheet (and also several other i.MX datasheets) is quite
nebulous. The i.MX6 has only one gate bit for each SSI unit, but
it's not clear if this bit actually gates both the ipg and serial
clock or only one of them.

My general idea is that each unit in the SoC has different input clocks.
In the driver we need to clk_get() the input clocks. If a given SoC has
no software control over some of the devices input clocks, then we need
to provide a dummy for this, because other SoCs have control over the
clock.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
