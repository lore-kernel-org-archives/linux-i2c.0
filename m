From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v4 1/2] i2c: aspeed: added driver for Aspeed I2C
Date: Tue, 29 Nov 2016 16:59:43 -0800
Message-ID: <CAFd5g44_NjguoM7A90swH2fnt95H6S5+vYff7dmnhJKSEoXFAw@mail.gmail.com>
References: <1478311099-6771-1-git-send-email-brendanhiggins@google.com>
 <1478311099-6771-2-git-send-email-brendanhiggins@google.com> <00867f8e-e861-4184-6179-25e996789762@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34539 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753383AbcK3A7o (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 29 Nov 2016 19:59:44 -0500
Received: by mail-qk0-f171.google.com with SMTP id q130so6702101qke.1
        for <linux-i2c@vger.kernel.org>; Tue, 29 Nov 2016 16:59:44 -0800 (PST)
In-Reply-To: <00867f8e-e861-4184-6179-25e996789762@mleia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: mark.rutland@arm.com, Wolfram Sang <wsa@the-dreams.de>, robh+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, OpenBMC Maillist <openbmc@lists.ozlabs.org>

Thanks for the comments!

Most of the stuff you suggested was pretty straightforward and will be
in the v5 patchset which I will send out in a bit.

I removed my implementation of the irq_chip; it appears that there is already a
dummy_irq_chip that is intended for just this kind of thing. Let me
know if you think
we still need to loop in the irqchip people.

The remaining comments are addressed below:

> > +#define ASPEED_I2CD_MULTI_MASTER_DIS                   BIT(15)
>
> Unused macro, please remove.

No, it is used below:

> +       /* Enable Master Mode */
> +       aspeed_i2c_write(bus, aspeed_i2c_read(bus, ASPEED_I2C_FUN_CTRL_REG) |
> +                     ASPEED_I2CD_MASTER_EN |
> +                     ASPEED_I2CD_MULTI_MASTER_DIS, ASPEED_I2C_FUN_CTRL_REG);

> > +#define ASPEED_I2CD_SDA_DRIVE_1T_EN                    BIT(8)
>
> Unused macro, please remove.

No, it is used below:

> +       /* Set AC Timing */
> +       if (clk_freq / 1000 > 400) {
> +               aspeed_i2c_write(bus, aspeed_i2c_read(bus,
> +                                                     ASPEED_I2C_FUN_CTRL_REG) |
> +                               ASPEED_I2CD_M_HIGH_SPEED_EN |
> +                               ASPEED_I2CD_M_SDA_DRIVE_1T_EN |
> +                               ASPEED_I2CD_SDA_DRIVE_1T_EN,
> +                               ASPEED_I2C_FUN_CTRL_REG);

> > +#define ASPEED_I2CD_SLAVE_EN                           BIT(1)
>
> Unused macro, please remove. You add slave support, may be you
> need this control, but it is unused.

No, it is used below:

> +       /* Switch from master mode to slave mode. */
> +       func_ctrl_reg_val = aspeed_i2c_read(bus, ASPEED_I2C_FUN_CTRL_REG);
> +       func_ctrl_reg_val &= ~ASPEED_I2CD_MASTER_EN;
> +       func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;

> > +       /* Slave was asked to stop. */
> > +       if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) {
> > +               status_ack |= ASPEED_I2CD_INTR_NORMAL_STOP;
> > +               bus->slave_state = ASPEED_I2C_SLAVE_STOP;
> > +       }
>
> Add an empty line here.
>
> > +       if (irq_status & ASPEED_I2CD_INTR_TX_NAK) {
> > +               status_ack |= ASPEED_I2CD_INTR_TX_NAK;
> > +               bus->slave_state = ASPEED_I2C_SLAVE_STOP;
> > +       }

Actually, I think this makes more sense without a space as these are
both stop conditions.

> > +static int aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus,
> > +                           struct platform_device *pdev)
> > +{
> > +       struct clk *pclk;
> > +       u32 clk_freq;
> > +       u32 divider_ratio;
> > +       int ret;
> > +
> > +       pclk = devm_clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(pclk)) {
> > +               dev_err(&pdev->dev, "clk_get failed\n");
> > +               return PTR_ERR(pclk);
> > +       }
> > +       ret = of_property_read_u32(pdev->dev.of_node,
> > +                       "clock-frequency", &clk_freq);
> > +       if (ret < 0) {
> > +               dev_err(&pdev->dev,
> > +                               "Could not read clock-frequency property\n");
> > +               clk_freq = 100000;
> > +       }
> > +       divider_ratio = clk_get_rate(pclk) / clk_freq;
> > +       /* We just need the clock rate, we don't actually use the clk object. */
> > +       devm_clk_put(&pdev->dev, pclk);
>
> Does the controller have a clock supply? If yes, shall the clock be
> enabled before issuing command to the controller?

No, the clock source for the busses is the APB's clock. The chip does
not really expose
any sophisticated way to manipulate it, so we can just assume it is
always on and is fixed
frequency. Additionally, each bus has its own clock which is just a
divider on the APB's
clock which we set up here. The controller does not participate in this.

> > +static int aspeed_i2c_probe_bus(struct platform_device *pdev)
> > +{
> > +       struct aspeed_i2c_bus *bus;
> > +       struct aspeed_i2c_controller *controller =
> > +                       dev_get_drvdata(pdev->dev.parent);
>
> How do you ensure that "controller" device _driver_ is initialized
> at this point? This is a critical race condition.

aspeed_i2c_probe_controller(...) is responsible for creating the bus
nodes right before it
finishes, so it makes sure that it is sufficiently initialized before
allowing its child busses
to be probed:

> +       for_each_child_of_node(pdev->dev.of_node, np) {
> +               of_platform_device_create(np, NULL, &pdev->dev);
> +               of_node_put(np);
> +       }

Cheers
