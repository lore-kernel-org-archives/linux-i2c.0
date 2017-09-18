From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
Date: Mon, 18 Sep 2017 06:21:20 -0700
Message-ID: <0c3eaa74-6e94-825c-5830-2cfc71efaf4f@roeck-us.net>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <20170914093509.uwk47vt3wnm3rtqb@dell>
 <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
 <59BF5483.9020403@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38159 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbdIRNVZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 18 Sep 2017 09:21:25 -0400
Received: by mail-pg0-f67.google.com with SMTP id m30so228289pgn.5
        for <linux-i2c@vger.kernel.org>; Mon, 18 Sep 2017 06:21:25 -0700 (PDT)
In-Reply-To: <59BF5483.9020403@denx.de>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: hs@denx.de, Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Ben Dooks <ben@fluff.org.uk>, Ville Syrjala <syrjala@sci.fi>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS <linux-mips@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net, "arm@kernel.org" <arm@kernel.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On 09/17/2017 10:07 PM, Heiko Schocher wrote:
> Hello Linux,
> 
> Am 17.09.2017 um 00:25 schrieb Linus Walleij:
>> On Thu, Sep 14, 2017 at 11:35 AM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>>>>   drivers/mfd/sm501.c                          |  49 +++++-----
>>>
>>> I'd prefer for this to be applied with a Tested-by.  I appreciate that
>>> this is an old driver, but can you attempt to contact one of the
>>> authors or someone else who might have hardware please?
>>
>> For SM501 specifically I guess.
>>
>> OK makes sense as it is the most invasive one, paging around...
>>
>> Ben, Ville, Magnus, Heiko, Guenther: is one of you still using this
>> hardware so you can test the patch set?
> 
> I am Sorry, I do not have the hardware anymore so no chance to test
> it :-(
> 

I had a look into the kernel and qemu code. The only machine actually using
it is an arm system names Anubis, which qemu does not support. No help here
either, sorry.

Guenter
