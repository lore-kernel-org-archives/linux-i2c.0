From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [RFC PATCH] mxs: i2c: Implement arbitrary clock speed derivation algorithm
Date: Sun, 10 Feb 2013 15:17:10 +0100
Message-ID: <201302101517.10571.marex@denx.de>
References: <1354297715-12201-1-git-send-email-marex@denx.de> <20130210135737.GB15546@nekote.pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130210135737.GB15546-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> On Fri, Nov 30, 2012 at 06:48:35PM +0100, Marek Vasut wrote:
> > This patch drops the i2c timing tables from this driver and instead
> > derives the timing based from the requested clock sleep. The timing
> > tables were completely wrong anyway when observed on a scope.
> > 
> > This new algorithm is also only derived by using a scope, but it seems
> > to produce much more accurate result.
> > 
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> 
> Since Shawn and I tested it meanwhile, I changed the printouts to
> dev_warn and applied to for-next, thanks!

Is this 3.9 matter now ?

Thanks!

Best regards,
Marek Vasut
