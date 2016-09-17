From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Sat, 17 Sep 2016 20:59:54 +0200
Message-ID: <CAMpxmJWh+cyTBE_ABujUuu_Q1dkmbzsON1Z2xNYrhbbxxQeSMg@mail.gmail.com>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <20160917011952.GK5016@twins.programming.kicks-ass.net> <20160917101821.GB4753@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160917101821.GB4753@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ingo Molnar <mingo@redhat.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2016-09-17 12:18 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
> On Sat, Sep 17, 2016 at 03:19:52AM +0200, Peter Zijlstra wrote:
>> On Fri, Sep 16, 2016 at 06:02:41PM +0200, Bartosz Golaszewski wrote:
>> > If an I2C GPIO multiplexer is driven by a GPIO provided by an expander
>> > when there's a second expander using the same device driver on one of
>> > the I2C bus segments, lockdep prints a deadlock warning when trying to
>> > set the direction or the value of the GPIOs provided by the second
>> > expander.
>> >
>> > This series exports an already existing function from i2c-core as
>> > public API and reuses it in pca953x to pass a correct lock subclass
>> > to lockdep.
>>
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Oops, I overlooked that I need your ack as well :) Thanks!
>
>> > Note: if this series gets merged, I'll prepare follow-up patches for
>> > other expanders for which a similar problem could potentially occur.
>>
>> We can't push this annotation into the i2c core, can we? Since the mutex
>> is in driver specific code, not more generic...
>
> Afraid so.
>

Most i2c controlled GPIO expanders could potentially be converted to
using the regmap framework which unfortunately suffers from the same
locking issue in its current form.

I'm already working on adding adapter depth dependent subclasses for
i2c regmaps - maybe I'll be able to submit it for 4.9 next week.

Using regmap would allow us to drop the separate mutexes in each gpio
driver and instead use the regmap-internal locking.

Best regards,
Bartosz Golaszewski
