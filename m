From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/7] I2C GPIO to use gpiolibs open drain
Date: Mon, 18 Sep 2017 13:15:55 +0200
Message-ID: <CAMuHMdWOt3e7eT4_wF8QJVM=aZNNcou+tGmjZOyvOziutedv_w@mail.gmail.com>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34342 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbdIRLP4 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 18 Sep 2017 07:15:56 -0400
Received: by mail-pg0-f68.google.com with SMTP id v82so79613pgb.1
        for <linux-i2c@vger.kernel.org>; Mon, 18 Sep 2017 04:15:56 -0700 (PDT)
In-Reply-To: <20170917093906.16325-1-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>

Hi Linus,

On Sun, Sep 17, 2017 at 11:38 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This augments the I2C GPIO driver to use open drain emulation
> or hardware support for open drain from the GPIO driver.
>
> This version layers Geert Uytterhoeven's idea to use explicit
> sda-gpios and scl-gpios for the GPIO lines, and strongly
> encourage the (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN) flags to be
> used in all device trees.
>
> We have collected ACKs from the ARM SoC maintainers and the
> MFD maintainer and are looking for testers to try this out.
>
> Geert Uytterhoeven (1):
>   dt-bindings: i2c: i2c-gpio: Add support for named gpios
>
> Linus Walleij (6):
>   i2c: gpio: Convert to use descriptors
>   gpio: Make it possible for consumers to enforce open drain
>   i2c: gpio: Enforce open drain through gpiolib
>   i2c: gpio: Augment all boardfiles to use open drain
>   i2c: gpio: Local vars in probe
>   i2c: gpio: Add support for named gpios in DT

Thanks for doing this, and picking up my patch.

I gave this a try on r8a7740/armadillo800eva.
Without DT changes, the GPIO i2c bus still works fine, but a warning is
printed, as expected:

    gpio-208 (sda): enforced open drain please flag it properly in
DT/ACPI DSDT/board file
    gpio-91 (scl): enforced open drain please flag it properly in
DT/ACPI DSDT/board file

After

    -  sda-gpios = <&pfc 208 GPIO_ACTIVE_HIGH>;
    -  scl-gpios = <&pfc 91 GPIO_ACTIVE_HIGH>;
    + sda-gpios = <&pfc 208 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
    + scl-gpios = <&pfc 91 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;

the warning is gone, and the GPIO i2c bus still works.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert
