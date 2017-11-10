From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ARM: sa1100: simpad: Correct I2C GPIO offsets
Date: Fri, 10 Nov 2017 16:17:26 +0100
Message-ID: <CAK8P3a3s-1mD+eVagHBr-YL-nAyr_QN2VZNo7qBn=FZCQfEEkg@mail.gmail.com>
References: <20171107201857.5752-1-linus.walleij@linaro.org>
 <20171110145038.i4jnqsctdzkfmoe5@ninjato> <CACRpkdangY192aFpSd1hVaie6A8kY+sASORhR_ncHLYLeUJMWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:55299 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752127AbdKJPR1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 10 Nov 2017 10:17:27 -0500
Received: by mail-oi0-f67.google.com with SMTP id i192so1522361oib.12
        for <linux-i2c@vger.kernel.org>; Fri, 10 Nov 2017 07:17:27 -0800 (PST)
In-Reply-To: <CACRpkdangY192aFpSd1hVaie6A8kY+sASORhR_ncHLYLeUJMWw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jochen Friedrich <jochen@scram.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>

On Fri, Nov 10, 2017 at 4:01 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Nov 10, 2017 at 3:50 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Applied to for-next, thanks!
>
> Thanks man.
>
>> This from checkpatch makes sense to me:
>>
>> ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit b2e63555592f ("i2c: gpio: Convert to use descriptors")'
>> #21:
>> commit b2e63555592f81331c8da3afaa607d8cf83e8138
>
> I never understood that thingie, I thought the check was
> only there in order to stop Fixes: tags from running wild.
> But feel free to cut it if you want.

I have this in my ~/.gitconfig:

[core]
        abbrev = 12
[alias]
        fixes = show --format='Fixes: %h (\"%s\")' -s

So 'git fixes b2e63555592f81331c8da3afaa607d8cf83e8138' produces
Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")

which I then copy into a changelog as the last line, or use only the reference.

     Arnd
