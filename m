From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: busses: i2c-pxa.c: Fix for possible null pointer
 dereferenc
Date: Thu, 03 Jul 2014 10:45:47 +0900
Message-ID: <003601cf9660$83368990$89a39cb0$%han@samsung.com>
References: <1404084516-901-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <1404084516-901-2-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <009301cf93f6$f938a270$eba9e750$%han@samsung.com>
 <CAFo99gY2qEEqwJgu-NQryAe2=o5AsDjL+SFaau6BA7CBMH8Xkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CAFo99gY2qEEqwJgu-NQryAe2=o5AsDjL+SFaau6BA7CBMH8Xkg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Rickard Strandqvist' <rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>
Cc: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, 'Grant Likely' <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Rob Herring' <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Leilei Shang' <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, 'Peter Korsgaard' <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday, July 02, 2014 3:26 AM, Rickard Strandqvist wrote:
> 2014-06-30 2:05 GMT+02:00 Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
> > On Monday, June 30, 2014 8:29 AM, Rickard Strandqvist wrote:
> >>
> >> Fix for possible null pointer dereferenc, and there is a risk for memory leak in when something
> >> unexpected happens and the function returns.
> >
> > Would you split the patch into two patches?
> >
> >   [PATCH 1/2] i2c: pxa: Fix for possible null pointer dereference
> >   [PATCH 2/2] i2c: pxa: Use devm_* functions
> >
> >>
> >> Signed-off-by: Rickard Strandqvist <rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>
> >> ---
> >>  drivers/i2c/busses/i2c-pxa.c |   37 ++++++++++++++++---------------------
> >>  1 file changed, 16 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> >> index be671f7..886877a 100644
> >> --- a/drivers/i2c/busses/i2c-pxa.c
> >> +++ b/drivers/i2c/busses/i2c-pxa.c
> >> @@ -1141,10 +1141,10 @@ static int i2c_pxa_probe(struct platform_device *dev)
> >>       struct resource *res = NULL;
> >>       int ret, irq;
> >>
> >> -     i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
> >> +     i2c = devm_kzalloc(&dev->dev, sizeof(struct pxa_i2c), GFP_KERNEL);
> >>       if (!i2c) {
> >>               ret = -ENOMEM;
> >> -             goto emalloc;
> >> +             goto err_nothing_to_release;
> >>       }
> >>
> >>       /* Default adapter num to device id; i2c_pxa_probe_dt can override. */
> >> @@ -1154,18 +1154,19 @@ static int i2c_pxa_probe(struct platform_device *dev)
> >>       if (ret > 0)
> >>               ret = i2c_pxa_probe_pdata(dev, i2c, &i2c_type);
> >>       if (ret < 0)
> >> -             goto eclk;
> >> +             goto err_nothing_to_release;
> >>
> >>       res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> >>       irq = platform_get_irq(dev, 0);
> >>       if (res == NULL || irq < 0) {
> >>               ret = -ENODEV;
> >> -             goto eclk;
> >> +             goto err_nothing_to_release;
> >>       }
> >>
> >> -     if (!request_mem_region(res->start, resource_size(res), res->name)) {
> >> +     if (!devm_request_mem_region(&dev->dev, res->start,
> >> +                             resource_size(res), res->name)) {
> >>               ret = -ENOMEM;
> >> -             goto eclk;
> >> +             goto emalloc;
> >>       }
> >>
> >>       i2c->adap.owner   = THIS_MODULE;
> >> @@ -1176,16 +1177,16 @@ static int i2c_pxa_probe(struct platform_device *dev)
> >>
> >>       strlcpy(i2c->adap.name, "pxa_i2c-i2c", sizeof(i2c->adap.name));
> >>
> >> -     i2c->clk = clk_get(&dev->dev, NULL);
> >> +     i2c->clk = devm_clk_get(&dev->dev, NULL);
> >>       if (IS_ERR(i2c->clk)) {
> >>               ret = PTR_ERR(i2c->clk);
> >> -             goto eclk;
> >> +             goto emalloc;
> >>       }
> >>
> >> -     i2c->reg_base = ioremap(res->start, resource_size(res));
> >> -     if (!i2c->reg_base) {
> >> +     i2c->reg_base = devm_ioremap(&dev->dev, res->start, resource_size(res));
> >> +     if (IS_ERR(i2c->reg_base)) {
> >
> > Did you check what devm_ioremap() returns?
> > It returns 'valid addr value' Or NULL as below.
> > So, IS_ERR() should NOT be used.
> >
> > ./lib/devres.c
> >
> > void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
> >                            unsigned long size)
> > {
> >         void __iomem **ptr, *addr;
> >
> >         ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
> >         if (!ptr)
> >                 return NULL;
> >
> >         addr = ioremap(offset, size);
> >         if (addr) {
> >                 *ptr = addr;
> >                 devres_add(dev, ptr);
> >         } else
> >                 devres_free(ptr);
> >
> >         return addr;
> > }
> > EXPORT_SYMBOL(devm_ioremap);
> >
> > Best regards,
> > Jingoo Han
> >
> >>               ret = -EIO;
> >> -             goto eremap;
> >> +             goto emalloc;
> >>       }
> >>
> >>       i2c->reg_ibmr = i2c->reg_base + pxa_reg_layout[i2c_type].ibmr;
> >> @@ -1227,10 +1228,10 @@ static int i2c_pxa_probe(struct platform_device *dev)
> >>               i2c->adap.algo = &i2c_pxa_pio_algorithm;
> >>       } else {
> >>               i2c->adap.algo = &i2c_pxa_algorithm;
> >> -             ret = request_irq(irq, i2c_pxa_handler, IRQF_SHARED,
> >> -                               dev_name(&dev->dev), i2c);
> >> +             ret = devm_request_irq(&dev->dev, irq, i2c_pxa_handler,
> >> +                              IRQF_SHARED, dev_name(&dev->dev), i2c);
> >>               if (ret)
> >> -                     goto ereqirq;
> >> +                     goto emalloc;
> >>       }
> >>
> >>       i2c_pxa_reset(i2c);
> >> @@ -1261,15 +1262,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
> >>  eadapt:
> >>       if (!i2c->use_pio)
> >>               free_irq(irq, i2c);
> >> -ereqirq:
> >> -     clk_disable_unprepare(i2c->clk);
> >> -     iounmap(i2c->reg_base);
> >> -eremap:
> >> -     clk_put(i2c->clk);
> >> -eclk:
> >> -     kfree(i2c);
> >>  emalloc:
> >>       release_mem_region(res->start, resource_size(res));
> >> +err_nothing_to_release:
> >>       return ret;
> >>  }
> >>
> >> --
> >> 1.7.10.4
> >
> 
> 
> Hi
> 
> Excuse my late reply.
> 
> 
> 1)  A fix of the original error I made in my original patch.
> But it was completely different from this solution, you have trouble
> seeing it as something reasonable to do.
> 
> My original patch:
> 
>  eclk:
>         kfree(i2c);
>  emalloc:
> -       release_mem_region(res->start, resource_size(res));
> +       if(res)
> +               release_mem_region(res->start, resource_size(res));
>         return ret;
>  }

