From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 3/5] i2c: pca-platform: add devicetree awareness
Date: Wed, 28 Jun 2017 12:20:41 +0300
Message-ID: <CAHp75VeFUZzj00i9oSSanudPVzd61XFRkQ9Uz72r05EqdHNdxg@mail.gmail.com>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz> <20170626004434.2757-4-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:36665 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbdF1JUn (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Jun 2017 05:20:43 -0400
In-Reply-To: <20170626004434.2757-4-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 26, 2017 at 3:44 AM, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> Allow devices that use this driver to be registered via a
> devicetree.

Device Tree

Wolfram was being a bit faster to apply it...
> +#include <linux/of.h>
> +#include <linux/of_device.h>

> +       struct device_node *np = pdev->dev.of_node;

>         /* If irq is 0, we do polling. */
> +       if (irq < 0)
> +               irq = 0;

This does not belong to what is written in commit message. Looks like
a separate fix.

> +       i2c->adap.dev.of_node = np;

> +       } else if (np) {

> +               i2c->adap.timeout = HZ;
> +               i2c->gpio = devm_gpiod_get_optional(&pdev->dev, "reset-gpios", GPIOD_OUT_LOW);
> +               if (IS_ERR(i2c->gpio))
> +                       return PTR_ERR(i2c->gpio);
> +               of_property_read_u32_index(np, "clock-frequency", 0,
> +                                          &i2c->algo_data.i2c_clock);

And what prevents you to use device_property_read_*() here and get rid
of OFstuff?

> +#ifdef CONFIG_OF

Better not to put it...

> +               .of_match_table = of_match_ptr(i2c_pca_of_match_table),

...and get rid of of_match_ptr().

-- 
With Best Regards,
Andy Shevchenko
