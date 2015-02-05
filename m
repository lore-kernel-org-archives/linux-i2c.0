From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: i2c-ocores: add common clock support
Date: Thu, 5 Feb 2015 22:24:42 +0300
Message-ID: <CAMo8BfJyKfKuUC5xmB7Ji1SmCELZZCm_EP2V6rD7TfpjVy4ftg@mail.gmail.com>
References: <1422890893-30989-1-git-send-email-jcmvbkbc@gmail.com>
	<1422890893-30989-3-git-send-email-jcmvbkbc@gmail.com>
	<20150205191510.GB15307@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150205191510.GB15307@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 5, 2015 at 10:15 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
> > -     if (of_property_read_u32(np, "opencores,ip-clock-frequency", &val)) {
> > +#ifdef CONFIG_HAVE_CLK
> > +     i2c->clk = devm_clk_get(&pdev->dev, NULL);
> > +
> > +     if (!IS_ERR(i2c->clk)) {
> > +             int ret = clk_prepare_enable(i2c->clk);
> > +
> > +             if (ret) {
> > +                     dev_err(&pdev->dev,
> > +                             "clk_prepare_enable failed: %d\n", ret);
> > +                     return ret;
> > +             }
> > +             i2c->ip_clock_khz = clk_get_rate(i2c->clk) / 1000;
> > +             if (clock_frequency_present)
> > +                     i2c->bus_clock_khz = clock_frequency / 1000;
> > +     } else
> > +#endif
> > +             if (of_property_read_u32(np, "opencores,ip-clock-frequency",
> > +                                      &val)) {
>
> This is not very readable (wrong indentation) and fragile. I'd suggest
> to leave out #ifdeffery, the compiler will remove the code for !HAVE_CLK
> because of the empty dummy functions[1]. Then, you can write properly
> formatted code again.
>
> [1] Well, it should if there wasn't a bug in that: https://lkml.org/lkml/2015/2/5/544

Ok, will fix.

> > +#ifdef CONFIG_HAVE_CLK
> > +     if (!IS_ERR(i2c->clk)) {
> > +             int ret = clk_prepare_enable(i2c->clk);
> > +
> > +             if (ret) {
> > +                     dev_err(&pdev->dev,
> > +                             "clk_prepare_enable failed: %d\n", ret);
> > +                     return ret;
> > +             }
> > +             i2c->ip_clock_khz = clk_get_rate(i2c->clk) / 1000;
> > +     }
> > +#endif
>
> Ahem, there is a build error in here :(

Ooops, looks like I don't have CONFIG_PM_SLEEP in my test config.
Will fix. Sorry about that.

-- 
Thanks.
-- Max
