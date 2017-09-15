From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
Date: Fri, 15 Sep 2017 10:57:24 -0700
Message-ID: <CAOesGMi5Jx+hDGtUV_3sE8-7Rc+KronFyUmRzT55hZuRn28OPQ@mail.gmail.com>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org> <CAOesGMitNqwjEHugsiwsmRAVSinUEv=eprJXHRRhSHUypm=b1A@mail.gmail.com>
 <20170915175439.izhfpx2ztep4evet@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35299 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdIOR51 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 15 Sep 2017 13:57:27 -0400
Received: by mail-lf0-f66.google.com with SMTP id c8so1553638lfe.2
        for <linux-i2c@vger.kernel.org>; Fri, 15 Sep 2017 10:57:26 -0700 (PDT)
In-Reply-To: <20170915175439.izhfpx2ztep4evet@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-MIPS <linux-mips@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net, "arm@kernel.org" <arm@kernel.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Lee Jones <lee.jones@linaro.org>

On Fri, Sep 15, 2017 at 10:54 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Fri, Sep 15, 2017 at 10:51:28AM -0700, Olof Johansson wrote:
>> On Sun, Sep 10, 2017 at 2:44 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> [...]
>> > Cc: arm@kernel.org
>> > Cc: Steven Miao <realmz6@gmail.com>
>> > Cc: Ralf Baechle <ralf@linux-mips.org>
>> > Cc: Lee Jones <lee.jones@linaro.org>
>> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> > ---
>> > ARM SoC folks: requesting ACK for Wolfram to take this patch.
>> > Steven (Blackfin): requesting ACK for Wolfram to take this patch.
>> > Ralf (MIPS): requesting ACK for Wolfram to take this patch.
>> > Lee: requesting ACK for Wolfram to take this patch.
>>
>> Acked-by: Olof Johansson <olof@lixom.net>
>>
>> Wolfram: Same thing here, maybe this and the other patch can go on one
>> branch for merge in case of conflicts.
>
> Yes, I am fine with picking all these up. However, we already found out
> there needs to be a V2 because Geert had another series cleaning up the
> i2c-gpio driver and it was decided to merge those two series.

Yep, that approach makes sense. I suspect the arm mach pieces will
still look the same so the ack can stay in that case.


-Olof
