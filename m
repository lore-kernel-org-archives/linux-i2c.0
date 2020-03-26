From: Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i2c-stm32f7: allows for any bus frequency
Date: Thu, 26 Mar 2020 11:12:19 +0100
Message-ID: <20200326101219.GA21190@gnbcxd0016.gnb.st.com>
References: <1585161361-3408-1-git-send-email-alain.volmat@st.com>
 <1585161361-3408-3-git-send-email-alain.volmat@st.com>
 <CAHp75VdPCWdpGo=2n9g0ivti-g2m4jZ=cG4BKHBLk8BVDzaCyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdPCWdpGo=2n9g0ivti-g2m4jZ=cG4BKHBLk8BVDzaCyg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pierre Yves MORDRET <pierre-yves.mordret-qxv4g6HH51o@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org" <linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabrice GASNIER <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

Thanks for the review.

On Wed, Mar 25, 2020 at 06:53:45PM +0000, Andy Shevchenko wrote:
> On Wed, Mar 25, 2020 at 8:38 PM Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org> wrote:
> >
> > Do not limitate to the 3 (100KHz, 400KHz, 1MHz) bus frequency but
> > instead allows any frequency (if it matches timing requirements).
> > Depending on the requested frequency, use the spec data from either
> > Standard, Fast or Fast Plus mode.
> >
> > Hardcoding of min/max bus frequencies is removed and is instead computed.
> >
> > The driver do not use anymore speed identifier but instead handle
> > directly the frequency and figure out the spec data (necessary
> > for the computation of the timing register) based on the frequency.
> 
> ...
> 
> > +static struct stm32f7_i2c_spec *get_specs(u32 rate)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(i2c_specs); i++)
> > +               if (rate <= i2c_specs[i].rate)
> > +                       return &i2c_specs[i];
> > +
> 
> > +       /* NOT REACHED */
> > +       return ERR_PTR(-EINVAL);
> 
> WARN_ONCE() ?

The comment should actually be removed. get_specs return value is
properly checked in stm32f7_i2c_compute_timing and an error message
is displayed in case of an error.

> 
> > +}
> 
> ...
> 
> > -                       if ((tscl_l < i2c_specs[setup->speed].l_min) ||
> > +                       if ((tscl_l < specs->l_min) ||
> 
> >                             (i2cclk >=
> >                              ((tscl_l - af_delay_min - dnf_delay) / 4))) {
> 
> Perhaps squash above two to one line at the same time?

I agree that this is not very pretty to read now but that would lead to
a line exceeding 80 characters. To fix that it'd be better to rework the code
but in such case that should be done at a separate time to keep this commit
as small / simpler to understand as possible. So I'd prefer leave this code
for the time being.

> 
> ...
> 
> > +       int i;
> > +
> > +       for (i = ARRAY_SIZE(i2c_specs) - 1; i >= 0; i--)
> 
> 
> Perhaps
> 
>        int i = ARRAY_SIZE(i2c_specs);
> 
>        while(i--)
> 
> ?

I propose the following code to make it a bit easier to read/understand:

static u32 get_lower_rate(u32 rate)
{
        int i = ARRAY_SIZE(i2c_specs);

        while (i--)
                if (i2c_specs[i].rate < rate)
                        break;

        return i2c_specs[i].rate;
}

If you agree with that I'll push a v2.

> 
> > +               if (i2c_specs[i].rate < rate)
> > +                       return i2c_specs[i].rate;
> 
> -- 
> With Best Regards,
> Andy Shevchenko
