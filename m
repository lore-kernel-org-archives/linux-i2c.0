From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Tue, 20 Sep 2016 12:48:49 +0200
Message-ID: <6e174c17-584f-580d-083a-94dab2f588bd@axentia.se>
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
 <CAMpxmJVNbsZewcui_WL0aZi3e4Q52=qHxGkm=w5EAr49YAqyaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMpxmJVNbsZewcui_WL0aZi3e4Q52=qHxGkm=w5EAr49YAqyaw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ingo Molnar <mingo@redhat.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2016-09-20 12:07, Bartosz Golaszewski wrote:
> 2016-09-20 10:48 GMT+02:00 Peter Rosin <peda@axentia.se>:
>>
>> One pretty simple problematic case is:
>>
>>   .---.          .----.
>>   |   |          |    |-- i2c2
>>   |   |-- i2c0 --|mux0|          .----.
>>   | l |          |    |-- i2c3 --|gpio|
>>   | i |          '----'          '----'
>>   | n |             .--------------'
>>   | u |          .----.          .----.
>>   | x |          |    |-- i2c4 --|dev0|
>>   |   |-- i2c1 --|mux1|          '----'
>>   |   |          |    |-- i2c5
>>   '---'          '----'
>>
>> Accesses to dev0 will:
>>
>> 1. lock i2c1:mux_lock (depth 0)
>> 2. switch mux1 to i2c4 using gpio
>>  a lock i2c0:mux_lock (depth 0)
>>  b switch mux0 to i2c3 using whatever
>>  c access gpio
>>  d unlock i2c0:mux_lock
>> 3. access dev0
>> 4. unlock i2c1:mux_lock
>>
>> 2a will cause a lockdep splat if i2c0:mux_lock is in the same
>> lockdep class & subclass as i2c1:mux_lock. So, lockdep needs
>> separate lockdep classes depending on the i2c root adapter
>> (subclasses are needed to handle deeper trees, so they are off
>> limits). Great fun. How do I go about creating a new lockdep
>> class for every i2c root adapter instance?
>>
> 
> I feel like it's just wrong to set an arbitrary limit on the number of
> i2c branches - and this is what the result of this approach would be.

What arbitrary limit would that be? The number of lockdep classes
can't be *that* limited? Or?

I mean one lockdep class per root adapter and one subclass within that
class per mux level doesn't sound too bad. How many root adapters do
we need to design for?

> One solution that comes to mind is to have a separate, global set of
> lock classes solely for gpio expanders. I think you mentioned earlier
> that it's the only thing that can cause this kind of lockdep false
> positives.

No, that's not true, so if I said that, it was simply wrong. E.g. I
think the new mlxcpld i2c mux can mux another i2c adapter and will
cause the same problem without involving any gpio expander.

[OT: Wolfram, are you still following this? Are you picking up the
 mlxcpld mux driver, or did my ack fly by without you noticing?]

Oh, and the there is a pinctrl-based i2c mux that also suffers as
there are pinctrl chips that are i2c clients.

And even though I don't really know the pinctrl demux, it will
probably also cause interesting nesting if an i2c based pinctrl
is used as demuxer. If that's relevant, probably isn't...

>            We could potentially have a limited set of lock classes and
> every expander that would need one would request it using some kind of
> API ensuring that every instance gets a separate class. But this
> sounds like a big hack too I'm afraid... And regmap would need to be
> aware of that as well.
> 
> Anyways, we're past rc7 already and 4.9 will be the next LTS kernel.
> We have real hardware here that runs on mainline linux and is
> suffering from this issue. Are there any objections against merging
> this series now and continuing the work on improving the solution for
> 4.10?

No, I have no objection. It's not wrong per se, it's just not complete.

Cheers,
Peter
