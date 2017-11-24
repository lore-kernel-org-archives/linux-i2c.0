From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] ARM: sa1100: simpad: Correct I2C GPIO offsets
Date: Fri, 24 Nov 2017 11:04:04 +0100
Message-ID: <CACRpkdbrcUOExjRmv5zN1hOvBAT18GOfRw9=5+e3d+MhS3q9+w@mail.gmail.com>
References: <20171107201857.5752-1-linus.walleij@linaro.org>
 <20171110145038.i4jnqsctdzkfmoe5@ninjato> <CACRpkdangY192aFpSd1hVaie6A8kY+sASORhR_ncHLYLeUJMWw@mail.gmail.com>
 <CAK8P3a3s-1mD+eVagHBr-YL-nAyr_QN2VZNo7qBn=FZCQfEEkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33785 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbdKXKEF (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 24 Nov 2017 05:04:05 -0500
Received: by mail-io0-f172.google.com with SMTP id i184so21662370ioa.0
        for <linux-i2c@vger.kernel.org>; Fri, 24 Nov 2017 02:04:05 -0800 (PST)
In-Reply-To: <CAK8P3a3s-1mD+eVagHBr-YL-nAyr_QN2VZNo7qBn=FZCQfEEkg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jochen Friedrich <jochen@scram.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>

On Fri, Nov 10, 2017 at 4:17 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> I have this in my ~/.gitconfig:
>
> [core]
>         abbrev = 12
> [alias]
>         fixes = show --format='Fixes: %h (\"%s\")' -s
>
> So 'git fixes b2e63555592f81331c8da3afaa607d8cf83e8138' produces
> Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
>
> which I then copy into a changelog as the last line, or use only the reference.

That's a neat trick.

I stole it :)

Yours,
Linus Walleij
