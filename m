From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 08/11] ARM: dts: imx6q-sabrelite: add sound device
 imx6q-sabrelite-sgtl5000
Date: Thu, 10 May 2012 17:41:15 +0800
Message-ID: <20120510094113.GG17875@S2101-09.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-9-git-send-email-richard.zhao@freescale.com>
 <20120510064816.GC17875@S2101-09.ap.freescale.net>
 <20120510093444.GI2982@b20223-02.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120510093444.GI2982-iWYTGMXpHj9ITqJhDdzsOjpauB2SiJktrE5yTffgRl4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, May 10, 2012 at 05:34:45PM +0800, Richard Zhao wrote:
> > "Mic Bias" is a SUPPLY for both "MIC_IN" and "Mic Jack", so it should
> > look like:
> > 
> >                        "Mic Jack", "Mic Bias",
> >                        "MIC_IN", "Mic Bias",
> Not really. The circuit:
> MIC_IN <-- capacitor <--> Mic Jack
>                       /
>             Mic Bias /
> 
The "Mic Bias" here is really a SGTL5000 internal supply.

Regards,
Shawn

> DC can not pass the capacitor. So Mic Bias only supply Jack.
> 
