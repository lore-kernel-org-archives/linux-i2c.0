From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: reorganize muxes to a standard pattern
Date: Sat, 7 Jan 2012 15:51:07 +0100
Message-ID: <20120107155107.1e682fee@endymion.delvare>
References: <1321220474-11378-1-git-send-email-w.sang@pengutronix.de>
	<20111127214847.547542fb@endymion.delvare>
	<87sjl9gtcv.fsf@macbook.be.48ers.dk>
	<20111128092227.3d5d6a25@endymion.delvare>
	<20111128093835.GA4243@pengutronix.de>
	<874nxoh8l5.fsf@macbook.be.48ers.dk>
	<20111128125751.3d6a3ca7@endymion.delvare>
	<20120107153820.45ed4b37@endymion.delvare>
	<20120107144559.GA2537@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120107144559.GA2537-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 7 Jan 2012 15:46:00 +0100, Wolfram Sang wrote:
> On Sat, Jan 07, 2012 at 03:38:20PM +0100, Jean Delvare wrote:
> > On Mon, 28 Nov 2011 12:57:51 +0100, Jean Delvare wrote:
> > > I see exactly 1 user of <linux/gpio-i2cmux.h> in the upstream kernel
> > > tree, and that is gpio-i2cmux itself. So I'd say no big deal renaming
> > > it, and actually if we intend to rename header files and/or structures,
> > > the sooner the better.
> > 
> > Wolfram, Peter, any progress here? I think Wolfram was supposed to send
> > an updated patch but I did not receive anything.
> 
> -EBUSY :(
> 
> It *is* on my todo-list, though...

OK, no problem. Let's schedule this for kernel 3.4 then.

-- 
Jean Delvare
