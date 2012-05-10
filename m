From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl support
Date: Thu, 10 May 2012 17:07:18 +0800
Message-ID: <20120510090715.GF17875@S2101-09.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-4-git-send-email-richard.zhao@freescale.com>
 <20120509160005.GG3955@opensource.wolfsonmicro.com>
 <20120510003532.GG2982@b20223-02.ap.freescale.net>
 <20120510063904.GB17875@S2101-09.ap.freescale.net>
 <20120510084403.GA3908@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120510084403.GA3908-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, May 10, 2012 at 09:44:04AM +0100, Mark Brown wrote:
> On Thu, May 10, 2012 at 02:39:06PM +0800, Shawn Guo wrote:
> > On Thu, May 10, 2012 at 08:35:33AM +0800, Richard Zhao wrote:
> 
> > > It's based on your for-next. But for working, it depends on
> > > pinctl/for-next.
> 
> > Mark, may I have your ack to have it go through arm-soc?  I will ask
> > Arnd pull your sound/for-v3.5 branch into arm-soc as a dependency.
> > You need to ensure the branch will not be rebased.
> 
> for-3.5 is the entire undifferentiated blob of ASoC stuff, it's not
> really suitable for merging elsewhere.  It won't actually get rebased
> but the idea of merging it into other trees doesn't seem terribly
> clever, it'd make having topic branches in arm-soc a bit of a joke and
> if you pull it right now you'll get problems in -next due to the the
> ux500 stuff.
> 
Pulling it into arm-soc as a dependency only means we will have it as
a base for other branches that depend on.  It does not change anything
about how the branch flows to Linus.  Arnd will only send those arm-soc
branches that depend on sound/for-3.5 after it gets merged by Linus.

> What does "working" mean in this context - what happens without the
> pinctl changes?

It will break all the imx-audmux users that haven't got any pinctrl
states defined for imx-audmux.  We have patches on imx (arm-soc) tree
defining pinctrl states either in DT or dummy states in board files
to make sure pinctrl API works fine for every imx-audmux users. 

-- 
Regards,
Shawn
