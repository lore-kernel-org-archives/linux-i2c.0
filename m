From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i2c-stm32f7: allows for any bus frequency
Date: Thu, 26 Mar 2020 13:38:38 +0200
Message-ID: <CAHp75Vc896RpnrX6+yb0LfXVroLJO5XX6Gt5V4BJZjdFYOXYnQ@mail.gmail.com>
References: <1585161361-3408-1-git-send-email-alain.volmat@st.com>
 <1585161361-3408-3-git-send-email-alain.volmat@st.com> <CAHp75VdPCWdpGo=2n9g0ivti-g2m4jZ=cG4BKHBLk8BVDzaCyg@mail.gmail.com>
 <20200326101219.GA21190@gnbcxd0016.gnb.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200326101219.GA21190-KtquC145j2edsQPTSGfZHNvLeJWuRmrY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pierre Yves MORDRET <pierre-yves.mordret-qxv4g6HH51o@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org" <linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabrice GASNIER <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 26, 2020 at 12:12 PM Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org> wrote:
> On Wed, Mar 25, 2020 at 06:53:45PM +0000, Andy Shevchenko wrote:
> > On Wed, Mar 25, 2020 at 8:38 PM Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org> wrote:

...

> > > +       int i;
> > > +
> > > +       for (i = ARRAY_SIZE(i2c_specs) - 1; i >= 0; i--)
> >
> >
> > Perhaps
> >
> >        int i = ARRAY_SIZE(i2c_specs);
> >
> >        while(i--)
> >
> > ?
>
> I propose the following code to make it a bit easier to read/understand:
>
> static u32 get_lower_rate(u32 rate)
> {
>         int i = ARRAY_SIZE(i2c_specs);
>
>         while (i--)
>                 if (i2c_specs[i].rate < rate)
>                         break;
>
>         return i2c_specs[i].rate;
> }
>
> If you agree with that I'll push a v2.

No objections.

-- 
With Best Regards,
Andy Shevchenko
