From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: reorganize muxes to a standard pattern
Date: Mon, 28 Nov 2011 12:57:51 +0100
Message-ID: <20111128125751.3d6a3ca7@endymion.delvare>
References: <1321220474-11378-1-git-send-email-w.sang@pengutronix.de>
	<20111127214847.547542fb@endymion.delvare>
	<87sjl9gtcv.fsf@macbook.be.48ers.dk>
	<20111128092227.3d5d6a25@endymion.delvare>
	<20111128093835.GA4243@pengutronix.de>
	<874nxoh8l5.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <874nxoh8l5.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 28 Nov 2011 10:58:30 +0100, Peter Korsgaard wrote:
> >>>>> "Wolfram" == Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> writes:
> 
>  >> > http://thread.gmane.org/gmane.linux.drivers.i2c/7171/focus=7244
>  >> 
>  >> Ah, yes, that's the discussion I was looking for, thanks for digging it
>  >> out. My point wasn't totally wrong back then, but Wolfram's is simply
>  >> better, I admit.
> 
>  Wolfram> I agree :) Okay, so I'll update the documentation as well. What about
>  Wolfram> include/linux/gpio-i2cmux.h and its users? I'd like consistency, but
>  Wolfram> renaming header files is not too nice...
> 
> Indeed. If we were to rename it we should also rename struct
> gpio_i2cmux_platform_data.
> 
> I don't feel strongly about it - It will break for existing users, but
> there's probably not too many of those. Your call.

I see exactly 1 user of <linux/gpio-i2cmux.h> in the upstream kernel
tree, and that is gpio-i2cmux itself. So I'd say no big deal renaming
it, and actually if we intend to rename header files and/or structures,
the sooner the better.

-- 
Jean Delvare
