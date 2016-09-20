From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Tue, 20 Sep 2016 10:48:33 +0200
Message-ID: <e4b4c894-4913-b00f-0a9d-243258f2699b@axentia.se>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160919090358.GU5016@twins.programming.kicks-ass.net>
Sender: linux-gpio-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ingo Molnar <mingo@redhat.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2016-09-19 11:03, Peter Zijlstra wrote:
> On Mon, Sep 19, 2016 at 10:48:44AM +0200, Peter Rosin wrote:
>> On 2016-09-19 10:14, Peter Zijlstra wrote:
>>> On Mon, Sep 19, 2016 at 10:01:49AM +0200, Peter Rosin wrote:
>>>> Or, do what the i2c-mux code is doing and use an rt_mutex instead
>>>> of an ordinary mutex. That way you are very sure to not get any
>>>> lockdep splat ... at all. Ok, sorry, that was not a serious
>>>> suggestion, but it would be a tad bit simpler to implement...
>>>
>>> So I find it weird that people use rt_mutex as a locking primitive,
>>> since its only that one lock that then does PI and all the other locks
>>> that are related still create inversions.
>>
>> So, someone took the bait :-)
>>
>> Yes, I too find it weird, and would like to get rid of it. It's just
>> odd. It's been some years since the start though, waaay before me
>> entering kernel space.
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=194684e596af4b
>>
>>
>> But it's hard to argue with the numbers given in the discussion:
>>
>> http://linux-i2c.vger.kernel.narkive.com/nokldJcc/patch-1-1-i2c-prevent-priority-inversion-on-top-of-bus-lock
>>
>> Has anything happened to the regular mutex implementation that might
>> have changed the picture? *crosses fingers*
> 
> Use the -RT kernel and all locks will end up as rt_mutex. Avoiding
> inversion on one specific lock, while there are then a gazillion other
> than can equally create inversion doesn't make sense to me.

So, are we willing to risk a regression and ask any victims of that
fallout to switch to the -RT kernel? -RT is still not completely
mainline, right? Is the part with the mutex->rt_mutex conversion
in mainline? In other words, is it just a config option that we
can ask victims to use, or will they have to defer to patches?

I guess the relatively freshly introduced rt_mutex "mux_lock" in
include/linux/i2c.h can be safely converted to an ordinary mutex since
the only reason I went with rt_mutex was that "bus_lock" was an
rt_mutex and they are grabbed in similar circumstances. I can certainly
send a patch. However, the i2c muxing suffers from the issue we were
originally discussing, potentially causing false positive lockdep
reports when you build complex hierarchies with additional
dependencies between branches coming from client devices in the
hierarchy (such as i2c-muxes controlled by i2c-gpio-expanders).

One pretty simple problematic case is:

  .---.          .----.
  |   |          |    |-- i2c2
  |   |-- i2c0 --|mux0|          .----.
  | l |          |    |-- i2c3 --|gpio|
  | i |          '----'          '----'
  | n |             .--------------'
  | u |          .----.          .----.
  | x |          |    |-- i2c4 --|dev0|
  |   |-- i2c1 --|mux1|          '----'
  |   |          |    |-- i2c5
  '---'          '----'

Accesses to dev0 will:

1. lock i2c1:mux_lock (depth 0)
2. switch mux1 to i2c4 using gpio
 a lock i2c0:mux_lock (depth 0)
 b switch mux0 to i2c3 using whatever
 c access gpio
 d unlock i2c0:mux_lock 
3. access dev0
4. unlock i2c1:mux_lock

2a will cause a lockdep splat if i2c0:mux_lock is in the same
lockdep class & subclass as i2c1:mux_lock. So, lockdep needs
separate lockdep classes depending on the i2c root adapter
(subclasses are needed to handle deeper trees, so they are off
limits). Great fun. How do I go about creating a new lockdep
class for every i2c root adapter instance?

Cheers,
Peter

