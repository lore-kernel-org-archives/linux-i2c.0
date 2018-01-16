From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: i2c: Include GPIO consumer header in main include
Date: Tue, 16 Jan 2018 10:47:29 +0100
Message-ID: <CACRpkdZr=fZSE3iNvfBBp0tZC+LftCr5YajqpoGQJB8ycDgDUw@mail.gmail.com>
References: <20171208133934.18038-1-linus.walleij@linaro.org> <20180115180303.pdax5amdj2rtytih@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:37517 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbeAPJra (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 Jan 2018 04:47:30 -0500
Received: by mail-it0-f67.google.com with SMTP id q8so4149514itb.2
        for <linux-i2c@vger.kernel.org>; Tue, 16 Jan 2018 01:47:30 -0800 (PST)
In-Reply-To: <20180115180303.pdax5amdj2rtytih@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Mon, Jan 15, 2018 at 7:03 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Fri, Dec 08, 2017 at 02:39:34PM +0100, Linus Walleij wrote:
>> It seems most users of <linux/i2c.h> pick up their
>> dependency of <linux/gpio/consumer.h> from other paths but
>> that is not a universal law, so include the header
>> explicitly so we have struct gpio_desc available.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> I still think drivers needing GPIO should include it explicitly.
> So, NAK until further arguments arrive...

What I mean is that they must be doing that currently since this
file uses struct gpio_desc (for recovert), else the build would fail.

So that is why I think it should be made explicit.

Another option is to just forward-declare struct gpio_desc;

Yours,
Linus Walleij
