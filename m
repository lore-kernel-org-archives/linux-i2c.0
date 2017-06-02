From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v9 2/5] irqchip/aspeed-i2c-ic: Add I2C IRQ controller for
 Aspeed
Date: Fri, 2 Jun 2017 10:54:37 +0100
Message-ID: <0db6df3c-013b-1d57-5c69-edfc53ef26c0@arm.com>
References: <20170602084603.30811-1-brendanhiggins@google.com>
 <20170602084603.30811-3-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750910AbdFBJyn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Jun 2017 05:54:43 -0400
In-Reply-To: <20170602084603.30811-3-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org, benh@kernel.crashing.org, ryan_chen@aspeedtech.com
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org

On 02/06/17 09:46, Brendan Higgins wrote:
> The Aspeed 24XX/25XX chips share a single hardware interrupt across 14
> separate I2C busses. This adds a dummy irqchip which maps the single
> hardware interrupt to software interrupts for each of the busses.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> Added in v6:
>   - Pulled "aspeed_i2c_controller" out into a interrupt controller since that is
>     what it actually does.
> Changes for v7:
>   - Renamed irq domain for consistency
> Changes for v8:
>   - None
> Changes for v9:
>   - None
> ---
>  drivers/irqchip/Makefile            |   2 +-
>  drivers/irqchip/irq-aspeed-i2c-ic.c | 102 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/irqchip/irq-aspeed-i2c-ic.c
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index b64c59b838a0..e067f9839b33 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -73,6 +73,6 @@ obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
>  obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
>  obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
>  obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
> -obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o
> +obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
> diff --git a/drivers/irqchip/irq-aspeed-i2c-ic.c b/drivers/irqchip/irq-aspeed-i2c-ic.c
> new file mode 100644
> index 000000000000..a36fb09c10c2
> --- /dev/null
> +++ b/drivers/irqchip/irq-aspeed-i2c-ic.c
> @@ -0,0 +1,102 @@
> +/*
> + *  Aspeed 24XX/25XX I2C Interrupt Controller.
> + *
> + *  Copyright (C) 2012-2017 ASPEED Technology Inc.
> + *  Copyright 2017 IBM Corporation
> + *  Copyright 2017 Google, Inc.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
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
> +	void __iomem		*base;
> +	int			parent_irq;
> +	struct irq_domain	*irq_domain;
> +};
> +
> +/*
> + * The aspeed chip provides a single hardware interrupt for all of the I2C
> + * busses, so we use a dummy interrupt chip to translate this single interrupt
> + * into multiple interrupts, each associated with a single I2C bus.
> + */
> +static void aspeed_i2c_ic_irq_handler(struct irq_desc *desc)
> +{
> +	struct aspeed_i2c_ic *i2c_ic = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned long bit, status;
> +	unsigned int bus_irq;
> +
> +	chained_irq_enter(chip, desc);
> +	status = readl(i2c_ic->base);
> +	for_each_set_bit(bit, &status, ASPEED_I2C_IC_NUM_BUS) {
> +		bus_irq = irq_find_mapping(i2c_ic->irq_domain, bit);
> +		generic_handle_irq(bus_irq);
> +	}
> +	chained_irq_exit(chip, desc);
> +}
> +
> +/*
> + * Set simple handler and mark IRQ as valid. Nothing interesting to do here
> + * since we are using a dummy interrupt chip.
> + */
> +static int aspeed_i2c_ic_map_irq_domain(struct irq_domain *domain,
> +					unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops aspeed_i2c_ic_irq_domain_ops = {
> +	.map = aspeed_i2c_ic_map_irq_domain,
> +};
> +
> +static int __init aspeed_i2c_ic_of_init(struct device_node *node,
> +					struct device_node *parent)
> +{
> +	struct aspeed_i2c_ic *i2c_ic;
> +
> +	i2c_ic = kzalloc(sizeof(*i2c_ic), GFP_KERNEL);
> +	if (!i2c_ic)
> +		return -ENOMEM;
> +
> +	i2c_ic->base = of_iomap(node, 0);
> +	if (IS_ERR(i2c_ic->base))
> +		return PTR_ERR(i2c_ic->base);
> +
> +	i2c_ic->parent_irq = irq_of_parse_and_map(node, 0);
> +	if (i2c_ic->parent_irq < 0)
> +		return i2c_ic->parent_irq;
> +
> +	i2c_ic->irq_domain = irq_domain_add_linear(
> +			node, ASPEED_I2C_IC_NUM_BUS,
> +			&aspeed_i2c_ic_irq_domain_ops, NULL);

nit: can you have at least one argument following the function name?
Even if checkpatch shouts out you?

> +	if (!i2c_ic->irq_domain)
> +		return -ENOMEM;

All these error paths are leaking the initial memory allocation.

> +
> +	i2c_ic->irq_domain->name = "aspeed-i2c-domain";
> +
> +	irq_set_chained_handler_and_data(i2c_ic->parent_irq,
> +					 aspeed_i2c_ic_irq_handler, i2c_ic);
> +
> +	pr_info("i2c controller registered, irq %d\n", i2c_ic->parent_irq);
> +
> +	return 0;
> +}
> +
> +IRQCHIP_DECLARE(ast2400_i2c_ic, "aspeed,ast2400-i2c-ic", aspeed_i2c_ic_of_init);
> +IRQCHIP_DECLARE(ast2500_i2c_ic, "aspeed,ast2500-i2c-ic", aspeed_i2c_ic_of_init);
> 

Once you've fixed the trivial bug above, this should be good to go.
What's the merging strategy? Can I take the initial two patches, and let
someone else deal with the rest? Or do you want the whole series to be
kept together?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
