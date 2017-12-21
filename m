From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] i2c/ARM: davinci: Deep refactoring of I2C recovery
Date: Thu, 21 Dec 2017 23:30:04 +0100
Message-ID: <CACRpkdYhtrVKk36cza_RUysjp_ZYvT5D0nCGdG3K9=SGsdJNLA@mail.gmail.com>
References: <20171220121749.12064-1-linus.walleij@linaro.org> <CAK8P3a2+oa+yzAcpmB+YMuCYMxtFdYknETUtKShZX56G6m76Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35223 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbdLUWaF (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Dec 2017 17:30:05 -0500
Received: by mail-io0-f196.google.com with SMTP id 14so16154760iou.2
        for <linux-i2c@vger.kernel.org>; Thu, 21 Dec 2017 14:30:05 -0800 (PST)
In-Reply-To: <CAK8P3a2+oa+yzAcpmB+YMuCYMxtFdYknETUtKShZX56G6m76Gg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, arm-soc <arm@kernel.org>, Kevin Hilman <khilman@kernel.org>, Keerthy <j-keerthy@ti.com>, Sekhar Nori <nsekhar@ti.com>

On Thu, Dec 21, 2017 at 4:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Dec 20, 2017 at 1:17 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> Alter the DaVinci GPIO recovery fetch to use descriptors
>> all the way down into the board files.
>>
>> Cc: arm@kernel.org
>> Cc: Kevin Hilman <khilman@kernel.org>
>> Cc: Keerthy <j-keerthy@ti.com>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Acked-by: Sekhar Nori <nsekhar@ti.com>
>> Tested-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v1->v2:
>> - Change gpiochip name from gpio_davinci.0 to gpio_davinci, simply.
>
> This seems to clash with "i2c: davinci: Add PM Runtime Support", please
> rebase on top of v4.15-rc and resend.

Strange, where do you see this problem?

I just applied the patch on top of Wolfram's for-next
branch and it worked like a charm. It has the PM Runtime patch
underneath and all.

Yours,
Linus Walleij
