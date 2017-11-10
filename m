From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] ARM: sa1100: simpad: Correct I2C GPIO offsets
Date: Fri, 10 Nov 2017 16:01:38 +0100
Message-ID: <CACRpkdangY192aFpSd1hVaie6A8kY+sASORhR_ncHLYLeUJMWw@mail.gmail.com>
References: <20171107201857.5752-1-linus.walleij@linaro.org> <20171110145038.i4jnqsctdzkfmoe5@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:35768 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752918AbdKJPBk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 10 Nov 2017 10:01:40 -0500
Received: by mail-it0-f41.google.com with SMTP id u132so1983720ita.0
        for <linux-i2c@vger.kernel.org>; Fri, 10 Nov 2017 07:01:39 -0800 (PST)
In-Reply-To: <20171110145038.i4jnqsctdzkfmoe5@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jochen Friedrich <jochen@scram.de>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>

On Fri, Nov 10, 2017 at 3:50 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

> Applied to for-next, thanks!

Thanks man.

> This from checkpatch makes sense to me:
>
> ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit b2e63555592f ("i2c: gpio: Convert to use descriptors")'
> #21:
> commit b2e63555592f81331c8da3afaa607d8cf83e8138

I never understood that thingie, I thought the check was
only there in order to stop Fixes: tags from running wild.
But feel free to cut it if you want.

Yours,
Linus Walleij
