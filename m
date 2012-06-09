From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
Date: Sat, 9 Jun 2012 13:25:45 +0200
Message-ID: <20120609112545.GH30400@pengutronix.de>
References: <1339181689-22573-1-git-send-email-marex@denx.de>
 <201206091234.47309.marex@denx.de>
 <20120609105330.GF30400@pengutronix.de>
 <201206091311.43229.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201206091311.43229.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 09, 2012 at 01:11:42PM +0200, Marek Vasut wrote:
> Dear Sascha Hauer,
> 
> > On Sat, Jun 09, 2012 at 12:34:47PM +0200, Marek Vasut wrote:
> > > Dear Shubhrajyoti Datta,
> > > 
> > > > Didnt understand this.
> > > 
> > > What exactly, it's running (according to the datasheet) at 95kHz.
> > > 
> > > > > +       .timing0        = 0x00780030,
> > > > > +       .timing1        = 0x00800030,
> > > > > +       .timing2        = 0x0015000d,
> > > > > +};
> > > > > +
> > > > > +const struct mxs_i2c_speed_config mxs_i2c_400kHz_config = {
> > > > > +       .timing0        = 0x000f0007,
> > > > > +       .timing1        = 0x001f000f,
> > > > > +       .timing2        = 0x0015000d,
> > > > > +};
> > > > > +
> > > > 
> > > > How are these values calculated?
> > > 
> > > They're not calculated, they're presented in the datasheet. There's no
> > > formula, even though I believe one could be derived given enough effort.
> > 
> > Don't these values depend on the input clock of this unit? I don't know,
> > just asking.
> 
> Isn't the i2c block supplied from 24MHz clock source in the mx28?

Maybe. Shouldn't this be checked then or at least mentioned that these
values assume a certain clock frequency?

I wonder that currently the timing registers are not initialized at all.
Do they depend on reset defaults or bootloader setup?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
