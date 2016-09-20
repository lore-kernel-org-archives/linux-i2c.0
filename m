From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Tue, 20 Sep 2016 17:33:29 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609201725550.6905@nanos>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com> <20160916172621.GA1426@katana> <deaa654a-9afc-eae6-6bc8-75f2c3960970@axentia.se> <20160916175842.GD1426@katana> <587cdb60-d7fe-3ab2-b635-02c5072e102e@axentia.se>
 <CAMpxmJUX8wszxhkoOyuqPeC8xgBjLXFRSWDSa0cOrJ92dUYX1g@mail.gmail.com> <CAMpxmJX3_ec44Z0UVTNqSDjmNq+Oe3sk+szLE-Nj7X4pztbywQ@mail.gmail.com> <2f7d572c-59e0-f584-9748-48a1a45a1a50@axentia.se> <20160919081413.GR5016@twins.programming.kicks-ass.net>
 <88940f9a-79bf-6c88-8e1d-f76f32dda04a@axentia.se> <20160919090358.GU5016@twins.programming.kicks-ass.net> <e4b4c894-4913-b00f-0a9d-243258f2699b@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:59844 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbcITPgN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 20 Sep 2016 11:36:13 -0400
In-Reply-To: <e4b4c894-4913-b00f-0a9d-243258f2699b@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Peter Zijlstra <peterz@infradead.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ingo Molnar <mingo@redhat.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, 20 Sep 2016, Peter Rosin wrote:
> On 2016-09-19 11:03, Peter Zijlstra wrote:
> >
> > Use the -RT kernel and all locks will end up as rt_mutex. Avoiding
> > inversion on one specific lock, while there are then a gazillion other
> > than can equally create inversion doesn't make sense to me.

That's true, but the locking of the i2c stuff is pretty much self contained
and the results of using an rtmutex speak for themself.

One of the issues is that i2c needs to use threaded interrupt handlers and
blocking out the handler thread with a preempted user space task is hurting
performance badly.

I don't think that using a rtmutex there is wrong. It cures at least a very
clear priority inversion issue versus the threaded interrupt handler.

Forcing all i2c users off to RT is not really an option. RT has other
drawbacks vs. throughput which you don't want to impose on everything which
happens to use i2c.

> 2a will cause a lockdep splat if i2c0:mux_lock is in the same
> lockdep class & subclass as i2c1:mux_lock. So, lockdep needs
> separate lockdep classes depending on the i2c root adapter
> (subclasses are needed to handle deeper trees, so they are off
> limits). Great fun. How do I go about creating a new lockdep
> class for every i2c root adapter instance?

lockdep_set_class() .....

Thanks,

	tglx
