From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] misc: eeprom: implement compatible DT probing
Date: Tue, 20 Dec 2016 16:00:12 +0100
Message-ID: <CACRpkdYQBSk4ZeUTNbe7fNoQWFeKeOGimss4p5N7JyRR+kQuww@mail.gmail.com>
References: <1481219279-6982-1-git-send-email-linus.walleij@linaro.org>
 <95d9c739-8a69-b990-2840-b5381d54a99d@axentia.se> <CACRpkda+_0+y6U-gjt2ym45gi=KZ69hixMw6T=tAQGTGy5J37Q@mail.gmail.com>
 <806f55f3-3fed-572d-4859-7c7dc76c5e08@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34756 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757690AbcLTPAR (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 20 Dec 2016 10:00:17 -0500
Received: by mail-qt0-f182.google.com with SMTP id n6so179097287qtd.1
        for <linux-i2c@vger.kernel.org>; Tue, 20 Dec 2016 07:00:16 -0800 (PST)
In-Reply-To: <806f55f3-3fed-572d-4859-7c7dc76c5e08@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Dec 9, 2016 at 6:48 AM, Peter Rosin <peda@axentia.se> wrote:
> On 2016-12-09 00:32, Linus Walleij wrote:

>> Bah I probably just screwed up syntactically and now worked around
>> a non-existing problem. I will try as you suggest, just "vendor,type"
>> and see if it works. It probably does.

(It does)

> But it is a bit strange. Grepping for compatible.*24c finds quite
> a few instances of "bad" compatible strings.
>
> Many on the patterns at,24c256 and at24,24c256 (should be probably
> be atmel,24c256) but also a few atmel,at24c16 and atmel,at24c128b.
> I don't understand how those last ones ever worked, if it is not
> working for you? Especially those with the trailing "b". WTF?

Those are the erroneous device trees that I copied as inspiration
instead of looking directly at the bindings.

Yours,
Linus Walleij
