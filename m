From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] gpio: pca953x: add a comment explaining the need for a
 lockdep subclass
Date: Thu, 29 Sep 2016 09:56:58 +0200
Message-ID: <CAMpxmJWmzju-gJ54irsqGb86i6THx4BXzqMAa=okqGAi=5bbrA@mail.gmail.com>
References: <1474883655-15824-1-git-send-email-bgolaszewski@baylibre.com>
 <1474883655-15824-2-git-send-email-bgolaszewski@baylibre.com>
 <20160926100030.GA5606@katana> <20160929060638.GB1524@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160929060638.GB1524@katana>
Sender: linux-gpio-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2016-09-29 8:06 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
> On Mon, Sep 26, 2016 at 12:00:30PM +0200, Wolfram Sang wrote:
>> On Mon, Sep 26, 2016 at 11:54:15AM +0200, Bartosz Golaszewski wrote:
>> > This is a follow-up to commit 559b46990e76 ("gpio: pca953x: fix an
>> > incorrect lockdep warning"). The reason for calling
>> > lockdep_set_subclass() in pca953x_probe() is not explained in
>> > the code.
>> >
>> > Add a comment describing the problem, partial solution and required
>> > future extensions.
>> >
>> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Acked-by: Wolfram Sang <wsa@the-dreams.de>
>>
>> Linus, because of dependencies, I should probably pick it up?
>
> Linus, ping!
>

Hi Wolfram,

this patch will not apply to the gpio tree. If Linus is too busy to
comment, maybe you could pick it up anyway - it doesn't change
anything in terms of functionality and it's better to have the code
commented when it's not obvious what it does.

Thanks,
Bartosz
