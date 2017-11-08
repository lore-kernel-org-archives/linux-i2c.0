From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ARM: sa1100: simpad: Correct I2C GPIO offsets
Date: Wed, 8 Nov 2017 11:55:23 +0100
Message-ID: <CAK8P3a35EyYU+B8bDXDjveMx7U5pVWuYAqgkwzYgRwi7A0qxfw@mail.gmail.com>
References: <20171107201857.5752-1-linus.walleij@linaro.org> <CAK8P3a0_kB8NBifbutqyvY_FYHnZTpwK-m0KZV3swpMa4fxjrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:52760 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdKHKzZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Nov 2017 05:55:25 -0500
Received: by mail-ot0-f194.google.com with SMTP id 18so1918677oty.9
        for <linux-i2c@vger.kernel.org>; Wed, 08 Nov 2017 02:55:24 -0800 (PST)
In-Reply-To: <CAK8P3a0_kB8NBifbutqyvY_FYHnZTpwK-m0KZV3swpMa4fxjrA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jochen Friedrich <jochen@scram.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>

On Wed, Nov 8, 2017 at 11:54 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Nov 7, 2017 at 9:18 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
>> index 9db483a42826..7d4feb8a49ac 100644
>> --- a/arch/arm/mach-sa1100/simpad.c
>> +++ b/arch/arm/mach-sa1100/simpad.c
>> @@ -328,9 +328,9 @@ static struct platform_device simpad_gpio_leds = {
>>  static struct gpiod_lookup_table simpad_i2c_gpiod_table = {
>>         .dev_id = "i2c-gpio",
>>         .table = {
>> -               GPIO_LOOKUP_IDX("gpio", GPIO_GPIO21, NULL, 0,
>> +               GPIO_LOOKUP_IDX("gpio", 21, NULL, 0,
>>                                 GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
>> -               GPIO_LOOKUP_IDX("gpio", GPIO_GPIO25, NULL, 1,
>> +               GPIO_LOOKUP_IDX("gpio", 25, NULL, 1,
>>                                 GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
>>         },
>>  };
>
> This looks like it's probably correct, but now I'm puzzled by another line in
> the same file:
>
> static struct gpio_keys_button simpad_button_table[] = {
>         { KEY_POWER, IRQ_GPIO_POWER_BUTTON, 1, "power button" },
> };
>
> Here we pass a gpio number as well, but we use the macro for the IRQ
> number that is apparently 32 higher than the gpio number. This came from the
> same commit that introduced the GPIO_GPIO21 reference, so it may well
> be broken, too.
>
> I'm fine with your version getting merged as it certainly can't make things
> worse, it fixes the build warning, and it probably fixes one thing that is
> wrong today

I also meant to say

Acked-by: Arnd Bergmann <arnd@arndb.de>

for this patch going through the i2c tree.
