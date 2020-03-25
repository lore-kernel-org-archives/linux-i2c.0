From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i2c-stm32f7: allows for any bus frequency
Date: Wed, 25 Mar 2020 20:53:45 +0200
Message-ID: <CAHp75VdPCWdpGo=2n9g0ivti-g2m4jZ=cG4BKHBLk8BVDzaCyg@mail.gmail.com>
References: <1585161361-3408-1-git-send-email-alain.volmat@st.com> <1585161361-3408-3-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1585161361-3408-3-git-send-email-alain.volmat-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, pierre-yves.mordret-qxv4g6HH51o@public.gmane.org, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, fabrice.gasnier-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 25, 2020 at 8:38 PM Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org> wrote:
>
> Do not limitate to the 3 (100KHz, 400KHz, 1MHz) bus frequency but
> instead allows any frequency (if it matches timing requirements).
> Depending on the requested frequency, use the spec data from either
> Standard, Fast or Fast Plus mode.
>
> Hardcoding of min/max bus frequencies is removed and is instead computed.
>
> The driver do not use anymore speed identifier but instead handle
> directly the frequency and figure out the spec data (necessary
> for the computation of the timing register) based on the frequency.

...

> +static struct stm32f7_i2c_spec *get_specs(u32 rate)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(i2c_specs); i++)
> +               if (rate <= i2c_specs[i].rate)
> +                       return &i2c_specs[i];
> +

> +       /* NOT REACHED */
> +       return ERR_PTR(-EINVAL);

WARN_ONCE() ?

> +}

...

> -                       if ((tscl_l < i2c_specs[setup->speed].l_min) ||
> +                       if ((tscl_l < specs->l_min) ||

>                             (i2cclk >=
>                              ((tscl_l - af_delay_min - dnf_delay) / 4))) {

Perhaps squash above two to one line at the same time?

...

> +       int i;
> +
> +       for (i = ARRAY_SIZE(i2c_specs) - 1; i >= 0; i--)


Perhaps

       int i = ARRAY_SIZE(i2c_specs);

       while(i--)

?

> +               if (i2c_specs[i].rate < rate)
> +                       return i2c_specs[i].rate;

-- 
With Best Regards,
Andy Shevchenko
