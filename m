From: Cong Ding <dinggnu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c: busses/i2c-pxa.c: fix potential null pointer
 dereference error
Date: Tue, 5 Feb 2013 11:25:40 +0100
Message-ID: <20130205102540.GC9969@gmail.com>
References: <1360015899-13706-1-git-send-email-dinggnu@gmail.com>
 <CAH9JG2XSpFJeUvv7cw-JWadmi=X0-4EsN5FFKuDkwo=-mmzHSQ@mail.gmail.com>
 <20130205000517.GB9969@gmail.com>
 <CAN1soZwM6qNTJn3vvMdc6TR1eJHc=K+_c0WuWOBBuFYMWB_oCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAN1soZwM6qNTJn3vvMdc6TR1eJHc=K+_c0WuWOBBuFYMWB_oCA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Haojian Zhuang <haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 05, 2013 at 09:14:08AM +0800, Haojian Zhuang wrote:
> On Tue, Feb 5, 2013 at 8:05 AM, Cong Ding <dinggnu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > If it goes to eclk through line 1107, the variable res would be NULL. It will
> > cause a null pointer dereference error if we call release_mem_region.
> >
> > Signed-off-by: Cong Ding <dinggnu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-pxa.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> > index 1034d93..00df535 100644
> > --- a/drivers/i2c/busses/i2c-pxa.c
> > +++ b/drivers/i2c/busses/i2c-pxa.c
> > @@ -1211,7 +1211,8 @@ eremap:
> >  eclk:
> >         kfree(i2c);
> >  emalloc:
> > -       release_mem_region(res->start, resource_size(res));
> > +       if (res)
> > +               release_mem_region(res->start, resource_size(res));
> >         return ret;
> >  }
> >
> >
> 
> No. I don't agree on this. Your fix can't resolve all potential issues.
> 
>         i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
>         if (!i2c) {
>                 ret = -ENOMEM;
>                 goto emalloc;
>         }
> 
>         ret = i2c_pxa_probe_dt(dev, i2c, &i2c_type);
>         if (ret > 0)
>                 ret = i2c_pxa_probe_pdata(dev, i2c, &i2c_type);
>         if (ret < 0)
>                 goto eclk;
> 
>         res = platform_get_resource(dev, IORESOURCE_MEM, 0);
>         irq = platform_get_irq(dev, 0);
>         if (res == NULL || irq < 0) {
>                 ret = -ENODEV;
>                 goto eclk;
>         }
> 
>         if (!request_mem_region(res->start, resource_size(res), res->name)) {
>                 ret = -ENOMEM;
>                 goto eclk;
>         }
> 
> We shouldn't jump to eclk for these error cases. Then we needn't to add
> checking on res.
So what do you suggest to do for these error cases?
 - cong
