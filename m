From: Sagar Kadam <sagar.kadam@sifive.com>
Subject: Re: [PATCH v4 3/3] i2c-ocores: sifive: add polling mode workaround
 for FU540-C000 SoC
Date: Mon, 20 May 2019 18:57:52 +0530
Message-ID: <CAARK3HnZgiUOE3S7BOk9uC-MfmB4wO5zWFbuGGRFqKauYaX8yg@mail.gmail.com>
References: <1558354817-12034-1-git-send-email-sagar.kadam@sifive.com>
 <1558354817-12034-4-git-send-email-sagar.kadam@sifive.com> <20190520124107.GA25785@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190520124107.GA25785@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com, Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,

On Mon, May 20, 2019 at 6:11 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > @@ -406,7 +416,7 @@ static int ocores_xfer(struct i2c_adapter *adap,
> >  {
> >       struct ocores_i2c *i2c = i2c_get_adapdata(adap);
> >
> > -     if (i2c->flags & OCORES_FLAG_POLL)
> > +     if ((i2c->flags & (OCORES_FLAG_POLL | OCORES_FLAG_BROKEN_IRQ)))
> >               return ocores_xfer_polling(adap, msgs, num);
> >       return ocores_xfer_core(i2c, msgs, num, false);
> >  }
>
> You are not listening to what i said. All you need to know here is
> that you must poll. It does not matter if the IRQ is broken or not.
>

Apologies for my miss-understanding. I will rectify this and submit a v5.

> >       irq = platform_get_irq(pdev, 0);
> >       if (irq == -ENXIO) {
> > -             i2c->flags |= OCORES_FLAG_POLL;
>
> If there is no interrupt, you need to poll. So keep this line.

Will retain this.

> > +             /*
> > +              * Set a OCORES_FLAG_BROKEN_IRQ to enable workaround for
> > +              * FU540-C000 SoC in polling mode interface of i2c-ocore driver.
> > +              * Else enable default polling mode interface for SIFIVE/OCORE
> > +              * device types.
> > +              */
> > +             match = of_match_node(ocores_i2c_match, pdev->dev.of_node);
> > +             if (match && (long)match->data == TYPE_SIFIVE_REV0)
> > +                     i2c->flags |= OCORES_FLAG_BROKEN_IRQ;
>
> If it is a OCORE, IRQ is broken, so OR in OCORES_FLAG_BROKEN_IRQ.

Got it, as device type SIFIVE is based on OCORE's re-implementation,
will OR in the broken IRQ flag and submit a v5.

> >
> > -     if (!(i2c->flags & OCORES_FLAG_POLL)) {
> > +     if (!(i2c->flags & (OCORES_FLAG_POLL | OCORES_FLAG_BROKEN_IRQ))) {
> >               ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
> >                                      pdev->name, i2c);
>
> Here you just need to know if you are polling. Broken IRQ does not
> matter.
>
>         Andrew

Thanks & Regards,
Sagar
