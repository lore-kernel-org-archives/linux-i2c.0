From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH] eeprom: at24: correctly set the size for at24mac402
Date: Mon, 4 Dec 2017 14:36:43 +0200
Message-ID: <cefc820d-5626-73ef-9b99-8c1d191e5ae7@microchip.com>
References: <20171127210613.9140-1-brgl@bgdev.pl>
 <CAHp75VfRhbfEKZJx8js-C+6r0h30SQs8duznT6AxCPiL4iMuaQ@mail.gmail.com>
 <CAMRc=Me3JJDvc6eDg0CX4K=JBJ=BXzJYt8DxzY79etPrNd-hPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:64647 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdLDMgr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 4 Dec 2017 07:36:47 -0500
In-Reply-To: <CAMRc=Me3JJDvc6eDg0CX4K=JBJ=BXzJYt8DxzY79etPrNd-hPQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable@vger.kernel.org



On 28.11.2017 12:44, Bartosz Golaszewski wrote:
> 2017-11-28 11:25 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
>> On Mon, Nov 27, 2017 at 11:06 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>> There's an ilog2() expansion in AT24_DEVICE_MAGIC() which rounds down
>>> the actual size of EUI-48 byte array in at24mac402 eeproms to 4 from 6,
>>> making it impossible to read it all.
>>>
>>> Fix it by manually adjusting the value in probe().
>>>
>>> This patch contains a temporary fix that is suitable for stable
>>> branches. Eventually we'll probably remove the call to ilog2() while
>>> converting the magic values to actual structs.
>>
>>> +       /*
>>> +        * REVISIT: the size of the EUI-48 byte array is 6 in at24mac402, while
>>> +        * the call to ilog2() in AT24_DEVICE_MAGIC() rounds it down to 4.
>>> +        *
>>> +        * Eventually we'll get rid of the magic values altoghether in favor of
>>> +        * real structs, but for now just manually set the right size.
>>> +        */
>>> +       if (chip.flags & AT24_FLAG_MAC && chip.byte_len == 4)
>>
>> I didn't check, but do we need to test for len == 4 at all?
>>
>>> +               chip.byte_len = 6;
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
> 
> Yes, because the fix is only relevant for at24mac402 whose MAC byte
> array is 6 bytes long, while the one in at24mac602 is 8 bytes and the
> driver doesn't truncate the byte_len for it.
>From my point of view, I think all chips in at24_ids[] array should be checked
about restrictions regarding the size truncation (especially the ones from the
initial commit: "2b7a5056a0a7ff17d5d2 i2c: New-style EEPROM driver using device IDs"
which introduces AT24_DEVICE_MAGIC() macro)  and if none of them has such restrictions
we should get rid of the ilog2() restrictions.

Just my 2 cents...
Claudiu

> 
> Thanks,
> Bartosz
> 
