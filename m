From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [PATCH] i2c: core: helper function to detect slave mode
Date: Fri, 6 Jan 2017 17:15:03 +0000
Message-ID: <475d9c2a-da11-97d0-d0b6-37ccd4990f18@synopsys.com>
References: <f4ec62119145bc70c938800c91eb396d30457304.1483636071.git.lolivei@synopsys.com>
 <CAHp75VdB+pApFgjFOwWYYQFUmxv5k6OYKgB4fstuy=3=2QesBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:46207 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752570AbdAFRPI (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 6 Jan 2017 12:15:08 -0500
In-Reply-To: <CAHp75VdB+pApFgjFOwWYYQFUmxv5k6OYKgB4fstuy=3=2QesBQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ramiro.Oliveira@synopsys.com, Joao Pinto <Joao.Pinto@synopsys.com>, CARLOS.PALMINHA@synopsys.com

On 06-Jan-17 16:29, Andy Shevchenko wrote:
> On Thu, Jan 5, 2017 at 7:24 PM, Luis Oliveira
> <Luis.Oliveira@synopsys.com> wrote:
>> This function has the purpose of mode detection by checking the
>> device nodes for a reg matching with the I2C_OWN_SLAVE_ADDREESS flag.
>> Currently only checks using OF functions (ACPI slave not supported yet).
> 
> The code looks good, one important comment below, after addressing it:
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> P.S. Btw, we have Suggested-by tag for giving credit for suggestion.
> Please use it.
> 

I will do it in the V2, thank you.

>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -3691,6 +3691,25 @@ int i2c_slave_unregister(struct i2c_client *client)
> 
> Please, add kernel doc description here, important thing is to explain
> return codes in Return: section of it.
> 
>> +int i2c_slave_mode_detect(struct device *dev)
>> +{
> 
>> +       struct device_node *child;
>> +       u32 reg;
> 
> I would consider them as private to the OF branch. But it's really
> minor and up to you (I don't remember if we have such style examples
> in i2c core code).

I can change that in the V2 too.

> 
>> +
>> +       if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
>> +               for_each_child_of_node(dev->of_node, child) {
>> +                       of_property_read_u32(child, "reg", &reg);
>> +                       if (reg & I2C_OWN_SLAVE_ADDRESS)
>> +                               return 1;
>> +               }
>> +       } else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev)) {
>> +               dev_dbg(dev, "ACPI slave is not supported yet\n");
>> +       }
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(i2c_slave_mode_detect);
> 
