From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4] MXS: I2C improvements
Date: Thu, 10 May 2012 15:35:20 +0800
Message-ID: <20120510073518.GE17875@S2101-09.ap.freescale.net>
References: <1335837621-14816-1-git-send-email-marex@denx.de>
 <201205092033.46812.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201205092033.46812.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 09, 2012 at 08:33:46PM +0200, Marek Vasut wrote:
> > This patchset implements support for adjustment of I2C bus speed via
> > platform data. Further, it implements support for DMA transfers into the
> > mxs-i2c driver. Lastly, there is a fix for GCC4.7 warning included.
> > 
> > Marek Vasut (4):
> >   MXS: Allow passing i2c bus speed via platform data
> >   MXS: Set I2C timing registers for mxs-i2c
> >   MXS: Implement DMA support into mxs-i2c
> >   MXS: Fix GCC4.7 complaint in mxs-i2c
> 
> Bump?
> 
Sorry, Marek.  Since we are moving over to device tree, I'm not going
to ack the arch/arm/mach-mxs changes, which are introducing more use
of platform data.

-- 
Regards,
Shawn
