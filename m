From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 0/2] eeprom: at24: write-protect pin support
Date: Wed, 20 Dec 2017 16:05:32 +0100
Message-ID: <CAMRc=MeT1a=srsbE6XKJmXmQ2UgrtC6mRQkXAm6rkGmrFUQ_qQ@mail.gmail.com>
References: <20171220082633.32237-1-brgl@bgdev.pl> <CAHp75VfCD=mXvvbMT6PtjhgRznqfOSX_8Y8K3Zr64oJTbKnPeg@mail.gmail.com>
 <CAMRc=Mej4SVZwSNqObgMfzgnc9mOFHi5GLTVKGW4Lp3n_Q-bvA@mail.gmail.com> <CAHp75VfjP64o8iqMRn-XOththnL=Wm+jMF++q+ic0zpR3T0EKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f176.google.com ([74.125.82.176]:40022 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbdLTPFd (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Dec 2017 10:05:33 -0500
Received: by mail-ot0-f176.google.com with SMTP id o39so378134otd.7
        for <linux-i2c@vger.kernel.org>; Wed, 20 Dec 2017 07:05:33 -0800 (PST)
In-Reply-To: <CAHp75VfjP64o8iqMRn-XOththnL=Wm+jMF++q+ic0zpR3T0EKw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

2017-12-20 16:00 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Wed, Dec 20, 2017 at 2:41 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> 2017-12-20 11:21 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
>>> On Wed, Dec 20, 2017 at 10:26 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>> AT24 EEPROMs have a write-protect pin, which - when pulled high -
>>>> inhibits writes to the upper quadrant of memory (although it has been
>>>> observed that on some chips it disables writing to the entire memory
>>>> range).
>>>>
>>>> On some boards, this pin is connected to a GPIO and pulled high by
>>>> default, which forces the user to manually change its state before
>>>> writing. On linux this means that we either need to hog the line all
>>>> the time, or set the GPIO value before writing from outside of the
>>>> at24 driver.
>>>>
>>>> This series adds support for the write-protect pin split into two
>>>> parts. The first patch extends the relevant binding document, while
>>>> the second modifies the at24 code to pull the write-protect GPIO
>>>> low (if present) during write operations.
>>>>
>>>
>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>
>>> A one totally minor nit: if it possible now to have one line where
>>> devm_gpiod_get_optional() is called?
>>> You may ignore this nit anyway.
>>>
>>
>> Hi Andy,
>>
>> I'm afraid I don't understand what you mean here. I do use
>> devm_gpiod_get_optional() in patch 2/2.
>
> I meant to do something like
> ...->wp_gpio = devm_gpiod_get_optional(...);
> if (IS_ERR(...))
>   return ...;
>
> So, note that the first is occupied only one line.
>
> --
> With Best Regards,
> Andy Shevchenko

Oh, now I get it.

It doesn't fit into 80 characters if we use &client->dev as the first
argument, but I see that client->dev is used extensively in probe() so
we could probably use a separate struct device *dev helper variable
for that. I'll note it for future refactoring that will happen soon. I
prefer that this patch stays as it is though.

Thanks,
Bartosz
