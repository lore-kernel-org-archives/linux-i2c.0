From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Sun, 18 Sep 2016 10:52:58 +0200
Message-ID: <587cdb60-d7fe-3ab2-b635-02c5072e102e@axentia.se>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <20160916172621.GA1426@katana>
 <deaa654a-9afc-eae6-6bc8-75f2c3960970@axentia.se>
 <20160916175842.GD1426@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160916175842.GD1426@katana>
Sender: linux-gpio-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2016-09-16 19:58, Wolfram Sang wrote:
> 
>>> Looks good from my POV, but will wait for Peter to comment.
>>>
>>> If accepted, I'd think this should go via my I2C tree and I would like
>>> to ask Linus to ack patch 4. D'accord, everyone?
>>
>> Since it is not clear if "Peter" is me or PeterZ (I suspect PeterZ...),
> 
> Nope, I meant you :) I really value your input, it especially helps me
> on topics like locking, nesting, muxing... etc. Much appreciated, thanks
> a lot for doing that!
> 
>> I'm just adding that it all looks fine by me as well, just to prevent
>> this from being held up by a misunderstanding.
> 
> OK. I read this as Acked-by.
> 
>> It does unconditionally add a new function to i2c-core that is only
>> ever used if lockdep is enabled, but it is tiny and I'm not bothered
>> by that memory waste.
> 
> Same here. And if it prevents us from false positive lockdep reports, I
> am all for fixing it.

Except it doesn't, when I think some more about it...

If you have two gpio-expanders on the same depth but on different i2c
branches you still end up with a splat if one is used to control a mux
to reach the other.

The only way to solve it for good, that I see, is to have every instance
of the gpio-expander mutex in its own class. That might lead to many
lockdep classes but then again, how many gpio expanders could there be
in a system? A dozen or two seems extreme, so maybe that is the correct
approach anyway?

Cheers,
Peter

