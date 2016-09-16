From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] gpio: pca953x: fix an incorrect lockdep warning
Date: Fri, 16 Sep 2016 16:40:27 +0200
Message-ID: <CAMpxmJXq+vxnjVxhiGWdEBmFBSdvp0JgRFxW6Tbv5ZyHhD+LgA@mail.gmail.com>
References: <1474035484-25134-1-git-send-email-bgolaszewski@baylibre.com> <d1f3c65c-0294-19fc-8de5-fa3e79a9f505@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:38366 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754878AbcIPOk3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Sep 2016 10:40:29 -0400
Received: by mail-it0-f42.google.com with SMTP id n143so18166467ita.1
        for <linux-i2c@vger.kernel.org>; Fri, 16 Sep 2016 07:40:28 -0700 (PDT)
In-Reply-To: <d1f3c65c-0294-19fc-8de5-fa3e79a9f505@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

2016-09-16 16:33 GMT+02:00 Peter Rosin <peda@axentia.se>:
>
> If this is to be fixed this even for crazy setups where the pattern is
> repeated for more levels, you can look into drivers/i2c/i2c-core.c
> i2c_adapter_depth() and how it's used (i.e. for this exact purpose).
> Maybe it's time to export that function?
>

Hi Peter,

thanks for the heads up. I was not aware of this function. Lockdep
only allows us to specify up to 8 subclasses, but I can't possibly
imagine a setup where more would be needed. I'll submit a series
exporting this function and using it in pca953x.

Best regards,
Bartosz Golaszewski
