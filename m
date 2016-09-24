From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 4/4] gpio: pca953x: fix an incorrect lockdep warning
Date: Sat, 24 Sep 2016 16:26:08 +0200
Message-ID: <CAMuHMdUa_0xnOQRWNBz1rTpJk1kd+E9=37H=Zkbs7vAHJYjaog@mail.gmail.com>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <1474041765-17818-5-git-send-email-bgolaszewski@baylibre.com> <20160924091506.GE1434@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160924091506.GE1434@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Sep 24, 2016 at 11:15 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>>  drivers/gpio/gpio-pca953x.c | 2 ++
>>  1 file changed, 2 insertions(+)
>
> FYI, my code checkers found this in this driver:
>
>     SMATCH
> drivers/gpio/gpio-pca953x.c:562 pca953x_irq_pending() error: buffer overflow 'cur_stat' 5 <= 8191
> drivers/gpio/gpio-pca953x.c:573 pca953x_irq_pending() warn: buffer overflow 'old_stat' 5 <= 8191
>
> Didn't check further. I fixed a sparse warning, though.

I guess those lines are

        memcpy(old_stat, chip->irq_stat, NBANK(chip));

and

        memcpy(chip->irq_stat, cur_stat, NBANK(chip));

?

#define NBANK(chip) DIV_ROUND_UP(chip->gpio_chip.ngpio, BANK_SZ)

ngpio is u16, BANK_SZ is 8, so smatch assumes someone may set
ngpio to 65535. Which someone could do through driver_data.
But none of the predefined entries in pca953x_dt_ids[] does.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
