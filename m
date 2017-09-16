From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
Date: Sun, 17 Sep 2017 00:25:12 +0200
Message-ID: <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org> <20170914093509.uwk47vt3wnm3rtqb@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:54782 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbdIPWZN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 16 Sep 2017 18:25:13 -0400
Received: by mail-it0-f42.google.com with SMTP id e134so6337139ite.3
        for <linux-i2c@vger.kernel.org>; Sat, 16 Sep 2017 15:25:13 -0700 (PDT)
In-Reply-To: <20170914093509.uwk47vt3wnm3rtqb@dell>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Ben Dooks <ben@fluff.org.uk>, Ville Syrjala <syrjala@sci.fi>, Magnus Damm <magnus.damm@gmail.com>, Heiko Schocher <hs@denx.de>, Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS <linux-mips@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net, "arm@kernel.org" <arm@kernel.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On Thu, Sep 14, 2017 at 11:35 AM, Lee Jones <lee.jones@linaro.org> wrote:

>>  drivers/mfd/sm501.c                          |  49 +++++-----
>
> I'd prefer for this to be applied with a Tested-by.  I appreciate that
> this is an old driver, but can you attempt to contact one of the
> authors or someone else who might have hardware please?

For SM501 specifically I guess.

OK makes sense as it is the most invasive one, paging around...

Ben, Ville, Magnus, Heiko, Guenther: is one of you still using this
hardware so you can test the patch set?

Yours,
Linus Walleij
