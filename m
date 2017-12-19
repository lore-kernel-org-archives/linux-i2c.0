From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: at24: new optional property - write-protect-gpios
Date: Wed, 20 Dec 2017 00:25:05 +0200
Message-ID: <CAHp75Ve=2NG5egBFCgCXzaaqC7yzZmm=gTe9RZNZO9wVcA6xHw@mail.gmail.com>
References: <20171219161432.29809-1-brgl@bgdev.pl> <20171219161432.29809-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36078 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdLSWZH (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Dec 2017 17:25:07 -0500
In-Reply-To: <20171219161432.29809-2-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Dec 19, 2017 at 6:14 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> AT24 EEPROMs have a write-protect pin, which - when pulled high -
> inhibits writes to the upper quadrant of memory (although it has been
> observed that on some chips it disables writing to the entire memory
> range).
>
> On some boards, this pin is connected to a GPIO and pulled high by
> default, which forces the user to manually change its state before
> writing. On linux this means that we either need to hog the line all
> the time, or set the GPIO value before writing from outside of the
> at24 driver.
>
> Add a new optional property to the device tree binding document, which
> allows to specify the GPIO line to which the write-protect pin is
> connected.
>

> +  - write-protect-gpios: GPIO to which the write-protect pin of the chip is

The rule of thumb is to check what is de facto state of the properties
like this, i.e.

% git grep -n wp-gpio -- Documentation/ | wc -l
14
% git grep -n write-protect-gpio -- Documentation/ | wc -l
0

I think it means something.

-- 
With Best Regards,
Andy Shevchenko
