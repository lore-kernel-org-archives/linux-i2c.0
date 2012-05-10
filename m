From: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl support
Date: Thu, 10 May 2012 21:41:20 +0800
Message-ID: <20120510134120.GM2982@b20223-02.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-4-git-send-email-richard.zhao@freescale.com>
 <20120509160005.GG3955@opensource.wolfsonmicro.com>
 <20120510003532.GG2982@b20223-02.ap.freescale.net>
 <20120510063904.GB17875@S2101-09.ap.freescale.net>
 <20120510084403.GA3908@opensource.wolfsonmicro.com>
 <20120510090459.GH2982@b20223-02.ap.freescale.net>
 <20120510092733.GH3908@opensource.wolfsonmicro.com>
 <20120510102309.GK2982@b20223-02.ap.freescale.net>
 <CACRpkdah3956QLZZ1wTw1PcZ90wWX=Ta9j45jjzWsBtT=nm8-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdah3956QLZZ1wTw1PcZ90wWX=Ta9j45jjzWsBtT=nm8-g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 10, 2012 at 02:26:31PM +0200, Linus Walleij wrote:
> On Thu, May 10, 2012 at 12:23 PM, Richard Zhao
> <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> > On Thu, May 10, 2012 at 10:27:34AM +0100, Mark Brown wrote:
> >> On Thu, May 10, 2012 at 05:05:00PM +0800, Richard Zhao wrote:
> >>
> >> > devm_pinctrl_get_select_default function is added in below commi=
t which
> >> > is in pinctrl/for-next.
> >>
> >> Oh, dear. =A0That's unfortunate, I guess it's not on a branch in p=
inctl
> >> which can be pulled separately (...)
> >
> > I prefer to have a non-rebase pinctrl branch. We can not defer pinc=
trl
> > patch for all drivers. pinctrl will be so widely used.
> >
> > Hi Linus,
> >
> > Could you comment?
>=20
> You're lucky because a few ARM SoC:s wanted a stable tag to
> use for pinctrl merges.
>=20
> Ref:
> git://git.linaro.org/people/triad/linux-pinctrl.git
>=20
> The tag pinctrl-mergebase-20120418
I only find the tag at your kernel.org git tree. Linaro switched git
server again? strange.

Mark,

Are you ok with that?

Thanks
Richard
> contains the devm and other changes, Stephen is already using
> that for Tegra stuff and it's solid as a rock. Newer patches are
> put on top of this and since pinctrl has no deps in any directions
> it will be requested for pull as soon as the merge window opens.
>=20
> Yours,
> Linus Walleij
>=20
