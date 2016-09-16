From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] gpio: pca953x: fix an incorrect lockdep warning
Date: Fri, 16 Sep 2016 18:04:36 +0200
Message-ID: <CAMpxmJUWJr7eEWDekSX=wwQ=vfuExfMDY1yFpnT8PW0vwMq0RQ@mail.gmail.com>
References: <1474035484-25134-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1474035484-25134-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

2016-09-16 16:18 GMT+02:00 Bartosz Golaszewski <bgolaszewski@baylibre.com>:
> If an I2C GPIO multiplexer is driven by a GPIO provided by an expander
> when there's a second expander using the same device driver on one of
> the I2C bus segments, lockdep prints a deadlock warning when trying to
> set the direction or the value of the GPIOs provided by the second
> expander.

[snip]

Superseded by v2.

Thanks,
Bartosz
