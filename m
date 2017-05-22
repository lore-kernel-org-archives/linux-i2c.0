From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] misc: apds990x: move header file out of I2C realm
Date: Mon, 22 May 2017 23:49:42 +0200
Message-ID: <CAK8P3a2xU4R=hq5fjOyZN=+cS1KVfwP9sFuwEB+g2jnTwcE6gw@mail.gmail.com>
References: <20170521204233.6745-1-wsa@the-dreams.de> <20170521204233.6745-2-wsa@the-dreams.de>
 <CAK8P3a2CfOPNe5KnSWb=xf_0YTtN6aQRwNthQXEDb9YgOrLMaw@mail.gmail.com> <20170522155649.wuf2rcdtywa7e667@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34276 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934097AbdEVVtn (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 May 2017 17:49:43 -0400
In-Reply-To: <20170522155649.wuf2rcdtywa7e667@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On Mon, May 22, 2017 at 5:56 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Should we also remove the drivers or move them into staging?
>
> I'd prefer to keep them. If they are needed again, DT conversion is
> likely and easier than restarting from scratch. Guenter Roeck also
> prefers to not unnecessarily annoy people who might have out-of-tree
> board code. So, as long as they are not painful, let's keep them?

The one reason I can think of for removing them is that we don't
want ambient light sensor drivers in drivers/misc any more and
instead of adding DT probing code would also expect new users to
migrate to drivers/iio/light/, which already has drivers for
apds9300 and apds9960 but not apds990x, as well as bh1750 and
bh1780 but not bh1770.

       Arnd
