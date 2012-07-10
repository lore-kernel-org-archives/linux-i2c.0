From: Robert Schwebel <robert-xKSCrvTH0lQb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
Date: Tue, 10 Jul 2012 16:09:11 +0200
Message-ID: <20120710140911.GK20456@pengutronix.de>
References: <1341554956-17416-1-git-send-email-marex@denx.de>
 <201207091307.35860.marex@denx.de>
 <20120709120523.GG1296@pengutronix.de>
 <201207091758.22788.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201207091758.22788.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 09, 2012 at 05:58:22PM +0200, Marek Vasut wrote:
> > The kernel should work for all users, not only for the majority, so:
> > Better safe than sorry.
> >
> > Also, defaults should make the system work. Tuning can be done later by
> > somebody who understands what is needed.
> >
> > And frankly, this attitude which made you add a potential regression is
> > worrisome. I'd suggest to give stability a higher priority.
>
> I believe you misunderstood my intention. Setting it to 400kHz was done because
> it's what most people will use, therefore avoiding duplication (most of the
> board files will override this setting now). All right, your sane defaults here
> can be applied, I won't argue.

I think all I2C chips support 100 kHz, but only selected ones support
400 kHz.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
