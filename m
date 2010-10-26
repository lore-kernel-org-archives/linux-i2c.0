From: "Tomoya MORINAGA" <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: Re: [PATCH v3] Topcliff: Update PCH_I2C driver to 2.6.36
Date: Wed, 27 Oct 2010 08:57:22 +0900
Message-ID: <008e01cb7569$8a01a2d0$66f8800a@maildom.okisemi.com>
References: <4CC645A1.5010509@dsn.okisemi.com><20101026102048.316d0c04@endymion.delvare><001a01cb74ec$e3eb3ea0$66f8800a@maildom.okisemi.com><20101026111322.738b0b14@endymion.delvare><001c01cb74f2$d3dd8990$66f8800a@maildom.okisemi.com> <20101026132649.623461f9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wang Qi <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wang Yong Y <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks  <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Tomoya MORINAGA <morinaga526-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday, October 26, 2010 8:26 PM, Jean Delvare wrote:
> It's not mandatory, but the time Ben and myself have to review new
> drivers is scarce, so it's in your own interest to have the code
> reviewed by people with more time and more interest in the specific
> hardware. I can only imagine that Intel wants Topcliff to be supported
> as soon as possible by the Linux kernel, so they should certainly have
> resources to allocate for the review and testing.

I see.

I will reuest Intel to review again and put signature.

> Hi Qi and Yong Y
Could you review this patch again and put signature?

Thanks, Tomoya(OKI SEMICONDUCTOR CO., LTD.)

----- Original Message ----- 
From: "Jean Delvare" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
To: "Tomoya MORINAGA" <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: "Samuel Ortiz" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; "Wolfram Sang" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>; "Ralf Baechle"
<ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>; <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; "LKML" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; "Ben Dooks "
<ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>; "Linus Walleij" <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>; "srinidhi kasagar"
<srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>; "Tomoya MORINAGA" <morinaga526-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>; "Wang Qi" <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; "Wang
Yong Y" <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; <kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; <joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; <andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, October 26, 2010 8:26 PM
Subject: Re: [PATCH v3] Topcliff: Update PCH_I2C driver to 2.6.36


> On Tue, 26 Oct 2010 18:47:37 +0900, Tomoya MORINAGA wrote:
> > Hi Jean,
> >
> > On Tuesday, October 26, 2010 6:13 PM, Jean Delvare wrote:
> > > The _pch becomes redundant then, i2c-topcliff.c would be enough, but
> > > both are fine with me, as my initial concern is gone.
> > I agree.
> > I will modify to "i2c-topcliff.c".
> >
> > > There's no Reviewed-by, Acked-by or Signed-off-by from anyone at Intel
> > > in the patch you posted.
> > Must we get Intel's signature ?
> > We have already got the following. Isn't  this enough ?
> > > Reviewed-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> >
> > Though I haven't heard like the requirement,
> > if Intel's signature is mandatory, I will request to Intel.
>
> It's not mandatory, but the time Ben and myself have to review new
> drivers is scarce, so it's in your own interest to have the code
> reviewed by people with more time and more interest in the specific
> hardware. I can only imagine that Intel wants Topcliff to be supported
> as soon as possible by the Linux kernel, so they should certainly have
> resources to allocate for the review and testing.
>
> -- 
> Jean Delvare
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
