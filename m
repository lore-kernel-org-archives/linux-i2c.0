From: Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH v10 2/5] irqchip/aspeed-i2c-ic: Add I2C IRQ controller
 for Aspeed
Date: Mon, 05 Jun 2017 14:26:08 +0930
Message-ID: <1496638568.8159.18.camel@aj.id.au>
References: <20170603012952.2192-1-brendanhiggins@google.com>
         <20170603012952.2192-3-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Jv9JtQxkmfrLAOc1hzqz"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54863 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751244AbdFEE4X (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 5 Jun 2017 00:56:23 -0400
In-Reply-To: <20170603012952.2192-3-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org, benh@kernel.crashing.org, ryan_chen@aspeedtech.com
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--=-Jv9JtQxkmfrLAOc1hzqz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2017-06-02 at 18:29 -0700, Brendan Higgins wrote:
> The Aspeed 24XX/25XX chips share a single hardware interrupt across 14
> separate I2C busses. This adds a dummy irqchip which maps the single
> hardware interrupt to software interrupts for each of the busses.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

I exercised the patch on an AST2500-based machine with good results.

Tested-by: Andrew Jeffery <andrew@aj.id.au>

> ---
> Added in v6:
> =C2=A0 - Pulled "aspeed_i2c_controller" out into a interrupt controller s=
ince that is
> =C2=A0=C2=A0=C2=A0=C2=A0what it actually does.
> Changes for v7:
> =C2=A0 - Renamed irq domain for consistency
> Changes for v8:
> =C2=A0 - None
> Changes for v9:
> =C2=A0 - None
> Changes for v10:
> =C2=A0 - Unallocate resources on init failure
> =C2=A0 - Changed formatting of a function call
> ---
> =C2=A0drivers/irqchip/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A02 +-
> =C2=A0drivers/irqchip/irq-aspeed-i2c-ic.c | 115 +++++++++++++++++++++++++=
+++++++++++
> =C2=A02 files changed, 116 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 drivers/irqchip/irq-aspeed-i2c-ic.c
>=20
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index b64c59b838a0..e067f9839b33 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> > @@ -73,6 +73,6 @@ obj-$(CONFIG_MVEBU_ODMI)		+=3D irq-mvebu-odmi.o
> > =C2=A0obj-$(CONFIG_MVEBU_PIC)			+=3D irq-mvebu-pic.o
> > =C2=A0obj-$(CONFIG_LS_SCFG_MSI)		+=3D irq-ls-scfg-msi.o
> > =C2=A0obj-$(CONFIG_EZNPS_GIC)			+=3D irq-eznps.o
> > -obj-$(CONFIG_ARCH_ASPEED)		+=3D irq-aspeed-vic.o
> > +obj-$(CONFIG_ARCH_ASPEED)		+=3D irq-aspeed-vic.o irq-aspeed-i2c-ic.o
> > =C2=A0obj-$(CONFIG_STM32_EXTI)=C2=A0		+=3D irq-stm32-exti.o
> > =C2=A0obj-$(CONFIG_QCOM_IRQ_COMBINER)		+=3D qcom-irq-combiner.o
> diff --git a/drivers/irqchip/irq-aspeed-i2c-ic.c b/drivers/irqchip/irq-as=
peed-i2c-ic.c
> new file mode 100644
> index 000000000000..815b88dd18f2
> --- /dev/null
> +++ b/drivers/irqchip/irq-aspeed-i2c-ic.c
> @@ -0,0 +1,115 @@
> +/*
> + *=C2=A0=C2=A0Aspeed 24XX/25XX I2C Interrupt Controller.
> + *
> + *=C2=A0=C2=A0Copyright (C) 2012-2017 ASPEED Technology Inc.
> + *=C2=A0=C2=A0Copyright 2017 IBM Corporation
> + *=C2=A0=C2=A0Copyright 2017 Google, Inc.
> + *
> + *=C2=A0=C2=A0This program is free software; you can redistribute it and=
/or modify
> + *=C2=A0=C2=A0it under the terms of the GNU General Public License versi=
on 2 as
> + *=C2=A0=C2=A0published by the Free Software Foundation.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/io.h>
> +
> +
> +#define ASPEED_I2C_IC_NUM_BUS 14
> +
> +struct aspeed_i2c_ic {
> > > +	void __iomem		*base;
> > > +	int			parent_irq;
> > > +	struct irq_domain	*irq_domain;
> +};
> +
> +/*
> + * The aspeed chip provides a single hardware interrupt for all of the I=
2C
> + * busses, so we use a dummy interrupt chip to translate this single int=
errupt
> + * into multiple interrupts, each associated with a single I2C bus.
> + */
> +static void aspeed_i2c_ic_irq_handler(struct irq_desc *desc)
> +{
> > +	struct aspeed_i2c_ic *i2c_ic =3D irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +	unsigned long bit, status;
> > +	unsigned int bus_irq;
> +
> > +	chained_irq_enter(chip, desc);
> > +	status =3D readl(i2c_ic->base);
> > +	for_each_set_bit(bit, &status, ASPEED_I2C_IC_NUM_BUS) {
> > +		bus_irq =3D irq_find_mapping(i2c_ic->irq_domain, bit);
> > +		generic_handle_irq(bus_irq);
> > +	}
> > +	chained_irq_exit(chip, desc);
> +}
> +
> +/*
> + * Set simple handler and mark IRQ as valid. Nothing interesting to do h=
ere
> + * since we are using a dummy interrupt chip.
> + */
> +static int aspeed_i2c_ic_map_irq_domain(struct irq_domain *domain,
> > +					unsigned int irq, irq_hw_number_t hwirq)
> +{
> > +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> > +	irq_set_chip_data(irq, domain->host_data);
> +
> > +	return 0;
> +}
> +
> +static const struct irq_domain_ops aspeed_i2c_ic_irq_domain_ops =3D {
> > +	.map =3D aspeed_i2c_ic_map_irq_domain,
> +};
> +
> +static int __init aspeed_i2c_ic_of_init(struct device_node *node,
> > +					struct device_node *parent)
> +{
> > +	struct aspeed_i2c_ic *i2c_ic;
> > +	int ret =3D 0;
> +
> > +	i2c_ic =3D kzalloc(sizeof(*i2c_ic), GFP_KERNEL);
> > +	if (!i2c_ic)
> > +		return -ENOMEM;
> +
> > +	i2c_ic->base =3D of_iomap(node, 0);
> > +	if (IS_ERR(i2c_ic->base)) {
> > +		ret =3D PTR_ERR(i2c_ic->base);
> > +		goto err_free_ic;
> > +	}
> +
> > +	i2c_ic->parent_irq =3D irq_of_parse_and_map(node, 0);
> > +	if (i2c_ic->parent_irq < 0) {
> > +		ret =3D i2c_ic->parent_irq;
> > +		goto err_iounmap;
> > +	}
> +
> > +	i2c_ic->irq_domain =3D irq_domain_add_linear(node, ASPEED_I2C_IC_NUM_=
BUS,
> > +						=C2=A0=C2=A0=C2=A0&aspeed_i2c_ic_irq_domain_ops,
> > +						=C2=A0=C2=A0=C2=A0NULL);
> > +	if (!i2c_ic->irq_domain) {
> > +		ret =3D -ENOMEM;
> > +		goto err_iounmap;
> > +	}
> +
> > +	i2c_ic->irq_domain->name =3D "aspeed-i2c-domain";
> +
> > +	irq_set_chained_handler_and_data(i2c_ic->parent_irq,
> > +					=C2=A0aspeed_i2c_ic_irq_handler, i2c_ic);
> +
> > +	pr_info("i2c controller registered, irq %d\n", i2c_ic->parent_irq);
> +
> > +	return 0;
> +
> +err_iounmap:
> > +	iounmap(i2c_ic->base);
> +err_free_ic:
> > +	kfree(i2c_ic);
> > +	return ret;
> +}
> +
> +IRQCHIP_DECLARE(ast2400_i2c_ic, "aspeed,ast2400-i2c-ic", aspeed_i2c_ic_o=
f_init);
> +IRQCHIP_DECLARE(ast2500_i2c_ic, "aspeed,ast2500-i2c-ic", aspeed_i2c_ic_o=
f_init);
--=-Jv9JtQxkmfrLAOc1hzqz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZNORoAAoJEJ0dnzgO5LT5sjUP/1bJYEtvNKL1y7MI1QvLy9Ye
ZTzWXPpJHOClmvec+IjICedOxA0JNiBrhxxm7cBXy4QNHQ8mV4h4llqDmpwUN3sO
+VXgGtp/dg2WNTiVVDBGwdrqjKTSkshbnmAMTUoBZI+DzwHIijxEeLtohCYF5K3g
3oKdHwkpv817/qsVA8uoDjji2OnsY8Mmudzab9eGVX9unP+4AtFq9SboYFBrJb9i
bbwQZv49F5VyspNdOYKPPOI0qzbM2xI/tkmn6NsWPkPYvjSzF4tSqX7ErAgGf07z
rHjfCooAwbO4Uc2f9l92KG7LyyzSK6v7t9jiMp6JGN+cZPOKwuzbyHnatyVOEph5
r6WHyJwy8QOlFfpV4d47UyeVKeNgeoQ1XVTiqJftyeaOz8iRTQGxc+BLVejLdXSV
FLrEg4Q36kvghbp81C+sKDnkkf/LfW500lN6zlFtEnDosuq/gDsZv5SRE3xqqtca
+xotZs7sKzhgziwYJoqhEtNfMicFN6HypVaMLiR3XNNgnrQnDSkKb2BGDv493aMu
zMvLvn6hbHa2Jg5qd/4GsRKeH/b2GpeFY8a2k/oFQGcxdsiScsgd5eXX1AcuqvM8
yjxbwMNbkCnMDyz+JWblcZfx1HM0QxXrWWpofW990oDL2r7jJBVW3+3vScccYCtn
jaQz++xYp2s+zBcNF9ux
=bFXT
-----END PGP SIGNATURE-----

--=-Jv9JtQxkmfrLAOc1hzqz--
