From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v9 2/5] irqchip/aspeed-i2c-ic: Add I2C IRQ controller for Aspeed
Date: Fri, 2 Jun 2017 11:29:07 -0700
Message-ID: <CAFd5g44FJyVHU1fss0zy1OrQVUQKVo27KQCS2GaRi7=JS-Gzmw@mail.gmail.com>
References: <20170602084603.30811-1-brendanhiggins@google.com>
 <20170602084603.30811-3-brendanhiggins@google.com> <0db6df3c-013b-1d57-5c69-edfc53ef26c0@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36268 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdFBS3J (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 2 Jun 2017 14:29:09 -0400
Received: by mail-qt0-f173.google.com with SMTP id f55so65478805qta.3
        for <linux-i2c@vger.kernel.org>; Fri, 02 Jun 2017 11:29:09 -0700 (PDT)
In-Reply-To: <0db6df3c-013b-1d57-5c69-edfc53ef26c0@arm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Joel Stanley <joel@jms.id.au>, Vladimir Zapolskiy <vz@mleia.com>, Kachalov Anton <mouse@mayc.ru>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ryan Chen <ryan_chen@aspeedtech.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>

>> +     i2c_ic->irq_domain = irq_domain_add_linear(
>> +                     node, ASPEED_I2C_IC_NUM_BUS,
>> +                     &aspeed_i2c_ic_irq_domain_ops, NULL);
>
> nit: can you have at least one argument following the function name?
> Even if checkpatch shouts out you?

Makes no difference to me.

>
>> +     if (!i2c_ic->irq_domain)
>> +             return -ENOMEM;
>
> All these error paths are leaking the initial memory allocation.

Whoops, forgot I am not using devm_*.

>
>> +
>> +     i2c_ic->irq_domain->name = "aspeed-i2c-domain";
>> +
>> +     irq_set_chained_handler_and_data(i2c_ic->parent_irq,
>> +                                      aspeed_i2c_ic_irq_handler, i2c_ic);
>> +
>> +     pr_info("i2c controller registered, irq %d\n", i2c_ic->parent_irq);
>> +
>> +     return 0;
>> +}
>> +
>> +IRQCHIP_DECLARE(ast2400_i2c_ic, "aspeed,ast2400-i2c-ic", aspeed_i2c_ic_of_init);
>> +IRQCHIP_DECLARE(ast2500_i2c_ic, "aspeed,ast2500-i2c-ic", aspeed_i2c_ic_of_init);
>>
>
> Once you've fixed the trivial bug above, this should be good to go.
> What's the merging strategy? Can I take the initial two patches, and let
> someone else deal with the rest? Or do you want the whole series to be
> kept together?

I think it makes most sense to keep it together and let Wolfram merge the
whole thing since the I2C patches won't work without this and I would not
want to make the merging process unnecessarily complicated.
