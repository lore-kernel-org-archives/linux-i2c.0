From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v6 2/5] irqchip/aspeed-i2c-ic: Add I2C IRQ controller for Aspeed
Date: Wed, 29 Mar 2017 21:28:44 +1030
Message-ID: <CACPK8XdYNi2mna=aBbYvMroujLOPbVkPdU-DeYGrevjRBjHodQ@mail.gmail.com>
References: <20170328051226.21677-1-brendanhiggins@google.com> <20170328051226.21677-3-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170328051226.21677-3-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, vz@mleia.com, mouse@mayc.ru, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 28, 2017 at 3:42 PM, Brendan Higgins
<brendanhiggins@google.com> wrote:
> +static int __init aspeed_i2c_ic_of_init(struct device_node *node,
> +                                       struct device_node *parent)
> +{
> +       struct aspeed_i2c_ic *i2c_ic;
> +
> +       i2c_ic = kzalloc(sizeof(*i2c_ic), GFP_KERNEL);
> +       if (!i2c_ic)
> +               return -ENOMEM;
> +
> +       i2c_ic->base = of_iomap(node, 0);
> +       if (IS_ERR(i2c_ic->base))
> +               return PTR_ERR(i2c_ic->base);
> +
> +       i2c_ic->parent_irq = irq_of_parse_and_map(node, 0);
> +       if (i2c_ic->parent_irq < 0)
> +               return i2c_ic->parent_irq;
> +
> +       i2c_ic->irq_domain = irq_domain_add_linear(
> +                       node, ASPEED_I2C_IC_NUM_BUS,
> +                       &aspeed_i2c_ic_irq_domain_ops, NULL);
> +       if (!i2c_ic->irq_domain)
> +               return -ENOMEM;
> +
> +       i2c_ic->irq_domain->name = "ast-i2c-domain";

Nit: Make this aspeed-i2c-domain to make this consistent with the
other Aspeed drivers in the kernel tree.

Could this irq code be embedded in the i2c driver? We took a similar
approach for the Aspeed GPIO driver, which has a similar IRQ structure
of one hardware IRQ that tells the driver to check status registers
for the precise irq source. The upside being all of the i2c code is in
the same place in the kernel tree.

Cheers,

Joel
