From: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] i2c: busses/i2c-pxa.c: fix potential null pointer
 dereference error
Date: Fri, 15 Feb 2013 00:10:54 +0800
Message-ID: <CAN1soZwMX8jDdaAhBPBojW0PA3Dyt8sq9QGr-F=worw+7WHMmg@mail.gmail.com>
References: <1360015899-13706-1-git-send-email-dinggnu@gmail.com>
	<CAH9JG2XSpFJeUvv7cw-JWadmi=X0-4EsN5FFKuDkwo=-mmzHSQ@mail.gmail.com>
	<20130205000517.GB9969@gmail.com>
	<CAN1soZwM6qNTJn3vvMdc6TR1eJHc=K+_c0WuWOBBuFYMWB_oCA@mail.gmail.com>
	<20130205102540.GC9969@gmail.com>
	<CAN1soZyDLtdjyOFWyVVXN-_ABrChcCR=QbifAo7cz9pYV-nHww@mail.gmail.com>
	<20130214112818.GA18774@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130214112818.GA18774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cong Ding <dinggnu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Haojian Zhuang <haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 14, 2013 at 7:28 PM, Cong Ding <dinggnu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> If it goes to eclk through line 1107, the variable res would be NULL. It will
> cause a null pointer dereference error if we call release_mem_region. The
> correct way should be using devm_kzalloc rather than kzalloc to allocate
> memory.
>
> Signed-off-by: Cong Ding <dinggnu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c |   22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 1034d93..dd2d640 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1094,29 +1094,23 @@ static int i2c_pxa_probe(struct platform_device *dev)
>         struct resource *res = NULL;
>         int ret, irq;
>
> -       i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
> -       if (!i2c) {
> -               ret = -ENOMEM;
> -               goto emalloc;
> -       }
> +       i2c = devm_kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
> +       if (!i2c)
> +               return -ENOMEM;
>
>         ret = i2c_pxa_probe_dt(dev, i2c, &i2c_type);
>         if (ret > 0)
>                 ret = i2c_pxa_probe_pdata(dev, i2c, &i2c_type);
>         if (ret < 0)
> -               goto eclk;
> +               return ret;
>
>         res = platform_get_resource(dev, IORESOURCE_MEM, 0);
>         irq = platform_get_irq(dev, 0);
> -       if (res == NULL || irq < 0) {
> -               ret = -ENODEV;
> -               goto eclk;
> -       }
> +       if (res == NULL || irq < 0)
> +               return -ENODEV;
>
> -       if (!request_mem_region(res->start, resource_size(res), res->name)) {
> -               ret = -ENOMEM;
> -               goto eclk;
> -       }
> +       if (!request_mem_region(res->start, resource_size(res), res->name))
> +               return -ENOMEM;
>
>         i2c->adap.owner   = THIS_MODULE;
>         i2c->adap.retries = 5;
> --
> 1.7.9.5
>

Acked-by: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
