From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
Date: Sat, 16 Sep 2017 17:14:42 -0700
Message-ID: <7f67dfa0-31da-0967-0929-28ae105bb2b5@roeck-us.net>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <20170914093509.uwk47vt3wnm3rtqb@dell>
 <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38729 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdIQAOp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 16 Sep 2017 20:14:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id q76so2952988pfq.5
        for <linux-i2c@vger.kernel.org>; Sat, 16 Sep 2017 17:14:45 -0700 (PDT)
In-Reply-To: <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ben Dooks <ben@fluff.org.uk>, Ville Syrjala <syrjala@sci.fi>, Magnus Damm <magnus.damm@gmail.com>, Heiko Schocher <hs@denx.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS <linux-mips@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net, "arm@kernel.org" <arm@kernel.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On 09/16/2017 03:25 PM, Linus Walleij wrote:
> On Thu, Sep 14, 2017 at 11:35 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
>>>   drivers/mfd/sm501.c                          |  49 +++++-----
>>
>> I'd prefer for this to be applied with a Tested-by.  I appreciate that
>> this is an old driver, but can you attempt to contact one of the
>> authors or someone else who might have hardware please?
> 
> For SM501 specifically I guess.
> 
> OK makes sense as it is the most invasive one, paging around...
> 
> Ben, Ville, Magnus, Heiko, Guenther: is one of you still using this
> hardware so you can test the patch set?
> 

qemu supports it. I _think_ my commit for this driver was to fix a warning
I saw when running some qemu test. Unfortunately, I have no idea how that
message was triggered in my tests, or in other words which qemu machine
actually uses it. I'll try to find out, but no promises.

Guenter
