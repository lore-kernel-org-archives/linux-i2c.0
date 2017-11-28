From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] eeprom: at24: correctly set the size for at24mac402
Date: Tue, 28 Nov 2017 11:44:07 +0100
Message-ID: <CAMRc=Me3JJDvc6eDg0CX4K=JBJ=BXzJYt8DxzY79etPrNd-hPQ@mail.gmail.com>
References: <20171127210613.9140-1-brgl@bgdev.pl> <CAHp75VfRhbfEKZJx8js-C+6r0h30SQs8duznT6AxCPiL4iMuaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f174.google.com ([74.125.82.174]:42473 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932755AbdK1KoI (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Nov 2017 05:44:08 -0500
Received: by mail-ot0-f174.google.com with SMTP id 18so27010611oty.9
        for <linux-i2c@vger.kernel.org>; Tue, 28 Nov 2017 02:44:08 -0800 (PST)
In-Reply-To: <CAHp75VfRhbfEKZJx8js-C+6r0h30SQs8duznT6AxCPiL4iMuaQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Claudiu Beznea <Claudiu.Beznea@microchip.com>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable@vger.kernel.org

2017-11-28 11:25 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Mon, Nov 27, 2017 at 11:06 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> There's an ilog2() expansion in AT24_DEVICE_MAGIC() which rounds down
>> the actual size of EUI-48 byte array in at24mac402 eeproms to 4 from 6,
>> making it impossible to read it all.
>>
>> Fix it by manually adjusting the value in probe().
>>
>> This patch contains a temporary fix that is suitable for stable
>> branches. Eventually we'll probably remove the call to ilog2() while
>> converting the magic values to actual structs.
>
>> +       /*
>> +        * REVISIT: the size of the EUI-48 byte array is 6 in at24mac402, while
>> +        * the call to ilog2() in AT24_DEVICE_MAGIC() rounds it down to 4.
>> +        *
>> +        * Eventually we'll get rid of the magic values altoghether in favor of
>> +        * real structs, but for now just manually set the right size.
>> +        */
>> +       if (chip.flags & AT24_FLAG_MAC && chip.byte_len == 4)
>
> I didn't check, but do we need to test for len == 4 at all?
>
>> +               chip.byte_len = 6;
>
> --
> With Best Regards,
> Andy Shevchenko

Yes, because the fix is only relevant for at24mac402 whose MAC byte
array is 6 bytes long, while the one in at24mac602 is 8 bytes and the
driver doesn't truncate the byte_len for it.

Thanks,
Bartosz
