From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/7 v3] I2C GPIO to use gpiolibs open drain
Date: Mon, 30 Oct 2017 08:52:18 +0100
Message-ID: <CACRpkdbX6O527z3B-jYUFQ-udwsQnD0iLPaTAwcj-1r24KR=Lw@mail.gmail.com>
References: <20171005110310.5900-1-linus.walleij@linaro.org>
 <CACRpkdbjyDWFpb5p6kQTRm8Q=rM5L-Mhi4Q1rphEmOwgF6SHVg@mail.gmail.com>
 <20171027134918.uclfmwgmukshwi5z@ninjato> <20171030002808.ytay6nvqose4jspr@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:47944 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbdJ3HwU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 30 Oct 2017 03:52:20 -0400
Received: by mail-io0-f196.google.com with SMTP id h70so25113689ioi.4
        for <linux-i2c@vger.kernel.org>; Mon, 30 Oct 2017 00:52:19 -0700 (PDT)
In-Reply-To: <20171030002808.ytay6nvqose4jspr@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Mon, Oct 30, 2017 at 1:28 AM, Wolfram Sang <wsa@the-dreams.de> wrote:

>> don't get ACKs for Blackfin these days, but there is still some MIPS and
>> MFD ack missing? Can you ping them again?
>
> Update: Lee's ack is already collected and Ralf acked V1 of this series.
> Did you miss to include it in v3? Or did the patch change so much?

Their ACKs are on the relevant patches on the git branch AFAICT
but if you want I can resend the patches too.

BTW my branch contains my changelogs as well,
so it should be edited to remove those (below the ---)
for convenience I also published a branch without them:
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-wolfram

If you want to pull from my tree, take this :)

Yours,
Linus Walleij
