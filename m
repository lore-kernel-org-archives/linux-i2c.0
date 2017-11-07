From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: sa1100: simpad: Correct I2C GPIO offsets
Date: Tue, 7 Nov 2017 21:13:12 +0100
Message-ID: <CACRpkdae=tTxSB2BX14j=_7y0Bz4B-EOEmwWEZNPaZdMnPtq3g@mail.gmail.com>
References: <20171107151703.3847-1-linus.walleij@linaro.org> <eee254f2-6c34-0cc3-85e6-a3b70100021c@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:56474 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932356AbdKGUNN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 7 Nov 2017 15:13:13 -0500
Received: by mail-io0-f170.google.com with SMTP id m81so3472095ioi.13
        for <linux-i2c@vger.kernel.org>; Tue, 07 Nov 2017 12:13:13 -0800 (PST)
In-Reply-To: <eee254f2-6c34-0cc3-85e6-a3b70100021c@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jochen Friedrich <jochen@scram.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>

On Tue, Nov 7, 2017 at 4:25 PM, Peter Rosin <peda@axentia.se> wrote:

>> arch/arm/mach-sa1100/include/mach/SA-1100.h it is
>> defined as:
>
> I suspect that you had a line here that started with a hashmark
> (#) and that the whole line got eaten by some git tool during
> a rebase or something. Don't ever start lines with # in the git
> commit message. It will simply disappear somewhere at some point.

Darn why didn't I think of that. I even knew it.

OK I resend a v2 with proper changelog.

Thanks,
Linus Walleij
