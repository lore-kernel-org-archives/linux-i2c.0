From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] misc: apds990x: move header file out of I2C realm
Date: Tue, 23 May 2017 00:33:39 +0200
Message-ID: <CACRpkdZ5CvmNuybrrOexYZ_9Cg1ojjNEybow+1pvUnhR0oX+UQ@mail.gmail.com>
References: <20170521204233.6745-1-wsa@the-dreams.de> <20170521204233.6745-2-wsa@the-dreams.de>
 <CAK8P3a2CfOPNe5KnSWb=xf_0YTtN6aQRwNthQXEDb9YgOrLMaw@mail.gmail.com>
 <20170522155649.wuf2rcdtywa7e667@ninjato> <CAK8P3a2xU4R=hq5fjOyZN=+cS1KVfwP9sFuwEB+g2jnTwcE6gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:35937 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbdEVWdl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 May 2017 18:33:41 -0400
Received: by mail-it0-f45.google.com with SMTP id o5so7562471ith.1
        for <linux-i2c@vger.kernel.org>; Mon, 22 May 2017 15:33:41 -0700 (PDT)
In-Reply-To: <CAK8P3a2xU4R=hq5fjOyZN=+cS1KVfwP9sFuwEB+g2jnTwcE6gw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Samu Onkalo <samu.onkalo@intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, May 22, 2017 at 11:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, May 22, 2017 at 5:56 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>>
>>> Should we also remove the drivers or move them into staging?
>>
>> I'd prefer to keep them. If they are needed again, DT conversion is
>> likely and easier than restarting from scratch. Guenter Roeck also
>> prefers to not unnecessarily annoy people who might have out-of-tree
>> board code. So, as long as they are not painful, let's keep them?
>
> The one reason I can think of for removing them is that we don't
> want ambient light sensor drivers in drivers/misc any more and
> instead of adding DT probing code would also expect new users to
> migrate to drivers/iio/light/, which already has drivers for
> apds9300 and apds9960 but not apds990x, as well as bh1750 and
> bh1780 but not bh1770.

This (apds990x) and bh1770 were added by Samu Onkalo
for Nokia's upstreaming efforts.

Samu, what are the hardware targets using this? Something that
has a userspace etc that we can test?

Like Nokia 900 or so?

Yours,
Linus Walleij
