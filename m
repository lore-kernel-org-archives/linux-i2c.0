From: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: Re: [PATCH 07/15] i2c: Add Device Tree support to the Nomadik I2C
 driver
Date: Thu, 21 Jun 2012 12:17:06 +0530
Message-ID: <20120621064705.GA24921@bnru02>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbi7vmJE9LPmiu2NGM4b_SZ-Hi=a_xgrCOQX9ofKsLFew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbi7vmJE9LPmiu2NGM4b_SZ-Hi=a_xgrCOQX9ofKsLFew-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linus WALLEIJ <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 20, 2012 at 21:30:17 +0200, Linus Walleij wrote:
> On Wed, Jun 20, 2012 at 2:56 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> 
> > Here we apply the bindings required for successful Device Tree
> > probing of the i2c-nomadik driver. We also apply a fall-back
> > configuration in case either one is not provided, or a required
> > element is missing from the one supplied.
> >
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Pls Cc Srinidhi on these patches, and I would prefer to get his ACK on this.

if trivial comments fixed, then

Acked-by: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

> 
> Srinidhi, could you propose a patch to MAINTAINERS adding yourself as
> explicit maintainer for this driver?

ok.

/srinidhi
