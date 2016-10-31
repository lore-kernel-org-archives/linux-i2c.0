From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 3/5] gpio-dmec: gpio support for dmec
Date: Mon, 31 Oct 2016 13:26:19 +0100
Message-ID: <CACRpkdYZUnBh6KjM-7oDvnFXoZEsEXb-5pNx-cDeoniGjfBWdg@mail.gmail.com>
References: <cover.42dd8126f6e33b5130d9afa4596d88a106c54188.1477564996.git-series.zahari.doychev@linux.com>
 <fe8ac70204de48edd8a3da8a783b10810f3d4ca1.1477564996.git-series.zahari.doychev@linux.com>
 <CACRpkdZ+v0HGUCQsTAdeK0+ymi+wQsz8M51kRxCGN7Nwjwny1w@mail.gmail.com> <20161031085044.GC9050@riot.zaxnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161031085044.GC9050-S5msFFqROX52XvNHrDenQA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zahari Doychev <zahari.doychev-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 31, 2016 at 9:50 AM, Zahari Doychev
<zahari.doychev-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org> wrote:
> On Sat, Oct 29, 2016 at 11:05:29AM +0200, Linus Walleij wrote:

>> > +static int dmec_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>> > +{
>> > +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>> > +       struct dmec_gpio_priv *priv = container_of(gc, struct dmec_gpio_priv,
>> > +                                                  gpio_chip);
>> > +       struct regmap *regmap = priv->regmap;
>> > +       unsigned int offset, mask, val;
>> > +
>> > +       offset = DMEC_GPIO_IRQTYPE_OFFSET(priv) + (d->hwirq >> 2);
>> > +       mask = ((d->hwirq & 3) << 1);
>> > +
>> > +       regmap_read(regmap, offset, &val);
>> > +
>> > +       val &= ~(3 << mask);
>> > +       switch (type & IRQ_TYPE_SENSE_MASK) {
>> > +       case IRQ_TYPE_LEVEL_LOW:
>> > +               break;
>> > +       case IRQ_TYPE_EDGE_RISING:
>> > +               val |= (1 << mask);
>> > +               break;
>> > +       case IRQ_TYPE_EDGE_FALLING:
>> > +               val |= (2 << mask);
>> > +               break;
>> > +       case IRQ_TYPE_EDGE_BOTH:
>> > +               val |= (3 << mask);
>> > +               break;
>> > +       default:
>> > +               return -EINVAL;
>> > +       }
>> > +
>> > +       regmap_write(regmap, offset, val);
>> > +
>> > +       return 0;
>> > +}
>>
>> This chip uses handle_simple_irq() which is fine if the chip really has no
>> edge detector ACK register.
>>
>> What some chips have is a special register to clearing (ACK:ing) the edge
>> IRQ which makes it possible for a new IRQ to be handled as soon as
>> that has happened, and those need to use handle_edge_irq() for edge IRQs
>> and handle_level_irq() for level IRQs, with the side effect that the edge
>> IRQ path will additionally call the .irq_ack() callback on the irqchip
>> when handle_edge_irq() is used. In this case we set handle_bad_irq()
>> as default handler and set up the right handler i .set_type().
>>
>> Look at drivers/gpio/gpio-pl061.c for an example.
>>
>> If you DON'T have a special edge ACK register, keep it like this.
>
> What is the difference between this special edge ACK register and the normal
> interrupt ACK register?

With level interrupts there is seldom use of any ACK register.
They will by definition just hold the line low until the clients stop
asserting their IRQs.

With edge triggered interrupts, you can have a transient event so
that you need an ACK register to tell the hardware that you have
seen and acknowledged this IRQ, so it can go ahead and fire a
second IRQ on the same line while you are still processing the
first one.

> I think I do not have such dedicated register
> but I will have to check this again.

Read the documentation for the register(s) and see what the
use case is.

>> > +static int dmec_gpio_probe(struct platform_device *pdev)
>> > +{
>> > +       struct device *dev = &pdev->dev;
>> > +       struct dmec_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> > +       struct dmec_gpio_priv *priv;
>> > +       struct gpio_chip *gpio_chip;
>> > +       struct irq_chip *irq_chip;
>> > +       int ret = 0;
>> > +
>> > +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> > +       if (!priv)
>> > +               return -ENOMEM;
>> > +
>> > +       priv->regmap = dmec_get_regmap(pdev->dev.parent);
>>
>> Do you really need a special accessor function to get the regmap like this?
>> If you just use syscon you get these kind of helpers for free. I don't know
>> if you can use syscon though, just a suggestion.
>
> The I/O memory is mapped in the mfd driver. The addresing mode is also set
> there which should be the same for all child devices. So in this way I have
> dependcy between the mfd and the rest of the drivers. I am not sure that I
> can use syscon as the driver is getting its resources from acpi.

OK.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
