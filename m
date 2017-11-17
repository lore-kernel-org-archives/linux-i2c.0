From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 5/6] arm64: renesas: draak: enable I2C controller 1
Date: Fri, 17 Nov 2017 08:40:08 -0800
Message-ID: <20171117164008.qvsolbchongphi4i@verge.net.au>
References: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1510759526-30346-6-git-send-email-ulrich.hecht+renesas@gmail.com>
 <CAMuHMdX1iitObng0nvhmP4r5yb1CnqBwbchu6qDQLtqjPLbDQg@mail.gmail.com>
 <20171117143218.56gdhcdchdfjtbaq@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171117143218.56gdhcdchdfjtbaq@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 17, 2017 at 06:32:19AM -0800, Simon Horman wrote:
> On Thu, Nov 16, 2017 at 10:31:31AM +0100, Geert Uytterhoeven wrote:
> > Hi Uli,
> > 
> > On Wed, Nov 15, 2017 at 4:25 PM, Ulrich Hecht
> > <ulrich.hecht+renesas@gmail.com> wrote:
> > > No devices to add, I2C1 has an external connector only.
> > >
> > > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > 
> > Thanks for your patch!
> > 
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > but please see below.
> 
> Thanks, applied.

Sorry, I was a bit hasty there as this patch
depends on a patch earlier in the series which I have not applied.

I've dropped this patch for now and will wait a bit longer for the review
to unfold.

> > > --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > > +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > 
> > > @@ -84,6 +89,12 @@
> > >         };
> > >  };
> > >
> > > +&i2c1 {
> > > +       pinctrl-0 = <&i2c1_pins>;
> > > +       pinctrl-names = "default";
> > > +       status = "okay";
> > 
> > If no devices are connected, perhaps it's wise to defer the status update
> > to e.g. an overlay that describes what's connected to CN23?
> > 
> > Or do you want it enabled to allow adding devices manually using
> > /sys/bus/i2c/devices/i2c-1/new_device?
> 
> Ulrich, please consider following up on this.
> 
