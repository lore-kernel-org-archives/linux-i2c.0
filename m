From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 2/5] i2c: pca-platform: switch to struct gpio_desc
Date: Wed, 28 Jun 2017 12:25:39 +0300
Message-ID: <CAHp75VeoJeq0Xjsu76gfZcpgULMO0krnETMwydx9C_4LbWdNXQ@mail.gmail.com>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz> <20170626004434.2757-3-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35760 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbdF1JZk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Jun 2017 05:25:40 -0400
In-Reply-To: <20170626004434.2757-3-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 26, 2017 at 3:44 AM, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> Make use of struct gpio_desc which allows us to specify the active state
> of the reset pin.

> +               if (gpio_is_valid(platform_data->gpio)) {

No way, it should be provided by GPIO lookup table.

> +                       ret = devm_gpio_request_one(&pdev->dev,
> +                                                   platform_data->gpio,
> +                                                   GPIOF_ACTIVE_LOW,
> +                                                   i2c->adap.name);
> +                       if (ret == 0) {
> +                               i2c->gpio = gpio_to_desc(platform_data->gpio);

This has to be devm_gpiod_get() instead.

Wolfram, I suggested to drop the series for now and wait for improvements.

-- 
With Best Regards,
Andy Shevchenko
