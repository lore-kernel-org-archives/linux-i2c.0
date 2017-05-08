From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v7 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Mon, 8 May 2017 16:34:58 -0700
Message-ID: <CAFd5g44RxehYCYB=WnxiXMZJe6E5_baQKDvdLAJX7+TTbvpi0Q@mail.gmail.com>
References: <20170424181818.2754-1-brendanhiggins@google.com> <20170424181818.2754-5-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:32986 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdEHXfA (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 8 May 2017 19:35:00 -0400
Received: by mail-qt0-f176.google.com with SMTP id t26so47677621qtg.0
        for <linux-i2c@vger.kernel.org>; Mon, 08 May 2017 16:34:59 -0700 (PDT)
In-Reply-To: <20170424181818.2754-5-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Joel Stanley <joel@jms.id.au>, Vladimir Zapolskiy <vz@mleia.com>, Kachalov Anton <mouse@mayc.ru>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Brendan Higgins <brendanhiggins@google.com>, Ryan Chen <ryan_chen@aspeedtech.com>

Sorry for the spam everyone, email client did not do what I expected it to do.

I would like to release another version this week or next week, and I
think that we are pretty closed to having something we can apply, but
before I do that, I want to get something resolved:

> +static int __aspeed_i2c_init(struct aspeed_i2c_bus *bus,
> +                            struct platform_device *pdev)
> +{
> +       int ret;
> +
> +       /* Disable everything. */
> +       writel(0, bus->base + ASPEED_I2C_FUN_CTRL_REG);
> +
> +       ret = __aspeed_i2c_init_clk(bus, pdev);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* Enable Master Mode */
> +       writel(readl(bus->base + ASPEED_I2C_FUN_CTRL_REG) |
> +              ASPEED_I2CD_MASTER_EN |
> +              /* TODO: provide device tree option for multi-master mode. */

I am curious what everyone thinks about this. It seemed that, earlier
on, people did not like me disabling multi-master mode, but I think
that it would make bus recovery not work as well. Given that, I think
it makes the most sense to provide a device tree option either to
enable multi-master support or disable it. Thoughts?

> +              ASPEED_I2CD_MULTI_MASTER_DIS,
> +              bus->base + ASPEED_I2C_FUN_CTRL_REG);
> +
> +       /* Set interrupt generation of I2C controller */
> +       writel(ASPEED_I2CD_INTR_ALL, bus->base + ASPEED_I2C_INTR_CTRL_REG);
> +
> +       return 0;
> +}
