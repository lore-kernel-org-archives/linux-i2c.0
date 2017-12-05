From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/6] i2c: add 'set_sda' to bus_recovery_info
Date: Tue, 5 Dec 2017 16:31:14 +0100
Message-ID: <CACRpkdYuHit1w1_d4h++vOuSWosf+iBdgimtCUbmic3mkbm1Wg@mail.gmail.com>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
 <20171204123640.3382-4-wsa+renesas@sang-engineering.com> <CACRpkdZzwo9UhT08VDHXg6=eXdK80Pt1omZ4Xda_HFwguyNpaw@mail.gmail.com>
 <20171205133848.nzrhysiz2twvlamx@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:38450 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbdLEPbP (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Dec 2017 10:31:15 -0500
Received: by mail-it0-f50.google.com with SMTP id r6so2400841itr.3
        for <linux-i2c@vger.kernel.org>; Tue, 05 Dec 2017 07:31:15 -0800 (PST)
In-Reply-To: <20171205133848.nzrhysiz2twvlamx@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Phil Reid <preid@electromag.com.au>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>

On Tue, Dec 5, 2017 at 2:38 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

>> Just compare it to zero. if (!gpiod_get_direction())
>
> So, this?
>
>         if (!gpiod_get_direction())
>                 bri->set_sda = set_sda_gpio_value;
>
> That looks like "if i couldn't the direction, then...", or?
>
> Comparing to plain numbers feels like magic values?

Hehe :)

> Maybe this should be named 'gpiod_is_direction_input()'?

Two statice inlines in <linux/gpio/consumer.h>
named

int gpiod_is output()
int gpiod_is_input()

should conform to Rusty Russell's API hierarchy.

Interested in fixing it, or should I?
I can almost ACK it before you write the patch.

Yours,
Linus Walleij
