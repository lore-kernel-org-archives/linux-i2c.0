From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 0/2] eeprom: at24: write-protect pin support
Date: Wed, 20 Dec 2017 17:00:41 +0200
Message-ID: <CAHp75VfjP64o8iqMRn-XOththnL=Wm+jMF++q+ic0zpR3T0EKw@mail.gmail.com>
References: <20171220082633.32237-1-brgl@bgdev.pl> <CAHp75VfCD=mXvvbMT6PtjhgRznqfOSX_8Y8K3Zr64oJTbKnPeg@mail.gmail.com>
 <CAMRc=Mej4SVZwSNqObgMfzgnc9mOFHi5GLTVKGW4Lp3n_Q-bvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36442 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755407AbdLTPAm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Dec 2017 10:00:42 -0500
In-Reply-To: <CAMRc=Mej4SVZwSNqObgMfzgnc9mOFHi5GLTVKGW4Lp3n_Q-bvA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Dec 20, 2017 at 2:41 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 2017-12-20 11:21 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
>> On Wed, Dec 20, 2017 at 10:26 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>> AT24 EEPROMs have a write-protect pin, which - when pulled high -
>>> inhibits writes to the upper quadrant of memory (although it has been
>>> observed that on some chips it disables writing to the entire memory
>>> range).
>>>
>>> On some boards, this pin is connected to a GPIO and pulled high by
>>> default, which forces the user to manually change its state before
>>> writing. On linux this means that we either need to hog the line all
>>> the time, or set the GPIO value before writing from outside of the
>>> at24 driver.
>>>
>>> This series adds support for the write-protect pin split into two
>>> parts. The first patch extends the relevant binding document, while
>>> the second modifies the at24 code to pull the write-protect GPIO
>>> low (if present) during write operations.
>>>
>>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>
>> A one totally minor nit: if it possible now to have one line where
>> devm_gpiod_get_optional() is called?
>> You may ignore this nit anyway.
>>
>
> Hi Andy,
>
> I'm afraid I don't understand what you mean here. I do use
> devm_gpiod_get_optional() in patch 2/2.

I meant to do something like
...->wp_gpio = devm_gpiod_get_optional(...);
if (IS_ERR(...))
  return ...;

So, note that the first is occupied only one line.

-- 
With Best Regards,
Andy Shevchenko
