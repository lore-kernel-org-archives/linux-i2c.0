From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
Date: Mon, 18 Sep 2017 07:07:15 +0200
Message-ID: <59BF5483.9020403@denx.de>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <20170914093509.uwk47vt3wnm3rtqb@dell>
 <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:60489 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdIRFHV (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 18 Sep 2017 01:07:21 -0400
In-Reply-To: <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Ben Dooks <ben@fluff.org.uk>, Ville Syrjala <syrjala@sci.fi>, Magnus Damm <magnus.damm@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS <linux-mips@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net, "arm@kernel.org" <arm@kernel.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

Hello Linux,

Am 17.09.2017 um 00:25 schrieb Linus Walleij:
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

I am Sorry, I do not have the hardware anymore so no chance to test
it :-(

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
