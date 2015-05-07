From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v7 0/3] ARM: mediatek: Add driver for Mediatek I2C
Date: Thu, 7 May 2015 15:54:44 +0800
Message-ID: <1430985284.22615.3.camel@mtksdaap41>
References: <1430901427-65146-1-git-send-email-eddie.huang@mediatek.com>
	 <20150507073900.GC12484@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150507073900.GC12484@x1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.orgAnders Berg <and>
List-Id: linux-i2c@vger.kernel.org

Hi Lee,

On Thu, 2015-05-07 at 08:39 +0100, Lee Jones wrote:
> On Wed, 06 May 2015, Eddie Huang wrote:
> 
> > 
> > Eddie Huang (1):
> >   I2C: mediatek: Add driver for MediaTek MT8173 I2C controller
> > 
> > Xudong Chen (2):
> >   dt-bindings: Add I2C bindings for mt65xx/mt81xx.
> >   I2C: mediatek: Add driver for MediaTek I2C controller
> > 
> >  .../devicetree/bindings/i2c/i2c-mt6577.txt         |  41 ++
> >  drivers/i2c/busses/Kconfig                         |   9 +
> >  drivers/i2c/busses/Makefile                        |   1 +
> >  drivers/i2c/busses/i2c-mt65xx.c                    | 748 +++++++++++++++++++++
> >  4 files changed, 799 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> >  create mode 100644 drivers/i2c/busses/i2c-mt65xx.c
> 
> Again, you've sent me a patch-set that has absolutely nothing to do
> with me.  Can you please stop doing that, my inbox is full enough
> already!
> 

Sorry, I use "scripts/get_maintainer.pl" to get mail receiver, and you
are on list.
I will narrow down receiver next time.

Eddie
