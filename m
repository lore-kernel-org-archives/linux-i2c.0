From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6] eeprom: at24: Add OF device ID table
Date: Wed, 18 Oct 2017 08:39:39 +0200
Message-ID: <CAMuHMdVo8_jV0RmWSS=MhF07hwFH68W6vMtj3Uts3NmNHbiqoQ@mail.gmail.com>
References: <20171001104948.21663-1-javierm@redhat.com> <20171017214040.kak3kpvh6tunjjfp@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:55838 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932346AbdJRGjl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 18 Oct 2017 02:39:41 -0400
In-Reply-To: <20171017214040.kak3kpvh6tunjjfp@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Andy Shevchenko <andy.shevchenko@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>

Hi Wolfram,

On Tue, Oct 17, 2017 at 11:40 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> +     {
>> +             .compatible = "atmel,spd",
>> +             .data = (void *)AT24_DEVICE_MAGIC(2048 / 8,
>> +                             AT24_FLAG_READONLY | AT24_FLAG_IRUGO)
>> +     },
>
> checkpatch reported this one as un-documented. And come to think of it,
> since this is solely for EEPROMs on RAM modules, I think we can drop a
> DT binding for it. Could you agree? I can do it locally, no need to
> resend. I'll do HW testing later, but wanted to check on your opinion
> already.

Why?

No one has placeholders for memory modules in DT?
In addition, I can imagine a DT overlay for a memory module, adding the
memory node and the EEPROM.

Gr{oetje,eeting}s,

                        Geert
