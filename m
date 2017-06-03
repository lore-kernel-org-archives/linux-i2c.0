From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v9 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Fri, 2 Jun 2017 18:39:09 -0700
Message-ID: <CAFd5g46JmZZCLfvLzMbeeszNMJ_vBa3VvQSp4AGdEsNxYpTnYQ@mail.gmail.com>
References: <20170602084603.30811-1-brendanhiggins@google.com>
 <20170602084603.30811-5-brendanhiggins@google.com> <1496404942.2842.2.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34564 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdFCBjK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 2 Jun 2017 21:39:10 -0400
Received: by mail-qt0-f171.google.com with SMTP id c13so71223791qtc.1
        for <linux-i2c@vger.kernel.org>; Fri, 02 Jun 2017 18:39:10 -0700 (PDT)
In-Reply-To: <1496404942.2842.2.camel@kernel.crashing.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Joel Stanley <joel@jms.id.au>, Vladimir Zapolskiy <vz@mleia.com>, Kachalov Anton <mouse@mayc.ru>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Ryan Chen <ryan_chen@aspeedtech.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>

On Fri, Jun 2, 2017 at 5:02 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2017-06-02 at 01:46 -0700, Brendan Higgins wrote:
>> Added initial master support for Aspeed I2C controller. Supports
>> fourteen busses present in AST24XX and AST25XX BMC SoCs by Aspeed.
>>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>
> Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> Just spotted a completely minor/tivial nit:
>
>> +static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
>> +                               struct i2c_msg *msgs, int num)
>> +{
>> +     struct aspeed_i2c_bus *bus = adap->algo_data;
>> +     unsigned long time_left, flags;
>> +     int ret = 0;
>> +
>> +     spin_lock_irqsave(&bus->lock, flags);
>> +     bus->cmd_err = 0;
>         ^^^^^^^^^^^^^^^^^
>
> This is probably unnecessary now since it's initialized further down.

Nope, reset uses cmd_err as well. Maybe reset should initialize it? Not sure.

>
>> +     /* If bus is busy, attempt recovery. We assume a single master
>> +      * environment.
>> +      */
>> +     if (readl(bus->base + ASPEED_I2C_CMD_REG) & ASPEED_I2CD_BUS_BUSY_STS) {
>> +             spin_unlock_irqrestore(&bus->lock, flags);
>> +             ret = aspeed_i2c_recover_bus(bus);
>> +             if (ret)
>> +                     return ret;
>> +             spin_lock_irqsave(&bus->lock, flags);
>> +     }
>> +
>> +     bus->cmd_err = 0;
>> +     bus->msgs = msgs;
>> +     bus->msgs_index = 0;
>> +     bus->msgs_count = num;
>
> Now I'd like Andrew to give it a spin as he's currently
> testing/debugging some i2c related stuff to be 100% certain it works
> fine on our systems.

If you haven't done this yet, you should try version 10 instead.
