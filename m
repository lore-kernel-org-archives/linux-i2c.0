From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Sun, 18 Sep 2016 21:43:10 +0200
Message-ID: <CAMpxmJUX8wszxhkoOyuqPeC8xgBjLXFRSWDSa0cOrJ92dUYX1g@mail.gmail.com>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <20160916172621.GA1426@katana> <deaa654a-9afc-eae6-6bc8-75f2c3960970@axentia.se>
 <20160916175842.GD1426@katana> <587cdb60-d7fe-3ab2-b635-02c5072e102e@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <587cdb60-d7fe-3ab2-b635-02c5072e102e@axentia.se>
Sender: linux-gpio-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2016-09-18 10:52 GMT+02:00 Peter Rosin <peda@axentia.se>:
> On 2016-09-16 19:58, Wolfram Sang wrote:
>>
>> Same here. And if it prevents us from false positive lockdep reports, I
>> am all for fixing it.
>
> Except it doesn't, when I think some more about it...
>
> If you have two gpio-expanders on the same depth but on different i2c
> branches you still end up with a splat if one is used to control a mux
> to reach the other.
>
> The only way to solve it for good, that I see, is to have every instance
> of the gpio-expander mutex in its own class. That might lead to many
> lockdep classes but then again, how many gpio expanders could there be
> in a system? A dozen or two seems extreme, so maybe that is the correct
> approach anyway?

Wouldn't it be enough to have a separate class for every base (as in:
not having any parent adapters) i2c adapter?

Best regards,
Bartosz Golaszewski
