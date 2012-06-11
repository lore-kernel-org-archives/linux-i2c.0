From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
Date: Mon, 11 Jun 2012 12:53:17 +0200
Message-ID: <201206111253.17314.marex@denx.de>
References: <1339242351-8797-1-git-send-email-marex@denx.de> <201206101353.06018.marex@denx.de> <20120611073036.GG2552@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120611073036.GG2552-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Shawn Guo,

> On Sun, Jun 10, 2012 at 01:53:05PM +0200, Marek Vasut wrote:
> > > +struct mxs_i2c_speed_config {
> > > +	uint32_t	timing0;
> > > +	uint32_t	timing1;
> > > +	uint32_t	timing2;
> > > +};
> > > +
> > > +/* Timing values for the default 24MHz clock supplied into the i2c
> > > block.
> > 
> > Thinking about these further -- does anyone have any idea how these
> > numbers were derived? And possibly even formula for that?
> > 
> > And maybe we should somehow make sure the source runs on 24MHz (how?).
> 
> There is nothing about I2C clock mentioned in CLKCTRL chapter.  I just
> contacted design team and was told that I2C clock sources from APBX
> (xbus) clock and always runs at the same frequency there.

Ok, then can you please try asking them how to exactly compute the values in 
timing0-timing2 registers? So we don't have to hardcode them like it's done now?

Best regards,
Marek Vasut
