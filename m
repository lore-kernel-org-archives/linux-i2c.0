From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
Date: Fri, 15 Sep 2017 10:51:28 -0700
Message-ID: <CAOesGMitNqwjEHugsiwsmRAVSinUEv=eprJXHRRhSHUypm=b1A@mail.gmail.com>
References: <20170910214424.14945-1-linus.walleij@linaro.org> <20170910214424.14945-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34488 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbdIORvb (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 15 Sep 2017 13:51:31 -0400
Received: by mail-lf0-f68.google.com with SMTP id h80so1551250lfe.1
        for <linux-i2c@vger.kernel.org>; Fri, 15 Sep 2017 10:51:30 -0700 (PDT)
In-Reply-To: <20170910214424.14945-2-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-MIPS <linux-mips@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net, "arm@kernel.org" <arm@kernel.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Lee Jones <lee.jones@linaro.org>

On Sun, Sep 10, 2017 at 2:44 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
[...]
> Cc: arm@kernel.org
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: requesting ACK for Wolfram to take this patch.
> Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> Ralf (MIPS): requesting ACK for Wolfram to take this patch.
> Lee: requesting ACK for Wolfram to take this patch.

Acked-by: Olof Johansson <olof@lixom.net>

Wolfram: Same thing here, maybe this and the other patch can go on one
branch for merge in case of conflicts.


-Olof
