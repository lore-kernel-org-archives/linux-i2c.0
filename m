From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v7 1/2] i2c: imx: add DMA support for freescale i2c driver
Date: Fri, 19 Sep 2014 14:15:21 +0200
Message-ID: <201409191415.21528.marex@denx.de>
References: <1407923215-3749-1-git-send-email-yao.yuan@freescale.com> <201409172114.36617.marex@denx.de> <1411055145666.72178@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411055145666.72178-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "LW-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org" <LW-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday, September 18, 2014 at 05:46:04 PM, Yao Yuan wrote:
> Marek Vasut wrote:
> > On Wednesday, September 17, 2014 at 04:50:34 PM, Yao Yuan wrote:
> > [...]
> > 
> > > > > > Would that mean that the "crashed" DMA would be running until the
> > > > > > next transmission is scheduled ?
> > > > > 
> > > > > [Yuan Yao] No, In fact any DMA timeout will result the failure of
> > > > > I2C transmission and then it will turn to report the exception and
> > > > > wait for next transmission.
> > > > 
> > > > Can you tell when the next transmission will happen? What if I issue
> > > > a single transmission and that one fails ? Will the DMA run until
> > > > who knows when ?
> > > 
> > > [Yuan Yao]
> > > Sorry for my unclear description. In fact, During the DMA transmission 
> > > if an error happened or time out, DMA will stop at once and be
> > > disabled. I just continue to route the TX and RX request to signal the
> > > DMA controller. Because the DMA is disabled, it will ignore those
> > > signals.
> > > 
> > > In a word, I just want to block the I2C TX, RX and interrupt signal
> > > when DMA mode failed until the next I2C transmission start.
> > 
> > So the I2C block is in error state until you clean it up upon next
> > transmission?
> 
> [Yuan Yao]
> No, just DMAEN bit.
> Other I2C error state will clean soon.
> 
> > > In fact, the bit "I2CR_DMAEN" is a switch which decide whether I2C
> > > route the TX, RX and interrupt signal to DMA controller.
> > > 
> > > > The only thing I worried about is I2C may still receive some
> > > > feedbacks after DMA timeout. In this case the feedbacks may lead to
> > > > abnormal state in PIO mode.But it will be ignored in DMA model.
> > > > That's why I tend to delay force-disable DMA until the next
> > > > transmission begin. Could you please give me some suggestion?
> > > > 
> > > > No, this design just seems flawed to me. You should stop the DMA
> > > > immediatelly if there is an error to avoid wasting resources and
> > > > prevent possible other adverse effects.
> > > 
> > > [Yuan Yao]
> > > Yes, I have stopped the DMA immediately. However I keep the I2C DMA
> > > single route.
> > > 
> > > I don't have the exact evidence to prove that my design is acceptable.
> > > So if you are sure it's flawed, I will change it in the next
> > > version(V8).
> > 
> > I'm just trying to understand it.
> 
> [Yuan Yao]
> Both of us know that we should stop DMA immediately when issue happened.
> The only argument is that I want to set the DMAEN bit just before the next
> transmission starts. But you think when I stop the DMA I should set it at
> the same time. The bit is the switch which is used to decide whether Rx
> and Tx signal can be routed to DMA. In fact, I deeply think about what is
> the difference between our arguments for those days. I think the two ways
> are almost the same. Your way is more acceptable because people tend to
> clear the DMA status just after stopping it. So I think your way is
> better.

OK, I am a bit lost, so let's see V8 and then go with that one I'd say.

Best regards,
Marek Vasut
