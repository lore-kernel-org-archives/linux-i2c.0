From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] of/irq: Export of_irq_get()
Date: Sat, 1 Nov 2014 04:58:07 +0800
Message-ID: <CAL_JsqJ_kD-QPoRySPTU+7CG=s66QQAytnXMyiJ3AUz8yRE4tw@mail.gmail.com>
References: <1414677578-27412-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1414677578-27412-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20141030141644.GE23852@katana> <2139081.L8ZrMAojpq@avalon> <20141031182037.GA2680@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141031182037.GA2680@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Nov 1, 2014 at 2:20 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Thu, Oct 30, 2014 at 04:17:19PM +0200, Laurent Pinchart wrote:
>> On Thursday 30 October 2014 15:16:44 Wolfram Sang wrote:
>> > On Thu, Oct 30, 2014 at 03:59:36PM +0200, Laurent Pinchart wrote:
>> > > The function will be used by the I2C core which can be compiled as a
>> > > module.
>> > >
>> > > Signed-off-by: Laurent Pinchart
>> > > <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>> >
>> > I think it makes sense if I take this via I2C to get the dependencies
>> > for the later patches right?
>>
>> It would be easier, yes.
>
> Oh, DT maintainers are not on CC. Then I can wait pretty long for an
> ack ;) Fixing that.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>
>>
>> > > ---
>> > >
>> > >  drivers/of/irq.c | 1 +
>> > >  1 file changed, 1 insertion(+)
>> > >
>> > > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
>> > > index 1471e0a223a5..0d7765807f49 100644
>> > > --- a/drivers/of/irq.c
>> > > +++ b/drivers/of/irq.c
>> > > @@ -405,6 +405,7 @@ int of_irq_get(struct device_node *dev, int index)
>> > >
>> > >   return irq_create_of_mapping(&oirq);
>> > >
>> > >  }
>> > >
>> > > +EXPORT_SYMBOL_GPL(of_irq_get);
>> > >
>> > >  /**
>> > >
>> > >   * of_irq_get_byname - Decode a node's IRQ and return it as a Linux irq
>> > >   number
>>
>> --
>> Regards,
>>
>> Laurent Pinchart
>>
