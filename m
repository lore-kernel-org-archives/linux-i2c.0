From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6] eeprom: at24: Add OF device ID table
Date: Tue, 17 Oct 2017 16:43:14 -0500
Message-ID: <CABGGiswNP=PrwpuqSH-Lqz6tBzrNUpZYCEzFHOPmZSWqsn3zaA@mail.gmail.com>
References: <20171001104948.21663-1-javierm@redhat.com> <20171017214040.kak3kpvh6tunjjfp@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754653AbdJQVnh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 17 Oct 2017 17:43:37 -0400
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com [209.85.128.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB35D21924
        for <linux-i2c@vger.kernel.org>; Tue, 17 Oct 2017 21:43:36 +0000 (UTC)
Received: by mail-wr0-f176.google.com with SMTP id l1so3116973wrc.3
        for <linux-i2c@vger.kernel.org>; Tue, 17 Oct 2017 14:43:36 -0700 (PDT)
In-Reply-To: <20171017214040.kak3kpvh6tunjjfp@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Tue, Oct 17, 2017 at 4:40 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Hi,
>
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

It is used by arch/powerpc/boot/dts/mpc8349emitx.dts.

Rob
