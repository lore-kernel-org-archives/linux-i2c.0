From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Mon, 19 Sep 2016 10:14:13 +0200
Message-ID: <20160919081413.GR5016@twins.programming.kicks-ass.net>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <20160916172621.GA1426@katana>
 <deaa654a-9afc-eae6-6bc8-75f2c3960970@axentia.se>
 <20160916175842.GD1426@katana>
 <587cdb60-d7fe-3ab2-b635-02c5072e102e@axentia.se>
 <CAMpxmJUX8wszxhkoOyuqPeC8xgBjLXFRSWDSa0cOrJ92dUYX1g@mail.gmail.com>
 <CAMpxmJX3_ec44Z0UVTNqSDjmNq+Oe3sk+szLE-Nj7X4pztbywQ@mail.gmail.com>
 <2f7d572c-59e0-f584-9748-48a1a45a1a50@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2f7d572c-59e0-f584-9748-48a1a45a1a50@axentia.se>
Sender: linux-gpio-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ingo Molnar <mingo@redhat.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 19, 2016 at 10:01:49AM +0200, Peter Rosin wrote:
> Or, do what the i2c-mux code is doing and use an rt_mutex instead
> of an ordinary mutex. That way you are very sure to not get any
> lockdep splat ... at all. Ok, sorry, that was not a serious
> suggestion, but it would be a tad bit simpler to implement...

So I find it weird that people use rt_mutex as a locking primitive,
since its only that one lock that then does PI and all the other locks
that are related still create inversions.

In any case, since people have started doing this, adding lockdep
support for rt_mutex is on the todo _somewhere_, so don't expect that to
avoid splats forever.
