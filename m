From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO
 expander
Date: Tue, 26 Jun 2018 21:56:48 +0200
Message-ID: <20180626215648.1472b96e@bbrezillon>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
        <20180622104930.32050-10-boris.brezillon@bootlin.com>
        <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland>
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

On Tue, 26 Jun 2018 22:07:03 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jun 22, 2018 at 1:49 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > Add a driver for Cadence I3C GPIO expander.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>  
> 
> > +       scratchbuf = kmalloc(sizeof(*scratchbuf) * 2, GFP_KERNEL);  
> 
> kmalloc_array() ?
> 
> > +       ret = i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
> > +                                      ARRAY_SIZE(xfers));  
> 
> One line?
> 
> 
> > +static void cdns_i3c_gpio_set_multiple(struct gpio_chip *g,
> > +                                      unsigned long *mask,
> > +                                      unsigned long *bits)
> > +{
> > +       struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
> > +       u8 newovr;
> > +       int ret;
> > +
> > +       newovr = (gpioc->ovr & ~(*mask)) | (*bits & *mask);
> > +       if (newovr == gpioc->ovr)
> > +               return;
> > +
> > +       ret = cdns_i3c_gpio_write_reg(gpioc, OVR, newovr);
> > +       if (!ret)
> > +               gpioc->ovr = newovr;  
> 
> You don't change mask here, why do you need a pointer to it?

What are you talking about??!!! This is part of the gpio_chip interface
that drivers have to implement. You can't decide that mask should not be
a pointer. And if you actually look at the code, you'll probably see
that the reason we're passed a pointer here is that the GPIO chip might
expose more GPIOs than can be represented by an unsigned long, hence
the array of unsigned long.

I'll say it here because this is not the first time I'm pissed off by
one of your review. You seem to review everything that is posted on the
LKML, and most of the time your reviews are superficial (focused on tiny
details or coding style issues). Don't you have better things to do?

I mean, I'm fine when I get such comments from people that also do
useful comments, but yours are most of the time useless and sometime
even wrong because you didn't time to look at the code in details.

> 
> > +}  
> 
> > +static int cdns_i3c_gpio_get_multiple(struct gpio_chip *g,
> > +                                     unsigned long *mask,
> > +                                     unsigned long *bits)
> > +{
> > +       struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
> > +       int ret;
> > +       u8 ivr;
> > +
> > +       ret = cdns_i3c_gpio_read_reg(gpioc, IVR, &ivr);
> > +       if (ret)
> > +               return ret;
> > +
> > +       *bits = ivr & *mask & gpioc->dir;
> > +       *bits |= gpioc->ovr & *mask & ~gpioc->dir;  
> 
> Ditto.
> 
> > +
> > +       return 0;
> > +}  
> 
> > +static void cdns_i3c_gpio_ibi_handler(struct i3c_device *i3cdev,
> > +                                     const struct i3c_ibi_payload *payload)
> > +{
> > +       struct cdns_i3c_gpio *gpioc = i3cdev_get_drvdata(i3cdev);  
> 
> > +       u8 isr = 0;  
> 
> Perhaps you need to check the result of _read_reg() below instead of
> dummy assignment?
> 
> > +       int i;
> > +
> > +       cdns_i3c_gpio_read_reg(gpioc, ISR, &isr);  
> 
> > +       for (i = 0; i < 8; i++) {
> > +               unsigned int irq;
> > +
> > +               if (!(BIT(i) & isr & gpioc->imr))
> > +                       continue;  
> 
> for_each_set_bit() ?
> 
> > +
> > +               irq = irq_find_mapping(gpioc->gpioc.irq.domain, i);
> > +               handle_nested_irq(irq);
> > +       }
> > +}  
> 
> > +static const struct i3c_device_id cdns_i3c_gpio_ids[] = {
> > +       I3C_DEVICE(0x1c9, 0x0, NULL),  
> 
> > +       { /* sentinel */ },  
> 
> Slightly better without comma.
> 
> > +};
> > +MODULE_DEVICE_TABLE(i3c, cdns_i3c_gpio_ids);  
> 
