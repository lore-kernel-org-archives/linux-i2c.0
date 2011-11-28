From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: reorganize muxes to a standard pattern
Date: Mon, 28 Nov 2011 09:22:27 +0100
Message-ID: <20111128092227.3d5d6a25@endymion.delvare>
References: <1321220474-11378-1-git-send-email-w.sang@pengutronix.de>
	<20111127214847.547542fb@endymion.delvare>
	<87sjl9gtcv.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87sjl9gtcv.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 27 Nov 2011 22:15:12 +0100, Peter Korsgaard wrote:
> >>>>> "Jean" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:
> 
> Hi,
> 
>  >> rename drivers/i2c/muxes/{gpio-i2cmux.c => i2c-mux-gpio.c} (100%)
>  >> rename drivers/i2c/muxes/{pca9541.c => i2c-mux-pca9541.c} (100%)
>  >> rename drivers/i2c/muxes/{pca954x.c => i2c-mux-pca954x.c} (100%)
> 
>  Jean> You forgot to rename Documentation/i2c/muxes/gpio-i2cmux.
> 
>  Jean> I thought the naming had been discussed before, but I can't find the
>  Jean> references, and to be honest the new names please me, so I have no
>  Jean> reason to decline your proposal. I would have appreciated an ack from
>  Jean> the driver authors (Cc'd) though. I'll apply your patch as soon as I
>  Jean> receive an updated version, unless I get an objection before then.
> 
> Are you referring to this?
> 
> http://thread.gmane.org/gmane.linux.drivers.i2c/7171/focus=7244

Ah, yes, that's the discussion I was looking for, thanks for digging it
out. My point wasn't totally wrong back then, but Wolfram's is simply
better, I admit.

> I originally called it i2c-gpiomux.c, and renamed it to gpio-i2cmux.c on
> request of you.
> 
> I don't mind the new name though, so:
> 
> Acked-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

Thanks,
-- 
Jean Delvare
