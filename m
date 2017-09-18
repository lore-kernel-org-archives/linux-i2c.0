From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 7/7] i2c: gpio: Add support for named gpios in DT
Date: Mon, 18 Sep 2017 21:09:39 +0200
Message-ID: <CACRpkdaYjQC9wTCvAJ-zEdX9fvBTRK5sazCd4L32zG3WkB1q4A@mail.gmail.com>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-8-linus.walleij@linaro.org> <CAMuHMdX+bx9pNEAFoBzfM7JhhH800u-HumpQYRsG3d5BNuduvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:53965 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdIRTJk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 18 Sep 2017 15:09:40 -0400
Received: by mail-io0-f175.google.com with SMTP id q11so4602163ioe.10
        for <linux-i2c@vger.kernel.org>; Mon, 18 Sep 2017 12:09:40 -0700 (PDT)
In-Reply-To: <CAMuHMdX+bx9pNEAFoBzfM7JhhH800u-HumpQYRsG3d5BNuduvg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>

On Mon, Sep 18, 2017 at 11:58 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

>> +       if (ret != -EPROBE_DEFER)
>> +               dev_err(dev, "error trying to get descriptor: %ld\n", ret);
>
> warning: format '%ld' expects argument of type 'long int', but
> argument 3 has type 'int' [-Wformat=]
>
> %d (0day busy?)

Bah haven't pushed it to the 0day builders yet.
I'll do that tonight so I can drown in the build errors.
:-D

Fixing it.

Yours,
Linus Walleij
