From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] misc: eeprom: implement compatible DT probing
Date: Fri, 9 Dec 2016 00:32:28 +0100
Message-ID: <CACRpkda+_0+y6U-gjt2ym45gi=KZ69hixMw6T=tAQGTGy5J37Q@mail.gmail.com>
References: <1481219279-6982-1-git-send-email-linus.walleij@linaro.org> <95d9c739-8a69-b990-2840-b5381d54a99d@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:32959 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbcLHXc3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 8 Dec 2016 18:32:29 -0500
Received: by mail-qt0-f180.google.com with SMTP id p16so1586371qta.0
        for <linux-i2c@vger.kernel.org>; Thu, 08 Dec 2016 15:32:29 -0800 (PST)
In-Reply-To: <95d9c739-8a69-b990-2840-b5381d54a99d@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Dec 8, 2016 at 7:23 PM, Peter Rosin <peda@axentia.se> wrote:
> On 2016-12-08 18:47, Linus Walleij wrote:

>> Before this patch, the following device tree node does not probe,
>> which might be considered a bug:
>>
>> eeprom@52 {
>>       compatible = "atmel,at24c128";
>
> The way I read it, that should be "atmel,24c128", i.e. w/o the "at" prefix.
(...)
> and then lists the compatibles you have added to the match table (but you
> have this extra "at" prefix for the atmel manufacturer).
>
> The way I read the above, you are free to use any manufacturer and still
> have it work, and indeed, I have success with this node:
>
>         eeprom@50 {
>                 compatible = "nxp,24c02";
>                 reg = <0x50>;
>                 pagesize = <16>;
>         };
>
> I fear that your patch will regress this matching on the wildcard
> manufacturer. I haven't tested that though, but there are enough
> question marks anyway...

Bah I probably just screwed up syntactically and now worked around
a non-existing problem. I will try as you suggest, just "vendor,type"
and see if it works. It probably does.

Some days I feel just utterly stupid. Sorry for the fuzz.

Wolfram: ignore the patch for now.

Yours,
Linus Walleij
