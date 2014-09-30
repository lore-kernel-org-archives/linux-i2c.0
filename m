From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 1/3] i2c: hix5hd2: add devicetree documentation
Date: Tue, 30 Sep 2014 12:24:59 +0200
Message-ID: <3181910.E4XHspguRh@wuerfel>
References: <1411878129-19743-1-git-send-email-zhangfei.gao@linaro.org> <2135291.ciFUCkAm4U@wuerfel> <542A7705.2030404@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <542A7705.2030404-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, haifeng.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, jchxue-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 30 September 2014 17:25:25 zhangfei wrote:
> On 09/30/2014 05:01 PM, Arnd Bergmann wrote:
> > On Sunday 28 September 2014 12:22:07 Zhangfei Gao wrote:
> >> +
> >> +Required properties:
> >> +- compatible: Must be "hisilicon,hix5hd2-i2c"
> >> +  Specifically, the following versions of the chipset are supported:
> >> +         Hi3716CV200 (support six I2C module)
> >> +         Hi3719CV100 (support six I2C module)
> >> +         Hi3718CV100 (support six I2C module)
> >> +         Hi3719MV100 (support two I2C module)
> >> +         Hi3718MV100 (support two I2C module)
> >>
> >
> > How do you detect the specific model? Is there a hardware register that
> > lets you know the type?
> > If you have a device specific "compatible" string, you should list all
> > the known strings.
> >
> In fact, no need to distinguish these hardware, the only difference is 
> i2c module number.
> The same compatible is used.

Ah, so you have multiple nodes in those cases, not just one node with
a variable number of I2C hosts. I was a bit confused by the
description

> These info can be removed to remove the confusion.

Yes, I think that would be better, both because it avoids the confusion,
and because it means you can use the driver for future machines without
having to update the binding each time.

	Arnd
