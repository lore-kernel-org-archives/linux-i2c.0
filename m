From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/7 v3] I2C GPIO to use gpiolibs open drain
Date: Thu, 19 Oct 2017 16:37:21 +0200
Message-ID: <CACRpkdbjyDWFpb5p6kQTRm8Q=rM5L-Mhi4Q1rphEmOwgF6SHVg@mail.gmail.com>
References: <20171005110310.5900-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:47908 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbdJSOhW (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Oct 2017 10:37:22 -0400
Received: by mail-it0-f66.google.com with SMTP id p138so10458068itp.2
        for <linux-i2c@vger.kernel.org>; Thu, 19 Oct 2017 07:37:22 -0700 (PDT)
In-Reply-To: <20171005110310.5900-1-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

On Thu, Oct 5, 2017 at 1:03 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> Finalized this series and collected the ACKs.
>
> Wolfram: if not too late for v4.15, please carry this series.

Sorry to bother with this, it's fine if you don't have time
to do the administration for this refactoring for v4.15.

There is a git branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=gpio-descriptors-i2c

If you want I can make a branch without the revision
comments and prepare a pull request on whatever
-rc you prefer.

If you want I can merge it through the GPIO tree with
your ACK if you need to get offloaded.

I can also hold it back for v4.16, just that then I want to
merge the GPIO infrastructure patches to GPIO
already.

Yours,
Linus Walleij
