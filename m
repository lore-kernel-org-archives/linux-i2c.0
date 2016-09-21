From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Wed, 21 Sep 2016 11:47:09 +0200
Message-ID: <f246a8ff-44ee-6837-a4cb-bbeec1a50ae0@axentia.se>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <20160916172621.GA1426@katana>
 <deaa654a-9afc-eae6-6bc8-75f2c3960970@axentia.se>
 <20160916175842.GD1426@katana>
 <587cdb60-d7fe-3ab2-b635-02c5072e102e@axentia.se>
 <CAMpxmJUX8wszxhkoOyuqPeC8xgBjLXFRSWDSa0cOrJ92dUYX1g@mail.gmail.com>
 <CAMpxmJX3_ec44Z0UVTNqSDjmNq+Oe3sk+szLE-Nj7X4pztbywQ@mail.gmail.com>
 <2f7d572c-59e0-f584-9748-48a1a45a1a50@axentia.se>
 <20160919081413.GR5016@twins.programming.kicks-ass.net>
 <88940f9a-79bf-6c88-8e1d-f76f32dda04a@axentia.se>
 <20160919090358.GU5016@twins.programming.kicks-ass.net>
 <e4b4c894-4913-b00f-0a9d-243258f2699b@axentia.se>
 <alpine.DEB.2.20.1609201725550.6905@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1609201725550.6905@nanos>
Sender: linux-gpio-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ingo Molnar <mingo@redhat.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2016-09-20 17:33, Thomas Gleixner wrote:
> On Tue, 20 Sep 2016, Peter Rosin wrote:
>> On 2016-09-19 11:03, Peter Zijlstra wrote:
>>>
>>> Use the -RT kernel and all locks will end up as rt_mutex. Avoiding
>>> inversion on one specific lock, while there are then a gazillion other
>>> than can equally create inversion doesn't make sense to me.
> 
> That's true, but the locking of the i2c stuff is pretty much self contained
> and the results of using an rtmutex speak for themself.
> 
> One of the issues is that i2c needs to use threaded interrupt handlers and
> blocking out the handler thread with a preempted user space task is hurting
> performance badly.
> 
> I don't think that using a rtmutex there is wrong. It cures at least a very
> clear priority inversion issue versus the threaded interrupt handler.
> 
> Forcing all i2c users off to RT is not really an option. RT has other
> drawbacks vs. throughput which you don't want to impose on everything which
> happens to use i2c.

Oh, we're not talking about forcing *all* i2c users off to RT, only
those that suffer from the priority inversion. The original report
leading to the bus_lock changing to a rt_mutex seemed like if
someone had suggested an -RT kernel instead of the patch being
accepted, it would have been the better option. If -RT was a viable
option back then? But ok, that was a long time ago and by now
there's no way to be sure what troubles a change back to an ordinary
mutex is going cause. The problem is of course that there is no way
of knowing what, if anything, will suffer from inversion with
ordinary mutexes instead of rt_mutexes.

And this is also true about changing mux_lock to an ordinary mutex.
There is simply no way of knowing if someone depends on avoiding
inversion in a muxing scenario, that dependency may have developed
at any point in time and is not related to the relatively recent
addition of the mux_lock. So, there is a greater risk for
regressions with turning mux_lock into a mutex than I originally
thought.

>> 2a will cause a lockdep splat if i2c0:mux_lock is in the same
>> lockdep class & subclass as i2c1:mux_lock. So, lockdep needs
>> separate lockdep classes depending on the i2c root adapter
>> (subclasses are needed to handle deeper trees, so they are off
>> limits). Great fun. How do I go about creating a new lockdep
>> class for every i2c root adapter instance?

Bzzzt. It is not enough to have one class per root adapter, just
move everything down one mux level:

  .---.                             .----.
  |   |                             |    |-- i2c3
  |   |                           .-|mux1|          .----.
  | l |          .----.          /  |    |-- i2c4 --|gpio|
  | i |          |    |-- i2c1 -'   '----'          '----'
  | n |-- i2c0 --|mux0|                .--------------'
  | u |          |    |-- i2c2 -.   .----.          .----.
  | x |          '----'          \  |    |-- i2c5 --|dev0|
  |   |                           '-|mux2|          '----'
  |   |                             |    |-- i2c6
  '---'                             '----'

access dev0 on i2c5
1. lock i2c2:mux_lock
2.   switch mux2 to i2c5 using gpio on i2c4
 a     lock i2c1:mux_lock
 b       switch mux1 to i2c4 using whatever
 c       access gpio on i2c1->i2c4
  i        lock i2c0:mux_lock
  ii         switch mux0 to i2c1 using whatever
  iii        access gpio on i2c0->i2c1->i2c4
  iv       unlock i2c0:mux_lock
 d     unlock i2c1:mux_lock
3.   access dev0 on i2c2->i2c5
 a     lock i2c0:mux_lock
 b       switch mux0 to i2c2 using whatever
 c       access dev0 on i2c0->i2c2->i2c5
 d     unlock i2c0:mux_lock
4. unlock i2c2:mux_lock

2a is the problematic step here too. i2c1:mux_lock and i2c2:mux_lock
are on the same depth, so needs fully separate lockdep classes. Which
means that using the adapter depth to set the lockdep subclass
is pointless. And since they are branches on the same root adapter,
using one lockdep class per root adapter also falls apart.

> lockdep_set_class() .....

Right, thanks. But given the above, the only way I can think of to
reduce the number of lockdep classes is to defer creating a lockdep
class for an adapter until a mux is attached as a child adapter.
But having extra code to reduce lockdep classes for mux_lock is
pointless, since first of all given the above risk for regression,
I'm no longer all that happy about the rt_mutex -> mutex conversion
even for mux_lock. Then the only reason to consider lockdep classes
is if someone adds support for lockdep to the rt_mutex, which is
on the todo anyway. By then I bet the lockdep class problem will also
present itself for the bus_lock in some manner with some form of
interdependent devices requiring one lockdep class per i2c adapter
anyway.

So, bottom line is that the best we can probably do is to create
one lockdep class per instantiated adapter (i.e. 7 classes for
the above tree), and use one subclass for bus_lock and one for
mux_lock. And the problem is of course that a lockdep class will
be leaked on each de-registration of an i2c adapter.

i2c-based gpio expanders could piggy-back on that and use the same
lockdep class as the i2c adapter it sits on, but use a special
"gpio" subclass. I don't know if that scales though? I mean, can
two drivers for different i2c gpio expanders share lockdep subclass
in the general case?

We can possibly defer the creation of the lockdep class until
either a client or a mux is attached to the adapter in order to
reduce the lockdep class leakage to actual in-use adapters,
whatever that may be worth...

Cheers,
Peter
