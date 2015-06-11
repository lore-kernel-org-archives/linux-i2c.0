From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch v1] i2c: imx: add runtime pm support to improve the performance
Date: Thu, 11 Jun 2015 15:40:55 +0530
Message-ID: <CAM=Q2cuyhhH+_HY8Fdwt35W2y_oNb+t2P12eMeZKGJsxLxq=Hw@mail.gmail.com>
References: <1433987404-28957-1-git-send-email-b54642@freescale.com>
	<CAM=Q2cuEChJySEex99e_xqfgXORZxDHqpGve7hbh-+nQVYPxAg@mail.gmail.com>
	<BLUPR03MB373DE1F76EE2A0B96A66FC9F5BC0@BLUPR03MB373.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BLUPR03MB373DE1F76EE2A0B96A66FC9F5BC0-GeMU99GfrrsHjcGqcGfFzOO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

<snip>
>> >  static irqreturn_t i2c_imx_isr(int irq, void *dev_id) @@ -583,6
>> > +582,9 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
>> >         struct imx_i2c_struct *i2c_imx = dev_id;
>> >         unsigned int temp;
>> >
>> > +       if (pm_runtime_suspended(i2c_imx->adapter.dev.parent))
>> > +               return IRQ_NONE;
>> > +
>>
>> Didn't quite get this one.
>
> Yes, there don't need to add pm_runtime_suspended() check in isr handler. But in some worse worse case,  like system is very
> busy and irq is blocked by others

you mean other irqs?

> that irq response coming is very late while i2c clock is gated off, the check can avoid system hang.
>
> So I think it can be reasonable. How do you think ?
>
> Regards,
> Andy
