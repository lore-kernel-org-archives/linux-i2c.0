From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
Date: Mon, 11 Sep 2017 13:27:59 +0200
Message-ID: <CAMuHMdXabvax2Wru8j+MC4X5F+z5hoUo1tEbX+zn2AUW6QENVA@mail.gmail.com>
References: <20170910214424.14945-1-linus.walleij@linaro.org> <20170910214424.14945-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36383 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdIKL2A (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Sep 2017 07:28:00 -0400
Received: by mail-pg0-f65.google.com with SMTP id d8so4486265pgt.3
        for <linux-i2c@vger.kernel.org>; Mon, 11 Sep 2017 04:28:00 -0700 (PDT)
In-Reply-To: <20170910214424.14945-2-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Steven Miao <realmz6@gmail.com>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>, Ralf Baechle <ralf@linux-mips.org>, "arm@kernel.org" <arm@kernel.org>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Linus,

On Sun, Sep 10, 2017 at 11:44 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This converts the GPIO-based I2C-driver to using GPIO
> descriptors instead of the old global numberspace-based
> GPIO interface. We:
>
> - Convert the driver to unconditionally grab two GPIOs
>   from the device by index 0 (SDA) and 1 (SCL) which
>   will work fine with device tree and descriptor tables.
>   The existing device trees will continue to work just
>   like before, but without any roundtrip through the
>   global numberspace.

FYI, I recently posted a series to deprecate (at least for DT) this error
prone indexing, in favor of using named GPIOs:

    [PATCH/RFC 0/3] i2c: gpio: Add support for named gpios in DT
    http://www.spinics.net/lists/devicetree/msg191936.html

Gr{oetje,eeting}s,

                        Geert
