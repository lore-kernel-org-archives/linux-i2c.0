From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 4/4] gpio: pca953x: fix an incorrect lockdep warning
Date: Fri, 23 Sep 2016 10:10:57 +0200
Message-ID: <CACRpkdbYgetpYntO6KsVLh1n_7DU+1AD3AwVVkmV5ud5A6Q31g@mail.gmail.com>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <1474041765-17818-5-git-send-email-bgolaszewski@baylibre.com> <20160921054521.GB1484@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160921054521.GB1484@katana>
Sender: linux-gpio-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 21, 2016 at 7:45 AM, Wolfram Sang <wsa@the-dreams.de> wrote:

>> In order to get rid of the warning, retrieve the adapter nesting depth
>> and use it as lockdep subclass for chip->i2c_lock.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Linus, we'd like that in 4.9. Can I get your ack for the gpio part?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Sorry for not attending quick enough, I was down in the
block layer.

Yours,
Linus Walleij
