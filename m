From: Qiao Zhou <zhouqiao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH 1/4] mfd: support 88pm80x in 80x driver
Date: Wed, 4 Jul 2012 08:47:54 -0700
Message-ID: <B2A7C617B3AB7F44B7B44C7D374B431E13A09E8DF1@sc-vexch3.marvell.com>
References: <1341392115-9425-1-git-send-email-zhouqiao@marvell.com>
 <201207041137.49020.arnd@arndb.de>
 <B2A7C617B3AB7F44B7B44C7D374B431E13A09E8DEE@sc-vexch3.marvell.com>
 <201207041527.13954.arnd@arndb.de>
 <20120704153307.GE4111@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120704153307.GE4111-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yu Tang <ytang5-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilbur Wang <wwang27-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> On Wed, Jul 04, 2012 at 03:27:13PM +0000, Arnd Bergmann wrote:
> > On Wednesday 04 July 2012, Qiao Zhou wrote:
>>
> > > >On the other hand, I think it probably makes sense to drop the 
> > > >irq_base member in this struct and rely on irq domains to allocate 
> > > >them dynamically as mentioned before.
>
> > > Do you mean that both regmap_add_irq_chip and mfd_add_devices api 
> > > pass -1 as the irq_base, so that system can dynamically allocate the irq_base for it?
>
> > regmap_add_irq_chip should pass -1, mfd_add_devices should pass 0.
> > Mark can probably correct me if that's wrong.
>
> That's right.
>
Mark, thanks for the confirmation.

Best Regards
Qiao
