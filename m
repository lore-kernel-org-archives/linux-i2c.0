From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH] mxs: i2c: Implement arbitrary clock speed derivation
 algorithm
Date: Fri, 25 Jan 2013 14:33:20 +0800
Message-ID: <20130125063318.GA2707@S2101-09.ap.freescale.net>
References: <1354297715-12201-1-git-send-email-marex@denx.de>
 <20130124072555.GD8364@nekote.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130124072555.GD8364-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 24, 2013 at 08:25:56AM +0100, Wolfram Sang wrote:
> Hi Marek,
> 
> On Fri, Nov 30, 2012 at 06:48:35PM +0100, Marek Vasut wrote:
> > This patch drops the i2c timing tables from this driver and instead
> > derives the timing based from the requested clock sleep. The timing
> > tables were completely wrong anyway when observed on a scope.
> > 
> > This new algorithm is also only derived by using a scope, but it seems
> > to produce much more accurate result.
> > 
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-mxs.c |   94 ++++++++++++++++++++++++------------------
> >  1 file changed, 55 insertions(+), 39 deletions(-)
> > 
> > NOTE: Can someone please test if this patch works for them as well?
> >       I tested this on DENX M28EVK and Freescale MX28EVK.
> 
> Second call for testers.

imx28 still talks good to sgtl5000 over i2c on my board, so

Tested-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
