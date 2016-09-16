From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Fri, 16 Sep 2016 19:45:26 +0200
Message-ID: <deaa654a-9afc-eae6-6bc8-75f2c3960970@axentia.se>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <20160916172621.GA1426@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160916172621.GA1426@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2016-09-16 19:26, Wolfram Sang wrote:
> On Fri, Sep 16, 2016 at 06:02:41PM +0200, Bartosz Golaszewski wrote:
>> If an I2C GPIO multiplexer is driven by a GPIO provided by an expander
>> when there's a second expander using the same device driver on one of
>> the I2C bus segments, lockdep prints a deadlock warning when trying to
>> set the direction or the value of the GPIOs provided by the second
>> expander.
>>
>> This series exports an already existing function from i2c-core as
>> public API and reuses it in pca953x to pass a correct lock subclass
>> to lockdep.
> 
> Looks good from my POV, but will wait for Peter to comment.
> 
> If accepted, I'd think this should go via my I2C tree and I would like
> to ask Linus to ack patch 4. D'accord, everyone?

Since it is not clear if "Peter" is me or PeterZ (I suspect PeterZ...),
I'm just adding that it all looks fine by me as well, just to prevent
this from being held up by a misunderstanding.

It does unconditionally add a new function to i2c-core that is only
ever used if lockdep is enabled, but it is tiny and I'm not bothered
by that memory waste.

Cheers,
Peter
