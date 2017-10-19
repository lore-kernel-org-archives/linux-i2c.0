From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/5] i2c: gpio: Augment all boardfiles to use open drain
Date: Thu, 19 Oct 2017 17:48:37 +0200
Message-ID: <CAK8P3a30U3pSEPqQtVN7MwE4dOC+Rj___adSEAebSBuX_2KadA@mail.gmail.com>
References: <20170910214424.14945-1-linus.walleij@linaro.org> <20170910214424.14945-5-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43551 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753458AbdJSPsi (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Oct 2017 11:48:38 -0400
Received: by mail-oi0-f68.google.com with SMTP id c77so15632691oig.0
        for <linux-i2c@vger.kernel.org>; Thu, 19 Oct 2017 08:48:38 -0700 (PDT)
In-Reply-To: <20170910214424.14945-5-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net, arm-soc <arm@kernel.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Lee Jones <lee.jones@linaro.org>

On Sun, Sep 10, 2017 at 11:44 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> We now handle the open drain mode internally in the I2C GPIO
> driver, but we will get warnings from the gpiolib that we
> override the default mode of the line so it becomes open
> drain.
>
> We can fix all in-kernel users by simply passing the right
> flag along in the descriptor table, and we already touched
> all of these files in the series so let's just tidy it up.
>
> Cc: arm@kernel.org
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: requesting ACK for Wolfram to take this patch.

Acked-by: Arnd Bergmann <arnd@arndb.de>
