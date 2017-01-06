From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: core: helper function to detect slave mode
Date: Fri, 6 Jan 2017 18:29:44 +0200
Message-ID: <CAHp75VdB+pApFgjFOwWYYQFUmxv5k6OYKgB4fstuy=3=2QesBQ@mail.gmail.com>
References: <f4ec62119145bc70c938800c91eb396d30457304.1483636071.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36688 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdAFQ3p (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 6 Jan 2017 11:29:45 -0500
In-Reply-To: <f4ec62119145bc70c938800c91eb396d30457304.1483636071.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ramiro.Oliveira@synopsys.com, Joao Pinto <Joao.Pinto@synopsys.com>, CARLOS.PALMINHA@synopsys.com

On Thu, Jan 5, 2017 at 7:24 PM, Luis Oliveira
<Luis.Oliveira@synopsys.com> wrote:
> This function has the purpose of mode detection by checking the
> device nodes for a reg matching with the I2C_OWN_SLAVE_ADDREESS flag.
> Currently only checks using OF functions (ACPI slave not supported yet).

The code looks good, one important comment below, after addressing it:

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

P.S. Btw, we have Suggested-by tag for giving credit for suggestion.
Please use it.

> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -3691,6 +3691,25 @@ int i2c_slave_unregister(struct i2c_client *client)

Please, add kernel doc description here, important thing is to explain
return codes in Return: section of it.

> +int i2c_slave_mode_detect(struct device *dev)
> +{

> +       struct device_node *child;
> +       u32 reg;

I would consider them as private to the OF branch. But it's really
minor and up to you (I don't remember if we have such style examples
in i2c core code).

> +
> +       if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
> +               for_each_child_of_node(dev->of_node, child) {
> +                       of_property_read_u32(child, "reg", &reg);
> +                       if (reg & I2C_OWN_SLAVE_ADDRESS)
> +                               return 1;
> +               }
> +       } else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev)) {
> +               dev_dbg(dev, "ACPI slave is not supported yet\n");
> +       }
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(i2c_slave_mode_detect);

-- 
With Best Regards,
Andy Shevchenko
