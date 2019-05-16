From: Sagar Kadam <sagar.kadam@sifive.com>
Subject: Re: [PATCH v3 3/3] i2c-ocores: sifive: add polling mode workaround
 for FU540-C000 SoC
Date: Thu, 16 May 2019 18:24:32 +0530
Message-ID: <CAARK3H=L2AFtog6wdJGU7rKi7yk-AzDgFdjcjktZgkqdDwnOZQ@mail.gmail.com>
References: <1557983320-14461-1-git-send-email-sagar.kadam@sifive.com>
 <1557983320-14461-4-git-send-email-sagar.kadam@sifive.com> <20190516123120.GB14298@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190516123120.GB14298@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com, Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello Andrew,

On Thu, May 16, 2019 at 6:01 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > @@ -682,13 +693,24 @@ static int ocores_i2c_probe(struct platform_device *pdev)
> >
> >       irq = platform_get_irq(pdev, 0);
> >       if (irq == -ENXIO) {
> > -             i2c->flags |= OCORES_FLAG_POLL;
> > +             /*
> > +              * Set a OCORES_FLAG_BROKEN_IRQ to enable workaround for
> > +              * FU540-C000 SoC in polling mode interface of i2c-ocore driver.
> > +              * Else enable default polling mode interface for SIFIVE/OCORE
> > +              * device types.
> > +              */
> > +             match = of_match_node(ocores_i2c_match, pdev->dev.of_node);
> > +             if (match && (long)match->data ==
> > +                             (TYPE_SIFIVE_REV0 | OCORES_FLAG_BROKEN_IRQ))
>
> This looks wrong. You added:
>
> +       {
> +               .compatible = "sifive,fu540-c000-i2c",
> +               .data = (void *)TYPE_SIFIVE_REV0,
> +       },
> +       {
> +               .compatible = "sifive,i2c0",
> +               .data = (void *)TYPE_SIFIVE_REV0,
> +       },
>
> So match->data just has TYPE_SIFIVE_REV0.
I updated the device_id table into two logically separated patches as follows:-

1. Update device id table for Sifive devices
    [PATCH v3 2/3] i2c-ocore:
                  .data for sifive,fu540-540-c000 and sifive,i2c0 both
are for sifive devices hence TYPE_SIFIVE_REV0
2. Add polling mode workaround fix for fu540-c000 SoC
    [PATCH v3 3/3] i2c-ocores:
                  .data for sifive,fu540-540-c000 is of
TYPE_SIFIVE_REV0 and has a broken IRQ so the flag
OCORES_FLAG_BROKEN_IRQ is OR'd to data into device id table.

Please let me know if you feel patch 2 and patch 3 need to be squashed
together into a single patch.

>
> > +                     i2c->flags |= OCORES_FLAG_BROKEN_IRQ;
> > +             else
> > +                     i2c->flags |= OCORES_FLAG_POLL;
>
> These two don't need to be exclusive. It makes more sense to say
> SIFIVE needs to poll and it its IRQ is broken. A lot of your other
> changes then go away.
>
Other SiFive chip's with Ocore based I2C re-implementation might not
need the broken IRQ workaround.
and can use the the existing mainline polling mode interface, using
OCORES_FLAG_POLL.

Thanks & BR,
Sagar Kadam
>        Andrew
