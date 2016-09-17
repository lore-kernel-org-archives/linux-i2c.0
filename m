From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Sat, 17 Sep 2016 03:19:52 +0200
Message-ID: <20160917011952.GK5016@twins.programming.kicks-ass.net>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ingo Molnar <mingo@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 16, 2016 at 06:02:41PM +0200, Bartosz Golaszewski wrote:
> If an I2C GPIO multiplexer is driven by a GPIO provided by an expander
> when there's a second expander using the same device driver on one of
> the I2C bus segments, lockdep prints a deadlock warning when trying to
> set the direction or the value of the GPIOs provided by the second
> expander.
> 
> This series exports an already existing function from i2c-core as
> public API and reuses it in pca953x to pass a correct lock subclass
> to lockdep.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Note: if this series gets merged, I'll prepare follow-up patches for
> other expanders for which a similar problem could potentially occur.

We can't push this annotation into the i2c core, can we? Since the mutex
is in driver specific code, not more generic...
