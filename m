From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] i2c/ARM: davinci: Deep refactoring of I2C recovery
Date: Thu, 21 Dec 2017 16:36:22 +0100
Message-ID: <CAK8P3a2+oa+yzAcpmB+YMuCYMxtFdYknETUtKShZX56G6m76Gg@mail.gmail.com>
References: <20171220121749.12064-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:38824 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdLUPgX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Dec 2017 10:36:23 -0500
Received: by mail-ot0-f194.google.com with SMTP id a42so509980otj.5
        for <linux-i2c@vger.kernel.org>; Thu, 21 Dec 2017 07:36:23 -0800 (PST)
In-Reply-To: <20171220121749.12064-1-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, arm-soc <arm@kernel.org>, Kevin Hilman <khilman@kernel.org>, Keerthy <j-keerthy@ti.com>, Sekhar Nori <nsekhar@ti.com>

On Wed, Dec 20, 2017 at 1:17 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> Alter the DaVinci GPIO recovery fetch to use descriptors
> all the way down into the board files.
>
> Cc: arm@kernel.org
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> Tested-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Change gpiochip name from gpio_davinci.0 to gpio_davinci, simply.

This seems to clash with "i2c: davinci: Add PM Runtime Support", please
rebase on top of v4.15-rc and resend.

       Arnd