I see what you wanted. It looks good.
But, I still think that the patch can be split into two patches. :-)
Then, it can be more readable.

   [PATCH 1/2] i2c: pxa: Fix for possible null pointer dereference
   [PATCH 2/2] i2c: pxa: Use devm_* functions

> 
> 2) Wolfram Sang helped me with a patch example from commit 9b2b98a3b4de
> It hade this code below. I thought that it seem a little strange, but
> I trust Wolfram.

I also trust Wolfram. He is one of the most important and active
person for Linux kernel. However, the mainline kernel code explicitly
reveals that ioremap() cannot return error values. ioremap() can return
valid value or NULL. So, IS_ERR() should NOT be used.

Wolfram may mean devm_ioremap_resource(), not devm_ioremap().
On the contrary, devm_ioremap_resource() can return error values,
NULL and valid value. So, in the case of devm_ioremap_resource(),
IS_ERR() can be used, in order to check the return values of
devm_ioremap_resource().


> 
> -       dev->virtbase = ioremap(adev->res.start, resource_size(&adev->res));
> -       if (!dev->virtbase) {
> +       dev->virtbase = devm_ioremap(&adev->dev, adev->res.start,
> +                               resource_size(&adev->res));
> +       if (IS_ERR(dev->virtbase)) {

So, please refer to the both cases as below.

1. devm_ioremap_resource(): IS_ERR() can be used.

	dev->virtbase = devm_ioremap_resource(&adev->dev, res));
	if (IS_ERR(dev->virtbase)) {

2. devm_ioremap(): Only NULL checking is required, not IS_ERR().

	dev->virtbase = devm_ioremap(&adev->dev, adev->res.start,
				resource_size(&adev->res));
	if (!dev->virtbase)

Then, if you have time, please refer to the following commit,
which was already merged a few months ago. According to the patch,
"devm_ioremap() returns NULL on error, not an error."; thus,
IS_ERR() should NOT be used.

commit 37e5eb0bae7bb4d98c2153c3c3400b5c00c3cad1
(i2c: nomadik: Don't use IS_ERR for devm_ioremap)

In addition, this patch was already accepted by Wolfram Sang.
Thank you.

Best regards,
Jingoo Han

>                 ret = -ENOMEM;
> -               goto err_no_ioremap;
> +               goto err_no_mem;
>         }
> 
> 
> Kind regards
> Rickard Strandqvist
