From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 4/7] i2c: gpio: Augment all boardfiles to use open drain
Date: Fri, 06 Oct 2017 22:52:50 +0200
Message-ID: <87bmlkf17h.fsf@belgarion.home>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
        <20170917093906.16325-5-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:17419 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbdJFUwy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 6 Oct 2017 16:52:54 -0400
In-Reply-To: <20170917093906.16325-5-linus.walleij@linaro.org> (Linus
        Walleij's message of "Sun, 17 Sep 2017 11:39:03 +0200")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, Steven Miao <realmz6@gmail.com>, adi-buildroot-devel@lists.sourceforge.net, Ralf Baechle <ralf@linux-mips.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> We now handle the open drain mode internally in the I2C GPIO
> driver, but we will get warnings from the gpiolib that we
> override the default mode of the line so it becomes open
> drain.
>
> We can fix all in-kernel users by simply passing the right
> flag along in the descriptor table, and we already touched
> all of these files in the series so let's just tidy it up.
>
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Collected ACKs.
>
> Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> Ralf (MIPS): requesting ACK for Wolfram to take this patch.
For mach-pxa:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.
