From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v8 3/3] I2C: mediatek: Add driver for MediaTek MT8173
 I2C controller
Date: Wed, 20 May 2015 10:53:22 +0800
Message-ID: <1432090402.13819.14.camel@mtksdaap41>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
	 <1431967209-5261-4-git-send-email-eddie.huang@mediatek.com>
	 <CABuKBeKJ=V6bP9iU9xDN0JecTTFoLDUfsX_QP5rpPj1bn167Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABuKBeKJ=V6bP9iU9xDN0JecTTFoLDUfsX_QP5rpPj1bn167Vg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Matthias,

On Tue, 2015-05-19 at 16:45 +0200, Matthias Brugger wrote:
> 2015-05-18 18:40 GMT+02:00 Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>:
> > Add mediatek MT8173 I2C controller driver. Compare to I2C controller
> > of earlier mediatek SoC, MT8173 fix write-then-read limitation, and
> > also increase message size to 64kb.
> >
> > Signed-off-by: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Acked-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-mt65xx.c | 94 +++++++++++++++++++++++++++++------------
> >  1 file changed, 67 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> > index 7462f05..1ebbf1a 100644
> > --- a/drivers/i2c/busses/i2c-mt65xx.c
> > +++ b/drivers/i2c/busses/i2c-mt65xx.c
> > @@ -33,10 +33,13 @@
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> >
> > +#define I2C_RS_TRANSFER                        (1 << 4)
> 
> As far as I can see, mt6589 and mt8127 don't have this bit defined in
> their datasheets (and most probably others neither).
> Is it save to write this bit, although it is not implemented?

I think it is safe to write this bit. Since other guys may have the same
question, I will modify to write I2C_RS_TRANSFER only when this bit
exist.

Eddie


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
