From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v7 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Mon, 18 May 2015 15:42:16 +0800
Message-ID: <1431934936.14340.17.camel@mtksdaap41>
References: <1430901427-65146-1-git-send-email-eddie.huang@mediatek.com>
	 <1430901427-65146-3-git-send-email-eddie.huang@mediatek.com>
	 <20150512125832.GB4447@schokonusskuchen.bad>
	 <1431928701.22349.22.camel@mtksdaap41> <20150518063742.GA1545@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150518063742.GA1545@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 2015-05-18 at 08:37 +0200, Wolfram Sang wrote:
> > > > +		rpaddr = dma_map_single(i2c->adap.dev.parent, msgs->buf,
> > > > +						msgs->len, DMA_FROM_DEVICE);
> > > 
> > > I think you shouldn't use the adapter device here and later, but the dma
> > > channel device.
> > > 
> > In MTK SoC, each I2C controller has its own DMA, and this DMA can't be
> > used by other hardware.
> > So I tend to use DMA directly, not through DMA channel.
> > Even so, "i2c->adap.dev.parent" is not suitable here. I will change to
> > use i2c->dev here. (Reference i2c-at91.c).
> 
> The better reference would be i2c-sh_mobile.c, especially commit
> 8cfcae9f0595bf0d145a67cfaa1051804a301d7c ("i2c: sh_mobile: use proper
> device for mapping DMA memory") ;) The request to use the DMA channel
> device came from the DMA folks, so if there is no real reason for an
> exception, please use the channel device.
> 

sh_mobile already implement dmaengine, so its I2C driver can use dma
channel.
But Mediatek SoC don't have "generic" DMA engine, Each DMA belong to
specific hardware, so dmaengine is not necessary, and not suitable for
our I2C controller.In other words, dma dev can be considered as part of
I2C controller dev.

Eddie
