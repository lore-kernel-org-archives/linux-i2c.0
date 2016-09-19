From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Mon, 19 Sep 2016 10:01:49 +0200
Message-ID: <2f7d572c-59e0-f584-9748-48a1a45a1a50@axentia.se>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <20160916172621.GA1426@katana>
 <deaa654a-9afc-eae6-6bc8-75f2c3960970@axentia.se>
 <20160916175842.GD1426@katana>
 <587cdb60-d7fe-3ab2-b635-02c5072e102e@axentia.se>
 <CAMpxmJUX8wszxhkoOyuqPeC8xgBjLXFRSWDSa0cOrJ92dUYX1g@mail.gmail.com>
 <CAMpxmJX3_ec44Z0UVTNqSDjmNq+Oe3sk+szLE-Nj7X4pztbywQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMpxmJX3_ec44Z0UVTNqSDjmNq+Oe3sk+szLE-Nj7X4pztbywQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2016-09-18 21:45, Bartosz Golaszewski wrote:
> 2016-09-18 21:43 GMT+02:00 Bartosz Golaszewski <bgolaszewski@baylibre.com>:
>> 2016-09-18 10:52 GMT+02:00 Peter Rosin <peda@axentia.se>:
>>> On 2016-09-16 19:58, Wolfram Sang wrote:
>>>>
>>>> Same here. And if it prevents us from false positive lockdep reports, I
>>>> am all for fixing it.
>>>
>>> Except it doesn't, when I think some more about it...
>>>
>>> If you have two gpio-expanders on the same depth but on different i2c
>>> branches you still end up with a splat if one is used to control a mux
>>> to reach the other.
>>>
>>> The only way to solve it for good, that I see, is to have every instance
>>> of the gpio-expander mutex in its own class. That might lead to many
>>> lockdep classes but then again, how many gpio expanders could there be
>>> in a system? A dozen or two seems extreme, so maybe that is the correct
>>> approach anyway?
>>
>> Wouldn't it be enough to have a separate class for every base (as in:
>> not having any parent adapters) i2c adapter?
>>
> 
> Eeek -ESENTTOOEARLY
> 
> Of course not - since we could have two branches deeper on the tree
> with the same problem.
> 
> Nevermind my last e-mail.

Right, but you have a point, we can avoid some lockdep classes if
we work at it.

We could recognize that no gpio-expander can be involved with
muxing for a gpio-expander sitting on a root i2c adapter. That
much is trivially obvious.

That means that we could treat all gpio-expanders sitting
directly on a root i2c-adapter as we always have, just like
v1 (and v2, implicitly) do, but instead of putting all other
gpio-exanders in one lockdep class (as in v1) or in one lockdep
class per depth (as in v2), we put all other gpio-mutexes in
a lockdep class of their own.

Then we do not get any extra lockdep classes unless there are
i2c muxes, which is better.

But only i2c-mux-gpio can cause the recursion.

I think the theoretical minimal number of lockdep classes is to
create a new lockdep class for every i2c-mux-gpio instance.
gpio-expanders needing a mutex could walk up the adapter tree
looking for a i2c-mux-gpio and getting the lockdep class from
there. If the root i2c adapter is reached, use some default
lockdep class.

That would consolidate muxes from different gpio-expander
drivers into the one lockdep class. I don't know if that is
a big no-no? I guess that can be handled too with more code,
but it is starting to get messy...

Or, do what the i2c-mux code is doing and use an rt_mutex instead
of an ordinary mutex. That way you are very sure to not get any
lockdep splat ... at all. Ok, sorry, that was not a serious
suggestion, but it would be a tad bit simpler to implement...

Cheers,
Peter
