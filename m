From: Rick Altherr <raltherr@google.com>
Subject: Re: [PATCH v2 1/1] i2c: aspeed: add proper support fo 24xx clock params
Date: Fri, 28 Jul 2017 14:00:02 -0700
Message-ID: <CAPLgG=kUxfriYRq-fc+AD=eo1T+6xa4imzda7Fd_aXmAb2pD3Q@mail.gmail.com>
References: <20170728204558.6455-1-brendanhiggins@google.com>
 <20170728204558.6455-2-brendanhiggins@google.com> <CAPLgG==69mNpqoqKUf-0tT4iJJ5-aCg+1uaAoLJ5QSe+8LGYkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38249 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbdG1VAE (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 28 Jul 2017 17:00:04 -0400
Received: by mail-wm0-f41.google.com with SMTP id m85so126283705wma.1
        for <linux-i2c@vger.kernel.org>; Fri, 28 Jul 2017 14:00:04 -0700 (PDT)
In-Reply-To: <CAPLgG==69mNpqoqKUf-0tT4iJJ5-aCg+1uaAoLJ5QSe+8LGYkw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: wsa@the-dreams.de, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Robi Buranyi <rburanyi@google.com>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Is clk_fractional_divider from include/linux/clk-provider.h appropriate here?

On Fri, Jul 28, 2017 at 1:57 PM, Rick Altherr <raltherr@google.com> wrote:
> Is clk_fractional_divider from include/linux/clk-provider.h appropriate
> here?
>
> On Fri, Jul 28, 2017 at 1:45 PM, Brendan Higgins <brendanhiggins@google.com>
> wrote:
>>
>> 24xx BMCs have larger clock divider granularity which can cause problems
>> when trying to set them as 25xx clock dividers; this adds clock setting
>> code specific to 24xx.
>>
>> This also fixes a potential issue where clock dividers were rounded down
>> instead of up.
>>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> ---
>> Changes for v2:
>>   - Fixed off by one error to check for divisors with base_clk == 0
>>   - Simplified some of the divisor math
>> ---
>>  drivers/i2c/busses/i2c-aspeed.c | 74
>> +++++++++++++++++++++++++++++++----------
>>  1 file changed, 56 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-aspeed.c
>> b/drivers/i2c/busses/i2c-aspeed.c
>> index f19348328a71..60afab866494 100644
>> --- a/drivers/i2c/busses/i2c-aspeed.c
>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>> @@ -132,6 +132,7 @@ struct aspeed_i2c_bus {
>>         /* Synchronizes I/O mem access to base. */
>>         spinlock_t                      lock;
>>         struct completion               cmd_complete;
>> +       u32                             (*get_clk_reg_val)(u32 divisor);
>>         unsigned long                   parent_clk_frequency;
>>         u32                             bus_frequency;
>>         /* Transaction state. */
>> @@ -674,7 +675,7 @@ static const struct i2c_algorithm aspeed_i2c_algo = {
>>  #endif /* CONFIG_I2C_SLAVE */
>>  };
>>
>> -static u32 aspeed_i2c_get_clk_reg_val(u32 divisor)
>> +static u32 aspeed_i2c_get_clk_reg_val(u32 clk_high_low_max, u32 divisor)
>>  {
>>         u32 base_clk, clk_high, clk_low, tmp;
>>
>> @@ -694,16 +695,22 @@ static u32 aspeed_i2c_get_clk_reg_val(u32 divisor)
>>          * Thus,
>>          *      SCL_freq = APB_freq /
>>          *              ((1 << base_clk) * (clk_high + 1 + clk_low + 1))
>> -        * The documentation recommends clk_high >= 8 and clk_low >= 7
>> when
>> -        * possible; this last constraint gives us the following solution:
>> +        * The documentation recommends clk_high >= clk_high_max / 2 and
>> +        * clk_low >= clk_low_max / 2 - 1 when possible; this last
>> constraint
>> +        * gives us the following solution:
>>          */
>> -       base_clk = divisor > 33 ? ilog2((divisor - 1) / 32) + 1 : 0;
>> -       tmp = divisor / (1 << base_clk);
>> -       clk_high = tmp / 2 + tmp % 2;
>> -       clk_low = tmp - clk_high;
>> +       base_clk = divisor > clk_high_low_max ?
>> +                       ilog2((divisor - 1) / clk_high_low_max) + 1 : 0;
>> +       tmp = (divisor + (1 << base_clk) - 1) >> base_clk;
>> +       clk_low = tmp / 2;
>> +       clk_high = tmp - clk_low;
>> +
>> +       if (clk_high)
>> +               clk_high--;
>> +
>> +       if (clk_low)
>> +               clk_low--;
>>
>> -       clk_high -= 1;
>> -       clk_low -= 1;
>>
>>         return ((clk_high << ASPEED_I2CD_TIME_SCL_HIGH_SHIFT)
>>                 & ASPEED_I2CD_TIME_SCL_HIGH_MASK)
>> @@ -712,13 +719,31 @@ static u32 aspeed_i2c_get_clk_reg_val(u32 divisor)
>>                         | (base_clk & ASPEED_I2CD_TIME_BASE_DIVISOR_MASK);
>>  }
>>
>> +static u32 aspeed_i2c_24xx_get_clk_reg_val(u32 divisor)
>> +{
>> +       /*
>> +        * clk_high and clk_low are each 3 bits wide, so each can hold a
>> max
>> +        * value of 8 giving a clk_high_low_max of 16.
>> +        */
>> +       return aspeed_i2c_get_clk_reg_val(16, divisor);
>> +}
>> +
>> +static u32 aspeed_i2c_25xx_get_clk_reg_val(u32 divisor)
>> +{
>> +       /*
>> +        * clk_high and clk_low are each 4 bits wide, so each can hold a
>> max
>> +        * value of 16 giving a clk_high_low_max of 32.
>> +        */
>> +       return aspeed_i2c_get_clk_reg_val(32, divisor);
>> +}
>> +
>>  /* precondition: bus.lock has been acquired. */
>>  static int aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus)
>>  {
>>         u32 divisor, clk_reg_val;
>>
>> -       divisor = bus->parent_clk_frequency / bus->bus_frequency;
>> -       clk_reg_val = aspeed_i2c_get_clk_reg_val(divisor);
>> +       divisor = DIV_ROUND_UP(bus->parent_clk_frequency,
>> bus->bus_frequency);
>> +       clk_reg_val = bus->get_clk_reg_val(divisor);
>>         writel(clk_reg_val, bus->base + ASPEED_I2C_AC_TIMING_REG1);
>>         writel(ASPEED_NO_TIMEOUT_CTRL, bus->base +
>> ASPEED_I2C_AC_TIMING_REG2);
>>
>> @@ -777,8 +802,22 @@ static int aspeed_i2c_reset(struct aspeed_i2c_bus
>> *bus)
>>         return ret;
>>  }
>>
>> +static const struct of_device_id aspeed_i2c_bus_of_table[] = {
>> +       {
>> +               .compatible = "aspeed,ast2400-i2c-bus",
>> +               .data = aspeed_i2c_24xx_get_clk_reg_val,
>> +       },
>> +       {
>> +               .compatible = "aspeed,ast2500-i2c-bus",
>> +               .data = aspeed_i2c_25xx_get_clk_reg_val,
>> +       },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, aspeed_i2c_bus_of_table);
>> +
>>  static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>>  {
>> +       const struct of_device_id *match;
>>         struct aspeed_i2c_bus *bus;
>>         struct clk *parent_clk;
>>         struct resource *res;
>> @@ -808,6 +847,12 @@ static int aspeed_i2c_probe_bus(struct
>> platform_device *pdev)
>>                 bus->bus_frequency = 100000;
>>         }
>>
>> +       match = of_match_node(aspeed_i2c_bus_of_table, pdev->dev.of_node);
>> +       if (!match)
>> +               bus->get_clk_reg_val = aspeed_i2c_24xx_get_clk_reg_val;
>> +       else
>> +               bus->get_clk_reg_val = match->data;
>> +
>>         /* Initialize the I2C adapter */
>>         spin_lock_init(&bus->lock);
>>         init_completion(&bus->cmd_complete);
>> @@ -869,13 +914,6 @@ static int aspeed_i2c_remove_bus(struct
>> platform_device *pdev)
>>         return 0;
>>  }
>>
>> -static const struct of_device_id aspeed_i2c_bus_of_table[] = {
>> -       { .compatible = "aspeed,ast2400-i2c-bus", },
>> -       { .compatible = "aspeed,ast2500-i2c-bus", },
>> -       { },
>> -};
>> -MODULE_DEVICE_TABLE(of, aspeed_i2c_bus_of_table);
>> -
>>  static struct platform_driver aspeed_i2c_bus_driver = {
>>         .probe          = aspeed_i2c_probe_bus,
>>         .remove         = aspeed_i2c_remove_bus,
>> --
>> 2.14.0.rc0.400.g1c36432dff-goog
>>
>
