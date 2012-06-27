From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
Date: Wed, 27 Jun 2012 03:30:31 +0200
Message-ID: <201206270330.31669.marex@denx.de>
References: <1339242351-8797-1-git-send-email-marex@denx.de> <20120611063903.GD2552@S2101-09.ap.freescale.net> <201206111254.21766.marex@denx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201206111254.21766.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Shawn Guo,

> > On Sat, Jun 09, 2012 at 01:45:50PM +0200, Marek Vasut wrote:
> > > This patch configures the I2C bus timing registers according
> > > to information passed via DT. Currently, 100kHz and 400kHz
> > > modes are supported.
> > > 
> > > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > 
> > I gave it a test on imx28-evk board with audio playback.  It seems
> > the patch makes the first time playback non-functional, but the later
> > playback is still working.
> 
> Any hints what can be the source of this issue? I tested it with i2c
> eeprom, saw no issues in there. I'll poke into it later.

Ok, I managed to replicate it just now. Scrap my previous email.

Still, any idea what can cause this?

Best regards,
Marek Vasut
