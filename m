From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 1/3] mfd: support 88pm80x in 80x driver
Date: Mon, 2 Jul 2012 15:58:50 +0000
Message-ID: <201207021558.51246.arnd@arndb.de>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com> <20120702101228.GD25093@opensource.wolfsonmicro.com> <4FF174AA.3020001@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FF174AA.3020001-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Qiao Zhou <zhouqiao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Wilbur Wang <wwang27-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday 02 July 2012, Qiao Zhou wrote:
> On 07/02/2012 06:12 PM, Mark Brown wrote:
> > On Mon, Jul 02, 2012 at 06:09:57PM +0800, Qiao Zhou wrote:
> >> On 07/02/2012 06:03 PM, Mark Brown wrote:
> >
> >>> What do you mean by pages?  regmap has paging support which just maps
> >>> everything into a single flat register map from the point of view of
> >>> callers.
> >
> >> Mark, let me explain: the 88pm800 chip has three i2c address
> >> internally, which we called different page instead. it confuses you
> >> with the register page_read/write operation. there are registers in
> >> each i2c address domain, and we need to use different i2c client to
> >> access reg in different domain. such as some common regs are in the
> >> page of i2c_addr = 0x30, and power related regs are in the page of
> >> i2c_addr = 0x31, and gpadc related regs are in the page of 0x32.
> >
> > These aren't what people normally call pages, those are just separate
> > I2C devices from a Linux point of view.
> >
> Mark, surely I'll pay attention to the terms used. thanks!
> due to there separate I2C devices, does it make sense to export separate 
> r/w interface for them? do you have suggestion in such case?

(adding the i2c mailing list to get more insight)

I think in case of device tree based probing, it would be straightforward
to represent 88pm800 as a single device with three addresses in the "reg"
property, while the natural linux representation would be one regular
i2c_client device with two dummies. Do we or should we have any
infrastructure to deal with this?

If this is a common scenario, we could probably let regmap handle it
entirely internally and represent the i2c client with its dummies
as a single regmap.

	Arnd
