From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/7] i2c: gpio: Convert to use descriptors
Date: Mon, 18 Sep 2017 21:00:18 +0200
Message-ID: <CACRpkdb8jDRZxuTUNoosLORqDbF4PP4RSHj3avtUqzvW2RwpmQ@mail.gmail.com>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-2-linus.walleij@linaro.org> <20170918083629.qn4dlrmk7ffipfsz@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:46758 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752772AbdIRTAX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 18 Sep 2017 15:00:23 -0400
Received: by mail-io0-f176.google.com with SMTP id d16so4566164ioj.3
        for <linux-i2c@vger.kernel.org>; Mon, 18 Sep 2017 12:00:22 -0700 (PDT)
In-Reply-To: <20170918083629.qn4dlrmk7ffipfsz@dell>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS <linux-mips@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Guenter Roeck <linux@roeck-us.net>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Heiko Schocher <hs@denx.de>

On Mon, Sep 18, 2017 at 10:36 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Sun, 17 Sep 2017, Linus Walleij wrote:

>> Lee: requesting ACK for Wolfram to take this patch.
>
> This ...
>
>> SM501 users: requesting Tested-by on this patch.
>
> ... loosely depends on this (until it doesn't).

Yeah I did my best to scout around the commit logs
to figure out who's been contributing to the SM501 and
using it, I hope someone will step up and test it.

Linus
