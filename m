From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/7] i2c: gpio: Convert to use descriptors
Date: Mon, 2 Oct 2017 03:05:22 +0200
Message-ID: <CACRpkdZ=BZHp3mjccUYaPTuMbXgwGSErvLprnp4j0H+7C5NYJQ@mail.gmail.com>
References: <20170917093906.16325-1-linus.walleij@linaro.org> <20170917093906.16325-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:54613 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdJBBFX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 1 Oct 2017 21:05:23 -0400
Received: by mail-io0-f171.google.com with SMTP id h66so3587445ioh.11
        for <linux-i2c@vger.kernel.org>; Sun, 01 Oct 2017 18:05:23 -0700 (PDT)
In-Reply-To: <20170917093906.16325-2-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Simtec Linux Team <linux@simtec.co.uk>, Vincent Sanders <vincent.sanders@collabora.co.uk>, Vincent Sanders <vince@kyllikki.org>, Teddy Wang <teddy.wang@siliconmotion.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS <linux-mips@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij <linus.walleij@linaro.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Lee Jones <lee.jones@linaro.org>, Guenter Roeck <linux@roeck-us.net>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Heiko Schocher <hs@denx.de>

On Sun, Sep 17, 2017 at 11:39 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> - The MFD Silicon Motion SM501 is a special case. It dynamically
>   spawns an I2C bus off the MFD using sm501_create_subdev().
>   We use an approach to dynamically create a machine descriptor
>   table and attach this to the "SM501-LOW" or "SM501-HIGH"
>   gpiochip. We use chip-local offsets to grab the right lines.
>   We can get rid of two local static inline helpers as part
>   of this refactoring.
(...)
> SM501 users: requesting Tested-by on this patch.

Paging Simtec (if it reaches anyone), Vincent Sanders,
Teddy Wang at Silicon Motion:

Does any of you have an "Anubis" board so you can test GPIO
on this board before/after this patch and see if it checks out right?

I guess it's this board:
http://www.simtec.co.uk/products/BBD20EUROA/

Does anyone know of a commercially obtainable product using
SM501 with reasonable mainline Linux support so I can test it myself?

Getting a bit desperate...

Yours,
Linus Walleij
