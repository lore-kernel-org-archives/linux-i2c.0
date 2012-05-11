From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl support
Date: Fri, 11 May 2012 13:27:42 +0000
Message-ID: <201205111327.42883.arnd@arndb.de>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com> <20120511053218.GT17875@S2101-09.ap.freescale.net> <CACRpkdY3Ga0soie+tsALxA1yhzXbyVOj_HbLLWOjRPz6cMLqtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdY3Ga0soie+tsALxA1yhzXbyVOj_HbLLWOjRPz6cMLqtQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 11 May 2012, Linus Walleij wrote:
> On Fri, May 11, 2012 at 7:32 AM, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> 
> > pinctrl-mergebase-20120418 is not enough for me.  I need mxs and dummy
> > states support.  So if your devel branch will never be rebased, we can
> > simply ask Arnd and Olof to get that as the dependent branch?
> 
> Hm, yes the devel branch is getting real stable now, so I will only add things
> on top.
> 
> Basically the for-next branch is supposed to be even more stable,
> but right now it's a copy of devel.
> 
> ARM SoC guys: how do you want the pinctrl deps? I can make
> a tag today if that is preferred.

No need for a signed tag, since we're not going to submit you changes
upstream. Knowing that we can pull in the for-next branch is good enough,
so we'll do that for anything that needs it.

> Also: short-cut to another subject: how have you other guys managed
> this? By e.g.:
> 
> git fetch <pinctrl tree>
> 
> git checkout -b my-pinwork v3.4-rc4
> git merge pinctrl-tag
> (develop develop)
> 
> Or:
> 
> git checkout -b my-pinwork pinctrl-tag
> 
> ?
> 
> I was a bit uncertain on how to do this for the pending Ux500
> stuff so better ask. I merged it for now but maybe it's better if
> I just base the whole pullrequest on top of a stable pinctrl
> branch?

No strong preference on my side. I've seen both ways getting done.
In arm-soc we try to do a 'git pull --log --no-ff' for all changes
that are being pulled into one of the main next/* branches, just
like torvalds does when he pulls in branches from maintainers.

	Arnd
