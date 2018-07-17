From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for a bus clock
Date: Tue, 17 Jul 2018 15:01:54 +0200
Message-ID: <CAMuHMdX8Q4wJtQ==PW0HrQpWS=CY1zPuasJPQCuQwhN0PzVfpQ@mail.gmail.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
 <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
 <20180717120737.bipotpki3yhn6klf@verge.net.au> <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
 <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Simon Horman <horms@verge.net.au>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Hi Phil,

On Tue, Jul 17, 2018 at 2:42 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> On 17 July 2018 13:24, Andy Shevchenko wrote:
> > On Tue, 2018-07-17 at 14:07 +0200, Simon Horman wrote:
> > > On Mon, Jul 16, 2018 at 09:59:13AM +0100, Phil Edworthy wrote:
> > > > The Synopsys I2C Controller has a bus clock, but typically SoCs hide
> > > > this away.
> > > > However, on some SoCs you need to explicity enable the bus clock in
> > > > order to access the registers.
> > > > Therefore, enable an optional bus clock specified by DT.
> >
> > > > +         /* Optional bus clock */
> > > > +         if (!IS_ERR(dev->busclk)) {
> > >
> > > I suspect that error values stored in dev->busclk,  other than
> > > -ENOENT, should be treated as errors.
> IS_ERR catches all errors and is the correct way to check the value
> returned by devm_clk_get.

What if it returns -EPROBE_DEFER, which means the clock is referenced,
and thus not optional, but not yet ready?
For optional clocks, all errors but -ENOENT should be propagated up.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
