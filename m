From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Tue, 20 Sep 2016 14:32:25 +0200
Message-ID: <CAMpxmJXkHaziKA1XtgQp0965RKUUCDTtLPm__=BdfbstQdc+kQ@mail.gmail.com>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <20160916172621.GA1426@katana> <deaa654a-9afc-eae6-6bc8-75f2c3960970@axentia.se>
 <20160916175842.GD1426@katana> <587cdb60-d7fe-3ab2-b635-02c5072e102e@axentia.se>
 <CAMpxmJUX8wszxhkoOyuqPeC8xgBjLXFRSWDSa0cOrJ92dUYX1g@mail.gmail.com>
 <CAMpxmJX3_ec44Z0UVTNqSDjmNq+Oe3sk+szLE-Nj7X4pztbywQ@mail.gmail.com>
 <2f7d572c-59e0-f584-9748-48a1a45a1a50@axentia.se> <20160919081413.GR5016@twins.programming.kicks-ass.net>
 <88940f9a-79bf-6c88-8e1d-f76f32dda04a@axentia.se> <20160919090358.GU5016@twins.programming.kicks-ass.net>
 <e4b4c894-4913-b00f-0a9d-243258f2699b@axentia.se> <CAMpxmJVNbsZewcui_WL0aZi3e4Q52=qHxGkm=w5EAr49YAqyaw@mail.gmail.com>
 <6e174c17-584f-580d-083a-94dab2f588bd@axentia.se> <CAMuHMdX6otYLuYm9x4BNm-U3gHn5Y_JwBUm5qagWLOU0ucRmcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdX6otYLuYm9x4BNm-U3gHn5Y_JwBUm5qagWLOU0ucRmcQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Rosin <peda@axentia.se>, Peter Zijlstra <peterz@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ingo Molnar <mingo@redhat.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2016-09-20 13:30 GMT+02:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> On Tue, Sep 20, 2016 at 12:48 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2016-09-20 12:07, Bartosz Golaszewski wrote:
>>> I feel like it's just wrong to set an arbitrary limit on the number of
>>> i2c branches - and this is what the result of this approach would be.
>>
>> What arbitrary limit would that be? The number of lockdep classes
>> can't be *that* limited? Or?
>>
>> I mean one lockdep class per root adapter and one subclass within that
>> class per mux level doesn't sound too bad. How many root adapters do
>> we need to design for?
>
> 'git grep -c i2c@ -- "*dts*"' told me exynos7 has 12 i2c interfaces.
> And as long as I have gpios (pcf8574?), I can add more using i2c-gpio.
> Hence the upper limit is infinity.
>

Agreed. If you add to that dynamic i2c adapters like hid-cp2112 or
greybus-i2c then it makes infinity plus some more.

Best regards,
Bartosz Golaszewski
